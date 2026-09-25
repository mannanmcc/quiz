package handlers

import (
	"crypto/rand"
	"crypto/sha256"
	"database/sql"
	"encoding/hex"
	"encoding/json"
	"fmt"
	"html/template"
	"log"
	"net/http"
	"net/mail"
	"os"
	"strings"
	"time"
	"vocabulary-quiz-app/internal/database"
	appemail "vocabulary-quiz-app/internal/email"
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

func normalizeEmail(email string) (string, bool) {
	email = strings.TrimSpace(strings.ToLower(email))
	if email == "" {
		return "", false
	}
	if _, err := mail.ParseAddress(email); err != nil {
		return "", false
	}
	return email, true
}

func generateResetToken() (string, string, error) {
	bytes := make([]byte, 32)
	if _, err := rand.Read(bytes); err != nil {
		return "", "", err
	}
	token := hex.EncodeToString(bytes)
	hash := sha256.Sum256([]byte(token))
	return token, hex.EncodeToString(hash[:]), nil
}

func hashResetToken(token string) string {
	hash := sha256.Sum256([]byte(token))
	return hex.EncodeToString(hash[:])
}

func baseURL(r *http.Request) string {
	if configured := strings.TrimRight(strings.TrimSpace(os.Getenv("APP_BASE_URL")), "/"); configured != "" {
		return configured
	}

	scheme := "http"
	if r.TLS != nil {
		scheme = "https"
	}
	return scheme + "://" + r.Host
}

func sendRegistrationEmail(to, fullName, username string) error {
	body := fmt.Sprintf("Hello %s,\n\nYour QUIZ account has been created.\n\nUsername: %s\n\nYou can now log in and start your quizzes.\n\nThanks,\nQUIZ", fullName, username)
	return appemail.Send(to, "Welcome to QUIZ", body)
}

func sendPasswordResetEmail(to, fullName, resetLink string) error {
	body := fmt.Sprintf("Hello %s,\n\nWe received a request to reset your QUIZ password.\n\nUse this link to choose a new password:\n%s\n\nThis link expires in 1 hour. If you did not request this, you can ignore this email.\n\nThanks,\nQUIZ", fullName, resetLink)
	return appemail.Send(to, "Reset your QUIZ password", body)
}

func renderLoginPage(w http.ResponseWriter, statusCode int, data map[string]interface{}) {
	tmpl := template.Must(template.ParseFiles("templates/login.html"))
	stages, err := getStages()
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}

	if data == nil {
		data = map[string]interface{}{}
	}
	data["Stages"] = stages

	w.WriteHeader(statusCode)
	tmpl.Execute(w, data)
}

func LoginPageHandler(w http.ResponseWriter, r *http.Request) {
	renderLoginPage(w, http.StatusOK, nil)
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
		renderLoginPage(w, http.StatusOK, map[string]interface{}{
			"Error":    "The username or password you entered is incorrect.",
			"Username": username,
		})
		return
	}

	if isDisabled {
		renderLoginPage(w, http.StatusOK, map[string]interface{}{
			"Error":    "This account is disabled. Please contact your teacher or administrator.",
			"Username": username,
		})
		return
	}

	// DEBUG: Print the password comparison
	match := checkPasswordHash(password, dbPassword)
	log.Printf("DEBUG: Attempting login for %s. Password match: %v", username, match)

	if !match {
		renderLoginPage(w, http.StatusOK, map[string]interface{}{
			"Error":    "The username or password you entered is incorrect.",
			"Username": username,
		})
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

func ForgotPasswordHandler(w http.ResponseWriter, r *http.Request) {
	var req struct {
		Email string `json:"email"`
	}

	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		http.Error(w, "Invalid request", http.StatusBadRequest)
		return
	}

	email, ok := normalizeEmail(req.Email)
	if !ok {
		http.Error(w, "Please enter a valid email address", http.StatusBadRequest)
		return
	}

	response := map[string]string{"message": "If an account uses that email, a password reset link has been sent."}

	var userID int
	var fullName string
	err := database.DB.QueryRow("SELECT id, full_name FROM users WHERE LOWER(email) = LOWER(?)", email).Scan(&userID, &fullName)
	if err == sql.ErrNoRows {
		json.NewEncoder(w).Encode(response)
		return
	}
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}

	token, tokenHash, err := generateResetToken()
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}

	expiresAt := time.Now().UTC().Add(time.Hour).Format("2006-01-02 15:04:05")
	if _, err := database.DB.Exec(
		"INSERT INTO password_reset_tokens (user_id, token_hash, expires_at) VALUES (?, ?, ?)",
		userID, tokenHash, expiresAt,
	); err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}

	resetLink := fmt.Sprintf("%s/reset-password?token=%s", baseURL(r), token)
	if err := sendPasswordResetEmail(email, fullName, resetLink); err != nil {
		log.Printf("Failed to send password reset email to %s: %v", email, err)
		http.Error(w, "We could not send the reset email. Please try again later.", http.StatusInternalServerError)
		return
	}

	json.NewEncoder(w).Encode(response)
}

func ResetPasswordPageHandler(w http.ResponseWriter, r *http.Request) {
	token := strings.TrimSpace(r.URL.Query().Get("token"))
	tmpl := template.Must(template.ParseFiles("templates/reset_password.html"))
	tmpl.Execute(w, map[string]interface{}{
		"Token": token,
	})
}

func ResetPasswordHandler(w http.ResponseWriter, r *http.Request) {
	if err := r.ParseForm(); err != nil {
		http.Error(w, "Invalid request", http.StatusBadRequest)
		return
	}

	token := strings.TrimSpace(r.FormValue("token"))
	password := strings.TrimSpace(r.FormValue("password"))
	confirmPassword := strings.TrimSpace(r.FormValue("confirm_password"))
	tmpl := template.Must(template.ParseFiles("templates/reset_password.html"))

	renderReset := func(statusCode int, data map[string]interface{}) {
		data["Token"] = token
		w.WriteHeader(statusCode)
		tmpl.Execute(w, data)
	}

	if token == "" {
		renderReset(http.StatusBadRequest, map[string]interface{}{"Error": "Password reset link is missing or invalid."})
		return
	}
	if password == "" || len(password) < 6 {
		renderReset(http.StatusBadRequest, map[string]interface{}{"Error": "Password must be at least 6 characters."})
		return
	}
	if password != confirmPassword {
		renderReset(http.StatusBadRequest, map[string]interface{}{"Error": "Passwords do not match."})
		return
	}

	var userID int
	tokenHash := hashResetToken(token)
	err := database.DB.QueryRow(`
		SELECT user_id
		FROM password_reset_tokens
		WHERE token_hash = ? AND used_at IS NULL AND expires_at > CURRENT_TIMESTAMP
	`, tokenHash).Scan(&userID)
	if err == sql.ErrNoRows {
		renderReset(http.StatusBadRequest, map[string]interface{}{"Error": "This password reset link is invalid or has expired."})
		return
	}
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}

	hashedPassword, err := hashPassword(password)
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}

	tx, err := database.DB.Begin()
	if err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	defer tx.Rollback()

	if _, err := tx.Exec("UPDATE users SET password = ? WHERE id = ?", hashedPassword, userID); err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	if _, err := tx.Exec("UPDATE password_reset_tokens SET used_at = CURRENT_TIMESTAMP WHERE token_hash = ?", tokenHash); err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	if err := tx.Commit(); err != nil {
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}

	renderReset(http.StatusOK, map[string]interface{}{"Success": "Your password has been reset. You can now log in."})
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
		Email    string `json:"email"`
		StageID  int    `json:"stage_id"`
	}

	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		http.Error(w, "Invalid request", http.StatusBadRequest)
		return
	}

	req.Username = strings.TrimSpace(req.Username)
	req.Password = strings.TrimSpace(req.Password)
	req.FullName = strings.TrimSpace(req.FullName)
	email, validEmail := normalizeEmail(req.Email)

	if req.Username == "" || req.Password == "" || req.FullName == "" || !validEmail {
		http.Error(w, "Full name, username, email, and password are required", http.StatusBadRequest)
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

	err = database.DB.QueryRow("SELECT id FROM users WHERE LOWER(email) = LOWER(?)", email).Scan(&existingUserID)
	if err == nil {
		http.Error(w, "Email already exists", http.StatusConflict)
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
		"INSERT INTO users (username, password, role, full_name, email, stage_id) VALUES (?, ?, ?, ?, ?, ?)",
		req.Username, hashedPassword, "student", req.FullName, email, req.StageID,
	)

	if err != nil {
		http.Error(w, "Username already exists", http.StatusConflict)
		return
	}

	if err := sendRegistrationEmail(email, req.FullName, req.Username); err != nil {
		log.Printf("Failed to send registration email to %s: %v", email, err)
	}

	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(map[string]string{"message": "Student registered successfully"})
}
