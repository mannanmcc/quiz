package handlers

import (
    "database/sql"
    "encoding/json"
    "html/template"
    "net/http"
    "strconv"
    "vocabulary-quiz-app/internal/database"
    "vocabulary-quiz-app/internal/models"
    "github.com/gorilla/mux"
)

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
