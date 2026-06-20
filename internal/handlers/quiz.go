package handlers

import (
	"database/sql"
	"encoding/json"
	"html/template"
	"log"
	"net/http"
	"strconv"
	"vocabulary-quiz-app/internal/database"
	"vocabulary-quiz-app/internal/middleware"
	"vocabulary-quiz-app/internal/models"

	"github.com/gorilla/mux"
)

func StudentDashboardHandler(w http.ResponseWriter, r *http.Request) {
	session, _ := middleware.Store.Get(r, "session")
	userID := session.Values["user_id"].(int)
	username := session.Values["username"].(string)

	tmpl := template.Must(template.ParseFiles("templates/student_dashboard.html"))

	// Get available quizzes
	rows, err := database.DB.Query(`
        SELECT id, title, description, created_at, unlock_version, lock_after_attempt
        FROM quizzes
        WHERE is_archived = 0
        ORDER BY created_at DESC
    `)
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	var quizzes []map[string]interface{}
	for rows.Next() {
		var id, unlockVersion int
		var lockAfterAttempt bool
		var title, description, createdAt string
		rows.Scan(&id, &title, &description, &createdAt, &unlockVersion, &lockAfterAttempt)

		var attemptCount int
		database.DB.QueryRow("SELECT COUNT(*) FROM quiz_attempts WHERE user_id = ? AND quiz_id = ?",
			userID, id).Scan(&attemptCount)

		var currentAttemptCount int
		database.DB.QueryRow("SELECT COUNT(*) FROM quiz_attempts WHERE user_id = ? AND quiz_id = ? AND unlock_version = ?",
			userID, id, unlockVersion).Scan(&currentAttemptCount)

		quizzes = append(quizzes, map[string]interface{}{
			"id":                 id,
			"title":              title,
			"description":        description,
			"created_at":         createdAt,
			"attempts":           attemptCount,
			"locked":             lockAfterAttempt && currentAttemptCount > 0,
			"unlock_version":     unlockVersion,
			"lock_after_attempt": lockAfterAttempt,
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

	// Get quiz details
	var quiz models.Quiz
	var unlockVersion int
	var isArchived bool
	err := database.DB.QueryRow(
		"SELECT id, title, description, unlock_version, lock_after_attempt, is_archived FROM quizzes WHERE id = ?",
		quizID,
	).Scan(&quiz.ID, &quiz.Title, &quiz.Description, &unlockVersion, &quiz.LockAfterAttempt, &isArchived)

	if err != nil {
		if err == sql.ErrNoRows {
			http.Error(w, "Quiz not found", http.StatusNotFound)
			return
		}
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}

	if isArchived {
		http.Error(w, "Quiz not found", http.StatusNotFound)
		return
	}

	var attemptCount int
	err = database.DB.QueryRow(
		"SELECT COUNT(*) FROM quiz_attempts WHERE user_id = ? AND quiz_id = ? AND unlock_version = ?",
		userID, quizID, unlockVersion,
	).Scan(&attemptCount)
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	if quiz.LockAfterAttempt && attemptCount > 0 {
		http.Error(w, "This exam is locked until the admin unlocks it again.", http.StatusLocked)
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

	var unlockVersion int
	var lockAfterAttempt bool
	var isArchived bool
	err := database.DB.QueryRow("SELECT unlock_version, lock_after_attempt, is_archived FROM quizzes WHERE id = ?", quizID).Scan(&unlockVersion, &lockAfterAttempt, &isArchived)
	if err != nil {
		if err == sql.ErrNoRows {
			http.Error(w, "Quiz not found", http.StatusNotFound)
			return
		}
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}

	if isArchived {
		http.Error(w, "Quiz not found", http.StatusNotFound)
		return
	}

	var attemptCount int
	err = database.DB.QueryRow(
		"SELECT COUNT(*) FROM quiz_attempts WHERE user_id = ? AND quiz_id = ? AND unlock_version = ?",
		userID, quizID, unlockVersion,
	).Scan(&attemptCount)
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	if lockAfterAttempt && attemptCount > 0 {
		http.Error(w, "This exam is locked until the admin unlocks it again.", http.StatusLocked)
		return
	}

	w.Header().Set("Cache-Control", "no-store, no-cache, must-revalidate, proxy-revalidate")
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

	var unlockVersion int
	var lockAfterAttempt bool
	var isArchived bool
	err := database.DB.QueryRow("SELECT unlock_version, lock_after_attempt, is_archived FROM quizzes WHERE id = ?", quizID).Scan(&unlockVersion, &lockAfterAttempt, &isArchived)
	if err != nil {
		if err == sql.ErrNoRows {
			http.Error(w, "Quiz not found", http.StatusNotFound)
			return
		}
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}

	if isArchived {
		http.Error(w, "Quiz not found", http.StatusNotFound)
		return
	}

	var attemptCount int
	err = database.DB.QueryRow(
		"SELECT COUNT(*) FROM quiz_attempts WHERE user_id = ? AND quiz_id = ? AND unlock_version = ?",
		userID, quizID, unlockVersion,
	).Scan(&attemptCount)
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	if lockAfterAttempt && attemptCount > 0 {
		http.Error(w, "This exam is locked until the admin unlocks it again.", http.StatusLocked)
		return
	}

	var req struct {
		Answers map[string]string `json:"answers"` // question_id -> answer
	}

	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		http.Error(w, "Invalid request", http.StatusBadRequest)
		return
	}

	log.Printf("SubmitQuizHandler called quiz_id=%d user_id=%d answers=%d", quizID, userID, len(req.Answers))

	// Start transaction
	tx, err := database.DB.Begin()
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	defer tx.Rollback()

	// Calculate score and build a detailed feedback report.
	score := 0
	maxScore := 0

	err = tx.QueryRow("SELECT COALESCE(SUM(points), 0) FROM questions WHERE quiz_id = ?", quizID).Scan(&maxScore)
	if err != nil {
		http.Error(w, "Failed to score quiz", http.StatusInternalServerError)
		return
	}
	if maxScore == 0 {
		http.Error(w, "Quiz has no questions", http.StatusBadRequest)
		return
	}

	rows, err := tx.Query(
		"SELECT id, question_text, correct_answer, points FROM questions WHERE quiz_id = ? ORDER BY id",
		quizID,
	)
	if err != nil {
		http.Error(w, "Failed to build answer report", http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	report := make([]map[string]interface{}, 0)
	for rows.Next() {
		var questionID int
		var questionText, correctAnswer string
		var points int

		if err := rows.Scan(&questionID, &questionText, &correctAnswer, &points); err != nil {
			continue
		}

		selectedAnswer := req.Answers[strconv.Itoa(questionID)]
		isCorrect := selectedAnswer != "" && selectedAnswer == correctAnswer
		if isCorrect {
			score += points
		}

		report = append(report, map[string]interface{}{
			"question_id":     questionID,
			"question_text":   questionText,
			"selected_answer": selectedAnswer,
			"correct_answer":  correctAnswer,
			"is_correct":      isCorrect,
			"points":          points,
		})
	}

	// Insert attempt
	result, err := tx.Exec(
		"INSERT INTO quiz_attempts (user_id, quiz_id, score, max_score, unlock_version) VALUES (?, ?, ?, ?, ?)",
		userID, quizID, score, maxScore, unlockVersion,
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
		err := tx.QueryRow("SELECT correct_answer FROM questions WHERE id = ? AND quiz_id = ?", questionID, quizID).Scan(&correctAnswer)
		if err != nil {
			continue
		}

		isCorrect := selectedAnswer == correctAnswer

		tx.Exec(
			"INSERT INTO answers (attempt_id, question_id, selected_answer, is_correct) VALUES (?, ?, ?, ?)",
			attemptID, questionID, selectedAnswer, isCorrect,
		)
	}

	tx.Commit()

	percentage := 0.0
	if maxScore > 0 {
		percentage = float64(score) / float64(maxScore) * 100
	}

	response := map[string]interface{}{
		"score":           score,
		"max_score":       maxScore,
		"percentage":      percentage,
		"message":         "Quiz submitted successfully",
		"report":          report,
		"handler_version": "v2",
	}

	log.Printf("SubmitQuizHandler returning report size=%d quiz_id=%d user_id=%d", len(report), quizID, userID)

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(response)
}
