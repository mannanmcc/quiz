package database

import (
	"database/sql"
	"os"
	"testing"
)

func TestLegacySetMigration(t *testing.T) {
	var err error
	DB, err = sql.Open("sqlite3", ":memory:")
	if err != nil {
		t.Fatal(err)
	}
	DB.SetMaxOpenConns(1)
	defer DB.Close()
	_, err = DB.Exec(`CREATE TABLE users(id INTEGER PRIMARY KEY);
 CREATE TABLE stages(id INTEGER PRIMARY KEY,name TEXT); INSERT INTO stages VALUES(1,'General'),(2,'Year 5'),(3,'Year 6');
 CREATE TABLE exam_types(id INTEGER PRIMARY KEY,name TEXT); INSERT INTO exam_types VALUES(1,'CSSE');
 CREATE TABLE exam_sets(id INTEGER PRIMARY KEY,exam_type_id INTEGER,name TEXT,created_at DATETIME);INSERT INTO exam_sets VALUES(1,1,'Default',CURRENT_TIMESTAMP);
 CREATE TABLE quizzes(id INTEGER PRIMARY KEY,exam_set_id INTEGER,stage_id INTEGER,exam_type TEXT,is_archived BOOLEAN DEFAULT 0);INSERT INTO quizzes VALUES(1,1,2,'CSSE',0),(2,1,3,'CSSE',0),(3,NULL,2,'CSSE',0);
 CREATE TABLE quiz_attempts(user_id INTEGER,quiz_id INTEGER);INSERT INTO quiz_attempts VALUES(7,1);
 CREATE TABLE questions(id INTEGER,quiz_id INTEGER);CREATE TABLE answers(question_id INTEGER);
 CREATE TABLE personalized_quiz_assignments(user_id INTEGER,quiz_id INTEGER);
 INSERT INTO quizzes VALUES(4,1,2,'CSSE',0); INSERT INTO personalized_quiz_assignments VALUES(7,4);`)
	if err != nil {
		t.Fatal(err)
	}
	for i := 0; i < 2; i++ {
		if err := migrateExamSets(); err != nil {
			t.Fatal(err)
		}
	}
	var count int
	if err := DB.QueryRow("SELECT COUNT(*) FROM quizzes WHERE id=4 AND exam_set_id IS NULL").Scan(&count); err != nil || count != 1 {
		t.Fatalf("personal practice migration %d %v", count, err)
	}
	if err := DB.QueryRow("SELECT COUNT(*) FROM quizzes q JOIN exam_sets es ON es.id=q.exam_set_id WHERE q.stage_id=es.stage_id").Scan(&count); err != nil || count != 3 {
		t.Fatalf("stage assignments %d %v", count, err)
	}
	if err := DB.QueryRow("SELECT COUNT(*) FROM paper_completions WHERE user_id=7 AND quiz_id=1").Scan(&count); err != nil || count != 1 {
		t.Fatalf("completion %d %v", count, err)
	}
}

func TestSeededStartupTwice(t *testing.T) {
	seed, err := os.ReadFile("../../seed_year5_vocabulary_exams.sql")
	if err != nil {
		t.Fatal(err)
	}
	t.Chdir(t.TempDir())
	if err = os.WriteFile("seed_year5_vocabulary_exams.sql", seed, 0600); err != nil {
		t.Fatal(err)
	}
	if err = InitDB(); err != nil {
		t.Fatal(err)
	}
	var count int
	if err = DB.QueryRow("SELECT COUNT(*) FROM quizzes WHERE exam_set_id IS NULL").Scan(&count); err != nil || count != 0 {
		t.Fatalf("unassigned seed papers: %d %v", count, err)
	}
	var paperID int
	if err = DB.QueryRow("SELECT MIN(id) FROM quizzes WHERE is_archived=0").Scan(&paperID); err != nil {
		t.Fatal(err)
	}
	if _, err = DB.Exec("INSERT INTO quiz_attempts(user_id,quiz_id,score,max_score) VALUES(1,?,0,1)", paperID); err != nil {
		t.Fatal(err)
	}
	DB.Close()
	if err = InitDB(); err != nil {
		t.Fatal(err)
	}
	defer DB.Close()
	if err = DB.QueryRow("SELECT COUNT(*) FROM paper_completions WHERE quiz_id=?", paperID).Scan(&count); err != nil || count != 1 {
		t.Fatalf("completion after restart: %d %v", count, err)
	}
}
