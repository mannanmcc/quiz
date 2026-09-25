package handlers

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"html/template"
	"net/http"
	"strconv"
	"strings"
	"vocabulary-quiz-app/internal/database"
	"vocabulary-quiz-app/internal/middleware"
	"vocabulary-quiz-app/internal/models"

	"github.com/gorilla/mux"
)

type quizQuestionRequest struct {
	ID                int      `json:"id"`
	QuestionContext   string   `json:"question_context"`
	QuestionText      string   `json:"question_text"`
	QuestionDiagram   string   `json:"question_diagram"`
	AnswerExplanation string   `json:"answer_explanation"`
	QuestionType      string   `json:"question_type"`
	CorrectAnswer     string   `json:"correct_answer"`
	Options           []string `json:"options"`
	Points            int      `json:"points"`
}

type saveQuizRequest struct {
	Title            string                `json:"title"`
	Description      string                `json:"description"`
	StageID          int                   `json:"stage_id"`
	TimeLimitMinutes int                   `json:"time_limit_minutes"`
	LockAfterAttempt *bool                 `json:"lock_after_attempt"`
	Questions        []quizQuestionRequest `json:"questions"`
}

type personalizedPracticeRequest struct {
	StudentID        int    `json:"student_id"`
	QuizIDs          []int  `json:"quiz_ids"`
	Title            string `json:"title"`
	Description      string `json:"description"`
	TimeLimitMinutes int    `json:"time_limit_minutes"`
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
        SELECT q.id, q.title, q.description, q.created_at, u.full_name, q.lock_after_attempt, q.is_archived, COALESCE(s.name, 'General'), COALESCE(q.time_limit_minutes, 0)
        FROM quizzes q
        JOIN users u ON q.created_by = u.id
        LEFT JOIN stages s ON q.stage_id = s.id
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
		var timeLimitMinutes int
		var lockAfterAttempt bool
		var isArchived bool
		var title, description, createdAt, createdBy, stageName string
		rows.Scan(&id, &title, &description, &createdAt, &createdBy, &lockAfterAttempt, &isArchived, &stageName, &timeLimitMinutes)
		quiz := map[string]interface{}{
			"id":                 id,
			"title":              title,
			"description":        description,
			"created_at":         createdAt,
			"created_by":         createdBy,
			"stage_name":         stageName,
			"time_limit_minutes": timeLimitMinutes,
			"lock_after_attempt": lockAfterAttempt,
			"is_archived":        isArchived,
		}
		if isArchived {
			archivedQuizzes = append(archivedQuizzes, quiz)
		} else {
			activeQuizzes = append(activeQuizzes, quiz)
		}
	}

	studentRows, err := database.DB.Query(`
        SELECT
            u.id,
            u.full_name,
            u.username,
            COALESCE(s.name, 'No stage'),
            COALESCE(u.is_disabled, 0),
            u.created_at,
            COUNT(qa.id),
            COALESCE(SUM(qa.score), 0),
            COALESCE(SUM(qa.max_score), 0),
            MAX(qa.completed_at),
            (
                SELECT COUNT(*)
                FROM quizzes q
                WHERE q.is_archived = 0 AND q.stage_id = u.stage_id
            )
        FROM users u
        LEFT JOIN stages s ON u.stage_id = s.id
        LEFT JOIN quiz_attempts qa ON qa.user_id = u.id
        WHERE u.role = 'student'
        GROUP BY u.id, u.full_name, u.username, s.name, u.is_disabled, u.created_at, u.stage_id
        ORDER BY u.created_at DESC
    `)
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	defer studentRows.Close()

	var students []map[string]interface{} = []map[string]interface{}{}
	for studentRows.Next() {
		var id, attemptCount, totalScore, totalMaxScore, assignedQuizzes int
		var isDisabled bool
		var fullName, username, stageName, createdAt string
		var lastAttempt sql.NullString

		if err := studentRows.Scan(&id, &fullName, &username, &stageName, &isDisabled, &createdAt, &attemptCount, &totalScore, &totalMaxScore, &lastAttempt, &assignedQuizzes); err != nil {
			http.Error(w, "Server error", http.StatusInternalServerError)
			return
		}

		averagePercentage := 0.0
		if totalMaxScore > 0 {
			averagePercentage = float64(totalScore) / float64(totalMaxScore) * 100
		}

		lastAttemptAt := "No attempts yet"
		if lastAttempt.Valid {
			lastAttemptAt = lastAttempt.String
		}

		students = append(students, map[string]interface{}{
			"id":                 id,
			"full_name":          fullName,
			"username":           username,
			"stage_name":         stageName,
			"is_disabled":        isDisabled,
			"created_at":         createdAt,
			"attempt_count":      attemptCount,
			"average_percentage": averagePercentage,
			"last_attempt_at":    lastAttemptAt,
			"assigned_quizzes":   assignedQuizzes,
		})
	}

	data := map[string]interface{}{
		"ActiveQuizzes":      activeQuizzes,
		"ArchivedQuizzes":    archivedQuizzes,
		"Students":           students,
		"StudentRegistered":  r.URL.Query().Get("registered") == "student",
		"RegisteredUsername": r.URL.Query().Get("username"),
		"StudentAction":      r.URL.Query().Get("student_action"),
		"StudentActionName":  r.URL.Query().Get("student_name"),
	}
	tmpl.Execute(w, data)
}

func CreateQuizPageHandler(w http.ResponseWriter, r *http.Request) {
	tmpl := template.Must(template.ParseFiles("templates/create_quiz.html"))
	stages, err := getStages()
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	tmpl.Execute(w, map[string]interface{}{
		"Stages": stages,
	})
}

func CreateStudentPageHandler(w http.ResponseWriter, r *http.Request) {
	tmpl := template.Must(template.ParseFiles("templates/create_student.html"))
	stages, err := getStages()
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	tmpl.Execute(w, map[string]interface{}{
		"Stages": stages,
	})
}

func CreatePersonalizedPracticePageHandler(w http.ResponseWriter, r *http.Request) {
	tmpl := template.Must(template.ParseFiles("templates/create_personalized_paper.html"))

	studentsRows, err := database.DB.Query(`
		SELECT id, full_name, username
		FROM users
		WHERE role = 'student'
		ORDER BY full_name, username
	`)
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	defer studentsRows.Close()

	students := []map[string]interface{}{}
	for studentsRows.Next() {
		var id int
		var fullName, username string
		if err := studentsRows.Scan(&id, &fullName, &username); err != nil {
			http.Error(w, "Server error", http.StatusInternalServerError)
			return
		}
		students = append(students, map[string]interface{}{
			"id":        id,
			"full_name": fullName,
			"username":  username,
		})
	}

	quizRows, err := database.DB.Query(`
		SELECT id, title, description
		FROM quizzes
		WHERE is_archived = 0
		ORDER BY created_at DESC
	`)
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	defer quizRows.Close()

	quizzes := []map[string]interface{}{}
	for quizRows.Next() {
		var id int
		var title, description string
		if err := quizRows.Scan(&id, &title, &description); err != nil {
			http.Error(w, "Server error", http.StatusInternalServerError)
			return
		}
		quizzes = append(quizzes, map[string]interface{}{
			"id":          id,
			"title":       title,
			"description": description,
		})
	}

	tmpl.Execute(w, map[string]interface{}{
		"Students": students,
		"Quizzes":  quizzes,
	})
}

func CreatePersonalizedPracticePaperHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
		return
	}

	var req personalizedPracticeRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		http.Error(w, "Invalid request", http.StatusBadRequest)
		return
	}

	if req.StudentID <= 0 || len(req.QuizIDs) == 0 {
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusBadRequest)
		json.NewEncoder(w).Encode(map[string]string{"error": "Please select a student and at least one quiz"})
		return
	}

	var studentName, studentUsername, stageName string
	var studentStageID int
	err := database.DB.QueryRow(`
		SELECT u.full_name, u.username, COALESCE(s.name, 'General'), COALESCE(u.stage_id, 0)
		FROM users u
		LEFT JOIN stages s ON s.id = u.stage_id
		WHERE u.id = ? AND u.role = 'student'
	`, req.StudentID).Scan(&studentName, &studentUsername, &stageName, &studentStageID)
	if err == sql.ErrNoRows {
		http.Error(w, "Student not found", http.StatusNotFound)
		return
	}
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}

	quizPlaceholders := make([]string, len(req.QuizIDs))
	quizArgs := make([]interface{}, len(req.QuizIDs))
	for i, quizID := range req.QuizIDs {
		quizPlaceholders[i] = "?"
		quizArgs[i] = quizID
	}
	quizFilter := strings.Join(quizPlaceholders, ", ")

	query := fmt.Sprintf(`
		SELECT DISTINCT q.id, COALESCE(q.question_context, ''), q.question_text, COALESCE(q.question_diagram, ''), COALESCE(q.answer_explanation, ''), q.question_type, q.correct_answer, q.option1, q.option2, q.option3, q.option4, q.points
		FROM (
			SELECT qa.quiz_id, MAX(qa.id) AS last_attempt_id
			FROM quiz_attempts qa
			WHERE qa.user_id = ? AND qa.quiz_id IN (%s)
			GROUP BY qa.quiz_id
		) latest_attempts
		JOIN answers a ON a.attempt_id = latest_attempts.last_attempt_id
		JOIN questions q ON q.id = a.question_id
		WHERE a.is_correct = 0
		ORDER BY q.id
	`, quizFilter)
	args := append([]interface{}{req.StudentID}, quizArgs...)

	rows, err := database.DB.Query(query, args...)
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	questions := []models.Question{}
	for rows.Next() {
		var q models.Question
		var opt1, opt2, opt3, opt4 sql.NullString
		if err := rows.Scan(&q.ID, &q.QuestionContext, &q.QuestionText, &q.QuestionDiagram, &q.AnswerExplanation, &q.QuestionType, &q.CorrectAnswer, &opt1, &opt2, &opt3, &opt4, &q.Points); err != nil {
			http.Error(w, "Server error", http.StatusInternalServerError)
			return
		}
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
	if len(questions) == 0 {
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusBadRequest)
		json.NewEncoder(w).Encode(map[string]string{"error": "No incorrect questions were found for the selected quizzes and student."})
		return
	}

	session, _ := middleware.Store.Get(r, "session")
	adminID := session.Values["user_id"].(int)
	if req.TimeLimitMinutes < 0 {
		http.Error(w, "Time limit cannot be negative", http.StatusBadRequest)
		return
	}

	quizTitle := strings.TrimSpace(req.Title)
	if quizTitle == "" {
		quizTitle = fmt.Sprintf("Personal Practice - %s", studentName)
	}

	tx, err := database.DB.Begin()
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	defer tx.Rollback()

	result, err := tx.Exec(
		"INSERT INTO quizzes (title, description, created_by, stage_id, time_limit_minutes, lock_after_attempt, is_archived) VALUES (?, ?, ?, ?, ?, ?, 0)",
		quizTitle,
		strings.TrimSpace(req.Description),
		adminID,
		studentStageID,
		req.TimeLimitMinutes,
		false,
	)
	if err != nil {
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusInternalServerError)
		json.NewEncoder(w).Encode(map[string]string{"error": "Failed to create practice paper"})
		return
	}
	newQuizID, err := result.LastInsertId()
	if err != nil {
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusInternalServerError)
		json.NewEncoder(w).Encode(map[string]string{"error": "Failed to create practice paper"})
		return
	}

	for _, q := range questions {
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

		if _, err := tx.Exec(`
			INSERT INTO questions (quiz_id, question_context, question_text, question_diagram, answer_explanation, question_type, correct_answer, option1, option2, option3, option4, points)
			VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
		`, newQuizID, q.QuestionContext, q.QuestionText, q.QuestionDiagram, q.AnswerExplanation, q.QuestionType, q.CorrectAnswer, opt1, opt2, opt3, opt4, q.Points); err != nil {
			w.Header().Set("Content-Type", "application/json")
			w.WriteHeader(http.StatusInternalServerError)
			json.NewEncoder(w).Encode(map[string]string{"error": "Failed to save practice paper questions"})
			return
		}
	}

	if _, err := tx.Exec("INSERT INTO personalized_quiz_assignments (user_id, quiz_id) VALUES (?, ?)", req.StudentID, newQuizID); err != nil {
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusInternalServerError)
		json.NewEncoder(w).Encode(map[string]string{"error": "Failed to assign practice paper"})
		return
	}

	if err := tx.Commit(); err != nil {
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusInternalServerError)
		json.NewEncoder(w).Encode(map[string]string{"error": "Failed to save practice paper"})
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(map[string]interface{}{
		"message":          "Personalized practice paper created",
		"quiz_id":          newQuizID,
		"student_name":     studentName,
		"student_username": studentUsername,
		"quiz_title":       quizTitle,
		"stage_name":       stageName,
	})
}

func EditStudentPageHandler(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	studentID, err := strconv.Atoi(vars["student_id"])
	if err != nil {
		http.Error(w, "Invalid student ID", http.StatusBadRequest)
		return
	}

	var id, stageID int
	var fullName, username, email string
	var isDisabled bool
	err = database.DB.QueryRow(`
		SELECT id, full_name, username, COALESCE(email, ''), COALESCE(stage_id, 0), COALESCE(is_disabled, 0)
		FROM users
		WHERE id = ? AND role = 'student'
	`, studentID).Scan(&id, &fullName, &username, &email, &stageID, &isDisabled)
	if err == sql.ErrNoRows {
		http.Error(w, "Student not found", http.StatusNotFound)
		return
	}
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}

	stages, err := getStages()
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}

	tmpl := template.Must(template.ParseFiles("templates/edit_student.html"))
	tmpl.Execute(w, map[string]interface{}{
		"Student": map[string]interface{}{
			"id":          id,
			"full_name":   fullName,
			"username":    username,
			"email":       email,
			"stage_id":    stageID,
			"is_disabled": isDisabled,
		},
		"Stages": stages,
	})
}

func UpdateStudentHandler(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	studentID, err := strconv.Atoi(vars["student_id"])
	if err != nil {
		http.Error(w, "Invalid student ID", http.StatusBadRequest)
		return
	}

	var req struct {
		Username   string `json:"username"`
		Password   string `json:"password"`
		FullName   string `json:"full_name"`
		Email      string `json:"email"`
		StageID    int    `json:"stage_id"`
		IsDisabled bool   `json:"is_disabled"`
	}
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		http.Error(w, "Invalid request", http.StatusBadRequest)
		return
	}

	req.Username = strings.TrimSpace(req.Username)
	req.Password = strings.TrimSpace(req.Password)
	req.FullName = strings.TrimSpace(req.FullName)
	email, validEmail := normalizeEmail(req.Email)

	if req.Username == "" || req.FullName == "" || !validEmail {
		http.Error(w, "Full name, username, and email are required", http.StatusBadRequest)
		return
	}
	if req.Password != "" && len(req.Password) < 6 {
		http.Error(w, "Password must be at least 6 characters", http.StatusBadRequest)
		return
	}

	exists, err := stageExists(req.StageID)
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	if !exists {
		http.Error(w, "Please select a valid stage", http.StatusBadRequest)
		return
	}

	var currentRole string
	if err := database.DB.QueryRow("SELECT role FROM users WHERE id = ?", studentID).Scan(&currentRole); err == sql.ErrNoRows {
		http.Error(w, "Student not found", http.StatusNotFound)
		return
	} else if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	if currentRole != "student" {
		http.Error(w, "Only student accounts can be edited here", http.StatusBadRequest)
		return
	}

	var existingUserID int
	err = database.DB.QueryRow("SELECT id FROM users WHERE LOWER(username) = LOWER(?) AND id != ?", req.Username, studentID).Scan(&existingUserID)
	if err == nil {
		http.Error(w, "Username already exists", http.StatusConflict)
		return
	}
	if err != sql.ErrNoRows {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}

	err = database.DB.QueryRow("SELECT id FROM users WHERE LOWER(email) = LOWER(?) AND id != ?", email, studentID).Scan(&existingUserID)
	if err == nil {
		http.Error(w, "Email already exists", http.StatusConflict)
		return
	}
	if err != sql.ErrNoRows {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}

	if req.Password == "" {
		_, err = database.DB.Exec(`
			UPDATE users
			SET username = ?, full_name = ?, email = ?, stage_id = ?, is_disabled = ?
			WHERE id = ? AND role = 'student'
		`, req.Username, req.FullName, email, req.StageID, req.IsDisabled, studentID)
	} else {
		hashedPassword, hashErr := hashPassword(req.Password)
		if hashErr != nil {
			http.Error(w, "Server error", http.StatusInternalServerError)
			return
		}
		_, err = database.DB.Exec(`
			UPDATE users
			SET username = ?, full_name = ?, email = ?, stage_id = ?, is_disabled = ?, password = ?
			WHERE id = ? AND role = 'student'
		`, req.Username, req.FullName, email, req.StageID, req.IsDisabled, hashedPassword, studentID)
	}
	if err != nil {
		http.Error(w, "Failed to update student", http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(map[string]string{"message": "Student updated successfully"})
}

func AdminAttemptReportPDFHandler(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	attemptID, err := strconv.Atoi(vars["attempt_id"])
	if err != nil {
		http.Error(w, "Invalid report", http.StatusBadRequest)
		return
	}

	writeAttemptReportPDF(w, attemptID, nil)
}

func AdminAttemptMistakesPDFHandler(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	attemptID, err := strconv.Atoi(vars["attempt_id"])
	if err != nil {
		http.Error(w, "Invalid report", http.StatusBadRequest)
		return
	}

	writeMistakesReportPDF(w, attemptID, nil)
}

func SetStudentDisabledHandler(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	studentID, err := strconv.Atoi(vars["student_id"])
	if err != nil {
		http.Error(w, "Invalid student ID", http.StatusBadRequest)
		return
	}

	disabled := vars["action"] == "disable"
	if vars["action"] != "disable" && vars["action"] != "enable" {
		http.Error(w, "Invalid action", http.StatusBadRequest)
		return
	}

	var fullName string
	var role string
	err = database.DB.QueryRow("SELECT full_name, role FROM users WHERE id = ?", studentID).Scan(&fullName, &role)
	if err != nil {
		if err == sql.ErrNoRows {
			http.Error(w, "Student not found", http.StatusNotFound)
			return
		}
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	if role != "student" {
		http.Error(w, "Only student accounts can be changed here", http.StatusBadRequest)
		return
	}

	result, err := database.DB.Exec("UPDATE users SET is_disabled = ? WHERE id = ? AND role = 'student'", disabled, studentID)
	if err != nil {
		http.Error(w, "Failed to update student", http.StatusInternalServerError)
		return
	}
	rowsAffected, _ := result.RowsAffected()
	if rowsAffected == 0 {
		http.Error(w, "Student not found", http.StatusNotFound)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(map[string]interface{}{
		"message":     "Student updated successfully",
		"student_id":  studentID,
		"full_name":   fullName,
		"is_disabled": disabled,
	})
}

func DeleteStudentHandler(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	studentID, err := strconv.Atoi(vars["student_id"])
	if err != nil {
		http.Error(w, "Invalid student ID", http.StatusBadRequest)
		return
	}

	var fullName string
	var role string
	err = database.DB.QueryRow("SELECT full_name, role FROM users WHERE id = ?", studentID).Scan(&fullName, &role)
	if err != nil {
		if err == sql.ErrNoRows {
			http.Error(w, "Student not found", http.StatusNotFound)
			return
		}
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	if role != "student" {
		http.Error(w, "Only student accounts can be deleted here", http.StatusBadRequest)
		return
	}

	tx, err := database.DB.Begin()
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	defer tx.Rollback()

	if _, err := tx.Exec(`
        DELETE FROM answers
        WHERE attempt_id IN (
            SELECT id FROM quiz_attempts WHERE user_id = ?
        )
    `, studentID); err != nil {
		http.Error(w, "Failed to delete student answers", http.StatusInternalServerError)
		return
	}

	if _, err := tx.Exec("DELETE FROM quiz_attempts WHERE user_id = ?", studentID); err != nil {
		http.Error(w, "Failed to delete student attempts", http.StatusInternalServerError)
		return
	}

	result, err := tx.Exec("DELETE FROM users WHERE id = ? AND role = 'student'", studentID)
	if err != nil {
		http.Error(w, "Failed to delete student", http.StatusInternalServerError)
		return
	}
	rowsAffected, _ := result.RowsAffected()
	if rowsAffected == 0 {
		http.Error(w, "Student not found", http.StatusNotFound)
		return
	}

	if err := tx.Commit(); err != nil {
		http.Error(w, "Failed to delete student", http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(map[string]interface{}{
		"message":    "Student deleted successfully",
		"student_id": studentID,
		"full_name":  fullName,
	})
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
	stages, err := getStages()
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	tmpl.Execute(w, map[string]interface{}{
		"QuizID": quizID,
		"Stages": stages,
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

	exists, err := stageExists(req.StageID)
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	if !exists {
		http.Error(w, "Please select a valid stage", http.StatusBadRequest)
		return
	}
	if req.TimeLimitMinutes < 0 {
		http.Error(w, "Time limit cannot be negative", http.StatusBadRequest)
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
		"INSERT INTO quizzes (title, description, created_by, stage_id, time_limit_minutes, lock_after_attempt) VALUES (?, ?, ?, ?, ?, ?)",
		req.Title, req.Description, userID, req.StageID, req.TimeLimitMinutes, req.shouldLockAfterAttempt(),
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
            INSERT INTO questions (quiz_id, question_context, question_text, question_diagram, answer_explanation, question_type, correct_answer, option1, option2, option3, option4, points)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
			quizID, q.QuestionContext, q.QuestionText, q.QuestionDiagram, q.AnswerExplanation, q.QuestionType, q.CorrectAnswer, opt1, opt2, opt3, opt4, q.Points,
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
		"SELECT id, title, description, COALESCE(stage_id, 0), COALESCE(time_limit_minutes, 0), lock_after_attempt FROM quizzes WHERE id = ?",
		quizID,
	).Scan(&quiz.ID, &quiz.Title, &quiz.Description, &quiz.StageID, &quiz.TimeLimitMinutes, &quiz.LockAfterAttempt)
	if err != nil {
		if err == sql.ErrNoRows {
			http.Error(w, "Quiz not found", http.StatusNotFound)
			return
		}
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}

	rows, err := database.DB.Query(`
        SELECT id, COALESCE(question_context, ''), question_text, COALESCE(question_diagram, ''), COALESCE(answer_explanation, ''), question_type, correct_answer, option1, option2, option3, option4, points
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

		if err := rows.Scan(&q.ID, &q.QuestionContext, &q.QuestionText, &q.QuestionDiagram, &q.AnswerExplanation, &q.QuestionType, &q.CorrectAnswer, &opt1, &opt2, &opt3, &opt4, &q.Points); err != nil {
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

	exists, err := stageExists(req.StageID)
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	if !exists {
		http.Error(w, "Please select a valid stage", http.StatusBadRequest)
		return
	}
	if req.TimeLimitMinutes < 0 {
		http.Error(w, "Time limit cannot be negative", http.StatusBadRequest)
		return
	}

	tx, err := database.DB.Begin()
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	defer tx.Rollback()

	result, err := tx.Exec(
		"UPDATE quizzes SET title = ?, description = ?, stage_id = ?, time_limit_minutes = ?, lock_after_attempt = ?, unlock_version = unlock_version + 1 WHERE id = ?",
		req.Title, req.Description, req.StageID, req.TimeLimitMinutes, req.shouldLockAfterAttempt(), quizID,
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
                SET question_context = ?, question_text = ?, question_diagram = ?, answer_explanation = ?, question_type = ?, correct_answer = ?, option1 = ?, option2 = ?, option3 = ?, option4 = ?, points = ?
                WHERE id = ? AND quiz_id = ?`,
				q.QuestionContext, q.QuestionText, q.QuestionDiagram, q.AnswerExplanation, q.QuestionType, q.CorrectAnswer, opt1, opt2, opt3, opt4, q.Points, q.ID, quizID,
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
            INSERT INTO questions (quiz_id, question_context, question_text, question_diagram, answer_explanation, question_type, correct_answer, option1, option2, option3, option4, points)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
			quizID, q.QuestionContext, q.QuestionText, q.QuestionDiagram, q.AnswerExplanation, q.QuestionType, q.CorrectAnswer, opt1, opt2, opt3, opt4, q.Points,
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

	var quizTitle string
	if err := tx.QueryRow("SELECT title FROM quizzes WHERE id = ?", quizID).Scan(&quizTitle); err != nil {
		if err == sql.ErrNoRows {
			http.Error(w, "Quiz not found", http.StatusNotFound)
			return
		}
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}

	if _, err = tx.Exec("INSERT OR IGNORE INTO deleted_seed_quizzes (title) VALUES (?)", quizTitle); err != nil {
		http.Error(w, "Failed to record quiz deletion", http.StatusInternalServerError)
		return
	}

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
        SELECT u.full_name, u.username, qa.id, qa.score, qa.max_score, qa.completed_at
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
		var attemptID, score, maxScore int
		if err := rows.Scan(&fullName, &username, &attemptID, &score, &maxScore, &completedAt); err != nil {
			http.Error(w, "Server error", http.StatusInternalServerError)
			return
		}

		percentage := 0.0
		if maxScore > 0 {
			percentage = float64(score) / float64(maxScore) * 100
		}

		results = append(results, map[string]interface{}{
			"full_name":        fullName,
			"username":         username,
			"attempt_id":       attemptID,
			"score":            score,
			"max_score":        maxScore,
			"percentage":       percentage,
			"completed_at":     completedAt,
			"report_pdf_url":   fmt.Sprintf("/admin/attempt/%d/report.pdf", attemptID),
			"mistakes_pdf_url": fmt.Sprintf("/admin/attempt/%d/mistakes.pdf", attemptID),
		})
	}
	if err := rows.Err(); err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
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
		ReportURL   string  `json:"report_pdf_url"`
		MistakesURL string  `json:"mistakes_pdf_url"`
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
			ReportURL:   fmt.Sprintf("/admin/attempt/%d/report.pdf", attemptID),
			MistakesURL: fmt.Sprintf("/admin/attempt/%d/mistakes.pdf", attemptID),
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
