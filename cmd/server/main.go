package main

import (
	"log"
	"net/http"
	"os"
	"vocabulary-quiz-app/internal/config"
	"vocabulary-quiz-app/internal/database"
	"vocabulary-quiz-app/internal/handlers"
	"vocabulary-quiz-app/internal/middleware"

	"github.com/gorilla/mux"
)

func main() {
	config.LoadLocalEnv()

	// Initialize database
	if err := database.InitDB(); err != nil {
		log.Fatal("Failed to initialize database:", err)
	}
	defer database.DB.Close()

	// Create router
	r := mux.NewRouter()

	// Public routes
	r.HandleFunc("/", handlers.LoginPageHandler).Methods("GET")
	r.HandleFunc("/login", handlers.LoginPageHandler).Methods("GET")
	r.HandleFunc("/login", handlers.LoginHandler).Methods("POST")
	r.HandleFunc("/logout", handlers.LogoutHandler).Methods("GET")
	r.HandleFunc("/api/register", handlers.RegisterStudentHandler).Methods("POST")
	r.HandleFunc("/api/password-reset", handlers.ForgotPasswordHandler).Methods("POST")
	r.HandleFunc("/reset-password", handlers.ResetPasswordPageHandler).Methods("GET")
	r.HandleFunc("/reset-password", handlers.ResetPasswordHandler).Methods("POST")

	// Student routes
	studentRouter := r.PathPrefix("/student").Subrouter()
	studentRouter.Use(middleware.AuthMiddleware)
	studentRouter.HandleFunc("/dashboard", handlers.StudentDashboardHandler).Methods("GET")
	studentRouter.HandleFunc("/quiz/{quiz_id}", handlers.QuizPageHandler).Methods("GET")
	studentRouter.HandleFunc("/attempt/{attempt_id}/report.pdf", handlers.StudentAttemptReportPDFHandler).Methods("GET")
	studentRouter.HandleFunc("/attempt/{attempt_id}/mistakes.pdf", handlers.StudentAttemptMistakesPDFHandler).Methods("GET")
	studentRouter.HandleFunc("/api/quiz/{quiz_id}", handlers.GetQuizHandler).Methods("GET")
	studentRouter.HandleFunc("/api/quiz/{quiz_id}/submit", handlers.SubmitQuizHandler).Methods("POST")

	// Admin routes
	adminRouter := r.PathPrefix("/admin").Subrouter()
	adminRouter.Use(middleware.AuthMiddleware)
	adminRouter.Use(middleware.AdminMiddleware)
	adminRouter.HandleFunc("/dashboard", handlers.AdminDashboardHandler).Methods("GET")
	adminRouter.HandleFunc("/student/create", handlers.CreateStudentPageHandler).Methods("GET")
	adminRouter.HandleFunc("/student/{student_id}/edit", handlers.EditStudentPageHandler).Methods("GET")
	adminRouter.HandleFunc("/personalized-practice", handlers.CreatePersonalizedPracticePageHandler).Methods("GET")
	adminRouter.HandleFunc("/attempt/{attempt_id}/report.pdf", handlers.AdminAttemptReportPDFHandler).Methods("GET")
	adminRouter.HandleFunc("/attempt/{attempt_id}/mistakes.pdf", handlers.AdminAttemptMistakesPDFHandler).Methods("GET")
	adminRouter.HandleFunc("/api/student/{student_id}/{action:disable|enable}", handlers.SetStudentDisabledHandler).Methods("POST")
	adminRouter.HandleFunc("/api/student/{student_id}", handlers.UpdateStudentHandler).Methods("PUT")
	adminRouter.HandleFunc("/api/student/{student_id}", handlers.DeleteStudentHandler).Methods("DELETE")
	adminRouter.HandleFunc("/api/personalized-practice", handlers.CreatePersonalizedPracticePaperHandler).Methods("POST")
	adminRouter.HandleFunc("/quiz/create", handlers.CreateQuizPageHandler).Methods("GET")
	adminRouter.HandleFunc("/quiz/{quiz_id}/edit", handlers.EditQuizPageHandler).Methods("GET")
	adminRouter.HandleFunc("/api/quiz/create", handlers.CreateQuizHandler).Methods("POST")
	adminRouter.HandleFunc("/api/quiz/{quiz_id}", handlers.GetAdminQuizHandler).Methods("GET")
	adminRouter.HandleFunc("/api/quiz/{quiz_id}", handlers.UpdateQuizHandler).Methods("PUT")
	adminRouter.HandleFunc("/api/quiz/{quiz_id}", handlers.DeleteQuizHandler).Methods("DELETE")
	adminRouter.HandleFunc("/api/quiz/{quiz_id}/archive", handlers.ArchiveQuizHandler).Methods("POST")
	adminRouter.HandleFunc("/api/quiz/{quiz_id}/unarchive", handlers.UnarchiveQuizHandler).Methods("POST")
	adminRouter.HandleFunc("/api/quiz/{quiz_id}/results", handlers.GetStudentResultsHandler).Methods("GET")
	adminRouter.HandleFunc("/api/quiz/{quiz_id}/progress", handlers.GetQuizProgressReportHandler).Methods("GET")
	adminRouter.HandleFunc("/api/quiz/{quiz_id}/reset", handlers.ResetQuizAttemptsHandler).Methods("POST")

	// Static files
	r.PathPrefix("/static/").Handler(http.StripPrefix("/static/", http.FileServer(http.Dir("static"))))

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	log.Printf("Server starting on http://localhost:%s", port)
	log.Println("Default admin login - username: admin, password: admin123")
	log.Fatal(http.ListenAndServe(":"+port, r))
}
