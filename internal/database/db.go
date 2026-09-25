package database

import (
	"database/sql"
	"log"
	"os"

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
        stage_id INTEGER,
        email TEXT,
        is_disabled BOOLEAN DEFAULT 0,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    );

    CREATE TABLE IF NOT EXISTS password_reset_tokens (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        token_hash TEXT NOT NULL UNIQUE,
        expires_at DATETIME NOT NULL,
        used_at DATETIME,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
    );

    CREATE TABLE IF NOT EXISTS stages (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT UNIQUE NOT NULL,
        description TEXT,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    );

    CREATE TABLE IF NOT EXISTS quizzes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        created_by INTEGER,
        stage_id INTEGER,
        unlock_version INTEGER DEFAULT 0,
        time_limit_minutes INTEGER DEFAULT 0,
        lock_after_attempt BOOLEAN DEFAULT 1,
        is_archived BOOLEAN DEFAULT 0,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (created_by) REFERENCES users(id)
    );

    CREATE TABLE IF NOT EXISTS questions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        quiz_id INTEGER NOT NULL,
        question_context TEXT,
        question_text TEXT NOT NULL,
        question_diagram TEXT,
        answer_explanation TEXT,
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

    CREATE TABLE IF NOT EXISTS personalized_quiz_assignments (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        quiz_id INTEGER NOT NULL,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
        FOREIGN KEY (quiz_id) REFERENCES quizzes(id) ON DELETE CASCADE
    );

    CREATE TABLE IF NOT EXISTS deleted_seed_quizzes (
        title TEXT PRIMARY KEY,
        deleted_at DATETIME DEFAULT CURRENT_TIMESTAMP
    );
    `

	_, err := DB.Exec(schema)
	if err != nil {
		log.Fatal("Error creating tables:", err)
	}

	addColumnIfMissing("quizzes", "unlock_version", "INTEGER DEFAULT 0")
	addColumnIfMissing("quizzes", "lock_after_attempt", "BOOLEAN DEFAULT 1")
	addColumnIfMissing("quizzes", "is_archived", "BOOLEAN DEFAULT 0")
	addColumnIfMissing("quizzes", "stage_id", "INTEGER")
	addColumnIfMissing("quizzes", "time_limit_minutes", "INTEGER DEFAULT 0")
	addColumnIfMissing("questions", "question_context", "TEXT")
	addColumnIfMissing("questions", "question_diagram", "TEXT")
	addColumnIfMissing("questions", "answer_explanation", "TEXT")
	addColumnIfMissing("users", "stage_id", "INTEGER")
	addColumnIfMissing("users", "email", "TEXT")
	addColumnIfMissing("users", "is_disabled", "BOOLEAN DEFAULT 0")
	addColumnIfMissing("quiz_attempts", "unlock_version", "INTEGER DEFAULT 0")

	createDefaultStages()
	assignDefaultStage()

	// Create default admin user
	createDefaultAdmin()
	runSeedFileIfPresent("seed_year5_vocabulary_exams.sql")
}

func runSeedFileIfPresent(path string) {
	seedSQL, err := os.ReadFile(path)
	if err != nil {
		if os.IsNotExist(err) {
			return
		}
		log.Fatal("Error reading seed file:", err)
	}

	if _, err := DB.Exec(string(seedSQL)); err != nil {
		log.Fatal("Error running seed file:", err)
	}
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

func createDefaultStages() {
	defaultStages := []struct {
		name        string
		description string
	}{
		{"General", "Shared exams not tied to one school year."},
		{"Year 1", "UK primary Year 1 students."},
		{"Year 2", "UK primary Year 2 students."},
		{"Year 3", "UK primary Year 3 students."},
		{"Year 4", "UK primary Year 4 students."},
		{"Year 5", "UK primary Year 5 students."},
		{"Year 6", "UK primary Year 6 students."},
	}

	for _, stage := range defaultStages {
		if _, err := DB.Exec(
			"INSERT OR IGNORE INTO stages (name, description) VALUES (?, ?)",
			stage.name, stage.description,
		); err != nil {
			log.Fatal("Error creating default stages:", err)
		}
	}
}

func assignDefaultStage() {
	var generalStageID int
	if err := DB.QueryRow("SELECT id FROM stages WHERE name = 'General'").Scan(&generalStageID); err != nil {
		log.Fatal("Error reading default stage:", err)
	}

	if _, err := DB.Exec("UPDATE users SET stage_id = ? WHERE stage_id IS NULL AND role = 'student'", generalStageID); err != nil {
		log.Fatal("Error assigning default student stage:", err)
	}
	if _, err := DB.Exec("UPDATE quizzes SET stage_id = ? WHERE stage_id IS NULL", generalStageID); err != nil {
		log.Fatal("Error assigning default quiz stage:", err)
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
