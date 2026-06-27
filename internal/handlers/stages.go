package handlers

import (
	"database/sql"
	"vocabulary-quiz-app/internal/database"
	"vocabulary-quiz-app/internal/models"
)

func getStages() ([]models.Stage, error) {
	rows, err := database.DB.Query(`
        SELECT id, name, COALESCE(description, ''), created_at
        FROM stages
        ORDER BY
            CASE name WHEN 'General' THEN 0 ELSE 1 END,
            name
    `)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	stages := []models.Stage{}
	for rows.Next() {
		var stage models.Stage
		if err := rows.Scan(&stage.ID, &stage.Name, &stage.Description, &stage.CreatedAt); err != nil {
			return nil, err
		}
		stages = append(stages, stage)
	}

	return stages, rows.Err()
}

func stageExists(stageID int) (bool, error) {
	if stageID <= 0 {
		return false, nil
	}

	var id int
	err := database.DB.QueryRow("SELECT id FROM stages WHERE id = ?", stageID).Scan(&id)
	if err == sql.ErrNoRows {
		return false, nil
	}
	if err != nil {
		return false, err
	}

	return true, nil
}
