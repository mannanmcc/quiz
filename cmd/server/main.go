package main

import (
	"log"
	"net/http"
	"os"
	"vocabulary-quiz-app/internal/database"
	"vocabulary-quiz-app/internal/handlers"
	"vocabulary-quiz-app/internal/middleware"

	"github.com/gorilla/mux"
)

func main() {
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
		port = "80"
	}

	log.Printf("Server starting on http://localhost:%s", port)
	log.Println("Default admin login - username: admin, password: admin123")
	log.Fatal(http.ListenAndServe(":"+port, r))
}
