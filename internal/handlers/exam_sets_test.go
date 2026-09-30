package handlers

import (
	"bytes"
	"github.com/gorilla/mux"
	"html/template"
	"net/http"
	"net/http/httptest"
	"net/url"
	"os"
	"path/filepath"
	"strings"
	"testing"
	"vocabulary-quiz-app/internal/database"
	"vocabulary-quiz-app/internal/middleware"
)

func setupSets(t *testing.T) {
	t.Helper()
	t.Chdir(t.TempDir())
	if err := database.InitDB(); err != nil {
		t.Fatal(err)
	}
	t.Cleanup(func() { database.DB.Close() })
	execSetSQL(t, `INSERT INTO exam_types(id,name) VALUES(100,'CSSE'),(101,'GL');
 INSERT INTO users(id,username,password,role,full_name,stage_id) VALUES(100,'pupil','x','student','Pupil',2),(101,'other','x','student','Other',3);
 INSERT INTO exam_sets(id,exam_type_id,stage_id,name,sequence_number,is_published) VALUES
 (100,100,2,'Set 1',1,0),(101,100,2,'Set 2',2,0),(102,101,2,'Set 1',1,0),(103,100,3,'Set 1',1,0),(104,100,2,'Draft',3,0),(105,100,2,'Empty',4,0);
 INSERT INTO quizzes(id,title,stage_id,exam_type,exam_set_id) VALUES
 (100,'Maths',2,'CSSE',100),(101,'English',2,'CSSE',100),(102,'Next maths',2,'CSSE',101),(103,'GL',2,'GL',102),(104,'Other stage',3,'CSSE',103),(105,'Draft',2,'CSSE',104);
 INSERT INTO quizzes(id,title,stage_id) VALUES(106,'Practice',3);
 INSERT INTO personalized_quiz_assignments(user_id,quiz_id) VALUES(100,106),(100,102);
 UPDATE quizzes SET description='' WHERE description IS NULL;
 INSERT INTO questions(quiz_id,question_text,question_type,correct_answer) SELECT id,'Question','text','answer' FROM quizzes;
 UPDATE exam_sets SET is_published=1 WHERE id BETWEEN 100 AND 103;`)
}
func execSetSQL(t *testing.T, s string, args ...interface{}) {
	t.Helper()
	if _, err := database.DB.Exec(s, args...); err != nil {
		t.Fatal(err)
	}
}
func assertAccess(t *testing.T, id int, want bool) {
	t.Helper()
	got, err := userCanAccessQuiz(100, id)
	if err != nil || got != want {
		t.Fatalf("paper %d access=%v err=%v want=%v", id, got, err, want)
	}
}
func complete(t *testing.T, id int) {
	t.Helper()
	execSetSQL(t, "INSERT INTO quiz_attempts(user_id,quiz_id,score,max_score) VALUES(100,?,0,1)", id)
}
func TestSetProgression(t *testing.T) {
	setupSets(t)
	for _, id := range []int{100, 101, 103, 106} {
		assertAccess(t, id, true)
	}
	for _, id := range []int{102, 104, 105} {
		assertAccess(t, id, false)
	}
	complete(t, 101)
	assertAccess(t, 102, false)
	if _, err := getExamSets(); err != nil {
		t.Fatal(err)
	}
	sets, err := boardSets(100, 100)
	if err != nil {
		t.Fatal(err)
	}
	if len(sets) != 2 || sets[0].Completed != 1 || !sets[1].Locked {
		t.Fatalf("unexpected sets %+v", sets)
	}
	complete(t, 100)
	assertAccess(t, 102, true)
	execSetSQL(t, "UPDATE quizzes SET unlock_version=unlock_version+1 WHERE id=100")
	assertAccess(t, 102, true)
	execSetSQL(t, "DELETE FROM quiz_attempts WHERE quiz_id=100")
	assertAccess(t, 102, true)
	boards, err := studentBoards(100, 2)
	if err != nil || len(boards) != 2 {
		t.Fatalf("boards=%v err=%v", boards, err)
	}
}
func TestSetGuards(t *testing.T) {
	setupSets(t)
	if err := recordSetStart(100, 100); err != nil {
		t.Fatal(err)
	}
	for _, q := range []string{
		"UPDATE exam_sets SET sequence_number=9 WHERE id=100",
		"UPDATE exam_sets SET is_published=0 WHERE id=100",
		"UPDATE quizzes SET exam_set_id=101 WHERE id=100",
		"UPDATE quizzes SET is_archived=1 WHERE id=100",
		"DELETE FROM quizzes WHERE id=100",
		"INSERT INTO quizzes(title,exam_set_id) VALUES('extra',100)",
		"UPDATE exam_sets SET is_published=1 WHERE id=105",
	} {
		if _, err := database.DB.Exec(q); err == nil {
			t.Fatalf("allowed forbidden change: %s", q)
		}
	}
	execSetSQL(t, "UPDATE quizzes SET title='Corrected title' WHERE id=100")
	practice := saveQuizRequest{}
	if err := preparePaperSet(&practice, 106); err != nil || practice.StageID != 3 {
		t.Fatalf("personalized edit: %v %+v", err, practice)
	}
	req := saveQuizRequest{ExamSetID: 100}
	if err := preparePaperSet(&req, 0); err == nil {
		t.Fatal("new paper allowed in published set")
	}
	if err := preparePaperSet(&req, 100); err != nil || req.StageID != 2 || req.ExamType != "CSSE" {
		t.Fatalf("inheritance: %+v %v", req, err)
	}
}
func TestLockedPaperEndpoints(t *testing.T) {
	setupSets(t)
	for _, tc := range []struct {
		method  string
		handler http.HandlerFunc
	}{{"GET", QuizPageHandler}, {"GET", GetQuizHandler}, {"POST", SubmitQuizHandler}} {
		r := httptest.NewRequest(tc.method, "/student/quiz/102", bytes.NewBufferString(`{"answers":{}}`))
		r = mux.SetURLVars(r, map[string]string{"quiz_id": "102"})
		session, _ := middleware.Store.Get(r, "session")
		session.Values["user_id"] = 100
		cookieResponse := httptest.NewRecorder()
		if err := session.Save(r, cookieResponse); err != nil {
			t.Fatal(err)
		}
		for _, cookie := range cookieResponse.Result().Cookies() {
			r.AddCookie(cookie)
		}
		w := httptest.NewRecorder()
		tc.handler(w, r)
		if w.Code != 404 && w.Code != 403 {
			t.Fatalf("%s returned %d", tc.method, w.Code)
		}
	}
}
func TestExamTemplates(t *testing.T) {
	root, err := os.Getwd()
	if err != nil {
		t.Fatal(err)
	}
	for _, name := range []string{"student_dashboard.html", "student_exam_board.html", "admin_dashboard.html", "create_quiz.html", "edit_quiz.html"} {
		tmpl, err := template.ParseFiles(filepath.Join(root, "../../templates", name))
		if err != nil {
			t.Fatal(err)
		}
		var out bytes.Buffer
		data := map[string]interface{}{"Boards": []boardCard{{ID: 1, Name: "CSSE", Sets: 2}}, "Sets": []setCard{{ID: 1, Name: "Set 1", Papers: []paperCard{{ID: 1, Title: "Maths"}}}}, "TotalPages": 1, "CurrentPage": 1, "RecentAttempts": []interface{}{}}
		if err := tmpl.Execute(&out, data); err != nil {
			t.Fatalf("%s: %v", name, err)
		}
	}
}

func TestQuestionEditorSupportsTextModesAndPastedImages(t *testing.T) {
	script, err := os.ReadFile("../../static/js/app.js")
	if err != nil {
		t.Fatal(err)
	}
	content := string(script)
	for _, expected := range []string{
		"function setQuestionTextMode",
		"Use multiple lines",
		"question_text_${questionCount}",
		"diagramTools.addEventListener('paste'",
		"accept=\"image/*\"",
		"loadDiagramFile",
	} {
		if !strings.Contains(content, expected) {
			t.Fatalf("question editor is missing %q", expected)
		}
	}
}

func TestCreateSetForExamType(t *testing.T) {
	setupSets(t)
	form := url.Values{"exam_type_id": {"100"}, "stage_id": {"2"}, "name": {"Set 5"}, "sequence_number": {"5"}}
	r := httptest.NewRequest(http.MethodPost, "/admin/exam-sets", strings.NewReader(form.Encode()))
	r.Header.Set("Content-Type", "application/x-www-form-urlencoded")
	w := httptest.NewRecorder()
	CreateExamSetHandler(w, r)
	if w.Code != http.StatusSeeOther || !strings.HasSuffix(w.Header().Get("Location"), "#exam-sets") {
		t.Fatalf("unexpected response: %d %s", w.Code, w.Header().Get("Location"))
	}
	sets, err := getExamSets()
	if err != nil {
		t.Fatal(err)
	}
	for _, set := range sets {
		if set.Name == "Set 5" {
			if set.ExamTypeID != 100 || set.StageID != 2 || set.Published {
				t.Fatalf("incorrect new set: %+v", set)
			}
			req := saveQuizRequest{ExamSetID: set.ID}
			if err := preparePaperSet(&req, 0); err != nil || req.ExamType != "CSSE" || req.StageID != 2 {
				t.Fatalf("new set unavailable to exam creation: %+v %v", req, err)
			}
			return
		}
	}
	t.Fatal("created set is missing from the exam set selector")
}

func TestDashboardBoardSections(t *testing.T) {
	tmpl, err := template.ParseFiles("../../templates/student_dashboard.html")
	if err != nil {
		t.Fatal(err)
	}
	setupSets(t)
	boards, err := studentBoards(100, 2)
	if err != nil {
		t.Fatal(err)
	}
	if len(boards) != 2 || boards[0].Name != "CSSE" || boards[0].CurrentSet == nil || boards[0].CurrentSet.ID != 100 || len(boards[0].CurrentSet.Papers) != 2 || boards[1].CurrentSet == nil || boards[1].CurrentSet.ID != 102 {
		t.Fatalf("unexpected board sections: %+v", boards)
	}
	var out bytes.Buffer
	if err = tmpl.Execute(&out, map[string]interface{}{"Boards": boards, "StageName": "Year 1"}); err != nil {
		t.Fatal(err)
	}
	html := out.String()
	for _, want := range []string{`id="board-100-title"`, `id="board-101-title"`, "Maths", "English", `href="/student/quiz/100"`, `href="/student/quiz/101"`} {
		if !strings.Contains(html, want) {
			t.Fatalf("dashboard missing %s", want)
		}
	}
	for _, hidden := range []string{"Next maths", "Other stage", `href="/student/quiz/105"`} {
		if strings.Contains(html, hidden) {
			t.Fatalf("dashboard exposed %s", hidden)
		}
	}
	complete(t, 100)
	boards, err = studentBoards(100, 2)
	if err != nil || boards[0].CurrentSet.ID != 100 || boards[0].CurrentSet.Completed != 1 {
		t.Fatalf("partial set changed: %+v %v", boards, err)
	}
	complete(t, 101)
	boards, err = studentBoards(100, 2)
	if err != nil || boards[0].CurrentSet.ID != 101 || boards[0].CompletedSets != 1 || boards[1].CurrentSet.ID != 102 {
		t.Fatalf("progression changed incorrectly: %+v %v", boards, err)
	}
	complete(t, 102)
	boards, err = studentBoards(100, 2)
	if err != nil || boards[0].CurrentSet != nil || boards[0].CompletedSets != 2 {
		t.Fatalf("completed board disappeared or still offers a set: %+v %v", boards, err)
	}
	other, err := studentBoards(101, 3)
	if err != nil || len(other) != 1 || other[0].CurrentSet.ID != 103 {
		t.Fatalf("wrong stage boards: %+v %v", other, err)
	}
}

func TestDashboardExcludesUnclassifiedExams(t *testing.T) {
	setupSets(t)
	execSetSQL(t, `INSERT INTO exam_sets(id,exam_type_id,stage_id,name,sequence_number,is_published)
 SELECT 200,id,2,'Imported',1,1 FROM exam_types WHERE name='General';
 INSERT INTO quizzes(id,title,stage_id,exam_type,exam_set_id) VALUES
 (200,'Unclassified',2,'General',200),(201,'Missing type',2,'',100),(202,'Default in CSSE',2,'General',100),(203,'Wrong type',2,'GL',100);`)
	boards, err := studentBoards(100, 2)
	if err != nil {
		t.Fatal(err)
	}
	if len(boards) != 2 {
		t.Fatalf("unclassified board displayed: %+v", boards)
	}
	for _, board := range boards {
		if board.Name == "General" {
			t.Fatal("General must not be offered as an assigned exam type")
		}
		for _, paper := range board.CurrentSet.Papers {
			if paper.ID >= 200 {
				t.Fatalf("unclassified or mismatched paper displayed: %+v", paper)
			}
		}
	}
	sets, err := boardSets(100, 100)
	if err != nil || sets[0].Total != 2 {
		t.Fatalf("unclassified papers counted toward completion: %+v %v", sets, err)
	}
	complete(t, 100)
	complete(t, 101)
	assertAccess(t, 102, true)
	assertAccess(t, 201, false)
}
