package handlers

import (
	"github.com/gorilla/mux"
	"net/http/httptest"
	"net/url"
	"strings"
	"testing"
	"vocabulary-quiz-app/internal/database"
)

func TestEditSetDetails(t *testing.T) {
	setupSets(t)
	update := func(id, name, board, stage, sequence, status string) bool {
		form := url.Values{"name": {name}, "exam_type_id": {board}, "stage_id": {stage}, "sequence_number": {sequence}, "is_published": {status}}
		r := httptest.NewRequest("POST", "/admin/exam-sets/"+id+"/update", strings.NewReader(form.Encode()))
		r.Header.Set("Content-Type", "application/x-www-form-urlencoded")
		r = mux.SetURLVars(r, map[string]string{"exam_set_id": id})
		w := httptest.NewRecorder()
		UpdateExamSetHandler(w, r)
		return w.Code == 303 && strings.Contains(w.Header().Get("Location"), "exam_type_message=")
	}
	if !update("104", "New title", "101", "3", "2", "0") {
		t.Fatal("draft editing failed")
	}
	var name, board string
	var stage int
	if err := database.DB.QueryRow("SELECT name FROM exam_sets WHERE id=104").Scan(&name); err != nil || name != "New title" {
		t.Fatalf("name %s %v", name, err)
	}
	if err := database.DB.QueryRow("SELECT exam_type,stage_id FROM quizzes WHERE id=105").Scan(&board, &stage); err != nil || board != "GL" || stage != 3 {
		t.Fatalf("papers not synchronized: %s %d %v", board, stage, err)
	}
	if err := recordSetStart(100, 100); err != nil {
		t.Fatal(err)
	}
	if !update("100", "Renamed after starting", "100", "2", "1", "1") {
		t.Fatal("started set rename failed")
	}
	for _, args := range [][6]string{
		{"100", "Invalid move", "101", "2", "1", "1"},
		{"100", "Invalid sequence", "100", "2", "8", "1"},
		{"100", "Invalid status", "100", "2", "1", "0"},
		{"104", " ", "101", "3", "2", "0"},
		{"104", "Invalid board", "999", "3", "2", "0"},
		{"104", "Duplicate sequence", "100", "2", "4", "0"},
	} {
		if update(args[0], args[1], args[2], args[3], args[4], args[5]) {
			t.Fatalf("invalid edit accepted: %v", args)
		}
	}
	if err := database.DB.QueryRow("SELECT name FROM exam_sets WHERE id=104").Scan(&name); err != nil || name != "New title" {
		t.Fatal("failed edit changed name")
	}
}
