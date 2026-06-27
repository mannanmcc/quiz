package handlers

import (
	"database/sql"
	"encoding/json"
	"html/template"
	"log"
	"net/http"
	"strings"
	"vocabulary-quiz-app/internal/database"
	"vocabulary-quiz-app/internal/middleware"

	"golang.org/x/crypto/bcrypt"
)

func hashPassword(password string) (string, error) {
	bytes, err := bcrypt.GenerateFromPassword([]byte(password), 14)
	return string(bytes), err
}

func checkPasswordHash(password, hash string) bool {
	if err := bcrypt.CompareHashAndPassword([]byte(hash), []byte(password)); err == nil {
		return true
	}

	// Keep existing plaintext admin/dev accounts working until their passwords
	// are reset or migrated.
	return password == hash
}

func LoginPageHandler(w http.ResponseWriter, r *http.Request) {
	tmpl := template.Must(template.ParseFiles("templates/login.html"))
	stages, err := getStages()
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	tmpl.Execute(w, map[string]interface{}{
		"Stages": stages,
	})
}
func LoginHandler(w http.ResponseWriter, r *http.Request) {
	r.ParseForm()
	username := r.FormValue("username")
	password := r.FormValue("password")

	var dbPassword string
	var userID int
	var role string
	var isDisabled bool

	err := database.DB.QueryRow("SELECT id, password, role, COALESCE(is_disabled, 0) FROM users WHERE username = ?", username).Scan(&userID, &dbPassword, &role, &isDisabled)

	if err != nil {
		log.Printf("DEBUG: User lookup failed for '%s': %v", username, err)
		http.Error(w, "Invalid credentials", http.StatusUnauthorized)
		return
	}

	if isDisabled {
		http.Error(w, "Account is disabled", http.StatusForbidden)
		return
	}

	// DEBUG: Print the password comparison
	match := checkPasswordHash(password, dbPassword)
	log.Printf("DEBUG: Attempting login for %s. Password match: %v", username, match)

	if !match {
		http.Error(w, "Invalid credentials", http.StatusUnauthorized)
		return
	}

	session, _ := middleware.Store.Get(r, "session")
	session.Values["user_id"] = userID
	session.Values["username"] = username
	session.Values["role"] = role
	session.Save(r, w)

	if role == "admin" {
		http.Redirect(w, r, "/admin/dashboard", http.StatusSeeOther)
		return
	}

	http.Redirect(w, r, "/student/dashboard", http.StatusSeeOther)
}

func LogoutHandler(w http.ResponseWriter, r *http.Request) {
	session, _ := middleware.Store.Get(r, "session")
	session.Values["user_id"] = nil
	session.Values["username"] = nil
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
		StageID  int    `json:"stage_id"`
	}

	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		http.Error(w, "Invalid request", http.StatusBadRequest)
		return
	}

	req.Username = strings.TrimSpace(req.Username)
	req.Password = strings.TrimSpace(req.Password)
	req.FullName = strings.TrimSpace(req.FullName)

	if req.Username == "" || req.Password == "" || req.FullName == "" {
		http.Error(w, "Full name, username, and password are required", http.StatusBadRequest)
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

	var existingUserID int
	err = database.DB.QueryRow("SELECT id FROM users WHERE LOWER(username) = LOWER(?)", req.Username).Scan(&existingUserID)
	if err == nil {
		http.Error(w, "Username already exists", http.StatusConflict)
		return
	}
	if err != sql.ErrNoRows {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}

	hashedPassword, err := hashPassword(req.Password)
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}

	_, err = database.DB.Exec(
		"INSERT INTO users (username, password, role, full_name, stage_id) VALUES (?, ?, ?, ?, ?)",
		req.Username, hashedPassword, "student", req.FullName, req.StageID,
	)

	if err != nil {
		http.Error(w, "Username already exists", http.StatusConflict)
		return
	}

	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(map[string]string{"message": "Student registered successfully"})
}
