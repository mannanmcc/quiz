package middleware

import (
    "context"
    "net/http"
    "github.com/gorilla/sessions"
)

var Store = sessions.NewCookieStore([]byte("your-secret-key-change-in-production"))

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
