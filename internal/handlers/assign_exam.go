package handlers

import (
	"database/sql"
	"github.com/gorilla/mux"
	"html/template"
	"net/http"
	"net/url"
	"strconv"
	"strings"
	"vocabulary-quiz-app/internal/database"
)

type assignmentPaper struct {
	ID                               int
	Title, Stage, Board, Set, Reason string
}

type setPaper struct {
	ID, SetID                    int
	Title, SetName, Board, Stage string
	Archived, Assignable         bool
}

// Load independently of the paginated exam search so every set shows all its papers.
func getSetPapers() (map[int][]setPaper, []setPaper, error) {
	rows, err := database.DB.Query(`SELECT q.id,COALESCE(q.exam_set_id,0),q.title,COALESCE(es.name,'No set'),COALESCE(q.exam_type,''),COALESCE(s.name,'No stage'),q.is_archived,
 q.is_archived=0 AND NOT EXISTS(SELECT 1 FROM personalized_quiz_assignments WHERE quiz_id=q.id)
 AND NOT EXISTS(SELECT 1 FROM exam_set_starts WHERE set_id=q.exam_set_id)
 FROM quizzes q LEFT JOIN exam_sets es ON es.id=q.exam_set_id LEFT JOIN stages s ON s.id=q.stage_id
 ORDER BY q.paper_order,q.title COLLATE NOCASE,q.id`)
	if err != nil {
		return nil, nil, err
	}
	defer rows.Close()
	grouped := make(map[int][]setPaper)
	available := []setPaper{}
	for rows.Next() {
		var p setPaper
		if err := rows.Scan(&p.ID, &p.SetID, &p.Title, &p.SetName, &p.Board, &p.Stage, &p.Archived, &p.Assignable); err != nil {
			return nil, nil, err
		}
		grouped[p.SetID] = append(grouped[p.SetID], p)
		if p.Assignable {
			available = append(available, p)
		}
	}
	return grouped, available, rows.Err()
}

func AssignExamPageHandler(w http.ResponseWriter, r *http.Request) {
	id, err := strconv.Atoi(mux.Vars(r)["exam_set_id"])
	if err != nil || id < 1 {
		http.NotFound(w, r)
		return
	}
	var name, board, stage string
	var published, started bool
	err = database.DB.QueryRow(`SELECT es.name,et.name,s.name,es.is_published,
 EXISTS(SELECT 1 FROM exam_set_starts WHERE set_id=es.id)
 FROM exam_sets es JOIN exam_types et ON et.id=es.exam_type_id JOIN stages s ON s.id=es.stage_id WHERE es.id=?`, id).Scan(&name, &board, &stage, &published, &started)
	if err == sql.ErrNoRows {
		http.NotFound(w, r)
		return
	}
	if err != nil {
		http.Error(w, "Could not load set", 500)
		return
	}
	search := strings.TrimSpace(r.URL.Query().Get("search"))
	page, _ := strconv.Atoi(r.URL.Query().Get("page"))
	if page < 1 {
		page = 1
	}
	const size = 30
	rows, err := database.DB.Query(`SELECT q.id,q.title,COALESCE(s.name,'No stage'),COALESCE(q.exam_type,'No type'),COALESCE(es.name,'No set'),
 CASE WHEN q.exam_set_id=? THEN 'Already in this set'
 WHEN q.is_archived=1 THEN 'Archived — restore the exam first'
 WHEN EXISTS(SELECT 1 FROM personalized_quiz_assignments WHERE quiz_id=q.id) THEN 'Personalized practice — assigned to individual students'
 WHEN EXISTS(SELECT 1 FROM exam_set_starts WHERE set_id=q.exam_set_id) THEN 'Students have started the current set'
 ELSE '' END
 FROM quizzes q LEFT JOIN stages s ON s.id=q.stage_id LEFT JOIN exam_sets es ON es.id=q.exam_set_id
 WHERE ?='' OR q.title LIKE ? OR COALESCE(q.description,'') LIKE ? OR COALESCE(q.exam_type,'') LIKE ? OR COALESCE(es.name,'') LIKE ? OR CAST(q.id AS TEXT)=?
 ORDER BY q.title COLLATE NOCASE,q.id LIMIT ? OFFSET ?`, id, search, "%"+search+"%", "%"+search+"%", "%"+search+"%", "%"+search+"%", search, size+1, (page-1)*size)
	if err != nil {
		http.Error(w, "Could not search exams", 500)
		return
	}
	defer rows.Close()
	papers := []assignmentPaper{}
	for rows.Next() {
		var p assignmentPaper
		if err = rows.Scan(&p.ID, &p.Title, &p.Stage, &p.Board, &p.Set, &p.Reason); err != nil {
			http.Error(w, "Could not read exams", 500)
			return
		}
		papers = append(papers, p)
	}
	if rows.Err() != nil {
		http.Error(w, "Could not read exams", 500)
		return
	}
	hasNext := len(papers) > size
	if hasNext {
		papers = papers[:size]
	}
	pageURL := func(n int) string {
		q := url.Values{"search": {search}, "page": {strconv.Itoa(n)}}
		return "/admin/exam-sets/" + strconv.Itoa(id) + "/assign?" + q.Encode()
	}
	data := map[string]interface{}{"SetID": id, "SetName": name, "Board": board, "Stage": stage, "Published": published, "Started": started, "Search": search, "Papers": papers, "Error": r.URL.Query().Get("error"), "Message": r.URL.Query().Get("message"), "HasPrevious": page > 1, "HasNext": hasNext, "PreviousURL": pageURL(page - 1), "NextURL": pageURL(page + 1)}
	template.Must(template.ParseFiles("templates/assign_exam.html")).Execute(w, data)
}

func AssignExamHandler(w http.ResponseWriter, r *http.Request) {
	setID, err := strconv.Atoi(mux.Vars(r)["exam_set_id"])
	if err != nil || setID < 1 {
		http.NotFound(w, r)
		return
	}
	redirect := func(key, message string) {
		if r.FormValue("return_to") == "exam-sets" {
			redirectExamTypeManagement(w, r, "exam_type_"+key, message)
			return
		}
		q := url.Values{key: {message}, "search": {r.FormValue("search")}}
		http.Redirect(w, r, "/admin/exam-sets/"+strconv.Itoa(setID)+"/assign?"+q.Encode(), http.StatusSeeOther)
	}
	quizID, err := strconv.Atoi(r.FormValue("quiz_id"))
	if err != nil || quizID < 1 {
		redirect("error", "Choose a valid exam.")
		return
	}
	tx, err := database.DB.Begin()
	if err != nil {
		http.Error(w, "Server error", 500)
		return
	}
	defer tx.Rollback()
	var stageID int
	var board string
	var published, started bool
	err = tx.QueryRow(`SELECT es.stage_id,et.name,es.is_published,EXISTS(SELECT 1 FROM exam_set_starts WHERE set_id=es.id)
 FROM exam_sets es JOIN exam_types et ON et.id=es.exam_type_id WHERE es.id=?`, setID).Scan(&stageID, &board, &published, &started)
	if err != nil {
		redirect("error", "Set not found.")
		return
	}
	if published || started {
		redirect("error", "Choose an unstarted draft set. Unpublish it before assigning exams.")
		return
	}
	result, err := tx.Exec(`UPDATE quizzes SET exam_set_id=?,stage_id=?,exam_type=?,paper_order=(SELECT COALESCE(MAX(paper_order),0)+1 FROM quizzes WHERE exam_set_id=?)
 WHERE id=? AND is_archived=0 AND (exam_set_id IS NULL OR exam_set_id<>?)
 AND NOT EXISTS(SELECT 1 FROM personalized_quiz_assignments WHERE quiz_id=quizzes.id)
 AND NOT EXISTS(SELECT 1 FROM exam_set_starts WHERE set_id=quizzes.exam_set_id)`, setID, stageID, board, setID, quizID, setID)
	if err != nil {
		redirect("error", "Could not assign exam. A set students have started cannot change membership.")
		return
	}
	n, err := result.RowsAffected()
	if err != nil || n != 1 {
		redirect("error", "Exam is already assigned, archived, personalized, missing, or belongs to a started set.")
		return
	}
	if err = tx.Commit(); err != nil {
		redirect("error", "Could not save assignment.")
		return
	}
	redirect("message", "Exam assigned. Its exam type and stage now match this set. Publish the set when all papers are ready.")
}
