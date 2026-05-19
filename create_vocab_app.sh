#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🎓 Creating Vocabulary Quiz Application${NC}"
echo "========================================"

# Create directory structure
mkdir -p vocabulary-quiz-app/{cmd/server,internal/{models,handlers,database,middleware},static/{css,js},templates}

cd vocabulary-quiz-app

# Create go.mod
cat > go.mod << 'EOF'
module vocabulary-quiz-app

go 1.19

require (
	github.com/gorilla/mux v1.8.1
	github.com/gorilla/sessions v1.2.2
	github.com/mattn/go-sqlite3 v1.14.18
	golang.org/x/crypto v0.16.0
)

require github.com/gorilla/securecookie v1.1.2 // indirect
EOF

# Create main.go
cat > cmd/server/main.go << 'EOF'
package main

import (
    "log"
    "net/http"
    "vocabulary-quiz-app/internal/database"
    "vocabulary-quiz-app/internal/handlers"
    "vocabulary-quiz-app/internal/middleware"
    "github.com/gorilla/mux"
)

func main() {
    if err := database.InitDB(); err != nil {
        log.Fatal("Failed to initialize database:", err)
    }
    defer database.DB.Close()

    r := mux.NewRouter()

    // Public routes
    r.HandleFunc("/", handlers.LoginPageHandler).Methods("GET")
    r.HandleFunc("/login", handlers.LoginPageHandler).Methods("GET")
    r.HandleFunc("/login", handlers.LoginHandler).Methods("POST")
    r.HandleFunc("/logout", handlers.LogoutHandler).Methods("GET")
    r.HandleFunc("/api/register", handlers.RegisterStudentHandler).Methods("POST")

    // Student routes
    studentRouter := r.PathPrefix("/student").Subrouter()
    studentRouter.Use(middleware.AuthMiddleware)
    studentRouter.HandleFunc("/dashboard", handlers.StudentDashboardHandler).Methods("GET")
    studentRouter.HandleFunc("/quiz/{quiz_id}", handlers.QuizPageHandler).Methods("GET")
    studentRouter.HandleFunc("/api/quiz/{quiz_id}", handlers.GetQuizHandler).Methods("GET")
    studentRouter.HandleFunc("/api/quiz/{quiz_id}/submit", handlers.SubmitQuizHandler).Methods("POST")

    // Admin routes
    adminRouter := r.PathPrefix("/admin").Subrouter()
    adminRouter.Use(middleware.AuthMiddleware)
    adminRouter.Use(middleware.AdminMiddleware)
    adminRouter.HandleFunc("/dashboard", handlers.AdminDashboardHandler).Methods("GET")
    adminRouter.HandleFunc("/quiz/create", handlers.CreateQuizPageHandler).Methods("GET")
    adminRouter.HandleFunc("/api/quiz/create", handlers.CreateQuizHandler).Methods("POST")
    adminRouter.HandleFunc("/api/quiz/{quiz_id}/results", handlers.GetStudentResultsHandler).Methods("GET")

    r.PathPrefix("/static/").Handler(http.StripPrefix("/static/", http.FileServer(http.Dir("static"))))

    log.Println("Server starting on http://localhost:8080")
    log.Println("Default admin login - username: admin, password: admin123")
    log.Fatal(http.ListenAndServe(":8080", r))
}
EOF

# Create models.go
cat > internal/models/models.go << 'EOF'
package models

import "time"

type User struct {
    ID        int       `json:"id"`
    Username  string    `json:"username"`
    Password  string    `json:"-"`
    Role      string    `json:"role"`
    FullName  string    `json:"full_name"`
    CreatedAt time.Time `json:"created_at"`
}

type Quiz struct {
    ID          int       `json:"id"`
    Title       string    `json:"title"`
    Description string    `json:"description"`
    CreatedBy   int       `json:"created_by"`
    CreatedAt   time.Time `json:"created_at"`
}

type Question struct {
    ID           int      `json:"id"`
    QuizID       int      `json:"quiz_id"`
    QuestionText string   `json:"question_text"`
    QuestionType string   `json:"question_type"`
    CorrectAnswer string  `json:"correct_answer"`
    Options      []string `json:"options"`
    Points       int      `json:"points"`
}

type QuizAttempt struct {
    ID          int       `json:"id"`
    UserID      int       `json:"user_id"`
    QuizID      int       `json:"quiz_id"`
    Score       int       `json:"score"`
    MaxScore    int       `json:"max_score"`
    CompletedAt time.Time `json:"completed_at"`
}

type Answer struct {
    ID              int    `json:"id"`
    AttemptID       int    `json:"attempt_id"`
    QuestionID      int    `json:"question_id"`
    SelectedAnswer  string `json:"selected_answer"`
    IsCorrect       bool   `json:"is_correct"`
}
EOF

# Create db.go
cat > internal/database/db.go << 'EOF'
package database

import (
    "database/sql"
    "log"
    _ "github.com/mattn/go-sqlite3"
    "golang.org/x/crypto/bcrypt"
)

var DB *sql.DB

func InitDB() error {
    var err error
    DB, err = sql.Open("sqlite3", "./vocabulary_quiz.db")
    if err != nil {
        return err
    }

    if err = DB.Ping(); err != nil {
        return err
    }

    createTables()
    return nil
}

func createTables() {
    schema := `
    CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL,
        role TEXT NOT NULL,
        full_name TEXT NOT NULL,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    );

    CREATE TABLE IF NOT EXISTS quizzes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        created_by INTEGER,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (created_by) REFERENCES users(id)
    );

    CREATE TABLE IF NOT EXISTS questions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        quiz_id INTEGER NOT NULL,
        question_text TEXT NOT NULL,
        question_type TEXT NOT NULL,
        correct_answer TEXT NOT NULL,
        option1 TEXT,
        option2 TEXT,
        option3 TEXT,
        option4 TEXT,
        points INTEGER DEFAULT 1,
        FOREIGN KEY (quiz_id) REFERENCES quizzes(id) ON DELETE CASCADE
    );

    CREATE TABLE IF NOT EXISTS quiz_attempts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        quiz_id INTEGER NOT NULL,
        score INTEGER NOT NULL,
        max_score INTEGER NOT NULL,
        completed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users(id),
        FOREIGN KEY (quiz_id) REFERENCES quizzes(id)
    );

    CREATE TABLE IF NOT EXISTS answers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        attempt_id INTEGER NOT NULL,
        question_id INTEGER NOT NULL,
        selected_answer TEXT NOT NULL,
        is_correct BOOLEAN NOT NULL,
        FOREIGN KEY (attempt_id) REFERENCES quiz_attempts(id) ON DELETE CASCADE,
        FOREIGN KEY (question_id) REFERENCES questions(id)
    );
    `

    _, err := DB.Exec(schema)
    if err != nil {
        log.Fatal("Error creating tables:", err)
    }

    createDefaultAdmin()
}

func createDefaultAdmin() {
    var count int
    DB.QueryRow("SELECT COUNT(*) FROM users WHERE role = 'admin'").Scan(&count)
    
    if count == 0 {
        hashedPassword, _ := bcrypt.GenerateFromPassword([]byte("admin123"), 14)
        _, err := DB.Exec(`
            INSERT INTO users (username, password, role, full_name) 
            VALUES (?, ?, ?, ?)`,
            "admin", string(hashedPassword), "admin", "Administrator")
        
        if err != nil {
            log.Println("Error creating admin:", err)
        } else {
            log.Println("Default admin created - username: admin, password: admin123")
        }
    }
}
EOF

# Create auth.go middleware
cat > internal/middleware/auth.go << 'EOF'
package middleware

import (
    "context"
    "net/http"
    "github.com/gorilla/sessions"
)

var Store = sessions.NewCookieStore([]byte("your-secret-key-change-in-production-12345678"))

type contextKey string

const UserContextKey contextKey = "user"

func AuthMiddleware(next http.Handler) http.Handler {
    return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        session, _ := Store.Get(r, "session")
        userID, ok := session.Values["user_id"]
        if !ok {
            http.Redirect(w, r, "/login", http.StatusSeeOther)
            return
        }
        
        ctx := context.WithValue(r.Context(), UserContextKey, userID)
        next.ServeHTTP(w, r.WithContext(ctx))
    })
}

func AdminMiddleware(next http.Handler) http.Handler {
    return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        session, _ := Store.Get(r, "session")
        role, ok := session.Values["role"]
        if !ok || role != "admin" {
            http.Error(w, "Unauthorized", http.StatusUnauthorized)
            return
        }
        next.ServeHTTP(w, r)
    })
}
EOF

# Create auth.go handler
cat > internal/handlers/auth.go << 'EOF'
package handlers

import (
    "database/sql"
    "encoding/json"
    "html/template"
    "net/http"
    "vocabulary-quiz-app/internal/database"
    "vocabulary-quiz-app/internal/middleware"
    "vocabulary-quiz-app/internal/models"
    "golang.org/x/crypto/bcrypt"
)

func hashPassword(password string) (string, error) {
    bytes, err := bcrypt.GenerateFromPassword([]byte(password), 14)
    return string(bytes), err
}

func checkPasswordHash(password, hash string) bool {
    err := bcrypt.CompareHashAndPassword([]byte(hash), []byte(password))
    return err == nil
}

func LoginPageHandler(w http.ResponseWriter, r *http.Request) {
    tmpl := template.Must(template.ParseFiles("templates/login.html"))
    tmpl.Execute(w, nil)
}

func LoginHandler(w http.ResponseWriter, r *http.Request) {
    if r.Method != http.MethodPost {
        http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
        return
    }

    username := r.FormValue("username")
    password := r.FormValue("password")

    var user models.User
    err := database.DB.QueryRow(
        "SELECT id, username, password, role, full_name FROM users WHERE username = ?",
        username,
    ).Scan(&user.ID, &user.Username, &user.Password, &user.Role, &user.FullName)

    if err != nil {
        if err == sql.ErrNoRows {
            http.Error(w, "Invalid credentials", http.StatusUnauthorized)
            return
        }
        http.Error(w, "Server error", http.StatusInternalServerError)
        return
    }

    if !checkPasswordHash(password, user.Password) {
        http.Error(w, "Invalid credentials", http.StatusUnauthorized)
        return
    }

    session, _ := middleware.Store.Get(r, "session")
    session.Values["user_id"] = user.ID
    session.Values["role"] = user.Role
    session.Values["username"] = user.Username
    session.Save(r, w)

    if user.Role == "admin" {
        http.Redirect(w, r, "/admin/dashboard", http.StatusSeeOther)
    } else {
        http.Redirect(w, r, "/student/dashboard", http.StatusSeeOther)
    }
}

func LogoutHandler(w http.ResponseWriter, r *http.Request) {
    session, _ := middleware.Store.Get(r, "session")
    session.Values["user_id"] = nil
    session.Values["role"] = nil
    session.Options.MaxAge = -1
    session.Save(r, w)
    http.Redirect(w, r, "/login", http.StatusSeeOther)
}

func RegisterStudentHandler(w http.ResponseWriter, r *http.Request) {
    if r.Method != http.MethodPost {
        http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
        return
    }

    var req struct {
        Username string `json:"username"`
        Password string `json:"password"`
        FullName string `json:"full_name"`
    }

    if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
        http.Error(w, "Invalid request", http.StatusBadRequest)
        return
    }

    hashedPassword, err := hashPassword(req.Password)
    if err != nil {
        http.Error(w, "Server error", http.StatusInternalServerError)
        return
    }

    _, err = database.DB.Exec(
        "INSERT INTO users (username, password, role, full_name) VALUES (?, ?, ?, ?)",
        req.Username, hashedPassword, "student", req.FullName,
    )

    if err != nil {
        http.Error(w, "Username already exists", http.StatusConflict)
        return
    }

    w.WriteHeader(http.StatusCreated)
    json.NewEncoder(w).Encode(map[string]string{"message": "Student registered successfully"})
}
EOF

# Create admin.go handler
cat > internal/handlers/admin.go << 'EOF'
package handlers

import (
    "database/sql"
    "encoding/json"
    "html/template"
    "net/http"
    "vocabulary-quiz-app/internal/database"
    "vocabulary-quiz-app/internal/middleware"
    "github.com/gorilla/mux"
)

func AdminDashboardHandler(w http.ResponseWriter, r *http.Request) {
    tmpl := template.Must(template.ParseFiles("templates/admin_dashboard.html"))
    
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
            "id": id,
            "title": title,
            "description": description,
            "created_at": createdAt,
            "created_by": createdBy,
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

func CreateQuizHandler(w http.ResponseWriter, r *http.Request) {
    if r.Method != http.MethodPost {
        http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
        return
    }

    var req struct {
        Title       string `json:"title"`
        Description string `json:"description"`
        Questions   []struct {
            QuestionText  string   `json:"question_text"`
            QuestionType  string   `json:"question_type"`
            CorrectAnswer string   `json:"correct_answer"`
            Options       []string `json:"options"`
            Points        int      `json:"points"`
        } `json:"questions"`
    }

    if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
        http.Error(w, "Invalid request", http.StatusBadRequest)
        return
    }

    session, _ := middleware.Store.Get(r, "session")
    userID := session.Values["user_id"].(int)

    tx, err := database.DB.Begin()
    if err != nil {
        http.Error(w, "Server error", http.StatusInternalServerError)
        return
    }
    defer tx.Rollback()

    result, err := tx.Exec(
        "INSERT INTO quizzes (title, description, created_by) VALUES (?, ?, ?)",
        req.Title, req.Description, userID,
    )
    if err != nil {
        http.Error(w, "Failed to create quiz", http.StatusInternalServerError)
        return
    }

    quizID, _ := result.LastInsertId()

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

    var results []map[string]interface{}
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
EOF

# Create quiz.go handler (Part 1)
cat > internal/handlers/quiz.go << 'EOF'
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

func StudentDashboardHandler(w http.ResponseWriter, r *http.Request) {
    session, _ := middleware.Store.Get(r, "session")
    userID := session.Values["user_id"].(int)
    username := session.Values["username"].(string)

    tmpl := template.Must(template.ParseFiles("templates/student_dashboard.html"))
    
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
    tmpl := template.Must(template.ParseFiles("templates/quiz.html"))
    
    vars := mux.Vars(r)
    quizID := vars["quiz_id"]
    
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

    var req struct {
        Answers map[string]string `json:"answers"`
    }

    if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
        http.Error(w, "Invalid request", http.StatusBadRequest)
        return
    }

    tx, err := database.DB.Begin()
    if err != nil {
        http.Error(w, "Server error", http.StatusInternalServerError)
        return
    }
    defer tx.Rollback()

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

    result, err := tx.Exec(
        "INSERT INTO quiz_attempts (user_id, quiz_id, score, max_score) VALUES (?, ?, ?, ?)",
        userID, quizID, score, maxScore,
    )
    if err != nil {
        http.Error(w, "Failed to save attempt", http.StatusInternalServerError)
        return
    }

    attemptID, _ := result.LastInsertId()

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
EOF

# Create CSS file
cat > static/css/style.css << 'EOFCSS'
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
    color: #333;
}

.navbar {
    background: white;
    padding: 1rem 2rem;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.nav-brand {
    font-size: 1.5rem;
    font-weight: bold;
    color: #667eea;
}

.nav-user {
    display: flex;
    align-items: center;
    gap: 1rem;
}

.container {
    max-width: 1200px;
    margin: 2rem auto;
    padding: 0 2rem;
}

.login-container {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    padding: 2rem;
}

.login-box, .register-box {
    background: white;
    padding: 3rem;
    border-radius: 15px;
    box-shadow: 0 10px 40px rgba(0,0,0,0.2);
    width: 100%;
    max-width: 400px;
    animation: slideUp 0.3s ease;
}

@keyframes slideUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.login-box h1 {
    text-align: center;
    color: #667eea;
    margin-bottom: 0.5rem;
    font-size: 2rem;
}

.login-box h2, .register-box h2 {
    text-align: center;
    color: #333;
    margin-bottom: 2rem;
    font-size: 1.5rem;
}

.form-group {
    margin-bottom: 1.5rem;
}

.form-group label {
    display: block;
    margin-bottom: 0.5rem;
    color: #555;
    font-weight: 500;
}

.form-group input,
.form-group textarea,
.form-group select {
    width: 100%;
    padding: 0.75rem;
    border: 2px solid #e0e0e0;
    border-radius: 8px;
    font-size: 1rem;
    transition: border-color 0.3s;
}

.form-group input:focus,
.form-group textarea:focus,
.form-group select:focus {
    outline: none;
    border-color: #667eea;
}

.btn {
    padding: 0.75rem 1.5rem;
    border: none;
    border-radius: 8px;
    font-size: 1rem;
    cursor: pointer;
    text-decoration: none;
    display: inline-block;
    transition: all 0.3s;
    font-weight: 500;
}

.btn-primary {
    background: #667eea;
    color: white;
}

.btn-primary:hover {
    background: #5568d3;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
}

.btn-secondary {
    background: #6c757d;
    color: white;
}

.btn-secondary:hover {
    background: #5a6268;
}

.btn-danger {
    background: #dc3545;
    color: white;
}

.btn-danger:hover {
    background: #c82333;
}

.btn-large {
    width: 100%;
    padding: 1rem;
    font-size: 1.1rem;
    margin-top: 1rem;
}

.quiz-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 2rem;
    margin: 2rem 0;
}

.quiz-card {
    background: white;
    padding: 2rem;
    border-radius: 15px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.1);
    transition: transform 0.3s;
}

.quiz-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 30px rgba(0,0,0,0.15);
}

.quiz-card h3 {
    color: #667eea;
    margin-bottom: 1rem;
}

.quiz-card p {
    color: #666;
    margin-bottom: 1rem;
}

.quiz-date {
    font-size: 0.9rem;
    color: #999;
}

.question-card {
    background: white;
    padding: 2rem;
    border-radius: 15px;
    margin-bottom: 2rem;
    box-shadow: 0 5px 20px rgba(0,0,0,0.1);
}

.question-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1rem;
    flex-wrap: wrap;
    gap: 0.5rem;
}

.question-number {
    font-weight: bold;
    color: #667eea;
    font-size: 1.1rem;
}

.question-type {
    background: #e3f2fd;
    padding: 0.25rem 0.75rem;
    border-radius: 20px;
    font-size: 0.9rem;
    color: #1976d2;
}

.question-points {
    background: #fff3e0;
    padding: 0.25rem 0.75rem;
    border-radius: 20px;
    font-size: 0.9rem;
    color: #f57c00;
}

.question-card h3 {
    color: #333;
    margin-bottom: 1.5rem;
    font-size: 1.2rem;
}

.options-container {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.option-label {
    display: flex;
    align-items: center;
    padding: 1rem;
    border: 2px solid #e0e0e0;
    border-radius: 8px;
    cursor: pointer;
    transition: all 0.3s;
}

.option-label:hover {
    border-color: #667eea;
    background: #f8f9ff;
}

.option-label input[type="radio"] {
    margin-right: 1rem;
    width: 20px;
    height: 20px;
    cursor: pointer;
}

.option-label span {
    flex: 1;
    font-size: 1rem;
}

.results-table {
    width: 100%;
    background: white;
    border-radius: 15px;
    overflow: hidden;
    box-shadow: 0 5px 20px rgba(0,0,0,0.1);
    margin: 2rem 0;
}

.results-table thead {
    background: #667eea;
    color: white;
}

.results-table th,
.results-table td {
    padding: 1rem;
    text-align: left;
}

.results-table tbody tr:nth-child(even) {
    background: #f8f9fa;
}

.results-table tbody tr:hover {
    background: #e3f2fd;
}

.results-box {
    background: white;
    padding: 3rem;
    border-radius: 15px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.1);
    text-align: center;
}

.results-box h2 {
    color: #667eea;
    font-size: 2rem;
    margin-bottom: 1rem;
}

.results-box #finalScore {
    color: #28a745;
    font-size: 2.5rem;
}

.badge {
    display: inline-block;
    padding: 0.35rem 0.75rem;
    border-radius: 20px;
    font-size: 0.85rem;
    font-weight: 500;
    margin: 0.5rem 0;
}

.badge-success {
    background: #d4edda;
    color: #155724;
}

.badge-info {
    background: #d1ecf1;
    color: #0c5460;
}

.register-link {
    text-align: center;
    margin-top: 1.5rem;
}

.register-link a {
    color: #667eea;
    text-decoration: none;
    font-weight: 500;
}

.register-link a:hover {
    text-decoration: underline;
}

.admin-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 2rem;
}

.admin-header h1 {
    color: white;
}

.quiz-builder {
    background: white;
    padding: 2rem;
    border-radius: 15px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.1);
}

.question-builder {
    border: 2px solid #e0e0e0;
    padding