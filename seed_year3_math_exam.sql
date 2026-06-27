BEGIN TRANSACTION;

INSERT OR IGNORE INTO stages (name, description)
VALUES ('Year 3', 'UK primary Year 3 students.');

INSERT INTO quizzes (title, description, created_by, stage_id, lock_after_attempt)
VALUES (
    'Year 3 Maths Practice - UK Curriculum',
    'A Year 3 maths practice exam covering place value, addition, subtraction, multiplication, division, fractions, measurement, geometry, and statistics.',
    1,
    (SELECT id FROM stages WHERE name = 'Year 3'),
    0
);

CREATE TEMP TABLE new_year3_math_quiz_id(id INTEGER);
INSERT INTO new_year3_math_quiz_id VALUES (last_insert_rowid());

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
VALUES
((SELECT id FROM new_year3_math_quiz_id), 'What is the value of the digit 7 in 472?', 'meaning', '70', '7', '70', '700', '407', 1),
((SELECT id FROM new_year3_math_quiz_id), 'Which number is 100 more than 386?', 'meaning', '486', '286', '396', '486', '3860', 1),
((SELECT id FROM new_year3_math_quiz_id), 'Which number is the greatest?', 'meaning', '509', '495', '509', '490', '499', 1),
((SELECT id FROM new_year3_math_quiz_id), 'Count on in 50s: 150, 200, 250, ___.', 'meaning', '300', '275', '300', '350', '400', 1),

((SELECT id FROM new_year3_math_quiz_id), 'What is 235 + 40?', 'meaning', '275', '239', '265', '275', '635', 1),
((SELECT id FROM new_year3_math_quiz_id), 'What is 426 - 100?', 'meaning', '326', '416', '326', '526', '306', 1),
((SELECT id FROM new_year3_math_quiz_id), 'What is 348 + 125?', 'meaning', '473', '463', '473', '483', '573', 1),
((SELECT id FROM new_year3_math_quiz_id), 'What is 702 - 268?', 'meaning', '434', '444', '534', '434', '466', 1),
((SELECT id FROM new_year3_math_quiz_id), 'Which calculation checks 528 - 176 = 352?', 'meaning', '352 + 176 = 528', '352 + 176 = 528', '528 + 176 = 352', '352 - 176 = 528', '528 - 352 = 1760', 1),

((SELECT id FROM new_year3_math_quiz_id), 'What is 4 x 8?', 'meaning', '32', '24', '28', '32', '36', 1),
((SELECT id FROM new_year3_math_quiz_id), 'What is 7 x 3?', 'meaning', '21', '10', '18', '21', '24', 1),
((SELECT id FROM new_year3_math_quiz_id), 'What is 48 divided by 8?', 'meaning', '6', '5', '6', '7', '8', 1),
((SELECT id FROM new_year3_math_quiz_id), 'There are 4 bags with 6 apples in each bag. How many apples are there altogether?', 'meaning', '24', '10', '20', '24', '46', 1),
((SELECT id FROM new_year3_math_quiz_id), 'Which number sentence is in the 8 times table?', 'meaning', '6 x 8 = 48', '6 x 8 = 42', '6 x 8 = 46', '6 x 8 = 48', '6 x 8 = 56', 1),

((SELECT id FROM new_year3_math_quiz_id), 'Which fraction is shaded if 3 out of 8 equal parts are shaded?', 'meaning', '3/8', '8/3', '3/8', '5/8', '3/5', 1),
((SELECT id FROM new_year3_math_quiz_id), 'What is 2/5 + 1/5?', 'meaning', '3/5', '2/10', '3/10', '3/5', '1/5', 1),
((SELECT id FROM new_year3_math_quiz_id), 'What is 5/6 - 2/6?', 'meaning', '3/6', '7/6', '3/6', '3/0', '2/6', 1),
((SELECT id FROM new_year3_math_quiz_id), 'Which fraction is equivalent to one half?', 'meaning', '2/4', '1/3', '2/4', '3/5', '4/6', 1),

((SELECT id FROM new_year3_math_quiz_id), 'A pencil costs 35p and a rubber costs 20p. How much do they cost altogether?', 'meaning', '55p', '15p', '45p', '55p', '65p', 1),
((SELECT id FROM new_year3_math_quiz_id), 'What time is 25 minutes after 3:10?', 'meaning', '3:35', '3:25', '3:35', '4:10', '2:45', 1),
((SELECT id FROM new_year3_math_quiz_id), 'A rectangle has sides of 6 cm and 4 cm. What is its perimeter?', 'meaning', '20 cm', '10 cm', '16 cm', '20 cm', '24 cm', 1),
((SELECT id FROM new_year3_math_quiz_id), 'Which is the best unit to measure the mass of a bag of potatoes?', 'meaning', 'kilograms', 'millilitres', 'centimetres', 'kilograms', 'minutes', 1),

((SELECT id FROM new_year3_math_quiz_id), 'How many right angles are in a rectangle?', 'meaning', '4', '1', '2', '3', '4', 1),
((SELECT id FROM new_year3_math_quiz_id), 'Which pair of lines never meet?', 'meaning', 'parallel lines', 'curved lines', 'parallel lines', 'intersecting lines', 'vertical lines', 1),

((SELECT id FROM new_year3_math_quiz_id), 'A pictogram key shows one star means 2 books. If Sam has 5 stars, how many books is that?', 'meaning', '10', '5', '7', '10', '12', 1);

DROP TABLE new_year3_math_quiz_id;

COMMIT;
