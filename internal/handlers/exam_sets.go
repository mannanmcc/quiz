package handlers

import (
	"fmt"
	"github.com/gorilla/mux"
	"html/template"
	"net/http"
	"strconv"
	"strings"
	"unicode/utf8"
	"vocabulary-quiz-app/internal/database"
	"vocabulary-quiz-app/internal/middleware"
)

type boardCard struct {
	ID            int
	Name          string
	Sets          int
	CompletedSets int
	CurrentSet    *setCard
}
type paperCard struct {
	ID                 int
	Title, Description string
	Minutes            int
	Completed, Locked  bool
}
type setCard struct {
	ID, Sequence, Total, Completed int
	Name, Status                   string
	Locked                         bool
	Papers                         []paperCard
}

func studentBoards(userID, stageID int) ([]boardCard, error) {
	rows, err := database.DB.Query(`SELECT et.id,et.name,COUNT(es.id) FROM exam_types et JOIN exam_sets es ON es.exam_type_id=et.id
 WHERE es.stage_id=? AND es.is_published=1 AND TRIM(et.name)<>'' AND TRIM(et.name)<>'General' COLLATE NOCASE
 AND EXISTS(SELECT 1 FROM quizzes q WHERE q.exam_set_id=es.id AND q.is_archived=0 AND TRIM(q.exam_type)=TRIM(et.name) COLLATE NOCASE)
 GROUP BY et.id ORDER BY et.name COLLATE NOCASE`, stageID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var result []boardCard
	for rows.Next() {
		var b boardCard
		if err = rows.Scan(&b.ID, &b.Name, &b.Sets); err != nil {
			return nil, err
		}
		result = append(result, b)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	for i := range result {
		sets, err := boardSets(userID, result[i].ID)
		if err != nil {
			return nil, err
		}
		for j := range sets {
			if sets[j].Completed == sets[j].Total {
				result[i].CompletedSets++
			}
			if result[i].CurrentSet == nil && !sets[j].Locked && sets[j].Completed < sets[j].Total {
				result[i].CurrentSet = &sets[j]
			}
		}
	}
	return result, nil
}
func personalizedPapers(userID int) ([]paperCard, error) {
	return readPapers(userID, 0)
}
func readPapers(userID, setID int) ([]paperCard, error) {
	rows, err := database.DB.Query(`SELECT q.id,q.title,COALESCE(q.description,''),COALESCE(q.time_limit_minutes,0),
 EXISTS(SELECT 1 FROM paper_completions pc WHERE pc.user_id=? AND pc.quiz_id=q.id),
 q.lock_after_attempt AND EXISTS(SELECT 1 FROM quiz_attempts a WHERE a.user_id=? AND a.quiz_id=q.id AND a.unlock_version=q.unlock_version)
 FROM quizzes q WHERE q.is_archived=0 AND (q.exam_set_id=? AND EXISTS(SELECT 1 FROM exam_sets es JOIN exam_types et ON et.id=es.exam_type_id WHERE es.id=q.exam_set_id AND TRIM(et.name)<>'' AND TRIM(et.name)<>'General' COLLATE NOCASE AND TRIM(q.exam_type)=TRIM(et.name) COLLATE NOCASE) OR (?=0 AND q.exam_set_id IS NULL AND EXISTS(SELECT 1 FROM personalized_quiz_assignments p WHERE p.user_id=? AND p.quiz_id=q.id)))
 ORDER BY q.paper_order,q.id`, userID, userID, setID, setID, userID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var result []paperCard
	for rows.Next() {
		var p paperCard
		if err = rows.Scan(&p.ID, &p.Title, &p.Description, &p.Minutes, &p.Completed, &p.Locked); err != nil {
			return nil, err
		}
		result = append(result, p)
	}
	return result, rows.Err()
}
func boardSets(userID, boardID int) ([]setCard, error) {
	rows, err := database.DB.Query(`SELECT es.id,es.name,es.sequence_number,COUNT(q.id),SUM(CASE WHEN pc.quiz_id IS NOT NULL THEN 1 ELSE 0 END)
 FROM exam_sets es JOIN exam_types et ON et.id=es.exam_type_id
 JOIN users u ON u.id=? AND u.stage_id=es.stage_id
 JOIN quizzes q ON q.exam_set_id=es.id AND q.is_archived=0 AND TRIM(q.exam_type)=TRIM(et.name) COLLATE NOCASE
 LEFT JOIN paper_completions pc ON pc.quiz_id=q.id AND pc.user_id=u.id
 WHERE es.exam_type_id=? AND es.is_published=1 AND TRIM(et.name)<>'' AND TRIM(et.name)<>'General' COLLATE NOCASE GROUP BY es.id ORDER BY es.sequence_number`, userID, boardID)
	if err != nil {
		return nil, err
	}
	var sets []setCard
	for rows.Next() {
		var s setCard
		if err = rows.Scan(&s.ID, &s.Name, &s.Sequence, &s.Total, &s.Completed); err != nil {
			rows.Close()
			return nil, err
		}
		sets = append(sets, s)
	}
	err = rows.Err()
	rows.Close()
	if err != nil {
		return nil, err
	}
	blocked := false
	for i := range sets {
		s := &sets[i]
		s.Locked = blocked
		s.Status = "Available"
		if s.Completed == s.Total {
			s.Status = "Completed"
		} else {
			if s.Completed > 0 {
				s.Status = "In progress"
			}
			if blocked {
				s.Status = "Locked — complete the previous set"
			}
			blocked = true
		}
		if !s.Locked {
			s.Papers, err = readPapers(userID, s.ID)
			if err != nil {
				return nil, err
			}
		}
	}
	return sets, nil
}
func StudentBoardHandler(w http.ResponseWriter, r *http.Request) {
	session, _ := middleware.Store.Get(r, "session")
	userID := session.Values["user_id"].(int)
	boardID, _ := strconv.Atoi(mux.Vars(r)["board_id"])
	var name string
	if err := database.DB.QueryRow("SELECT name FROM exam_types WHERE id=?", boardID).Scan(&name); err != nil {
		http.NotFound(w, r)
		return
	}
	sets, err := boardSets(userID, boardID)
	if err != nil {
		http.Error(w, "Server error", 500)
		return
	}
	if len(sets) == 0 {
		http.NotFound(w, r)
		return
	}
	template.Must(template.ParseFiles("templates/student_exam_board.html")).Execute(w, map[string]interface{}{"Board": name, "Sets": sets})
}
func StudentSetHandler(w http.ResponseWriter, r *http.Request) {
	session, _ := middleware.Store.Get(r, "session")
	userID := session.Values["user_id"].(int)
	id, _ := strconv.Atoi(mux.Vars(r)["set_id"])
	var boardID int
	if err := database.DB.QueryRow("SELECT exam_type_id FROM exam_sets WHERE id=?", id).Scan(&boardID); err != nil {
		http.NotFound(w, r)
		return
	}
	sets, err := boardSets(userID, boardID)
	if err != nil {
		http.Error(w, "Server error", 500)
		return
	}
	for _, s := range sets {
		if s.ID == id {
			if s.Locked {
				http.Error(w, "Complete the previous set first", http.StatusForbidden)
				return
			}
			http.Redirect(w, r, "/student/exam-board/"+strconv.Itoa(boardID)+"#set-"+strconv.Itoa(id), http.StatusSeeOther)
			return
		}
	}
	http.NotFound(w, r)
}
func recordSetStart(userID int, quizID interface{}) error {
	_, err := database.DB.Exec(`INSERT OR IGNORE INTO exam_set_starts(user_id,set_id) SELECT ?,exam_set_id FROM quizzes WHERE id=? AND exam_set_id IS NOT NULL`, userID, quizID)
	return err
}

func UpdateExamSetHandler(w http.ResponseWriter, r *http.Request) {
	fail := func(message string) { redirectExamTypeManagement(w, r, "exam_type_error", message) }
	id, err := strconv.Atoi(mux.Vars(r)["exam_set_id"])
	if err != nil || id < 1 {
		fail("Invalid set.")
		return
	}
	if err = r.ParseForm(); err != nil {
		fail("Invalid form.")
		return
	}
	name := strings.TrimSpace(r.FormValue("name"))
	sequence, seqErr := strconv.Atoi(r.FormValue("sequence_number"))
	typeID, typeErr := strconv.Atoi(r.FormValue("exam_type_id"))
	stageID, stageErr := strconv.Atoi(r.FormValue("stage_id"))
	status := r.FormValue("is_published")
	if name == "" || utf8.RuneCountInString(name) > 100 || seqErr != nil || sequence < 1 || typeErr != nil || stageErr != nil || (status != "0" && status != "1") {
		fail("Enter a set name (up to 100 characters), exam type, stage, positive sequence and publication status.")
		return
	}
	published := status == "1"
	tx, err := database.DB.Begin()
	if err != nil {
		fail("Could not update set.")
		return
	}
	defer tx.Rollback()
	var oldType, oldStage, oldSequence int
	var oldPublished, started bool
	err = tx.QueryRow(`SELECT exam_type_id,stage_id,sequence_number,is_published,EXISTS(SELECT 1 FROM exam_set_starts WHERE set_id=exam_sets.id) FROM exam_sets WHERE id=?`, id).Scan(&oldType, &oldStage, &oldSequence, &oldPublished, &started)
	if err != nil {
		fail("Set not found.")
		return
	}
	var board string
	err = tx.QueryRow(`SELECT et.name FROM exam_types et JOIN stages s ON s.id=? WHERE et.id=?`, stageID, typeID).Scan(&board)
	if err != nil {
		fail("Select a valid exam type and stage.")
		return
	}
	moving := typeID != oldType || stageID != oldStage
	if started && (moving || sequence != oldSequence || published != oldPublished) {
		fail("Students have started this set. Only its name can change.")
		return
	}
	if moving {
		if oldPublished {
			fail("Save this set as Draft before changing its exam type or stage.")
			return
		}
		var blocked int
		err = tx.QueryRow(`SELECT COUNT(*) FROM exam_set_starts st JOIN exam_sets es ON es.id=st.set_id WHERE
 (es.exam_type_id=? AND es.stage_id=? AND es.sequence_number>=?) OR
 (es.exam_type_id=? AND es.stage_id=? AND es.sequence_number>=?)`, oldType, oldStage, oldSequence, typeID, stageID, sequence).Scan(&blocked)
		if err != nil || blocked > 0 {
			fail("Changing this set would affect a sequence students have already started.")
			return
		}
	}
	_, err = tx.Exec(`UPDATE exam_sets SET name=?,exam_type_id=?,stage_id=?,sequence_number=?,is_published=? WHERE id=?`, name, typeID, stageID, sequence, published, id)
	if err != nil {
		fail("Could not save: the name or sequence may already exist, the set may have no papers, or students have started this sequence.")
		return
	}
	if moving {
		if _, err = tx.Exec(`UPDATE quizzes SET stage_id=?,exam_type=? WHERE exam_set_id=?`, stageID, board, id); err != nil {
			fail("Could not update the papers in this set.")
			return
		}
	}
	if err = tx.Commit(); err != nil {
		fail("Could not save set.")
		return
	}
	redirectExamTypeManagement(w, r, "exam_type_message", "Set details saved.")
}

// The set is the source of truth for stage and board.
func preparePaperSet(req *saveQuizRequest, quizID int) error {
	if req.PaperOrder < 1 {
		req.PaperOrder = 1
	}
	if req.ExamSetID == 0 && quizID > 0 {
		return database.DB.QueryRow(`SELECT q.stage_id,q.exam_type FROM quizzes q WHERE q.id=? AND q.exam_set_id IS NULL AND EXISTS(SELECT 1 FROM personalized_quiz_assignments p WHERE p.quiz_id=q.id)`, quizID).Scan(&req.StageID, &req.ExamType)
	}

	var published bool
	if err := database.DB.QueryRow("SELECT is_published FROM exam_sets WHERE id=?", req.ExamSetID).Scan(&published); err != nil {
		return err
	}
	if published {
		var oldSet int
		if quizID == 0 {
			return fmt.Errorf("unpublish the set before adding papers")
		}
		if err := database.DB.QueryRow("SELECT COALESCE(exam_set_id,0) FROM quizzes WHERE id=?", quizID).Scan(&oldSet); err != nil {
			return err
		}
		if oldSet != req.ExamSetID {
			return fmt.Errorf("unpublish the set before moving papers")
		}
	}
	return database.DB.QueryRow(`SELECT es.stage_id,et.name FROM exam_sets es JOIN exam_types et ON et.id=es.exam_type_id WHERE es.id=?`, req.ExamSetID).Scan(&req.StageID, &req.ExamType)
}
