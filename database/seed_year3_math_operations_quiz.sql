BEGIN TRANSACTION;

INSERT OR IGNORE INTO stages (name, description)
VALUES ('Year 3', 'UK primary Year 3 students.');

INSERT INTO quizzes (title, description, created_by, stage_id, lock_after_attempt, is_archived)
SELECT 'Year 3 Maths Operations Quiz',
       'A 20-question Year 3 UK curriculum maths quiz covering addition, subtraction, multiplication, and division.',
       1,
       (SELECT id FROM stages WHERE name = 'Year 3'),
       0,
       0
WHERE NOT EXISTS (SELECT 1 FROM quizzes WHERE title = 'Year 3 Maths Operations Quiz')
  AND NOT EXISTS (SELECT 1 FROM deleted_seed_quizzes WHERE title = 'Year 3 Maths Operations Quiz');

UPDATE quizzes
SET description = 'A 20-question Year 3 UK curriculum maths quiz covering addition, subtraction, multiplication, and division.',
    stage_id = (SELECT id FROM stages WHERE name = 'Year 3'),
    lock_after_attempt = 0,
    is_archived = 0
WHERE title = 'Year 3 Maths Operations Quiz';

DROP TABLE IF EXISTS seed_year3_math_operations_quiz_id;
CREATE TEMP TABLE seed_year3_math_operations_quiz_id(id INTEGER);
INSERT INTO seed_year3_math_operations_quiz_id
SELECT id FROM quizzes WHERE title = 'Year 3 Maths Operations Quiz' LIMIT 1;

DELETE FROM questions
WHERE quiz_id = (SELECT id FROM seed_year3_math_operations_quiz_id);

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
VALUES
((SELECT id FROM seed_year3_math_operations_quiz_id), 'What is 245 + 30?', 'meaning', '275', '255', '265', '275', '285', 1),
((SELECT id FROM seed_year3_math_operations_quiz_id), 'What is 368 + 100?', 'meaning', '468', '268', '378', '468', '1368', 1),
((SELECT id FROM seed_year3_math_operations_quiz_id), 'What is 147 + 126?', 'meaning', '273', '263', '273', '283', '373', 1),
((SELECT id FROM seed_year3_math_operations_quiz_id), 'A class has 28 pencils. The teacher adds 35 more. How many pencils are there altogether?', 'meaning', '63', '53', '58', '63', '73', 1),
((SELECT id FROM seed_year3_math_operations_quiz_id), 'What is 409 + 85?', 'meaning', '494', '484', '494', '504', '584', 1),

((SELECT id FROM seed_year3_math_operations_quiz_id), 'What is 560 - 40?', 'meaning', '520', '500', '520', '540', '600', 1),
((SELECT id FROM seed_year3_math_operations_quiz_id), 'What is 426 - 100?', 'meaning', '326', '316', '326', '426', '526', 1),
((SELECT id FROM seed_year3_math_operations_quiz_id), 'What is 384 - 129?', 'meaning', '255', '245', '255', '265', '513', 1),
((SELECT id FROM seed_year3_math_operations_quiz_id), 'There are 72 children in a hall. 28 children leave. How many children are left?', 'meaning', '44', '34', '44', '54', '100', 1),
((SELECT id FROM seed_year3_math_operations_quiz_id), 'Which calculation checks 615 - 240 = 375?', 'meaning', '375 + 240 = 615', '375 + 240 = 615', '615 + 240 = 375', '375 - 240 = 615', '615 - 375 = 2400', 1),

((SELECT id FROM seed_year3_math_operations_quiz_id), 'What is 4 x 8?', 'meaning', '32', '24', '28', '32', '36', 1),
((SELECT id FROM seed_year3_math_operations_quiz_id), 'What is 7 x 3?', 'meaning', '21', '10', '18', '21', '24', 1),
((SELECT id FROM seed_year3_math_operations_quiz_id), 'What is 6 x 5?', 'meaning', '30', '11', '25', '30', '35', 1),
((SELECT id FROM seed_year3_math_operations_quiz_id), 'There are 5 bags with 6 apples in each bag. How many apples are there altogether?', 'meaning', '30', '11', '25', '30', '56', 1),
((SELECT id FROM seed_year3_math_operations_quiz_id), 'Which number sentence is in the 8 times table?', 'meaning', '6 x 8 = 48', '6 x 8 = 42', '6 x 8 = 46', '6 x 8 = 48', '6 x 8 = 56', 1),

((SELECT id FROM seed_year3_math_operations_quiz_id), 'What is 48 divided by 8?', 'meaning', '6', '5', '6', '7', '8', 1),
((SELECT id FROM seed_year3_math_operations_quiz_id), 'What is 36 divided by 4?', 'meaning', '9', '6', '8', '9', '12', 1),
((SELECT id FROM seed_year3_math_operations_quiz_id), 'What is 21 divided by 3?', 'meaning', '7', '6', '7', '8', '9', 1),
((SELECT id FROM seed_year3_math_operations_quiz_id), '24 counters are shared equally between 6 children. How many counters does each child get?', 'meaning', '4', '3', '4', '5', '6', 1),
((SELECT id FROM seed_year3_math_operations_quiz_id), 'Which division has the same answer as 5 x 4 = 20?', 'meaning', '20 divided by 4 = 5', '20 divided by 4 = 5', '20 divided by 5 = 5', '20 divided by 2 = 4', '4 divided by 20 = 5', 1);

DROP TABLE seed_year3_math_operations_quiz_id;

COMMIT;
