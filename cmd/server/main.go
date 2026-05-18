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
    adminRouter.HandleFunc("/api/quiz/create", handlers.CreateQuizHandler).Methods("POST")
    adminRouter.HandleFunc("/api/quiz/{quiz_id}/results", handlers.GetStudentResultsHandler).Methods("GET")

    // Static files
    r.PathPrefix("/static/").Handler(http.StripPrefix("/static/", http.FileServer(http.Dir("static"))))

    log.Println("Server starting on http://localhost:8080")
    log.Println("Default admin login - username: admin, password: admin123")
    log.Fatal(http.ListenAndServe(":8080", r))
}