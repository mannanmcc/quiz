package handlers

import (
	"database/sql"
	"encoding/json"
	"html/template"
	"net/http"
	"strconv"
	"vocabulary-quiz-app/internal/database"
	"vocabulary-quiz-app/internal/middleware"
	"vocabulary-quiz-app/internal/models"

	"github.com/gorilla/mux"
)

type quizQuestionRequest struct {
	ID            int      `json:"id"`
	QuestionText  string   `json:"question_text"`
	QuestionType  string   `json:"question_type"`
	CorrectAnswer string   `json:"correct_answer"`
	Options       []string `json:"options"`
	Points        int      `json:"points"`
}

type saveQuizRequest struct {
	Title            string                `json:"title"`
	Description      string                `json:"description"`
	LockAfterAttempt *bool                 `json:"lock_after_attempt"`
	Questions        []quizQuestionRequest `json:"questions"`
}

func (req saveQuizRequest) shouldLockAfterAttempt() bool {
	if req.LockAfterAttempt == nil {
		return true
	}
	return *req.LockAfterAttempt
}

func AdminDashboardHandler(w http.ResponseWriter, r *http.Request) {
	tmpl := template.Must(template.ParseFiles("templates/admin_dashboard.html"))

	// Get all quizzes
	rows, err := database.DB.Query(`
        SELECT q.id, q.title, q.description, q.created_at, u.full_name, q.lock_after_attempt, q.is_archived
        FROM quizzes q
        JOIN users u ON q.created_by = u.id
        ORDER BY q.created_at DESC
    `)
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	var activeQuizzes []map[string]interface{} = []map[string]interface{}{}
	var archivedQuizzes []map[string]interface{} = []map[string]interface{}{}
	for rows.Next() {
		var id int
		var lockAfterAttempt bool
		var isArchived bool
		var title, description, createdAt, createdBy string
		rows.Scan(&id, &title, &description, &createdAt, &createdBy, &lockAfterAttempt, &isArchived)
		quiz := map[string]interface{}{
			"id":                 id,
			"title":              title,
			"description":        description,
			"created_at":         createdAt,
			"created_by":         createdBy,
			"lock_after_attempt": lockAfterAttempt,
			"is_archived":        isArchived,
		}
		if isArchived {
			archivedQuizzes = append(archivedQuizzes, quiz)
		} else {
			activeQuizzes = append(activeQuizzes, quiz)
		}
	}

	data := map[string]interface{}{
		"ActiveQuizzes":   activeQuizzes,
		"ArchivedQuizzes": archivedQuizzes,
	}
	tmpl.Execute(w, data)
}

func CreateQuizPageHandler(w http.ResponseWriter, r *http.Request) {
	tmpl := template.Must(template.ParseFiles("templates/create_quiz.html"))
	tmpl.Execute(w, nil)
}

func EditQuizPageHandler(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	quizID := vars["quiz_id"]

	var exists int
	err := database.DB.QueryRow("SELECT COUNT(*) FROM quizzes WHERE id = ?", quizID).Scan(&exists)
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	if exists == 0 {
		http.Error(w, "Quiz not found", http.StatusNotFound)
		return
	}

	tmpl := template.Must(template.ParseFiles("templates/edit_quiz.html"))
	tmpl.Execute(w, map[string]interface{}{
		"QuizID": quizID,
	})
}

func CreateQuizHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
		return
	}

	var req saveQuizRequest

	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		http.Error(w, "Invalid request", http.StatusBadRequest)
		return
	}

	// Get user ID from session
	session, _ := middleware.Store.Get(r, "session")
	userID := session.Values["user_id"].(int)

	// Start transaction
	tx, err := database.DB.Begin()
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	defer tx.Rollback()

	// Insert quiz
	result, err := tx.Exec(
		"INSERT INTO quizzes (title, description, created_by, lock_after_attempt) VALUES (?, ?, ?, ?)",
		req.Title, req.Description, userID, req.shouldLockAfterAttempt(),
	)
	if err != nil {
		http.Error(w, "Failed to create quiz", http.StatusInternalServerError)
		return
	}

	quizID, _ := result.LastInsertId()

	// Insert questions
	for _, q := range req.Questions {
		var opt1, opt2, opt3, opt4 sql.NullString
		if len(q.Options) > 0 {
			opt1 = sql.NullString{String: q.Options[0], Valid: true}
		}
		if len(q.Options) > 1 {
			opt2 = sql.NullString{String: q.Options[1], Valid: true}
		}
		if len(q.Options) > 2 {
			opt3 = sql.NullString{String: q.Options[2], Valid: true}
		}
		if len(q.Options) > 3 {
			opt4 = sql.NullString{String: q.Options[3], Valid: true}
		}

		_, err = tx.Exec(`
            INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
			quizID, q.QuestionText, q.QuestionType, q.CorrectAnswer, opt1, opt2, opt3, opt4, q.Points,
		)
		if err != nil {
			http.Error(w, "Failed to create questions", http.StatusInternalServerError)
			return
		}
	}

	tx.Commit()

	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(map[string]interface{}{
		"message": "Quiz created successfully",
		"quiz_id": quizID,
	})
}

func GetAdminQuizHandler(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	quizID := vars["quiz_id"]

	var quiz models.Quiz
	err := database.DB.QueryRow(
		"SELECT id, title, description, lock_after_attempt FROM quizzes WHERE id = ?",
		quizID,
	).Scan(&quiz.ID, &quiz.Title, &quiz.Description, &quiz.LockAfterAttempt)
	if err != nil {
		if err == sql.ErrNoRows {
			http.Error(w, "Quiz not found", http.StatusNotFound)
			return
		}
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}

	rows, err := database.DB.Query(`
        SELECT id, question_text, question_type, correct_answer, option1, option2, option3, option4, points
        FROM questions
        WHERE quiz_id = ?
        ORDER BY id
    `, quizID)
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	questions := []models.Question{}
	for rows.Next() {
		var q models.Question
		var opt1, opt2, opt3, opt4 sql.NullString

		if err := rows.Scan(&q.ID, &q.QuestionText, &q.QuestionType, &q.CorrectAnswer, &opt1, &opt2, &opt3, &opt4, &q.Points); err != nil {
			http.Error(w, "Server error", http.StatusInternalServerError)
			return
		}
		q.QuizID = quiz.ID
		q.Options = []string{}
		if opt1.Valid {
			q.Options = append(q.Options, opt1.String)
		}
		if opt2.Valid {
			q.Options = append(q.Options, opt2.String)
		}
		if opt3.Valid {
			q.Options = append(q.Options, opt3.String)
		}
		if opt4.Valid {
			q.Options = append(q.Options, opt4.String)
		}

		questions = append(questions, q)
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(map[string]interface{}{
		"quiz":      quiz,
		"questions": questions,
	})
}

func UpdateQuizHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPut {
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
		return
	}

	vars := mux.Vars(r)
	quizID, err := strconv.Atoi(vars["quiz_id"])
	if err != nil {
		http.Error(w, "Invalid quiz ID", http.StatusBadRequest)
		return
	}

	var req saveQuizRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		http.Error(w, "Invalid request", http.StatusBadRequest)
		return
	}

	if req.Title == "" || len(req.Questions) == 0 {
		http.Error(w, "Quiz title and at least one question are required", http.StatusBadRequest)
		return
	}

	tx, err := database.DB.Begin()
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	defer tx.Rollback()

	result, err := tx.Exec(
		"UPDATE quizzes SET title = ?, description = ?, lock_after_attempt = ?, unlock_version = unlock_version + 1 WHERE id = ?",
		req.Title, req.Description, req.shouldLockAfterAttempt(), quizID,
	)
	if err != nil {
		http.Error(w, "Failed to update quiz", http.StatusInternalServerError)
		return
	}
	updated, _ := result.RowsAffected()
	if updated == 0 {
		http.Error(w, "Quiz not found", http.StatusNotFound)
		return
	}

	if _, err = tx.Exec(`
        DELETE FROM answers
        WHERE attempt_id IN (
            SELECT id FROM quiz_attempts WHERE quiz_id = ?
        )
    `, quizID); err != nil {
		http.Error(w, "Failed to clear existing answers", http.StatusInternalServerError)
		return
	}

	if _, err = tx.Exec("DELETE FROM quiz_attempts WHERE quiz_id = ?", quizID); err != nil {
		http.Error(w, "Failed to clear existing attempts", http.StatusInternalServerError)
		return
	}

	questionIDsToKeep := []int{}
	for _, q := range req.Questions {
		var opt1, opt2, opt3, opt4 sql.NullString
		if len(q.Options) > 0 {
			opt1 = sql.NullString{String: q.Options[0], Valid: true}
		}
		if len(q.Options) > 1 {
			opt2 = sql.NullString{String: q.Options[1], Valid: true}
		}
		if len(q.Options) > 2 {
			opt3 = sql.NullString{String: q.Options[2], Valid: true}
		}
		if len(q.Options) > 3 {
			opt4 = sql.NullString{String: q.Options[3], Valid: true}
		}

		if q.ID > 0 {
			result, err := tx.Exec(`
                UPDATE questions
                SET question_text = ?, question_type = ?, correct_answer = ?, option1 = ?, option2 = ?, option3 = ?, option4 = ?, points = ?
                WHERE id = ? AND quiz_id = ?`,
				q.QuestionText, q.QuestionType, q.CorrectAnswer, opt1, opt2, opt3, opt4, q.Points, q.ID, quizID,
			)
			if err != nil {
				http.Error(w, "Failed to update questions", http.StatusInternalServerError)
				return
			}

			updated, _ := result.RowsAffected()
			if updated == 0 {
				http.Error(w, "Question not found for this quiz", http.StatusBadRequest)
				return
			}

			questionIDsToKeep = append(questionIDsToKeep, q.ID)
			continue
		}

		result, err := tx.Exec(`
            INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
			quizID, q.QuestionText, q.QuestionType, q.CorrectAnswer, opt1, opt2, opt3, opt4, q.Points,
		)
		if err != nil {
			http.Error(w, "Failed to add questions", http.StatusInternalServerError)
			return
		}

		newQuestionID, _ := result.LastInsertId()
		questionIDsToKeep = append(questionIDsToKeep, int(newQuestionID))
	}

	if len(questionIDsToKeep) == 0 {
		http.Error(w, "At least one question is required", http.StatusBadRequest)
		return
	}

	deleteQuery := "DELETE FROM questions WHERE quiz_id = ?"
	deleteArgs := []interface{}{quizID}
	for index, questionID := range questionIDsToKeep {
		if index == 0 {
			deleteQuery += " AND id NOT IN (?"
		} else {
			deleteQuery += ", ?"
		}
		deleteArgs = append(deleteArgs, questionID)
	}
	deleteQuery += ")"

	if _, err = tx.Exec(deleteQuery, deleteArgs...); err != nil {
		http.Error(w, "Failed to remove deleted questions", http.StatusInternalServerError)
		return
	}

	if err := tx.Commit(); err != nil {
		http.Error(w, "Failed to save quiz", http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(map[string]interface{}{
		"message": "Quiz updated successfully",
		"quiz_id": quizID,
	})
}

func ArchiveQuizHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
		return
	}

	vars := mux.Vars(r)
	quizID := vars["quiz_id"]

	result, err := database.DB.Exec("UPDATE quizzes SET is_archived = 1 WHERE id = ?", quizID)
	if err != nil {
		http.Error(w, "Failed to archive exam", http.StatusInternalServerError)
		return
	}

	updated, _ := result.RowsAffected()
	if updated == 0 {
		http.Error(w, "Quiz not found", http.StatusNotFound)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(map[string]interface{}{
		"message": "Quiz archived successfully",
	})
}

func UnarchiveQuizHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
		return
	}

	vars := mux.Vars(r)
	quizID := vars["quiz_id"]

	result, err := database.DB.Exec("UPDATE quizzes SET is_archived = 0 WHERE id = ?", quizID)
	if err != nil {
		http.Error(w, "Failed to restore exam", http.StatusInternalServerError)
		return
	}

	updated, _ := result.RowsAffected()
	if updated == 0 {
		http.Error(w, "Quiz not found", http.StatusNotFound)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(map[string]interface{}{
		"message": "Quiz restored successfully",
	})
}

func DeleteQuizHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodDelete {
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
		return
	}

	vars := mux.Vars(r)
	quizID := vars["quiz_id"]

	tx, err := database.DB.Begin()
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	defer tx.Rollback()

	if _, err = tx.Exec(`
        DELETE FROM answers
        WHERE attempt_id IN (
            SELECT id FROM quiz_attempts WHERE quiz_id = ?
        )
    `, quizID); err != nil {
		http.Error(w, "Failed to delete quiz answers", http.StatusInternalServerError)
		return
	}

	if _, err = tx.Exec("DELETE FROM quiz_attempts WHERE quiz_id = ?", quizID); err != nil {
		http.Error(w, "Failed to delete quiz attempts", http.StatusInternalServerError)
		return
	}

	if _, err = tx.Exec("DELETE FROM questions WHERE quiz_id = ?", quizID); err != nil {
		http.Error(w, "Failed to delete quiz questions", http.StatusInternalServerError)
		return
	}

	result, err := tx.Exec("DELETE FROM quizzes WHERE id = ?", quizID)
	if err != nil {
		http.Error(w, "Failed to delete quiz", http.StatusInternalServerError)
		return
	}

	deleted, _ := result.RowsAffected()
	if deleted == 0 {
		http.Error(w, "Quiz not found", http.StatusNotFound)
		return
	}

	if err := tx.Commit(); err != nil {
		http.Error(w, "Failed to complete deletion", http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(map[string]interface{}{
		"message": "Quiz deleted successfully",
	})
}

func GetStudentResultsHandler(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	quizID := vars["quiz_id"]

	rows, err := database.DB.Query(`
        SELECT u.full_name, u.username, qa.score, qa.max_score, qa.completed_at
        FROM quiz_attempts qa
        JOIN users u ON qa.user_id = u.id
        WHERE qa.quiz_id = ?
        ORDER BY qa.completed_at DESC
    `, quizID)

	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	results := []map[string]interface{}{}
	for rows.Next() {
		var fullName, username, completedAt string
		var score, maxScore int
		rows.Scan(&fullName, &username, &score, &maxScore, &completedAt)

		percentage := float64(score) / float64(maxScore) * 100

		results = append(results, map[string]interface{}{
			"full_name":    fullName,
			"username":     username,
			"score":        score,
			"max_score":    maxScore,
			"percentage":   percentage,
			"completed_at": completedAt,
		})
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(results)
}

func GetQuizProgressReportHandler(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	quizID := vars["quiz_id"]

	rows, err := database.DB.Query(`
        SELECT u.id, u.full_name, u.username, qa.id, qa.score, qa.max_score, qa.completed_at
        FROM quiz_attempts qa
        JOIN users u ON qa.user_id = u.id
        WHERE qa.quiz_id = ?
        ORDER BY u.full_name, u.username, qa.completed_at ASC, qa.id ASC
    `, quizID)
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	type attemptReport struct {
		AttemptID   int     `json:"attempt_id"`
		Score       int     `json:"score"`
		MaxScore    int     `json:"max_score"`
		Percentage  float64 `json:"percentage"`
		CompletedAt string  `json:"completed_at"`
	}

	type studentReport struct {
		UserID            int             `json:"user_id"`
		FullName          string          `json:"full_name"`
		Username          string          `json:"username"`
		AttemptCount      int             `json:"attempt_count"`
		FirstPercentage   float64         `json:"first_percentage"`
		LatestPercentage  float64         `json:"latest_percentage"`
		BestPercentage    float64         `json:"best_percentage"`
		Improvement       float64         `json:"improvement"`
		FirstCompletedAt  string          `json:"first_completed_at"`
		LatestCompletedAt string          `json:"latest_completed_at"`
		Attempts          []attemptReport `json:"attempts"`
	}

	reports := []studentReport{}
	reportIndexByUserID := map[int]int{}

	for rows.Next() {
		var userID, attemptID, score, maxScore int
		var fullName, username, completedAt string
		if err := rows.Scan(&userID, &fullName, &username, &attemptID, &score, &maxScore, &completedAt); err != nil {
			http.Error(w, "Server error", http.StatusInternalServerError)
			return
		}

		percentage := 0.0
		if maxScore > 0 {
			percentage = float64(score) / float64(maxScore) * 100
		}

		attempt := attemptReport{
			AttemptID:   attemptID,
			Score:       score,
			MaxScore:    maxScore,
			Percentage:  percentage,
			CompletedAt: completedAt,
		}

		index, exists := reportIndexByUserID[userID]
		if !exists {
			reports = append(reports, studentReport{
				UserID:            userID,
				FullName:          fullName,
				Username:          username,
				AttemptCount:      1,
				FirstPercentage:   percentage,
				LatestPercentage:  percentage,
				BestPercentage:    percentage,
				Improvement:       0,
				FirstCompletedAt:  completedAt,
				LatestCompletedAt: completedAt,
				Attempts:          []attemptReport{attempt},
			})
			reportIndexByUserID[userID] = len(reports) - 1
			continue
		}

		report := &reports[index]
		report.AttemptCount++
		report.LatestPercentage = percentage
		report.LatestCompletedAt = completedAt
		report.Improvement = report.LatestPercentage - report.FirstPercentage
		if percentage > report.BestPercentage {
			report.BestPercentage = percentage
		}
		report.Attempts = append(report.Attempts, attempt)
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(reports)
}

func ResetQuizAttemptsHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
		return
	}

	vars := mux.Vars(r)
	quizID := vars["quiz_id"]

	result, err := database.DB.Exec("UPDATE quizzes SET unlock_version = unlock_version + 1 WHERE id = ?", quizID)
	if err != nil {
		http.Error(w, "Failed to unlock quiz", http.StatusInternalServerError)
		return
	}
	updated, _ := result.RowsAffected()
	if updated == 0 {
		http.Error(w, "Quiz not found", http.StatusNotFound)
		return
	}

	var unlockVersion int
	if err := database.DB.QueryRow("SELECT unlock_version FROM quizzes WHERE id = ?", quizID).Scan(&unlockVersion); err != nil {
		http.Error(w, "Failed to read unlock state", http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(map[string]interface{}{
		"message":        "Quiz unlocked successfully",
		"unlock_version": unlockVersion,
	})
}
