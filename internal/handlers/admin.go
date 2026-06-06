package handlers

import (
	"database/sql"
	"encoding/json"
	"github.com/gorilla/mux"
	"html/template"
	"net/http"
	"strconv"
	"vocabulary-quiz-app/internal/database"
	"vocabulary-quiz-app/internal/middleware"
	"vocabulary-quiz-app/internal/models"
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
	Title       string                `json:"title"`
	Description string                `json:"description"`
	Questions   []quizQuestionRequest `json:"questions"`
}

func AdminDashboardHandler(w http.ResponseWriter, r *http.Request) {
	tmpl := template.Must(template.ParseFiles("templates/admin_dashboard.html"))

	// Get all quizzes
	rows, err := database.DB.Query(`
        SELECT q.id, q.title, q.description, q.created_at, u.full_name
        FROM quizzes q
        JOIN users u ON q.created_by = u.id
        ORDER BY q.created_at DESC
    `)
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	var quizzes []map[string]interface{}
	for rows.Next() {
		var id int
		var title, description, createdAt, createdBy string
		rows.Scan(&id, &title, &description, &createdAt, &createdBy)
		quizzes = append(quizzes, map[string]interface{}{
			"id":          id,
			"title":       title,
			"description": description,
			"created_at":  createdAt,
			"created_by":  createdBy,
		})
	}

	data := map[string]interface{}{
		"Quizzes": quizzes,
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
		"INSERT INTO quizzes (title, description, created_by) VALUES (?, ?, ?)",
		req.Title, req.Description, userID,
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
		"SELECT id, title, description FROM quizzes WHERE id = ?",
		quizID,
	).Scan(&quiz.ID, &quiz.Title, &quiz.Description)
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

	result, err := tx.Exec("UPDATE quizzes SET title = ?, description = ? WHERE id = ?", req.Title, req.Description, quizID)
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

func ResetQuizAttemptsHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
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

	_, err = tx.Exec(`
        DELETE FROM answers
        WHERE attempt_id IN (
            SELECT id FROM quiz_attempts WHERE quiz_id = ?
        )
    `, quizID)
	if err != nil {
		http.Error(w, "Failed to reset quiz answers", http.StatusInternalServerError)
		return
	}

	result, err := tx.Exec("DELETE FROM quiz_attempts WHERE quiz_id = ?", quizID)
	if err != nil {
		http.Error(w, "Failed to reset quiz attempts", http.StatusInternalServerError)
		return
	}

	if err := tx.Commit(); err != nil {
		http.Error(w, "Failed to reset quiz", http.StatusInternalServerError)
		return
	}

	deleted, _ := result.RowsAffected()
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(map[string]interface{}{
		"message":          "Quiz reset successfully",
		"deleted_attempts": deleted,
	})
}
