package handlers

import (
	"bytes"
	"github.com/gorilla/mux"
	"html/template"
	"net/http/httptest"
	"net/url"
	"strings"
	"testing"
	"vocabulary-quiz-app/internal/database"
)

func TestAssignExistingExam(t *testing.T) {
	setupSets(t)
	execSetSQL(t, `INSERT INTO quizzes(id,title,stage_id,exam_type) VALUES(200,'Existing exam',3,'General');
 INSERT INTO questions(quiz_id,question_text,question_type,correct_answer) VALUES(200,'Q','text','A');
 INSERT INTO quiz_attempts(user_id,quiz_id,score,max_score) VALUES(100,200,0,1);`)
	assign := func(set, exam string) string {
		form := url.Values{"quiz_id": {exam}, "search": {"Existing"}}
		r := httptest.NewRequest("POST", "/admin/exam-sets/104/assign", strings.NewReader(form.Encode()))
		r.Header.Set("Content-Type", "application/x-www-form-urlencoded")
		r = mux.SetURLVars(r, map[string]string{"exam_set_id": set})
		w := httptest.NewRecorder()
		AssignExamHandler(w, r)
		if w.Code != 303 {
			t.Fatalf("assignment returned %d", w.Code)
		}
		return w.Header().Get("Location")
	}
	if dest := assign("104", "200"); !strings.Contains(dest, "message=") {
		t.Fatalf("assignment failed: %s", dest)
	}
	var setID, stageID, attempts, questions int
	var board string
	err := database.DB.QueryRow(`SELECT exam_set_id,stage_id,exam_type,(SELECT COUNT(*) FROM quiz_attempts WHERE quiz_id=200),(SELECT COUNT(*) FROM questions WHERE quiz_id=200) FROM quizzes WHERE id=200`).Scan(&setID, &stageID, &board, &attempts, &questions)
	if err != nil || setID != 104 || stageID != 2 || board != "CSSE" || attempts != 1 || questions != 1 {
		t.Fatalf("assignment did not preserve/update expected data: %d %d %s %d %d %v", setID, stageID, board, attempts, questions, err)
	}
	for _, tc := range [][2]string{{"100", "105"}, {"104", "106"}, {"104", "999"}, {"104", "200"}} {
		if dest := assign(tc[0], tc[1]); !strings.Contains(dest, "error=") {
			t.Fatalf("invalid assignment accepted: %v %s", tc, dest)
		}
	}
	if err := recordSetStart(100, 100); err != nil {
		t.Fatal(err)
	}
	if dest := assign("104", "100"); !strings.Contains(dest, "error=") {
		t.Fatalf("moved from started set: %s", dest)
	}
}

func TestAssignExamSearchPage(t *testing.T) {
	source, err := template.ParseFiles("../../templates/assign_exam.html")
	if err != nil {
		t.Fatal(err)
	}
	var output bytes.Buffer
	err = source.Execute(&output, map[string]interface{}{"SetID": 1, "SetName": "Set 1", "Board": "CSSE", "Stage": "Year 5", "Papers": []assignmentPaper{{ID: 10, Title: "English"}, {ID: 11, Title: "Private", Reason: "Personalized practice"}}})
	if err != nil {
		t.Fatal(err)
	}
	for _, want := range []string{"English", "Assign to this set", "Personalized practice", "/admin/exam-sets/1/assign"} {
		if !strings.Contains(output.String(), want) {
			t.Fatalf("page missing %s", want)
		}
	}
}

func TestManageSetPapersAndInlineAssignment(t *testing.T) {
	tmpl, err := template.ParseFiles("../../templates/admin_dashboard.html")
	if err != nil {
		t.Fatal(err)
	}
	setupSets(t)
	execSetSQL(t, `INSERT INTO quizzes(id,title,stage_id,exam_type) VALUES(200,'Available paper',3,'General'); UPDATE quizzes SET is_archived=1 WHERE id=101;`)
	grouped, available, err := getSetPapers()
	if err != nil {
		t.Fatal(err)
	}
	if len(grouped[100]) != 2 {
		t.Fatalf("expected both set papers: %+v", grouped[100])
	}
	for _, p := range available {
		if p.ID == 101 || p.ID == 106 {
			t.Fatalf("ineligible paper offered: %+v", p)
		}
	}
	sets, err := getExamSets()
	if err != nil {
		t.Fatal(err)
	}
	var output bytes.Buffer
	if err := tmpl.Execute(&output, map[string]interface{}{"TotalPages": 1, "ExamSets": sets, "SetPapers": grouped, "AvailablePapers": available}); err != nil {
		t.Fatal(err)
	}
	for _, want := range []string{"Maths", "English", "Archived", "Available paper (#200)", "add-paper-104", "No papers added yet."} {
		if !strings.Contains(output.String(), want) {
			t.Fatalf("missing %q", want)
		}
	}
	form := url.Values{"quiz_id": {"200"}, "return_to": {"exam-sets"}}
	r := httptest.NewRequest("POST", "/admin/exam-sets/104/assign", strings.NewReader(form.Encode()))
	r.Header.Set("Content-Type", "application/x-www-form-urlencoded")
	r = mux.SetURLVars(r, map[string]string{"exam_set_id": "104"})
	w := httptest.NewRecorder()
	AssignExamHandler(w, r)
	location := w.Header().Get("Location")
	if w.Code != 303 || !strings.HasPrefix(location, "/admin/dashboard?exam_type_message=") || !strings.HasSuffix(location, "#exam-sets") {
		t.Fatalf("unexpected redirect: %d %s", w.Code, location)
	}
	grouped, _, err = getSetPapers()
	if err != nil {
		t.Fatal(err)
	}
	if len(grouped[104]) != 2 {
		t.Fatalf("assigned paper not in set: %+v", grouped[104])
	}
}
