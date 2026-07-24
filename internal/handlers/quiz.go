package handlers

import (
	"bytes"
	"database/sql"
	"encoding/json"
	"fmt"
	"html/template"
	"log"
	"net/http"
	"strconv"
	"strings"
	"vocabulary-quiz-app/internal/database"
	"vocabulary-quiz-app/internal/middleware"
	"vocabulary-quiz-app/internal/models"

	"github.com/gorilla/mux"
)

func userCanAccessQuiz(userID int, quizID interface{}) (bool, error) {
	var count int
	err := database.DB.QueryRow(`
        SELECT COUNT(*)
        FROM quizzes q
        JOIN users u ON u.stage_id = q.stage_id
        WHERE u.id = ? AND q.id = ? AND q.is_archived = 0
    `, userID, quizID).Scan(&count)
	if err != nil {
		return false, err
	}

	return count > 0, nil
}

func StudentDashboardHandler(w http.ResponseWriter, r *http.Request) {
	session, _ := middleware.Store.Get(r, "session")
	userID := session.Values["user_id"].(int)
	username := session.Values["username"].(string)

	tmpl := template.Must(template.ParseFiles("templates/student_dashboard.html"))

	var stageName string
	var stageID int
	err := database.DB.QueryRow(`
        SELECT COALESCE(s.id, 0), COALESCE(s.name, 'No stage')
        FROM users u
        LEFT JOIN stages s ON u.stage_id = s.id
        WHERE u.id = ?
    `, userID).Scan(&stageID, &stageName)
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}

	// Get available quizzes
	rows, err := database.DB.Query(`
        SELECT id, title, description, created_at, unlock_version, lock_after_attempt, COALESCE(time_limit_minutes, 0)
        FROM quizzes
        WHERE is_archived = 0 AND stage_id = ?
        ORDER BY created_at DESC
    `, stageID)
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	var quizzes []map[string]interface{}
	for rows.Next() {
		var id, unlockVersion, timeLimitMinutes int
		var lockAfterAttempt bool
		var title, description, createdAt string
		rows.Scan(&id, &title, &description, &createdAt, &unlockVersion, &lockAfterAttempt, &timeLimitMinutes)

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
			"time_limit_minutes": timeLimitMinutes,
			"lock_after_attempt": lockAfterAttempt,
		})
	}

	// Get recent attempts
	attemptsRows, _ := database.DB.Query(`
        SELECT qa.id, q.title, qa.score, qa.max_score, qa.completed_at
        FROM quiz_attempts qa
        JOIN quizzes q ON qa.quiz_id = q.id
        WHERE qa.user_id = ?
        ORDER BY qa.completed_at DESC
        LIMIT 5
    `, userID)
	defer attemptsRows.Close()

	var recentAttempts []map[string]interface{}
	for attemptsRows.Next() {
		var attemptID int
		var title, completedAt string
		var score, maxScore int
		attemptsRows.Scan(&attemptID, &title, &score, &maxScore, &completedAt)

		percentage := float64(score) / float64(maxScore) * 100

		recentAttempts = append(recentAttempts, map[string]interface{}{
			"attempt_id":   attemptID,
			"title":        title,
			"score":        score,
			"max_score":    maxScore,
			"percentage":   percentage,
			"completed_at": completedAt,
		})
	}

	data := map[string]interface{}{
		"Username":       username,
		"StageName":      stageName,
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
		"SELECT id, title, description, unlock_version, COALESCE(time_limit_minutes, 0), lock_after_attempt, is_archived FROM quizzes WHERE id = ?",
		quizID,
	).Scan(&quiz.ID, &quiz.Title, &quiz.Description, &unlockVersion, &quiz.TimeLimitMinutes, &quiz.LockAfterAttempt, &isArchived)

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

	canAccess, err := userCanAccessQuiz(userID, quizID)
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	if !canAccess {
		http.Error(w, "Quiz not found for your stage", http.StatusNotFound)
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
        ORDER BY id
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

	canAccess, err := userCanAccessQuiz(userID, quizID)
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	if !canAccess {
		http.Error(w, "Quiz not found for your stage", http.StatusNotFound)
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

	canAccess, err := userCanAccessQuiz(userID, quizID)
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	if !canAccess {
		http.Error(w, "Quiz not found for your stage", http.StatusNotFound)
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

	for _, item := range report {
		selectedAnswer, _ := item["selected_answer"].(string)
		if selectedAnswer == "" {
			continue
		}

		tx.Exec(
			"INSERT INTO answers (attempt_id, question_id, selected_answer, is_correct) VALUES (?, ?, ?, ?)",
			attemptID, item["question_id"], selectedAnswer, item["is_correct"],
		)
	}

	tx.Commit()

	percentage := 0.0
	if maxScore > 0 {
		percentage = float64(score) / float64(maxScore) * 100
	}

	response := map[string]interface{}{
		"attempt_id":      attemptID,
		"report_pdf_url":  fmt.Sprintf("/student/attempt/%d/report.pdf", attemptID),
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

func StudentAttemptReportPDFHandler(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	attemptID, err := strconv.Atoi(vars["attempt_id"])
	if err != nil {
		http.Error(w, "Invalid report", http.StatusBadRequest)
		return
	}

	session, _ := middleware.Store.Get(r, "session")
	userID := session.Values["user_id"].(int)

	var studentName, username, quizTitle, quizDescription, completedAt string
	var score, maxScore int
	err = database.DB.QueryRow(`
        SELECT u.full_name, u.username, q.title, COALESCE(q.description, ''), qa.score, qa.max_score, qa.completed_at
        FROM quiz_attempts qa
        JOIN users u ON qa.user_id = u.id
        JOIN quizzes q ON qa.quiz_id = q.id
        WHERE qa.id = ? AND qa.user_id = ?
    `, attemptID, userID).Scan(&studentName, &username, &quizTitle, &quizDescription, &score, &maxScore, &completedAt)
	if err != nil {
		if err == sql.ErrNoRows {
			http.Error(w, "Report not found", http.StatusNotFound)
			return
		}
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}

	rows, err := database.DB.Query(`
        SELECT q.question_text, COALESCE(a.selected_answer, ''), q.correct_answer, COALESCE(a.is_correct, 0), q.points
        FROM quiz_attempts qa
        JOIN questions q ON q.quiz_id = qa.quiz_id
        LEFT JOIN answers a ON a.attempt_id = qa.id AND a.question_id = q.id
        WHERE qa.id = ? AND qa.user_id = ?
        ORDER BY q.id
    `, attemptID, userID)
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	lines := []pdfLine{
		newPDFLine("Quiz Test Report", pdfBlue),
		newPDFLine("", pdfBlack),
		newPDFLine("Student: "+studentName+" ("+username+")", pdfBlack),
		newPDFLine("Quiz: "+quizTitle, pdfBlack),
		newPDFLine("Completed: "+completedAt, pdfBlack),
		newPDFLine(fmt.Sprintf("Score: %d / %d (%.1f%%)", score, maxScore, reportPercentage(score, maxScore)), pdfBlue),
	}
	if strings.TrimSpace(quizDescription) != "" {
		lines = append(lines, newPDFLine("Description: "+quizDescription, pdfBlack))
	}
	lines = append(lines, newPDFLine("", pdfBlack), newPDFLine("Answer Review", pdfBlue))

	questionNumber := 1
	for rows.Next() {
		var questionText, selectedAnswer, correctAnswer string
		var isCorrect bool
		var points int
		if err := rows.Scan(&questionText, &selectedAnswer, &correctAnswer, &isCorrect, &points); err != nil {
			http.Error(w, "Server error", http.StatusInternalServerError)
			return
		}

		if selectedAnswer == "" {
			selectedAnswer = "No answer"
		}

		status := "Incorrect"
		statusColor := pdfRed
		answerColor := pdfRed
		if isCorrect {
			status = "Correct"
			statusColor = pdfGreen
			answerColor = pdfGreen
		}

		lines = append(lines,
			newPDFLine("", pdfBlack),
			newPDFLine(fmt.Sprintf("Question %d (%d point(s))", questionNumber, points), pdfBlue),
			newPDFLine("Question: "+questionText, pdfBlack),
			newPDFLine("Your answer: "+selectedAnswer, answerColor),
			newPDFLine("Correct answer: "+correctAnswer, pdfGreen),
			newPDFLine("Result: "+status, statusColor),
		)
		questionNumber++
	}

	pdf, err := buildTextPDF(lines)
	if err != nil {
		http.Error(w, "Failed to create report", http.StatusInternalServerError)
		return
	}

	filename := fmt.Sprintf("quiz-report-%d.pdf", attemptID)
	w.Header().Set("Content-Type", "application/pdf")
	w.Header().Set("Content-Disposition", `inline; filename="`+filename+`"`)
	w.Write(pdf)
}

func reportPercentage(score, maxScore int) float64 {
	if maxScore == 0 {
		return 0
	}
	return float64(score) / float64(maxScore) * 100
}

type pdfColor struct {
	r float64
	g float64
	b float64
}

type pdfLine struct {
	text  string
	color pdfColor
}

var (
	pdfBlack = pdfColor{r: 0.12, g: 0.12, b: 0.12}
	pdfBlue  = pdfColor{r: 0.16, g: 0.31, b: 0.73}
	pdfGreen = pdfColor{r: 0.08, g: 0.48, b: 0.18}
	pdfRed   = pdfColor{r: 0.78, g: 0.12, b: 0.12}
)

func newPDFLine(text string, color pdfColor) pdfLine {
	return pdfLine{text: text, color: color}
}

func buildTextPDF(lines []pdfLine) ([]byte, error) {
	const (
		pageWidth       = 612
		pageHeight      = 792
		leftMargin      = 54
		topMargin       = 742
		lineHeight      = 15
		linesPerPage    = 45
		maxCharsPerLine = 86
	)

	wrappedLines := []pdfLine{}
	for _, line := range lines {
		wrappedLines = append(wrappedLines, wrapPDFLine(line, maxCharsPerLine)...)
	}
	if len(wrappedLines) == 0 {
		wrappedLines = append(wrappedLines, newPDFLine("", pdfBlack))
	}

	pages := [][]pdfLine{}
	for len(wrappedLines) > 0 {
		end := linesPerPage
		if len(wrappedLines) < end {
			end = len(wrappedLines)
		}
		pages = append(pages, wrappedLines[:end])
		wrappedLines = wrappedLines[end:]
	}

	var buf bytes.Buffer
	offsets := []int{0}
	writeObj := func(id int, body string) {
		offsets = append(offsets, buf.Len())
		fmt.Fprintf(&buf, "%d 0 obj\n%s\nendobj\n", id, body)
	}

	buf.WriteString("%PDF-1.4\n")
	pageCount := len(pages)
	fontObjID := 3 + pageCount*2

	writeObj(1, fmt.Sprintf("<< /Type /Catalog /Pages 2 0 R >>"))

	pageRefs := make([]string, pageCount)
	for i := range pages {
		pageObjID := 3 + i*2
		pageRefs[i] = fmt.Sprintf("%d 0 R", pageObjID)
	}
	writeObj(2, fmt.Sprintf("<< /Type /Pages /Kids [%s] /Count %d >>", strings.Join(pageRefs, " "), pageCount))

	for i, pageLines := range pages {
		pageObjID := 3 + i*2
		contentObjID := pageObjID + 1
		content := buildPDFPageContent(pageLines, leftMargin, topMargin, lineHeight)
		writeObj(pageObjID, fmt.Sprintf("<< /Type /Page /Parent 2 0 R /MediaBox [0 0 %d %d] /Resources << /Font << /F1 %d 0 R >> >> /Contents %d 0 R >>", pageWidth, pageHeight, fontObjID, contentObjID))
		writeObj(contentObjID, fmt.Sprintf("<< /Length %d >>\nstream\n%s\nendstream", len(content), content))
	}

	writeObj(fontObjID, "<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica >>")

	xrefOffset := buf.Len()
	fmt.Fprintf(&buf, "xref\n0 %d\n", len(offsets))
	buf.WriteString("0000000000 65535 f \n")
	for i := 1; i < len(offsets); i++ {
		fmt.Fprintf(&buf, "%010d 00000 n \n", offsets[i])
	}
	fmt.Fprintf(&buf, "trailer\n<< /Size %d /Root 1 0 R >>\nstartxref\n%d\n%%%%EOF\n", len(offsets), xrefOffset)

	return buf.Bytes(), nil
}

func buildPDFPageContent(lines []pdfLine, leftMargin, topMargin, lineHeight int) string {
	var content strings.Builder
	content.WriteString("BT\n/F1 11 Tf\n")
	for i, line := range lines {
		y := topMargin - (i * lineHeight)
		fmt.Fprintf(&content, "%.3f %.3f %.3f rg\n", line.color.r, line.color.g, line.color.b)
		fmt.Fprintf(&content, "1 0 0 1 %d %d Tm (%s) Tj\n", leftMargin, y, escapePDFText(line.text))
	}
	content.WriteString("ET")
	return content.String()
}

func escapePDFText(value string) string {
	value = strings.ReplaceAll(value, "\\", "\\\\")
	value = strings.ReplaceAll(value, "(", "\\(")
	value = strings.ReplaceAll(value, ")", "\\)")
	value = strings.ReplaceAll(value, "\r", "")
	value = strings.ReplaceAll(value, "\n", " ")
	return value
}

func wrapPDFLine(line pdfLine, maxChars int) []pdfLine {
	if len(line.text) <= maxChars {
		return []pdfLine{line}
	}

	words := strings.Fields(line.text)
	if len(words) == 0 {
		return []pdfLine{newPDFLine("", line.color)}
	}

	var lines []pdfLine
	current := words[0]
	for _, word := range words[1:] {
		if len(current)+1+len(word) <= maxChars {
			current += " " + word
			continue
		}
		lines = append(lines, newPDFLine(current, line.color))
		current = word
	}
	lines = append(lines, newPDFLine(current, line.color))
	return lines
}
