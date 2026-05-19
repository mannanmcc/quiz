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

func StudentDashboardHandler(w http.ResponseWriter, r *http.Request) {
	session, _ := middleware.Store.Get(r, "session")
	userID := session.Values["user_id"].(int)
	username := session.Values["username"].(string)

	tmpl := template.Must(template.ParseFiles("templates/student_dashboard.html"))

	// Get available quizzes
	rows, err := database.DB.Query(`
        SELECT id, title, description, created_at
        FROM quizzes
        ORDER BY created_at DESC
    `)
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	var quizzes []map[string]interface{}
	for rows.Next() {
		var id int
		var title, description, createdAt string
		rows.Scan(&id, &title, &description, &createdAt)

		// Check if student has already attempted
		var attemptCount int
		database.DB.QueryRow("SELECT COUNT(*) FROM quiz_attempts WHERE user_id = ? AND quiz_id = ?",
			userID, id).Scan(&attemptCount)

		quizzes = append(quizzes, map[string]interface{}{
			"id":          id,
			"title":       title,
			"description": description,
			"created_at":  createdAt,
			"attempted":   attemptCount > 0,
		})
	}

	// Get recent attempts
	attemptsRows, _ := database.DB.Query(`
        SELECT q.title, qa.score, qa.max_score, qa.completed_at
        FROM quiz_attempts qa
        JOIN quizzes q ON qa.quiz_id = q.id
        WHERE qa.user_id = ?
        ORDER BY qa.completed_at DESC
        LIMIT 5
    `, userID)
	defer attemptsRows.Close()

	var recentAttempts []map[string]interface{}
	for attemptsRows.Next() {
		var title, completedAt string
		var score, maxScore int
		attemptsRows.Scan(&title, &score, &maxScore, &completedAt)

		percentage := float64(score) / float64(maxScore) * 100

		recentAttempts = append(recentAttempts, map[string]interface{}{
			"title":        title,
			"score":        score,
			"max_score":    maxScore,
			"percentage":   percentage,
			"completed_at": completedAt,
		})
	}

	data := map[string]interface{}{
		"Username":       username,
		"Quizzes":        quizzes,
		"RecentAttempts": recentAttempts,
	}

	tmpl.Execute(w, data)
}

func GetQuizHandler(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	quizID := vars["quiz_id"]

	session, _ := middleware.Store.Get(r, "session")
	userID := session.Values["user_id"].(int)

	var attemptCount int
	err := database.DB.QueryRow(
		"SELECT COUNT(*) FROM quiz_attempts WHERE user_id = ? AND quiz_id = ?",
		userID, quizID,
	).Scan(&attemptCount)
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	if attemptCount > 0 {
		http.Error(w, "Quiz already completed", http.StatusLocked)
		return
	}

	// Get quiz details
	var quiz models.Quiz
	err = database.DB.QueryRow(
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

	// Get questions
	rows, err := database.DB.Query(`
        SELECT id, question_text, question_type, option1, option2, option3, option4, points
        FROM questions
        WHERE quiz_id = ?
    `, quizID)
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	var questions []models.Question
	for rows.Next() {
		var q models.Question
		var opt1, opt2, opt3, opt4 sql.NullString

		rows.Scan(&q.ID, &q.QuestionText, &q.QuestionType, &opt1, &opt2, &opt3, &opt4, &q.Points)
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

	response := map[string]interface{}{
		"quiz":      quiz,
		"questions": questions,
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(response)
}

func QuizPageHandler(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	quizID := vars["quiz_id"]

	session, _ := middleware.Store.Get(r, "session")
	userID := session.Values["user_id"].(int)

	var attemptCount int
	err := database.DB.QueryRow(
		"SELECT COUNT(*) FROM quiz_attempts WHERE user_id = ? AND quiz_id = ?",
		userID, quizID,
	).Scan(&attemptCount)
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	if attemptCount > 0 {
		http.Error(w, "This quiz is locked because you have already completed it.", http.StatusLocked)
		return
	}

	tmpl := template.Must(template.ParseFiles("templates/quiz.html"))

	data := map[string]interface{}{
		"QuizID": quizID,
	}

	tmpl.Execute(w, data)
}

func SubmitQuizHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
		return
	}

	vars := mux.Vars(r)
	quizID, _ := strconv.Atoi(vars["quiz_id"])

	session, _ := middleware.Store.Get(r, "session")
	userID := session.Values["user_id"].(int)

	var attemptCount int
	err := database.DB.QueryRow(
		"SELECT COUNT(*) FROM quiz_attempts WHERE user_id = ? AND quiz_id = ?",
		userID, quizID,
	).Scan(&attemptCount)
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	if attemptCount > 0 {
		http.Error(w, "Quiz already completed", http.StatusLocked)
		return
	}

	var req struct {
		Answers map[string]string `json:"answers"` // question_id -> answer
	}

	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		http.Error(w, "Invalid request", http.StatusBadRequest)
		return
	}

	// Start transaction
	tx, err := database.DB.Begin()
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	defer tx.Rollback()

	// Calculate score
	score := 0
	maxScore := 0

	for questionIDStr, selectedAnswer := range req.Answers {
		questionID, _ := strconv.Atoi(questionIDStr)

		var correctAnswer string
		var points int
		err := tx.QueryRow(
			"SELECT correct_answer, points FROM questions WHERE id = ?",
			questionID,
		).Scan(&correctAnswer, &points)

		if err != nil {
			continue
		}

		maxScore += points
		if selectedAnswer == correctAnswer {
			score += points
		}
	}

	// Insert attempt
	result, err := tx.Exec(
		"INSERT INTO quiz_attempts (user_id, quiz_id, score, max_score) VALUES (?, ?, ?, ?)",
		userID, quizID, score, maxScore,
	)
	if err != nil {
		http.Error(w, "Failed to save attempt", http.StatusInternalServerError)
		return
	}

	attemptID, _ := result.LastInsertId()

	// Insert answers
	for questionIDStr, selectedAnswer := range req.Answers {
		questionID, _ := strconv.Atoi(questionIDStr)

		var correctAnswer string
		tx.QueryRow("SELECT correct_answer FROM questions WHERE id = ?", questionID).Scan(&correctAnswer)

		isCorrect := selectedAnswer == correctAnswer

		tx.Exec(
			"INSERT INTO answers (attempt_id, question_id, selected_answer, is_correct) VALUES (?, ?, ?, ?)",
			attemptID, questionID, selectedAnswer, isCorrect,
		)
	}

	tx.Commit()

	percentage := float64(score) / float64(maxScore) * 100

	response := map[string]interface{}{
		"score":      score,
		"max_score":  maxScore,
		"percentage": percentage,
		"message":    "Quiz submitted successfully",
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(response)
}
