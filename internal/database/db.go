package database

import (
	"database/sql"
	"log"

	_ "github.com/mattn/go-sqlite3"
)

var DB *sql.DB

func InitDB() error {
	var err error
	DB, err = sql.Open("sqlite3", "./vocabulary_quiz.db")
	if err != nil {
		return err
	}

	if err = DB.Ping(); err != nil {
		return err
	}

	createTables()
	return nil
}

func createTables() {
	schema := `
    CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL,
        role TEXT NOT NULL,
        full_name TEXT NOT NULL,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    );

    CREATE TABLE IF NOT EXISTS quizzes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        created_by INTEGER,
        unlock_version INTEGER DEFAULT 0,
        lock_after_attempt BOOLEAN DEFAULT 1,
        is_archived BOOLEAN DEFAULT 0,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (created_by) REFERENCES users(id)
    );

    CREATE TABLE IF NOT EXISTS questions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        quiz_id INTEGER NOT NULL,
        question_text TEXT NOT NULL,
        question_type TEXT NOT NULL,
        correct_answer TEXT NOT NULL,
        option1 TEXT,
        option2 TEXT,
        option3 TEXT,
        option4 TEXT,
        points INTEGER DEFAULT 1,
        FOREIGN KEY (quiz_id) REFERENCES quizzes(id) ON DELETE CASCADE
    );

    CREATE TABLE IF NOT EXISTS quiz_attempts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        quiz_id INTEGER NOT NULL,
        score INTEGER NOT NULL,
        max_score INTEGER NOT NULL,
        unlock_version INTEGER DEFAULT 0,
        completed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users(id),
        FOREIGN KEY (quiz_id) REFERENCES quizzes(id)
    );

    CREATE TABLE IF NOT EXISTS answers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        attempt_id INTEGER NOT NULL,
        question_id INTEGER NOT NULL,
        selected_answer TEXT NOT NULL,
        is_correct BOOLEAN NOT NULL,
        FOREIGN KEY (attempt_id) REFERENCES quiz_attempts(id) ON DELETE CASCADE,
        FOREIGN KEY (question_id) REFERENCES questions(id)
    );
    `

	_, err := DB.Exec(schema)
	if err != nil {
		log.Fatal("Error creating tables:", err)
	}

	addColumnIfMissing("quizzes", "unlock_version", "INTEGER DEFAULT 0")
	addColumnIfMissing("quizzes", "lock_after_attempt", "BOOLEAN DEFAULT 1")
	addColumnIfMissing("quizzes", "is_archived", "BOOLEAN DEFAULT 0")
	addColumnIfMissing("quiz_attempts", "unlock_version", "INTEGER DEFAULT 0")

	// Create default admin user
	createDefaultAdmin()
}

func addColumnIfMissing(tableName, columnName, columnDefinition string) {
	rows, err := DB.Query("PRAGMA table_info(" + tableName + ")")
	if err != nil {
		log.Fatal("Error checking table schema:", err)
	}
	defer rows.Close()

	for rows.Next() {
		var cid int
		var name, dataType string
		var notNull, pk int
		var defaultValue sql.NullString
		if err := rows.Scan(&cid, &name, &dataType, &notNull, &defaultValue, &pk); err != nil {
			log.Fatal("Error reading table schema:", err)
		}
		if name == columnName {
			return
		}
	}

	if _, err := DB.Exec("ALTER TABLE " + tableName + " ADD COLUMN " + columnName + " " + columnDefinition); err != nil {
		log.Fatal("Error migrating table schema:", err)
	}
}

func createDefaultAdmin() {
	var count int
	DB.QueryRow("SELECT COUNT(*) FROM users WHERE role = 'admin'").Scan(&count)

	if count == 0 {
		_, err := DB.Exec(`
            INSERT INTO users (username, password, role, full_name) 
    VALUES (?, ?, ?, ?)`,
			"admin", "admin123", "admin", "Administrator")

		if err != nil {
			log.Println("Error creating admin:", err)
		} else {
			log.Println("Default admin created - username: admin, password: admin123")
		}
	}
}

func hashPassword(password string) (string, error) {
	// We'll implement this in the auth handler
	return password, nil // Placeholder
}
