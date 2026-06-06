BEGIN TRANSACTION;

INSERT INTO quizzes (title, description, created_by)
VALUES (
    'Mock Exam - Vocabulary Synonyms and Antonyms',
    'Synonym and antonym practice for 20 vocabulary words.',
    1
);

CREATE TEMP TABLE new_quiz_id(id INTEGER);
INSERT INTO new_quiz_id VALUES (last_insert_rowid());

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
VALUES
((SELECT id FROM new_quiz_id), 'Which word is a synonym of "Apprehensive"?', 'synonym', 'anxious', 'confident', 'anxious', 'careless', 'cheerful', 1),
((SELECT id FROM new_quiz_id), 'Which word is an antonym of "Apprehensive"?', 'antonym', 'confident', 'nervous', 'worried', 'confident', 'uneasy', 1),

((SELECT id FROM new_quiz_id), 'Which word is a synonym of "Cumbersome"?', 'synonym', 'awkward', 'simple', 'graceful', 'awkward', 'light', 1),
((SELECT id FROM new_quiz_id), 'Which word is an antonym of "Cumbersome"?', 'antonym', 'manageable', 'bulky', 'clumsy', 'manageable', 'unwieldy', 1),

((SELECT id FROM new_quiz_id), 'Which word is a synonym of "Bemoan"?', 'synonym', 'lament', 'celebrate', 'ignore', 'lament', 'admire', 1),
((SELECT id FROM new_quiz_id), 'Which word is an antonym of "Bemoan"?', 'antonym', 'rejoice', 'mourn', 'complain', 'rejoice', 'regret', 1),

((SELECT id FROM new_quiz_id), 'Which word is a synonym of "Cultivate"?', 'synonym', 'develop', 'neglect', 'destroy', 'develop', 'abandon', 1),
((SELECT id FROM new_quiz_id), 'Which word is an antonym of "Cultivate"?', 'antonym', 'neglect', 'nurture', 'develop', 'encourage', 'neglect', 1),

((SELECT id FROM new_quiz_id), 'Which word is a synonym of "Fathom"?', 'synonym', 'understand', 'misjudge', 'confuse', 'understand', 'forget', 1),
((SELECT id FROM new_quiz_id), 'Which word is an antonym of "Fathom"?', 'antonym', 'misunderstand', 'grasp', 'comprehend', 'misunderstand', 'realize', 1),

((SELECT id FROM new_quiz_id), 'Which word is a synonym of "Existence"?', 'synonym', 'being', 'absence', 'ending', 'being', 'fiction', 1),
((SELECT id FROM new_quiz_id), 'Which word is an antonym of "Existence"?', 'antonym', 'nonexistence', 'life', 'presence', 'reality', 'nonexistence', 1),

((SELECT id FROM new_quiz_id), 'Which word is a synonym of "Brusque"?', 'synonym', 'abrupt', 'polite', 'gentle', 'abrupt', 'patient', 1),
((SELECT id FROM new_quiz_id), 'Which word is an antonym of "Brusque"?', 'antonym', 'courteous', 'curt', 'abrupt', 'courteous', 'blunt', 1),

((SELECT id FROM new_quiz_id), 'Which word is a synonym of "Disastrous"?', 'synonym', 'catastrophic', 'fortunate', 'minor', 'catastrophic', 'helpful', 1),
((SELECT id FROM new_quiz_id), 'Which word is an antonym of "Disastrous"?', 'antonym', 'successful', 'ruinous', 'catastrophic', 'harmful', 'successful', 1),

((SELECT id FROM new_quiz_id), 'Which word is a synonym of "Forthcoming"?', 'synonym', 'upcoming', 'past', 'hidden', 'upcoming', 'reluctant', 1),
((SELECT id FROM new_quiz_id), 'Which word is an antonym of "Forthcoming"?', 'antonym', 'past', 'approaching', 'upcoming', 'expected', 'past', 1),

((SELECT id FROM new_quiz_id), 'Which word is a synonym of "Foreign"?', 'synonym', 'alien', 'native', 'local', 'alien', 'familiar', 1),
((SELECT id FROM new_quiz_id), 'Which word is an antonym of "Foreign"?', 'antonym', 'native', 'strange', 'external', 'native', 'alien', 1),

((SELECT id FROM new_quiz_id), 'Which word is a synonym of "Destitute"?', 'synonym', 'impoverished', 'wealthy', 'comfortable', 'impoverished', 'generous', 1),
((SELECT id FROM new_quiz_id), 'Which word is an antonym of "Destitute"?', 'antonym', 'wealthy', 'poor', 'needy', 'wealthy', 'penniless', 1),

((SELECT id FROM new_quiz_id), 'Which word is a synonym of "Disused"?', 'synonym', 'abandoned', 'active', 'new', 'abandoned', 'maintained', 1),
((SELECT id FROM new_quiz_id), 'Which word is an antonym of "Disused"?', 'antonym', 'used', 'unused', 'abandoned', 'used', 'neglected', 1),

((SELECT id FROM new_quiz_id), 'Which word is a synonym of "Fortuitous"?', 'synonym', 'accidental', 'planned', 'deliberate', 'accidental', 'expected', 1),
((SELECT id FROM new_quiz_id), 'Which word is an antonym of "Fortuitous"?', 'antonym', 'intentional', 'chance', 'accidental', 'random', 'intentional', 1),

((SELECT id FROM new_quiz_id), 'Which word is a synonym of "Flippant"?', 'synonym', 'frivolous', 'serious', 'respectful', 'frivolous', 'solemn', 1),
((SELECT id FROM new_quiz_id), 'Which word is an antonym of "Flippant"?', 'antonym', 'serious', 'frivolous', 'careless', 'serious', 'dismissive', 1),

((SELECT id FROM new_quiz_id), 'Which word is a synonym of "Collide"?', 'synonym', 'crash', 'separate', 'avoid', 'crash', 'cooperate', 1),
((SELECT id FROM new_quiz_id), 'Which word is an antonym of "Collide"?', 'antonym', 'separate', 'crash', 'clash', 'strike', 'separate', 1),

((SELECT id FROM new_quiz_id), 'Which word is a synonym of "Despise"?', 'synonym', 'loathe', 'admire', 'respect', 'loathe', 'cherish', 1),
((SELECT id FROM new_quiz_id), 'Which word is an antonym of "Despise"?', 'antonym', 'admire', 'hate', 'loathe', 'admire', 'detest', 1),

((SELECT id FROM new_quiz_id), 'Which word is a synonym of "Elude"?', 'synonym', 'evade', 'confront', 'catch', 'evade', 'explain', 1),
((SELECT id FROM new_quiz_id), 'Which word is an antonym of "Elude"?', 'antonym', 'confront', 'evade', 'escape', 'avoid', 'confront', 1),

((SELECT id FROM new_quiz_id), 'Which word is a synonym of "Eloquence"?', 'synonym', 'fluency', 'silence', 'clumsiness', 'fluency', 'hesitation', 1),
((SELECT id FROM new_quiz_id), 'Which word is an antonym of "Eloquence"?', 'antonym', 'inarticulateness', 'fluency', 'persuasiveness', 'grace', 'inarticulateness', 1),

((SELECT id FROM new_quiz_id), 'Which word is a synonym of "Feign"?', 'synonym', 'pretend', 'reveal', 'admit', 'pretend', 'prove', 1),
((SELECT id FROM new_quiz_id), 'Which word is an antonym of "Feign"?', 'antonym', 'reveal', 'pretend', 'simulate', 'fake', 'reveal', 1),

((SELECT id FROM new_quiz_id), 'Which word is a synonym of "Fabricate"?', 'synonym', 'invent', 'verify', 'destroy', 'invent', 'confirm', 1),
((SELECT id FROM new_quiz_id), 'Which word is an antonym of "Fabricate"?', 'antonym', 'verify', 'invent', 'falsify', 'manufacture', 'verify', 1);

DROP TABLE new_quiz_id;

COMMIT;
