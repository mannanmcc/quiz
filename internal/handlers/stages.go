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

func getExamTypes() ([]models.ExamType, error) {
	rows, err := database.DB.Query(`
        SELECT id, name, created_at
        FROM exam_types
        ORDER BY name COLLATE NOCASE
    `)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	examTypes := []models.ExamType{}
	for rows.Next() {
		var examType models.ExamType
		if err := rows.Scan(&examType.ID, &examType.Name, &examType.CreatedAt); err != nil {
			return nil, err
		}
		examTypes = append(examTypes, examType)
	}
	return examTypes, rows.Err()
}

func examTypeExists(name string) (bool, error) {
	var id int
	err := database.DB.QueryRow("SELECT id FROM exam_types WHERE name = ? COLLATE NOCASE", name).Scan(&id)
	if err == sql.ErrNoRows {
		return false, nil
	}
	if err != nil {
		return false, err
	}
	return true, nil
}

func getExamSets() ([]models.ExamSet, error) {
	rows, err := database.DB.Query(`
        SELECT es.id, es.exam_type_id, et.name, es.name, es.created_at, es.stage_id, s.name, es.sequence_number, es.is_published, EXISTS(SELECT 1 FROM exam_set_starts st WHERE st.set_id=es.id)
        FROM exam_sets es
        JOIN exam_types et ON et.id = es.exam_type_id
 JOIN stages s ON s.id=es.stage_id
        ORDER BY et.name COLLATE NOCASE, es.stage_id, es.sequence_number
    `)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	examSets := []models.ExamSet{}
	for rows.Next() {
		var examSet models.ExamSet
		if err := rows.Scan(&examSet.ID, &examSet.ExamTypeID, &examSet.ExamTypeName, &examSet.Name, &examSet.CreatedAt, &examSet.StageID, &examSet.StageName, &examSet.SequenceNumber, &examSet.Published, &examSet.Started); err != nil {
			return nil, err
		}
		examSets = append(examSets, examSet)
	}
	return examSets, rows.Err()
}

func examSetBelongsToType(examSetID int, examType string) (bool, error) {
	var id int
	err := database.DB.QueryRow(`
        SELECT es.id
        FROM exam_sets es
        JOIN exam_types et ON et.id = es.exam_type_id
        WHERE es.id = ? AND et.name = ? COLLATE NOCASE
    `, examSetID, examType).Scan(&id)
	if err == sql.ErrNoRows {
		return false, nil
	}
	if err != nil {
		return false, err
	}
	return true, nil
}
