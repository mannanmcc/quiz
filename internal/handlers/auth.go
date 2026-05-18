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
