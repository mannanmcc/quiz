package middleware

import (
	"context"
	"database/sql"
	"net/http"
	"vocabulary-quiz-app/internal/database"

	"github.com/gorilla/sessions"
)

var Store = sessions.NewCookieStore([]byte("your-secret-key-change-in-production"))

func init() {
	Store.Options = &sessions.Options{
		Path:     "/",
		MaxAge:   86400 * 30,
		HttpOnly: true,
		SameSite: http.SameSiteLaxMode,
		Secure:   false,
	}
}

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

		var isDisabled bool
		err := database.DB.QueryRow("SELECT COALESCE(is_disabled, 0) FROM users WHERE id = ?", userID).Scan(&isDisabled)
		if err == sql.ErrNoRows || isDisabled {
			session.Values["user_id"] = nil
			session.Values["username"] = nil
			session.Values["role"] = nil
			session.Options.MaxAge = -1
			session.Save(r, w)
			http.Redirect(w, r, "/login", http.StatusSeeOther)
			return
		}
		if err != nil {
			http.Error(w, "Server error", http.StatusInternalServerError)
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
