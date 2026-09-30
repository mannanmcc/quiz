package database

// Legacy sets are split by stage; imported content remains published.
func migrateExamSets() error {
	tx, err := DB.Begin()
	if err != nil {
		return err
	}
	defer tx.Rollback()
	var migrated int
	if _, err = tx.Exec(`CREATE TABLE IF NOT EXISTS schema_migrations (name TEXT PRIMARY KEY)`); err != nil {
		return err
	}
	if err = tx.QueryRow(`SELECT COUNT(*) FROM schema_migrations WHERE name='ordered_exam_sets'`).Scan(&migrated); err != nil {
		return err
	}
	if migrated == 0 {
		_, err = tx.Exec(`
 UPDATE quizzes SET exam_set_id=NULL WHERE EXISTS(SELECT 1 FROM personalized_quiz_assignments p WHERE p.quiz_id=quizzes.id);
 ALTER TABLE exam_sets RENAME TO legacy_exam_sets;
 CREATE TABLE exam_sets (
 id INTEGER PRIMARY KEY AUTOINCREMENT, exam_type_id INTEGER NOT NULL REFERENCES exam_types(id),
 stage_id INTEGER NOT NULL REFERENCES stages(id), name TEXT NOT NULL,
 sequence_number INTEGER NOT NULL CHECK(sequence_number>0), is_published BOOLEAN NOT NULL DEFAULT 0,
 created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
 UNIQUE(exam_type_id,stage_id,name), UNIQUE(exam_type_id,stage_id,sequence_number));
 INSERT INTO exam_sets(id,exam_type_id,stage_id,name,sequence_number,is_published,created_at)
 SELECT es.id,es.exam_type_id,COALESCE((SELECT MIN(stage_id) FROM quizzes WHERE exam_set_id=es.id),(SELECT id FROM stages WHERE name='General')),
 es.name,es.id,1,es.created_at FROM legacy_exam_sets es;
 INSERT INTO exam_sets(exam_type_id,stage_id,name,sequence_number,is_published)
 SELECT DISTINCT es.exam_type_id,q.stage_id,es.name,es.id,1 FROM legacy_exam_sets es JOIN quizzes q ON q.exam_set_id=es.id
 WHERE q.stage_id<>(SELECT stage_id FROM exam_sets WHERE id=es.id);
 UPDATE quizzes SET exam_set_id=(SELECT es.id FROM exam_sets es JOIN legacy_exam_sets old ON old.exam_type_id=es.exam_type_id AND old.name=es.name WHERE old.id=quizzes.exam_set_id AND es.stage_id=quizzes.stage_id) WHERE exam_set_id IS NOT NULL;
 DROP TABLE legacy_exam_sets;
 ALTER TABLE quizzes ADD COLUMN paper_order INTEGER NOT NULL DEFAULT 1;
 INSERT INTO schema_migrations VALUES('ordered_exam_sets');
 `)
		if err != nil {
			return err
		}
	}
	_, err = tx.Exec(`
 INSERT OR IGNORE INTO exam_sets(exam_type_id,stage_id,name,sequence_number,is_published)
 SELECT et.id,q.stage_id,'Imported papers ' || (COALESCE((SELECT MAX(sequence_number) FROM exam_sets WHERE exam_type_id=et.id AND stage_id=q.stage_id),0)+1),COALESCE((SELECT MAX(sequence_number) FROM exam_sets WHERE exam_type_id=et.id AND stage_id=q.stage_id),0)+1,1
 FROM quizzes q JOIN exam_types et ON et.name=q.exam_type COLLATE NOCASE
 WHERE q.exam_set_id IS NULL AND NOT EXISTS(SELECT 1 FROM personalized_quiz_assignments p WHERE p.quiz_id=q.id)
 GROUP BY et.id,q.stage_id;
 UPDATE quizzes SET exam_set_id=(SELECT es.id FROM exam_sets es JOIN exam_types et ON et.id=es.exam_type_id WHERE et.name=quizzes.exam_type COLLATE NOCASE AND es.stage_id=quizzes.stage_id AND es.name LIKE 'Imported papers %' ORDER BY es.sequence_number DESC LIMIT 1)
 WHERE exam_set_id IS NULL AND NOT EXISTS(SELECT 1 FROM personalized_quiz_assignments p WHERE p.quiz_id=quizzes.id);
 CREATE TABLE IF NOT EXISTS paper_completions(user_id INTEGER NOT NULL,quiz_id INTEGER NOT NULL,PRIMARY KEY(user_id,quiz_id));
 INSERT OR IGNORE INTO paper_completions SELECT user_id,quiz_id FROM quiz_attempts;
 CREATE TRIGGER IF NOT EXISTS record_paper_completion AFTER INSERT ON quiz_attempts BEGIN
 INSERT OR IGNORE INTO paper_completions(user_id,quiz_id) VALUES(NEW.user_id,NEW.quiz_id); END;
 CREATE TABLE IF NOT EXISTS exam_set_starts(user_id INTEGER NOT NULL,set_id INTEGER NOT NULL,PRIMARY KEY(user_id,set_id));
 INSERT OR IGNORE INTO exam_set_starts SELECT DISTINCT pc.user_id,q.exam_set_id FROM paper_completions pc JOIN quizzes q ON q.id=pc.quiz_id WHERE q.exam_set_id IS NOT NULL;
 CREATE TRIGGER IF NOT EXISTS record_set_attempt AFTER INSERT ON quiz_attempts BEGIN
 INSERT OR IGNORE INTO exam_set_starts(user_id,set_id) SELECT NEW.user_id,exam_set_id FROM quizzes WHERE id=NEW.quiz_id AND exam_set_id IS NOT NULL; END;
 CREATE TRIGGER IF NOT EXISTS protect_answered_question BEFORE DELETE ON questions WHEN EXISTS(SELECT 1 FROM answers WHERE question_id=OLD.id)
 BEGIN SELECT RAISE(ABORT,'Cannot remove a question with recorded answers'); END;
 CREATE TRIGGER IF NOT EXISTS clean_student_set_progress AFTER DELETE ON users BEGIN
 DELETE FROM paper_completions WHERE user_id=OLD.id;
 DELETE FROM exam_set_starts WHERE user_id=OLD.id; END;
 CREATE INDEX IF NOT EXISTS quizzes_set ON quizzes(exam_set_id,is_archived);
 CREATE TRIGGER IF NOT EXISTS set_publish_guard BEFORE UPDATE ON exam_sets
 WHEN (NEW.sequence_number<>OLD.sequence_number OR NEW.is_published<>OLD.is_published) AND (
 EXISTS(SELECT 1 FROM exam_set_starts st WHERE st.set_id=OLD.id)
 OR EXISTS(SELECT 1 FROM exam_set_starts st JOIN exam_sets es ON es.id=st.set_id WHERE es.exam_type_id=OLD.exam_type_id AND es.stage_id=OLD.stage_id AND es.sequence_number>=MIN(OLD.sequence_number,NEW.sequence_number)))
 BEGIN SELECT RAISE(ABORT,'Students have started this sequence'); END;
 CREATE TRIGGER IF NOT EXISTS set_publish_nonempty BEFORE UPDATE OF is_published ON exam_sets WHEN NEW.is_published=1 AND OLD.is_published=0 AND (
 NOT EXISTS(SELECT 1 FROM quizzes q WHERE q.exam_set_id=NEW.id AND q.is_archived=0)
 OR EXISTS(SELECT 1 FROM quizzes q WHERE q.exam_set_id=NEW.id AND q.is_archived=0 AND NOT EXISTS(SELECT 1 FROM questions WHERE quiz_id=q.id)))
 BEGIN SELECT RAISE(ABORT,'Add papers and questions before publishing'); END;
 CREATE TRIGGER IF NOT EXISTS paper_insert_guard BEFORE INSERT ON quizzes WHEN NEW.exam_set_id IS NOT NULL AND EXISTS(SELECT 1 FROM exam_set_starts WHERE set_id=NEW.exam_set_id)
 BEGIN SELECT RAISE(ABORT,'Cannot add papers to a started set'); END;
 CREATE TRIGGER IF NOT EXISTS paper_move_guard BEFORE UPDATE ON quizzes WHEN
 (NEW.exam_set_id IS NOT OLD.exam_set_id OR NEW.paper_order<>OLD.paper_order OR NEW.is_archived<>OLD.is_archived OR NEW.stage_id IS NOT OLD.stage_id)
 AND EXISTS(SELECT 1 FROM exam_set_starts WHERE set_id=OLD.exam_set_id OR set_id=NEW.exam_set_id)
 BEGIN SELECT RAISE(ABORT,'Cannot change membership of a started set'); END;
 CREATE TRIGGER IF NOT EXISTS paper_delete_guard BEFORE DELETE ON quizzes WHEN EXISTS(SELECT 1 FROM exam_set_starts WHERE set_id=OLD.exam_set_id)
 BEGIN SELECT RAISE(ABORT,'Cannot delete papers from a started set'); END;
 CREATE TRIGGER IF NOT EXISTS set_delete_guard BEFORE DELETE ON exam_sets WHEN EXISTS(SELECT 1 FROM quizzes WHERE exam_set_id=OLD.id) OR EXISTS(SELECT 1 FROM exam_set_starts WHERE set_id=OLD.id)
 BEGIN SELECT RAISE(ABORT,'Set is in use'); END;
 CREATE TRIGGER IF NOT EXISTS board_delete_guard BEFORE DELETE ON exam_types WHEN EXISTS(SELECT 1 FROM exam_sets WHERE exam_type_id=OLD.id)
 BEGIN SELECT RAISE(ABORT,'Board has sets'); END;

 `)
	if err != nil {
		return err
	}
	return tx.Commit()
}
