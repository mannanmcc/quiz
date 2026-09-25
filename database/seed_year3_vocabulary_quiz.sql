BEGIN TRANSACTION;

INSERT OR IGNORE INTO stages (name, description)
VALUES ('Year 3', 'UK primary Year 3 students.');

INSERT INTO quizzes (title, description, created_by, stage_id, lock_after_attempt, is_archived)
SELECT 'Year 3 Vocabulary Quiz',
       'A 20-question Year 3 vocabulary quiz covering meaning and word understanding.',
       1,
       (SELECT id FROM stages WHERE name = 'Year 3'),
       0,
       0
WHERE NOT EXISTS (SELECT 1 FROM quizzes WHERE title = 'Year 3 Vocabulary Quiz')
  AND NOT EXISTS (SELECT 1 FROM deleted_seed_quizzes WHERE title = 'Year 3 Vocabulary Quiz');

UPDATE quizzes
SET description = 'A 20-question Year 3 vocabulary quiz covering meaning and word understanding.',
    stage_id = (SELECT id FROM stages WHERE name = 'Year 3'),
    lock_after_attempt = 0,
    is_archived = 0
WHERE title = 'Year 3 Vocabulary Quiz';

DROP TABLE IF EXISTS seed_year3_vocab_quiz_id;
CREATE TEMP TABLE seed_year3_vocab_quiz_id(id INTEGER);
INSERT INTO seed_year3_vocab_quiz_id SELECT id FROM quizzes WHERE title = 'Year 3 Vocabulary Quiz' LIMIT 1;

DELETE FROM questions
WHERE quiz_id = (SELECT id FROM seed_year3_vocab_quiz_id);

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
VALUES
((SELECT id FROM seed_year3_vocab_quiz_id), 'What does "ancient" mean?', 'meaning', 'Very old', 'Very old', 'Very noisy', 'Very small', 'Very quick', 1),
((SELECT id FROM seed_year3_vocab_quiz_id), 'What does "brave" mean?', 'meaning', 'Showing courage', 'Showing courage', 'Feeling sleepy', 'Speaking quietly', 'Moving slowly', 1),
((SELECT id FROM seed_year3_vocab_quiz_id), 'What does "curious" mean?', 'meaning', 'Wanting to know more', 'Wanting to know more', 'Feeling very angry', 'Hard to break', 'Almost gone', 1),
((SELECT id FROM seed_year3_vocab_quiz_id), 'What does "delighted" mean?', 'meaning', 'Very pleased', 'Very pleased', 'Very worried', 'Very old', 'Very tired', 1),
((SELECT id FROM seed_year3_vocab_quiz_id), 'What does "enormous" mean?', 'meaning', 'Very large', 'Very large', 'Very quiet', 'Very rare', 'Very shy', 1),
((SELECT id FROM seed_year3_vocab_quiz_id), 'What does "furious" mean?', 'meaning', 'Very angry', 'Very angry', 'Very happy', 'Very careful', 'Very tiny', 1),
((SELECT id FROM seed_year3_vocab_quiz_id), 'What is a "glimpse"?', 'meaning', 'A quick look', 'A quick look', 'A long trip', 'A loud complaint', 'A hidden treasure', 1),
((SELECT id FROM seed_year3_vocab_quiz_id), 'What does "grumble" mean?', 'meaning', 'Complain quietly', 'Complain quietly', 'Disappear suddenly', 'Run very fast', 'Ask many questions', 1),
((SELECT id FROM seed_year3_vocab_quiz_id), 'What is a "journey"?', 'meaning', 'A trip from one place to another', 'A trip from one place to another', 'A tiny sound', 'A strong box', 'A quick look', 1),
((SELECT id FROM seed_year3_vocab_quiz_id), 'What does "mysterious" mean?', 'meaning', 'Hard to explain or understand', 'Hard to explain or understand', 'Easy to carry', 'Full of courage', 'Very common', 1),
((SELECT id FROM seed_year3_vocab_quiz_id), 'What does "nervous" mean?', 'meaning', 'Worried or uneasy', 'Worried or uneasy', 'Very strong', 'Very pleased', 'Very old', 1),
((SELECT id FROM seed_year3_vocab_quiz_id), 'What does "precious" mean?', 'meaning', 'Very special or valuable', 'Very special or valuable', 'Very angry', 'Very quick', 'Very tired', 1),
((SELECT id FROM seed_year3_vocab_quiz_id), 'What does "rapid" mean?', 'meaning', 'Very fast', 'Very fast', 'Very old', 'Very shy', 'Very rare', 1),
((SELECT id FROM seed_year3_vocab_quiz_id), 'What does "reluctant" mean?', 'meaning', 'Not wanting to do something', 'Not wanting to do something', 'Ready to help at once', 'Very pleased', 'Very large', 1),
((SELECT id FROM seed_year3_vocab_quiz_id), 'What does "scarce" mean?', 'meaning', 'Not much available', 'Not much available', 'Very strong', 'Very loud', 'Easy to see', 1),
((SELECT id FROM seed_year3_vocab_quiz_id), 'What does "sturdy" mean?', 'meaning', 'Strong and well made', 'Strong and well made', 'Afraid and shy', 'Hard to explain', 'Very angry', 1),
((SELECT id FROM seed_year3_vocab_quiz_id), 'What does "timid" mean?', 'meaning', 'Shy or easily frightened', 'Shy or easily frightened', 'Very quick', 'Very valuable', 'Very pleased', 1),
((SELECT id FROM seed_year3_vocab_quiz_id), 'What does "vanish" mean?', 'meaning', 'Disappear suddenly', 'Disappear suddenly', 'Complain quietly', 'Travel somewhere', 'Look quickly', 1),
((SELECT id FROM seed_year3_vocab_quiz_id), 'What does "weary" mean?', 'meaning', 'Very tired', 'Very tired', 'Very brave', 'Very rare', 'Very huge', 1),
((SELECT id FROM seed_year3_vocab_quiz_id), 'What does "whisper" mean?', 'meaning', 'Speak very quietly', 'Speak very quietly', 'Shout loudly', 'Move very quickly', 'Feel very angry', 1);

DROP TABLE seed_year3_vocab_quiz_id;

COMMIT;
