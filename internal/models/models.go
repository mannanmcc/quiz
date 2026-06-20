package models

import "time"

type User struct {
	ID        int       `json:"id"`
	Username  string    `json:"username"`
	Password  string    `json:"-"`
	Role      string    `json:"role"` // "student" or "admin"
	FullName  string    `json:"full_name"`
	CreatedAt time.Time `json:"created_at"`
}

type Quiz struct {
	ID               int       `json:"id"`
	Title            string    `json:"title"`
	Description      string    `json:"description"`
	CreatedBy        int       `json:"created_by"`
	LockAfterAttempt bool      `json:"lock_after_attempt"`
	CreatedAt        time.Time `json:"created_at"`
}

type Question struct {
	ID            int      `json:"id"`
	QuizID        int      `json:"quiz_id"`
	QuestionText  string   `json:"question_text"`
	QuestionType  string   `json:"question_type"` // "meaning", "synonym", "antonym"
	CorrectAnswer string   `json:"correct_answer"`
	Options       []string `json:"options"`
	Points        int      `json:"points"`
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
	ID             int    `json:"id"`
	AttemptID      int    `json:"attempt_id"`
	QuestionID     int    `json:"question_id"`
	SelectedAnswer string `json:"selected_answer"`
	IsCorrect      bool   `json:"is_correct"`
}
