package handlers

import (
	"encoding/json"
	"html/template"
	"log"
	"net/http"
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
	tmpl.Execute(w, nil)
}
func LoginHandler(w http.ResponseWriter, r *http.Request) {
	r.ParseForm()
	username := r.FormValue("username")
	password := r.FormValue("password")

	var dbPassword string
	var userID int
	var role string

	err := database.DB.QueryRow("SELECT id, password, role FROM users WHERE username = ?", username).Scan(&userID, &dbPassword, &role)

	if err != nil {
		log.Printf("DEBUG: User lookup failed for '%s': %v", username, err)
		http.Error(w, "Invalid credentials", http.StatusUnauthorized)
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
