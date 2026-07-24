BEGIN TRANSACTION;

INSERT OR IGNORE INTO stages (name, description)
VALUES ('Year 5', 'UK primary Year 5 students.');

UPDATE quizzes SET title = 'Year 5 Vocabulary Synonym Paper 1',
       description = 'A 100-question Year 5 vocabulary exam asking students to identify synonym pairs.'
WHERE title = 'Year 5 Vocabulary Synonyms Exam'
  AND NOT EXISTS (SELECT 1 FROM quizzes WHERE title = 'Year 5 Vocabulary Synonym Paper 1');

UPDATE quizzes SET title = 'Year 5 Vocabulary Antonym Paper 1',
       description = 'A 100-question Year 5 vocabulary exam asking students to identify antonym pairs.'
WHERE title = 'Year 5 Vocabulary Antonyms Exam'
  AND NOT EXISTS (SELECT 1 FROM quizzes WHERE title = 'Year 5 Vocabulary Antonym Paper 1');

-- Year 5 Vocabulary Synonym Paper 1
INSERT INTO quizzes (title, description, created_by, stage_id, lock_after_attempt)
SELECT 'Year 5 Vocabulary Synonym Paper 1',
       'A 100-question Year 5 vocabulary exam asking students to identify synonym pairs.',
       1,
       (SELECT id FROM stages WHERE name = 'Year 5'),
       1
WHERE NOT EXISTS (SELECT 1 FROM quizzes WHERE title = 'Year 5 Vocabulary Synonym Paper 1');

DROP TABLE IF EXISTS seed_quiz_id;
CREATE TEMP TABLE seed_quiz_id(id INTEGER);
INSERT INTO seed_quiz_id SELECT id FROM quizzes WHERE title = 'Year 5 Vocabulary Synonym Paper 1' LIMIT 1;

UPDATE questions
SET option1 = 'Kill, Destroy',
    option2 = 'Destroy, Reveal',
    option3 = 'Invent, Fake',
    option4 = 'Shaky, Weak'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "fabricate"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Invent, Fake';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "fabricate"?', 'synonym', 'Invent, Fake', 'Kill, Destroy', 'Destroy, Reveal', 'Invent, Fake', 'Shaky, Weak', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "fabricate"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Invent, Fake'
) < 1;

UPDATE questions
SET option1 = 'Shaky, Weak',
    option2 = 'Firm, Stubborn',
    option3 = 'Steady, Firm',
    option4 = 'Flexible, Weak'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "unwavering"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Steady, Firm';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "unwavering"?', 'synonym', 'Steady, Firm', 'Shaky, Weak', 'Firm, Stubborn', 'Steady, Firm', 'Flexible, Weak', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "unwavering"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Steady, Firm'
) < 1;

UPDATE questions
SET option1 = 'Flexible, Weak',
    option2 = 'Incomprehensible, Mysterious',
    option3 = 'Ordinary, Usual',
    option4 = 'Clear, Simple'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "unfathomable"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Incomprehensible, Mysterious';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "unfathomable"?', 'synonym', 'Incomprehensible, Mysterious', 'Flexible, Weak', 'Incomprehensible, Mysterious', 'Ordinary, Usual', 'Clear, Simple', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "unfathomable"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Incomprehensible, Mysterious'
) < 1;

UPDATE questions
SET option1 = 'Steady, Firm',
    option2 = 'Flexible, Weak',
    option3 = 'Shaky, Weak',
    option4 = 'Firm, Stubborn'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "unyielding"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Firm, Stubborn';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "unyielding"?', 'synonym', 'Firm, Stubborn', 'Steady, Firm', 'Flexible, Weak', 'Shaky, Weak', 'Firm, Stubborn', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "unyielding"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Firm, Stubborn'
) < 1;

UPDATE questions
SET option1 = 'Shaky, Weak',
    option2 = 'Unique, Extraordinary',
    option3 = 'Flexible, Weak',
    option4 = 'Ordinary, Usual'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "unprecedented"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Unique, Extraordinary';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "unprecedented"?', 'synonym', 'Unique, Extraordinary', 'Shaky, Weak', 'Unique, Extraordinary', 'Flexible, Weak', 'Ordinary, Usual', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "unprecedented"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Unique, Extraordinary'
) < 1;

UPDATE questions
SET option1 = 'Flexible, Weak',
    option2 = 'Shaky, Weak',
    option3 = 'Afraid, Timid',
    option4 = 'Brave, Fearless'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "unflinching"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Brave, Fearless';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "unflinching"?', 'synonym', 'Brave, Fearless', 'Flexible, Weak', 'Shaky, Weak', 'Afraid, Timid', 'Brave, Fearless', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "unflinching"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Brave, Fearless'
) < 1;

UPDATE questions
SET option1 = 'Kill, Destroy',
    option2 = 'Refill, Restore',
    option3 = 'Restore, Resurrect',
    option4 = 'Forget, Ignore'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "revive"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Restore, Resurrect';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "revive"?', 'synonym', 'Restore, Resurrect', 'Kill, Destroy', 'Refill, Restore', 'Restore, Resurrect', 'Forget, Ignore', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "revive"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Restore, Resurrect'
) < 1;

UPDATE questions
SET option1 = 'Refresh, Renew',
    option2 = 'Empty, Drain',
    option3 = 'Forget, Ignore',
    option4 = 'Age, Weaken'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "rejuvenate"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Refresh, Renew';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "rejuvenate"?', 'synonym', 'Refresh, Renew', 'Refresh, Renew', 'Empty, Drain', 'Forget, Ignore', 'Age, Weaken', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "rejuvenate"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Refresh, Renew'
) < 1;

UPDATE questions
SET option1 = 'Reignite, Restart',
    option2 = 'Repeat, Restate',
    option3 = 'Age, Weaken',
    option4 = 'Forget, Ignore'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "reiterate"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Repeat, Restate';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "reiterate"?', 'synonym', 'Repeat, Restate', 'Reignite, Restart', 'Repeat, Restate', 'Age, Weaken', 'Forget, Ignore', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "reiterate"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Repeat, Restate'
) < 1;

UPDATE questions
SET option1 = 'Extinguish, End',
    option2 = 'Repeat, Restate',
    option3 = 'Reignite, Restart',
    option4 = 'Forget, Ignore'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "rekindle"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Reignite, Restart';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "rekindle"?', 'synonym', 'Reignite, Restart', 'Extinguish, End', 'Repeat, Restate', 'Reignite, Restart', 'Forget, Ignore', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "rekindle"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Reignite, Restart'
) < 1;

UPDATE questions
SET option1 = 'Forget, Ignore',
    option2 = 'Refill, Restore',
    option3 = 'Restore, Resurrect',
    option4 = 'Empty, Drain'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "replenish"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Refill, Restore';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "replenish"?', 'synonym', 'Refill, Restore', 'Forget, Ignore', 'Refill, Restore', 'Restore, Resurrect', 'Empty, Drain', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "replenish"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Refill, Restore'
) < 1;

UPDATE questions
SET option1 = 'Rude, Insolent',
    option2 = 'Respectful',
    option3 = 'Passable, Open',
    option4 = 'Impassable, Unbreakable'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "impertinent"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Rude, Insolent';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "impertinent"?', 'synonym', 'Rude, Insolent', 'Rude, Insolent', 'Respectful', 'Passable, Open', 'Impassable, Unbreakable', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "impertinent"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Rude, Insolent'
) < 1;

UPDATE questions
SET option1 = 'Unlawful, Invalid',
    option2 = 'Legal, Legitimate',
    option3 = 'Doubtful, Uncertain',
    option4 = 'Thinkable, Likely'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "illegitimate"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Unlawful, Invalid';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "illegitimate"?', 'synonym', 'Unlawful, Invalid', 'Unlawful, Invalid', 'Legal, Legitimate', 'Doubtful, Uncertain', 'Thinkable, Likely', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "illegitimate"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Unlawful, Invalid'
) < 1;

UPDATE questions
SET option1 = 'Passable, Open',
    option2 = 'Doubtful, Uncertain',
    option3 = 'Certain, Definite',
    option4 = 'Respectful'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "irrefutable"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Certain, Definite';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "irrefutable"?', 'synonym', 'Certain, Definite', 'Passable, Open', 'Doubtful, Uncertain', 'Certain, Definite', 'Respectful', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "irrefutable"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Certain, Definite'
) < 1;

UPDATE questions
SET option1 = 'Respectful',
    option2 = 'Passable, Open',
    option3 = 'Rude, Insolent',
    option4 = 'Impassable, Unbreakable'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "impenetrable"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Impassable, Unbreakable';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "impenetrable"?', 'synonym', 'Impassable, Unbreakable', 'Respectful', 'Passable, Open', 'Rude, Insolent', 'Impassable, Unbreakable', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "impenetrable"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Impassable, Unbreakable'
) < 1;

UPDATE questions
SET option1 = 'Preventable, Unlikely',
    option2 = 'Thinkable, Likely',
    option3 = 'Passable, Open',
    option4 = 'Unthinkable, Unimaginable'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "inconceivable"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Unthinkable, Unimaginable';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "inconceivable"?', 'synonym', 'Unthinkable, Unimaginable', 'Preventable, Unlikely', 'Thinkable, Likely', 'Passable, Open', 'Unthinkable, Unimaginable', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "inconceivable"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Unthinkable, Unimaginable'
) < 1;

UPDATE questions
SET option1 = 'Encourage, Cheer',
    option2 = 'Confuse, Bewilder',
    option3 = 'Guide, Clarify',
    option4 = 'Notice, Respect'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "disorient"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Confuse, Bewilder';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "disorient"?', 'synonym', 'Confuse, Bewilder', 'Encourage, Cheer', 'Confuse, Bewilder', 'Guide, Clarify', 'Notice, Respect', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "disorient"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Confuse, Bewilder'
) < 1;

UPDATE questions
SET option1 = 'Warn, Discourage',
    option2 = 'Persuade, Encourage',
    option3 = 'Encourage, Cheer',
    option4 = 'Discourage, Depress'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "dishearten"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Discourage, Depress';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "dishearten"?', 'synonym', 'Discourage, Depress', 'Warn, Discourage', 'Persuade, Encourage', 'Encourage, Cheer', 'Discourage, Depress', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "dishearten"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Discourage, Depress'
) < 1;

UPDATE questions
SET option1 = 'Encourage, Cheer',
    option2 = 'Guide, Clarify',
    option3 = 'Ignore, Neglect',
    option4 = 'Notice, Respect'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "disregard"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Ignore, Neglect';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "disregard"?', 'synonym', 'Ignore, Neglect', 'Encourage, Cheer', 'Guide, Clarify', 'Ignore, Neglect', 'Notice, Respect', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "disregard"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Ignore, Neglect'
) < 1;

UPDATE questions
SET option1 = 'Persuade, Encourage',
    option2 = 'Gather, Keep',
    option3 = 'Scatter, Eliminate',
    option4 = 'Encourage, Cheer'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "dispel"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Scatter, Eliminate';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "dispel"?', 'synonym', 'Scatter, Eliminate', 'Persuade, Encourage', 'Gather, Keep', 'Scatter, Eliminate', 'Encourage, Cheer', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "dispel"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Scatter, Eliminate'
) < 1;

UPDATE questions
SET option1 = 'Encourage, Cheer',
    option2 = 'Discourage, Depress',
    option3 = 'Warn, Discourage',
    option4 = 'Persuade, Encourage'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "dissuade"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Warn, Discourage';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "dissuade"?', 'synonym', 'Warn, Discourage', 'Encourage, Cheer', 'Discourage, Depress', 'Warn, Discourage', 'Persuade, Encourage', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "dissuade"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Warn, Discourage'
) < 1;

UPDATE questions
SET option1 = 'Plain, Simplify',
    option2 = 'Weaken, Discourage',
    option3 = 'Strengthen, Enable',
    option4 = 'Decorate, Adorn'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "embellish"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Decorate, Adorn';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "embellish"?', 'synonym', 'Decorate, Adorn', 'Plain, Simplify', 'Weaken, Discourage', 'Strengthen, Enable', 'Decorate, Adorn', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "embellish"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Decorate, Adorn'
) < 1;

UPDATE questions
SET option1 = 'Quit, Give up',
    option2 = 'Involve, Include',
    option3 = 'Persist, Survive',
    option4 = 'Exclude, Avoid'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "endure"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Persist, Survive';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "endure"?', 'synonym', 'Persist, Survive', 'Quit, Give up', 'Involve, Include', 'Persist, Survive', 'Exclude, Avoid', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "endure"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Persist, Survive'
) < 1;

UPDATE questions
SET option1 = 'Exclude, Avoid',
    option2 = 'Quit, Give up',
    option3 = 'Teach, Inform',
    option4 = 'Confuse, Mislead'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "enlighten"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Teach, Inform';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "enlighten"?', 'synonym', 'Teach, Inform', 'Exclude, Avoid', 'Quit, Give up', 'Teach, Inform', 'Confuse, Mislead', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "enlighten"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Teach, Inform'
) < 1;

UPDATE questions
SET option1 = 'Decorate, Adorn',
    option2 = 'Weaken, Discourage',
    option3 = 'Plain, Simplify',
    option4 = 'Strengthen, Enable'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "empower"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Strengthen, Enable';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "empower"?', 'synonym', 'Strengthen, Enable', 'Decorate, Adorn', 'Weaken, Discourage', 'Plain, Simplify', 'Strengthen, Enable', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "empower"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Strengthen, Enable'
) < 1;

UPDATE questions
SET option1 = 'Exclude, Avoid',
    option2 = 'Quit, Give up',
    option3 = 'Involve, Include',
    option4 = 'Confuse, Mislead'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "entail"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Involve, Include';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "entail"?', 'synonym', 'Involve, Include', 'Exclude, Avoid', 'Quit, Give up', 'Involve, Include', 'Confuse, Mislead', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "entail"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Involve, Include'
) < 1;

UPDATE questions
SET option1 = 'Exclude, Avoid',
    option2 = 'Recklessly, Carelessly',
    option3 = 'Cautiously, Carefully',
    option4 = 'Full, Occupied'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "warily"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Cautiously, Carefully';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "warily"?', 'synonym', 'Cautiously, Carefully', 'Exclude, Avoid', 'Recklessly, Carelessly', 'Cautiously, Carefully', 'Full, Occupied', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "warily"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Cautiously, Carefully'
) < 1;

UPDATE questions
SET option1 = 'Optional, Free',
    option2 = 'Rural, Countryside',
    option3 = 'Forced, Required',
    option4 = 'Full, Occupied'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "voluntary"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Optional, Free';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "voluntary"?', 'synonym', 'Optional, Free', 'Optional, Free', 'Rural, Countryside', 'Forced, Required', 'Full, Occupied', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "voluntary"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Optional, Free'
) < 1;

UPDATE questions
SET option1 = 'Empty, Unoccupied',
    option2 = 'Full, Occupied',
    option3 = 'Humble, Modest',
    option4 = 'Proud, Conceited'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "vain"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Proud, Conceited';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "vain"?', 'synonym', 'Proud, Conceited', 'Empty, Unoccupied', 'Full, Occupied', 'Humble, Modest', 'Proud, Conceited', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "vain"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Proud, Conceited'
) < 1;

UPDATE questions
SET option1 = 'Full, Occupied',
    option2 = 'Empty, Unoccupied',
    option3 = 'Proud, Conceited',
    option4 = 'Humble, Modest'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "vacant"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Empty, Unoccupied';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "vacant"?', 'synonym', 'Empty, Unoccupied', 'Full, Occupied', 'Empty, Unoccupied', 'Proud, Conceited', 'Humble, Modest', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "vacant"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Empty, Unoccupied'
) < 1;

UPDATE questions
SET option1 = 'Go, Act',
    option2 = 'Forced, Required',
    option3 = 'Rural, Countryside',
    option4 = 'City, Metropolitan'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "urban"?'
  AND question_type = 'synonym'
  AND correct_answer = 'City, Metropolitan';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "urban"?', 'synonym', 'City, Metropolitan', 'Go, Act', 'Forced, Required', 'Rural, Countryside', 'City, Metropolitan', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "urban"?'
      AND question_type = 'synonym'
      AND correct_answer = 'City, Metropolitan'
) < 1;

UPDATE questions
SET option1 = 'Uncover, Expose',
    option2 = 'Confuse, Mislead',
    option3 = 'Wrap, Cover',
    option4 = 'Over, Extra'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "envelop"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Wrap, Cover';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "envelop"?', 'synonym', 'Wrap, Cover', 'Uncover, Expose', 'Confuse, Mislead', 'Wrap, Cover', 'Over, Extra', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "envelop"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Wrap, Cover'
) < 1;

UPDATE questions
SET option1 = 'Calm, Reassure',
    option2 = 'Lost, Neglected',
    option3 = 'Scare, Alarm',
    option4 = 'Remembered, Known'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "forgotten"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Lost, Neglected';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "forgotten"?', 'synonym', 'Lost, Neglected', 'Calm, Reassure', 'Lost, Neglected', 'Scare, Alarm', 'Remembered, Known', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "forgotten"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Lost, Neglected'
) < 1;

UPDATE questions
SET option1 = 'Little, Moderate',
    option2 = 'Full, Occupied',
    option3 = 'Go, Act',
    option4 = 'Pause, Waver'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "hesitate"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Pause, Waver';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "hesitate"?', 'synonym', 'Pause, Waver', 'Little, Moderate', 'Full, Occupied', 'Go, Act', 'Pause, Waver', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "hesitate"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Pause, Waver'
) < 1;

UPDATE questions
SET option1 = 'Ignore, Neglect',
    option2 = 'Understanding, Awareness',
    option3 = 'Confusion, Ignorance',
    option4 = 'Ignorance, Confusion'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "insight"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Understanding, Awareness';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "insight"?', 'synonym', 'Understanding, Awareness', 'Ignore, Neglect', 'Understanding, Awareness', 'Confusion, Ignorance', 'Ignorance, Confusion', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "insight"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Understanding, Awareness'
) < 1;

UPDATE questions
SET option1 = 'Ordinary, Boring',
    option2 = 'Teacher, Guide',
    option3 = 'Exciting, Fun',
    option4 = 'Student, Pupil'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "mentor"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Teacher, Guide';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "mentor"?', 'synonym', 'Teacher, Guide', 'Ordinary, Boring', 'Teacher, Guide', 'Exciting, Fun', 'Student, Pupil', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "mentor"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Teacher, Guide'
) < 1;

UPDATE questions
SET option1 = 'Little, Moderate',
    option2 = 'Uncover, Expose',
    option3 = 'Over, Extra',
    option4 = 'Wrap, Cover'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "excessive"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Over, Extra';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "excessive"?', 'synonym', 'Over, Extra', 'Little, Moderate', 'Uncover, Expose', 'Over, Extra', 'Wrap, Cover', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "excessive"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Over, Extra'
) < 1;

UPDATE questions
SET option1 = 'Calm, Relaxed',
    option2 = 'Scare, Alarm',
    option3 = 'Remembered, Known',
    option4 = 'Calm, Reassure'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "frighten"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Scare, Alarm';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "frighten"?', 'synonym', 'Scare, Alarm', 'Calm, Relaxed', 'Scare, Alarm', 'Remembered, Known', 'Calm, Reassure', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "frighten"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Scare, Alarm'
) < 1;

UPDATE questions
SET option1 = 'Hero, Star',
    option2 = 'Villain, Nobody',
    option3 = 'Solitude, Separation',
    option4 = 'Company, Togetherness'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "idol"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Hero, Star';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "idol"?', 'synonym', 'Hero, Star', 'Hero, Star', 'Villain, Nobody', 'Solitude, Separation', 'Company, Togetherness', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "idol"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Hero, Star'
) < 1;

UPDATE questions
SET option1 = 'Awful, Ordinary',
    option2 = 'Exciting, Fun',
    option3 = 'Ordinary, Boring',
    option4 = 'Generous, Kind'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "mundane"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Ordinary, Boring';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "mundane"?', 'synonym', 'Ordinary, Boring', 'Awful, Ordinary', 'Exciting, Fun', 'Ordinary, Boring', 'Generous, Kind', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "mundane"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Ordinary, Boring'
) < 1;

UPDATE questions
SET option1 = 'Student, Pupil',
    option2 = 'Solitude, Separation',
    option3 = 'Company, Togetherness',
    option4 = 'Villain, Nobody'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "isolation"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Solitude, Separation';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "isolation"?', 'synonym', 'Solitude, Separation', 'Student, Pupil', 'Solitude, Separation', 'Company, Togetherness', 'Villain, Nobody', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "isolation"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Solitude, Separation'
) < 1;

UPDATE questions
SET option1 = 'Die, Fail',
    option2 = 'Strong, Sturdy',
    option3 = 'Gentle, Weak',
    option4 = 'Weak, Fragile'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "robust"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Strong, Sturdy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "robust"?', 'synonym', 'Strong, Sturdy', 'Die, Fail', 'Strong, Sturdy', 'Gentle, Weak', 'Weak, Fragile', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "robust"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Strong, Sturdy'
) < 1;

UPDATE questions
SET option1 = 'Clever, Smart',
    option2 = 'Starve, Deprive',
    option3 = 'Foolish, Naive',
    option4 = 'March, Walk'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "shrewd"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Clever, Smart';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "shrewd"?', 'synonym', 'Clever, Smart', 'Clever, Smart', 'Starve, Deprive', 'Foolish, Naive', 'March, Walk', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "shrewd"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Clever, Smart'
) < 1;

UPDATE questions
SET option1 = 'Weak, Fragile',
    option2 = 'Greedy, Selfish',
    option3 = 'Strong, Solid',
    option4 = 'Generous, Kind'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "stingy"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Greedy, Selfish';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "stingy"?', 'synonym', 'Greedy, Selfish', 'Weak, Fragile', 'Greedy, Selfish', 'Strong, Solid', 'Generous, Kind', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "stingy"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Greedy, Selfish'
) < 1;

UPDATE questions
SET option1 = 'Die, Fail',
    option2 = 'Live, Endure',
    option3 = 'Trusting, Sure',
    option4 = 'Weak, Fragile'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "survive"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Live, Endure';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "survive"?', 'synonym', 'Live, Endure', 'Die, Fail', 'Live, Endure', 'Trusting, Sure', 'Weak, Fragile', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "survive"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Live, Endure'
) < 1;

UPDATE questions
SET option1 = 'Control, Captivity',
    option2 = 'Impossible, Unlikely',
    option3 = 'Irresponsible, Unlikely',
    option4 = 'Responsible, Accountable'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "liable"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Responsible, Accountable';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "liable"?', 'synonym', 'Responsible, Accountable', 'Control, Captivity', 'Impossible, Unlikely', 'Irresponsible, Unlikely', 'Responsible, Accountable', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "liable"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Responsible, Accountable'
) < 1;

UPDATE questions
SET option1 = 'Generous, Kind',
    option2 = 'Die, Fail',
    option3 = 'Starve, Deprive',
    option4 = 'Satisfy, Fill'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "sate"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Satisfy, Fill';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "sate"?', 'synonym', 'Satisfy, Fill', 'Generous, Kind', 'Die, Fail', 'Starve, Deprive', 'Satisfy, Fill', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "sate"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Satisfy, Fill'
) < 1;

UPDATE questions
SET option1 = 'Weak, Fragile',
    option2 = 'March, Walk',
    option3 = 'Sneak, Lurk',
    option4 = 'Trusting, Sure'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "skulk"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Sneak, Lurk';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "skulk"?', 'synonym', 'Sneak, Lurk', 'Weak, Fragile', 'March, Walk', 'Sneak, Lurk', 'Trusting, Sure', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "skulk"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Sneak, Lurk'
) < 1;

UPDATE questions
SET option1 = 'Weak, Fragile',
    option2 = 'Strong, Solid',
    option3 = 'Generous, Kind',
    option4 = 'Greedy, Selfish'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "sturdy"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Strong, Solid';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "sturdy"?', 'synonym', 'Strong, Solid', 'Weak, Fragile', 'Strong, Solid', 'Generous, Kind', 'Greedy, Selfish', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "sturdy"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Strong, Solid'
) < 1;

UPDATE questions
SET option1 = 'Wary, Doubtful',
    option2 = 'Die, Fail',
    option3 = 'Trusting, Sure',
    option4 = 'Live, Endure'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "suspicious"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Wary, Doubtful';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "suspicious"?', 'synonym', 'Wary, Doubtful', 'Wary, Doubtful', 'Die, Fail', 'Trusting, Sure', 'Live, Endure', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "suspicious"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Wary, Doubtful'
) < 1;

UPDATE questions
SET option1 = 'Starve, Deprive',
    option2 = 'Outfit, Same',
    option3 = 'Similar, Same',
    option4 = 'Different, Odd'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "uniform"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Outfit, Same';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "uniform"?', 'synonym', 'Outfit, Same', 'Starve, Deprive', 'Outfit, Same', 'Similar, Same', 'Different, Odd', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "uniform"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Outfit, Same'
) < 1;

UPDATE questions
SET option1 = 'Uninterested, Bored',
    option2 = 'Interrupt, Invade',
    option3 = 'Meddle, Interrupt',
    option4 = 'Help, Allow'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "interfere"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Meddle, Interrupt';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "interfere"?', 'synonym', 'Meddle, Interrupt', 'Uninterested, Bored', 'Interrupt, Invade', 'Meddle, Interrupt', 'Help, Allow', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "interfere"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Meddle, Interrupt'
) < 1;

UPDATE questions
SET option1 = 'Help, Allow',
    option2 = 'Shelter, Keep',
    option3 = 'Expose, Release',
    option4 = 'Lose, Give'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "harboured"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Shelter, Keep';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "harboured"?', 'synonym', 'Shelter, Keep', 'Help, Allow', 'Shelter, Keep', 'Expose, Release', 'Lose, Give', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "harboured"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Shelter, Keep'
) < 1;

UPDATE questions
SET option1 = 'Gentle, Weak',
    option2 = 'Weak, Fragile',
    option3 = 'Strong, Solid',
    option4 = 'Strong, Intense'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "fierce"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Strong, Intense';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "fierce"?', 'synonym', 'Strong, Intense', 'Gentle, Weak', 'Weak, Fragile', 'Strong, Solid', 'Strong, Intense', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "fierce"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Strong, Intense'
) < 1;

UPDATE questions
SET option1 = 'Get, Obtain',
    option2 = 'Lose, Give',
    option3 = 'Impossible, Unlikely',
    option4 = 'Quit, Give up'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "acquire"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Get, Obtain';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "acquire"?', 'synonym', 'Get, Obtain', 'Get, Obtain', 'Lose, Give', 'Impossible, Unlikely', 'Quit, Give up', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "acquire"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Get, Obtain'
) < 1;

UPDATE questions
SET option1 = 'Communicate, Express',
    option2 = 'Hide, Conceal',
    option3 = 'Share, Reveal',
    option4 = 'Deny, Hide'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "confide"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Share, Reveal';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "confide"?', 'synonym', 'Share, Reveal', 'Communicate, Express', 'Hide, Conceal', 'Share, Reveal', 'Deny, Hide', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "confide"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Share, Reveal'
) < 1;

UPDATE questions
SET option1 = 'Awkward, Silly',
    option2 = 'Graceful, Smooth',
    option3 = 'Refill, Restore',
    option4 = 'Honest, Truthful'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "clumsy"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Awkward, Silly';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "clumsy"?', 'synonym', 'Awkward, Silly', 'Awkward, Silly', 'Graceful, Smooth', 'Refill, Restore', 'Honest, Truthful', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "clumsy"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Awkward, Silly'
) < 1;

UPDATE questions
SET option1 = 'Share, Reveal',
    option2 = 'Hide, Conceal',
    option3 = 'Deny, Hide',
    option4 = 'Communicate, Express'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "convey"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Communicate, Express';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "convey"?', 'synonym', 'Communicate, Express', 'Share, Reveal', 'Hide, Conceal', 'Deny, Hide', 'Communicate, Express', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "convey"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Communicate, Express'
) < 1;

UPDATE questions
SET option1 = 'Honest, Truthful',
    option2 = 'Refill, Restore',
    option3 = 'Dishonest, Tricksy',
    option4 = 'Empty, Drain'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "deplete"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Empty, Drain';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "deplete"?', 'synonym', 'Empty, Drain', 'Honest, Truthful', 'Refill, Restore', 'Dishonest, Tricksy', 'Empty, Drain', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "deplete"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Empty, Drain'
) < 1;

UPDATE questions
SET option1 = 'Various, Mixed',
    option2 = 'Similar, Same',
    option3 = 'Sleepy, Tired',
    option4 = 'Awake, Energetic'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "drowsy"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Sleepy, Tired';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "drowsy"?', 'synonym', 'Sleepy, Tired', 'Various, Mixed', 'Similar, Same', 'Sleepy, Tired', 'Awake, Energetic', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "drowsy"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Sleepy, Tired'
) < 1;

UPDATE questions
SET option1 = 'Empty, Drain',
    option2 = 'Approximate, Calculated',
    option3 = 'Exact, Certain',
    option4 = 'Annoy, Anger'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "estimated"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Approximate, Calculated';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "estimated"?', 'synonym', 'Approximate, Calculated', 'Empty, Drain', 'Approximate, Calculated', 'Exact, Certain', 'Annoy, Anger', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "estimated"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Approximate, Calculated'
) < 1;

UPDATE questions
SET option1 = 'Dishonest, Tricksy',
    option2 = 'Refill, Restore',
    option3 = 'Empty, Drain',
    option4 = 'Honest, Truthful'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "deceitful"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Dishonest, Tricksy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "deceitful"?', 'synonym', 'Dishonest, Tricksy', 'Dishonest, Tricksy', 'Refill, Restore', 'Empty, Drain', 'Honest, Truthful', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "deceitful"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Dishonest, Tricksy'
) < 1;

UPDATE questions
SET option1 = 'Various, Mixed',
    option2 = 'Sleepy, Tired',
    option3 = 'Awake, Energetic',
    option4 = 'Similar, Same'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "diverse"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Various, Mixed';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "diverse"?', 'synonym', 'Various, Mixed', 'Various, Mixed', 'Sleepy, Tired', 'Awake, Energetic', 'Similar, Same', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "diverse"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Various, Mixed'
) < 1;

UPDATE questions
SET option1 = 'Lose, Give',
    option2 = 'Persist, Survive',
    option3 = 'Last, Survive',
    option4 = 'Quit, Give up'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "endure"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Persist, Survive';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "endure"?', 'synonym', 'Persist, Survive', 'Lose, Give', 'Persist, Survive', 'Last, Survive', 'Quit, Give up', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "endure"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Persist, Survive'
) < 2;

UPDATE questions
SET option1 = 'Plain, Ordinary',
    option2 = 'Amazing, Fantastic',
    option3 = 'Awful, Ordinary',
    option4 = 'Real, Actual'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "marvellous"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Amazing, Fantastic';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "marvellous"?', 'synonym', 'Amazing, Fantastic', 'Plain, Ordinary', 'Amazing, Fantastic', 'Awful, Ordinary', 'Real, Actual', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "marvellous"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Amazing, Fantastic'
) < 1;

UPDATE questions
SET option1 = 'Calm, Relaxed',
    option2 = 'Impossible, Unlikely',
    option3 = 'Pacify, Satisfy',
    option4 = 'Annoy, Anger'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "appease"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Pacify, Satisfy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "appease"?', 'synonym', 'Pacify, Satisfy', 'Calm, Relaxed', 'Impossible, Unlikely', 'Pacify, Satisfy', 'Annoy, Anger', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "appease"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Pacify, Satisfy'
) < 1;

UPDATE questions
SET option1 = 'Smelly, Stinky',
    option2 = 'Whole, Complete',
    option3 = 'Sweet-smelling, Aromatic',
    option4 = 'Similar, Same'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "fragrant"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Sweet-smelling, Aromatic';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "fragrant"?', 'synonym', 'Sweet-smelling, Aromatic', 'Smelly, Stinky', 'Whole, Complete', 'Sweet-smelling, Aromatic', 'Similar, Same', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "fragrant"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Sweet-smelling, Aromatic'
) < 1;

UPDATE questions
SET option1 = 'Make-believe, Pretend',
    option2 = 'Similar, Same',
    option3 = 'Real, Actual',
    option4 = 'Boredom, Calm'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "imaginary"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Make-believe, Pretend';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "imaginary"?', 'synonym', 'Make-believe, Pretend', 'Make-believe, Pretend', 'Similar, Same', 'Real, Actual', 'Boredom, Calm', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "imaginary"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Make-believe, Pretend'
) < 1;

UPDATE questions
SET option1 = 'Calm, Relaxed',
    option2 = 'Worried, Nervous',
    option3 = 'Boredom, Calm',
    option4 = 'Nervous, Excited'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "anxious"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Worried, Nervous';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "anxious"?', 'synonym', 'Worried, Nervous', 'Calm, Relaxed', 'Worried, Nervous', 'Boredom, Calm', 'Nervous, Excited', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "anxious"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Worried, Nervous'
) < 1;

UPDATE questions
SET option1 = 'Impossible, Unlikely',
    option2 = 'Get, Obtain',
    option3 = 'Possible, Attainable',
    option4 = 'Lose, Give'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "achievable"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Possible, Attainable';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "achievable"?', 'synonym', 'Possible, Attainable', 'Impossible, Unlikely', 'Get, Obtain', 'Possible, Attainable', 'Lose, Give', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "achievable"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Possible, Attainable'
) < 1;

UPDATE questions
SET option1 = 'Real, Actual',
    option2 = 'Pamphlet, Leaflet',
    option3 = 'Bore, Repel',
    option4 = 'Poster, Billboard'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "brochure"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Pamphlet, Leaflet';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "brochure"?', 'synonym', 'Pamphlet, Leaflet', 'Real, Actual', 'Pamphlet, Leaflet', 'Bore, Repel', 'Poster, Billboard', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "brochure"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Pamphlet, Leaflet'
) < 1;

UPDATE questions
SET option1 = 'Defeat, Loss',
    option2 = 'Growing, Thriving',
    option3 = 'Victory, Win',
    option4 = 'Boredom, Calm'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "triumph"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Victory, Win';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "triumph"?', 'synonym', 'Victory, Win', 'Defeat, Loss', 'Growing, Thriving', 'Victory, Win', 'Boredom, Calm', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "triumph"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Victory, Win'
) < 1;

UPDATE questions
SET option1 = 'Calm, Relaxed',
    option2 = 'Careless, Rushed',
    option3 = 'Boredom, Calm',
    option4 = 'Excitement, Rush'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "thrill"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Excitement, Rush';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "thrill"?', 'synonym', 'Excitement, Rush', 'Calm, Relaxed', 'Careless, Rushed', 'Boredom, Calm', 'Excitement, Rush', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "thrill"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Excitement, Rush'
) < 1;

UPDATE questions
SET option1 = 'Whole, Intact',
    option2 = 'Growing, Thriving',
    option3 = 'Ready, Agreeable',
    option4 = 'Debris, Rubble'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "wreckage"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Debris, Rubble';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "wreckage"?', 'synonym', 'Debris, Rubble', 'Whole, Intact', 'Growing, Thriving', 'Ready, Agreeable', 'Debris, Rubble', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "wreckage"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Debris, Rubble'
) < 1;

UPDATE questions
SET option1 = 'Fading, Shrivelling',
    option2 = 'Growing, Thriving',
    option3 = 'Unwilling, Refusing',
    option4 = 'Ready, Agreeable'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "withering"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Fading, Shrivelling';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "withering"?', 'synonym', 'Fading, Shrivelling', 'Fading, Shrivelling', 'Growing, Thriving', 'Unwilling, Refusing', 'Ready, Agreeable', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "withering"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Fading, Shrivelling'
) < 1;

UPDATE questions
SET option1 = 'Unwilling, Refusing',
    option2 = 'Fading, Shrivelling',
    option3 = 'Ready, Agreeable',
    option4 = 'Growing, Thriving'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "willing"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Ready, Agreeable';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "willing"?', 'synonym', 'Ready, Agreeable', 'Unwilling, Refusing', 'Fading, Shrivelling', 'Ready, Agreeable', 'Growing, Thriving', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "willing"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Ready, Agreeable'
) < 1;

UPDATE questions
SET option1 = 'Vague, General',
    option2 = 'Nervous, Excited',
    option3 = 'Judgmental, Critical',
    option4 = 'Specific, Precise'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "nonspecific"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Vague, General';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "nonspecific"?', 'synonym', 'Vague, General', 'Vague, General', 'Nervous, Excited', 'Judgmental, Critical', 'Specific, Precise', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "nonspecific"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Vague, General'
) < 1;

UPDATE questions
SET option1 = 'Casual, Cool',
    option2 = 'Soldier, Fighter',
    option3 = 'Civilian, Bystander',
    option4 = 'Nervous, Excited'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "nonchalant"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Casual, Cool';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "nonchalant"?', 'synonym', 'Casual, Cool', 'Casual, Cool', 'Soldier, Fighter', 'Civilian, Bystander', 'Nervous, Excited', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "nonchalant"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Casual, Cool'
) < 1;

UPDATE questions
SET option1 = 'Rubbish, Foolishness',
    option2 = 'Judgmental, Critical',
    option3 = 'Specific, Precise',
    option4 = 'Sense, Logic'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "nonsense"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Rubbish, Foolishness';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "nonsense"?', 'synonym', 'Rubbish, Foolishness', 'Rubbish, Foolishness', 'Judgmental, Critical', 'Specific, Precise', 'Sense, Logic', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "nonsense"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Rubbish, Foolishness'
) < 1;

UPDATE questions
SET option1 = 'Nervous, Excited',
    option2 = 'Casual, Cool',
    option3 = 'Civilian, Bystander',
    option4 = 'Soldier, Fighter'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "noncombatant"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Civilian, Bystander';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "noncombatant"?', 'synonym', 'Civilian, Bystander', 'Nervous, Excited', 'Casual, Cool', 'Civilian, Bystander', 'Soldier, Fighter', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "noncombatant"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Civilian, Bystander'
) < 1;

UPDATE questions
SET option1 = 'Sense, Logic',
    option2 = 'Specific, Precise',
    option3 = 'Judgmental, Critical',
    option4 = 'Accepting, Open-minded'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "nonjudgemental"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Accepting, Open-minded';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "nonjudgemental"?', 'synonym', 'Accepting, Open-minded', 'Sense, Logic', 'Specific, Precise', 'Judgmental, Critical', 'Accepting, Open-minded', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "nonjudgemental"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Accepting, Open-minded'
) < 1;

UPDATE questions
SET option1 = 'Bore, Repel',
    option2 = 'Praise, Respect',
    option3 = 'Diminish, Mock',
    option4 = 'Resent, Envy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "belittle"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Diminish, Mock';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "belittle"?', 'synonym', 'Diminish, Mock', 'Bore, Repel', 'Praise, Respect', 'Diminish, Mock', 'Resent, Envy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "belittle"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Diminish, Mock'
) < 1;

UPDATE questions
SET option1 = 'Give, Allow',
    option2 = 'Praise, Respect',
    option3 = 'Bore, Repel',
    option4 = 'Charm, Trick'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "beguile"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Charm, Trick';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "beguile"?', 'synonym', 'Charm, Trick', 'Give, Allow', 'Praise, Respect', 'Bore, Repel', 'Charm, Trick', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "beguile"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Charm, Trick'
) < 1;

UPDATE questions
SET option1 = 'Give, Allow',
    option2 = 'Praise, Respect',
    option3 = 'Refuse, Deny',
    option4 = 'Resent, Envy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "begrudge"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Resent, Envy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "begrudge"?', 'synonym', 'Resent, Envy', 'Give, Allow', 'Praise, Respect', 'Refuse, Deny', 'Resent, Envy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "begrudge"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Resent, Envy'
) < 1;

UPDATE questions
SET option1 = 'Resent, Envy',
    option2 = 'Praise, Respect',
    option3 = 'Beg, Plead',
    option4 = 'Refuse, Deny'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "beseech"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Beg, Plead';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "beseech"?', 'synonym', 'Beg, Plead', 'Resent, Envy', 'Praise, Respect', 'Beg, Plead', 'Refuse, Deny', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "beseech"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Beg, Plead'
) < 1;

UPDATE questions
SET option1 = 'Clear, Certain',
    option2 = 'Bore, Repel',
    option3 = 'Refuse, Deny',
    option4 = 'Confused, Puzzled'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "bewildered"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Confused, Puzzled';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "bewildered"?', 'synonym', 'Confused, Puzzled', 'Clear, Certain', 'Bore, Repel', 'Refuse, Deny', 'Confused, Puzzled', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "bewildered"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Confused, Puzzled'
) < 1;

UPDATE questions
SET option1 = 'Relax, Rest',
    option2 = 'Examine, Study',
    option3 = 'Simplify, Shorten',
    option4 = 'Complicate, Expand'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "oversimplify"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Simplify, Shorten';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "oversimplify"?', 'synonym', 'Simplify, Shorten', 'Relax, Rest', 'Examine, Study', 'Simplify, Shorten', 'Complicate, Expand', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "oversimplify"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Simplify, Shorten'
) < 1;

UPDATE questions
SET option1 = 'Ignore, Forget',
    option2 = 'Gentle, Mild',
    option3 = 'Relax, Rest',
    option4 = 'Domineering, Bossy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "overbearing"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Domineering, Bossy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "overbearing"?', 'synonym', 'Domineering, Bossy', 'Ignore, Forget', 'Gentle, Mild', 'Relax, Rest', 'Domineering, Bossy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "overbearing"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Domineering, Bossy'
) < 1;

UPDATE questions
SET option1 = 'Ignore, Forget',
    option2 = 'Relax, Rest',
    option3 = 'Gentle, Mild',
    option4 = 'Exhaust, Stretch'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "overextend"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Exhaust, Stretch';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "overextend"?', 'synonym', 'Exhaust, Stretch', 'Ignore, Forget', 'Relax, Rest', 'Gentle, Mild', 'Exhaust, Stretch', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "overextend"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Exhaust, Stretch'
) < 1;

UPDATE questions
SET option1 = 'Calm, Manage',
    option2 = 'Relax, Rest',
    option3 = 'Flood, Stun',
    option4 = 'Examine, Study'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "overwhelm"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Flood, Stun';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "overwhelm"?', 'synonym', 'Flood, Stun', 'Calm, Manage', 'Relax, Rest', 'Flood, Stun', 'Examine, Study', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "overwhelm"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Flood, Stun'
) < 1;

UPDATE questions
SET option1 = 'Complicate, Expand',
    option2 = 'Ignore, Forget',
    option3 = 'Examine, Study',
    option4 = 'Relax, Rest'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "overanalyse"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Examine, Study';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "overanalyse"?', 'synonym', 'Examine, Study', 'Complicate, Expand', 'Ignore, Forget', 'Examine, Study', 'Relax, Rest', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "overanalyse"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Examine, Study'
) < 1;

UPDATE questions
SET option1 = 'Estimate, Correct',
    option2 = 'Misunderstand, Mistake',
    option3 = 'Correct name, Accurate',
    option4 = 'Understand, Correct'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "misinterpret"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Misunderstand, Mistake';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "misinterpret"?', 'synonym', 'Misunderstand, Mistake', 'Estimate, Correct', 'Misunderstand, Mistake', 'Correct name, Accurate', 'Understand, Correct', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "misinterpret"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Misunderstand, Mistake'
) < 1;

UPDATE questions
SET option1 = 'Misestimate, Mistake',
    option2 = 'Understand, Correct',
    option3 = 'Correct name, Accurate',
    option4 = 'Estimate, Correct'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "miscalculate"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Misestimate, Mistake';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "miscalculate"?', 'synonym', 'Misestimate, Mistake', 'Misestimate, Mistake', 'Understand, Correct', 'Correct name, Accurate', 'Estimate, Correct', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "miscalculate"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Misestimate, Mistake'
) < 1;

UPDATE questions
SET option1 = 'Good behaviour, Obedience',
    option2 = 'Wrongdoing, Misbehaviour',
    option3 = 'Estimate, Correct',
    option4 = 'Wrong name, Mistake'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "misconduct"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Wrongdoing, Misbehaviour';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "misconduct"?', 'synonym', 'Wrongdoing, Misbehaviour', 'Good behaviour, Obedience', 'Wrongdoing, Misbehaviour', 'Estimate, Correct', 'Wrong name, Mistake', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "misconduct"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Wrongdoing, Misbehaviour'
) < 1;

UPDATE questions
SET option1 = 'Understand, Correct',
    option2 = 'Tell truth, Clarify',
    option3 = 'Falsify, Twist',
    option4 = 'Misunderstand, Mistake'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "misrepresent"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Falsify, Twist';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "misrepresent"?', 'synonym', 'Falsify, Twist', 'Understand, Correct', 'Tell truth, Clarify', 'Falsify, Twist', 'Misunderstand, Mistake', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "misrepresent"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Falsify, Twist'
) < 1;

UPDATE questions
SET option1 = 'Understand, Correct',
    option2 = 'Correct name, Accurate',
    option3 = 'Wrong name, Mistake',
    option4 = 'Estimate, Correct'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "misnomer"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Wrong name, Mistake';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "misnomer"?', 'synonym', 'Wrong name, Mistake', 'Understand, Correct', 'Correct name, Accurate', 'Wrong name, Mistake', 'Estimate, Correct', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "misnomer"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Wrong name, Mistake'
) < 1;

UPDATE questions
SET option1 = 'Poor, Inferior',
    option2 = 'Float, Rise',
    option3 = 'Excellent, Superior',
    option4 = 'Rebellious, Independent'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "substandard"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Poor, Inferior';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "substandard"?', 'synonym', 'Poor, Inferior', 'Poor, Inferior', 'Float, Rise', 'Excellent, Superior', 'Rebellious, Independent', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "substandard"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Poor, Inferior'
) < 1;

UPDATE questions
SET option1 = 'Correct name, Accurate',
    option2 = 'Boss, Leader',
    option3 = 'Agitate, Release',
    option4 = 'Tame, Restrain'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "subdue"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Tame, Restrain';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "subdue"?', 'synonym', 'Tame, Restrain', 'Correct name, Accurate', 'Boss, Leader', 'Agitate, Release', 'Tame, Restrain', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "subdue"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Tame, Restrain'
) < 1;

UPDATE questions
SET option1 = 'Obedient, Compliant',
    option2 = 'Float, Rise',
    option3 = 'Rebellious, Independent',
    option4 = 'Sink, Drown'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "submerge"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Sink, Drown';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "submerge"?', 'synonym', 'Sink, Drown', 'Obedient, Compliant', 'Float, Rise', 'Rebellious, Independent', 'Sink, Drown', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "submerge"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Sink, Drown'
) < 1;

UPDATE questions
SET option1 = 'Rebellious, Independent',
    option2 = 'Junior, Assistant',
    option3 = 'Boss, Leader',
    option4 = 'Excellent, Superior'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "subordinate"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Junior, Assistant';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "subordinate"?', 'synonym', 'Junior, Assistant', 'Rebellious, Independent', 'Junior, Assistant', 'Boss, Leader', 'Excellent, Superior', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "subordinate"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Junior, Assistant'
) < 1;

DROP TABLE seed_quiz_id;

-- Year 5 Vocabulary Synonym Paper 2
INSERT INTO quizzes (title, description, created_by, stage_id, lock_after_attempt)
SELECT 'Year 5 Vocabulary Synonym Paper 2',
       'A 100-question Year 5 vocabulary exam asking students to identify synonym pairs.',
       1,
       (SELECT id FROM stages WHERE name = 'Year 5'),
       1
WHERE NOT EXISTS (SELECT 1 FROM quizzes WHERE title = 'Year 5 Vocabulary Synonym Paper 2');

DROP TABLE IF EXISTS seed_quiz_id;
CREATE TEMP TABLE seed_quiz_id(id INTEGER);
INSERT INTO seed_quiz_id SELECT id FROM quizzes WHERE title = 'Year 5 Vocabulary Synonym Paper 2' LIMIT 1;

UPDATE questions
SET option1 = 'Excellent, Superior',
    option2 = 'Float, Rise',
    option3 = 'Rebellious, Independent',
    option4 = 'Obedient, Compliant'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "subservient"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Obedient, Compliant';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "subservient"?', 'synonym', 'Obedient, Compliant', 'Excellent, Superior', 'Float, Rise', 'Rebellious, Independent', 'Obedient, Compliant', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "subservient"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Obedient, Compliant'
) < 1;

UPDATE questions
SET option1 = 'Tiny, Small',
    option2 = 'Tiny, Narrow',
    option3 = 'Small, Tiny',
    option4 = 'Huge, Giant'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "enormous"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Huge, Giant';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "enormous"?', 'synonym', 'Huge, Giant', 'Tiny, Small', 'Tiny, Narrow', 'Small, Tiny', 'Huge, Giant', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "enormous"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Huge, Giant'
) < 1;

UPDATE questions
SET option1 = 'Huge, Gigantic',
    option2 = 'Tiny, Small',
    option3 = 'Tiny, Petite',
    option4 = 'Massive, Colossal'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "gargantuan"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Massive, Colossal';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "gargantuan"?', 'synonym', 'Massive, Colossal', 'Huge, Gigantic', 'Tiny, Small', 'Tiny, Petite', 'Massive, Colossal', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "gargantuan"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Massive, Colossal'
) < 1;

UPDATE questions
SET option1 = 'Tiny, Small',
    option2 = 'Small, Tiny',
    option3 = 'Vast, Huge',
    option4 = 'Large, Huge'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "immense"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Vast, Huge';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "immense"?', 'synonym', 'Vast, Huge', 'Tiny, Small', 'Small, Tiny', 'Vast, Huge', 'Large, Huge', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "immense"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Vast, Huge'
) < 1;

UPDATE questions
SET option1 = 'Huge, Big',
    option2 = 'Large, Huge',
    option3 = 'Tiny, Narrow',
    option4 = 'Huge, Expansive'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "vast"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Huge, Expansive';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "vast"?', 'synonym', 'Huge, Expansive', 'Huge, Big', 'Large, Huge', 'Tiny, Narrow', 'Huge, Expansive', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "vast"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Huge, Expansive'
) < 1;

UPDATE questions
SET option1 = 'Giant, Massive',
    option2 = 'Tiny, Narrow',
    option3 = 'Small, Tiny',
    option4 = 'Tiny, Small'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "colossal"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Giant, Massive';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "colossal"?', 'synonym', 'Giant, Massive', 'Giant, Massive', 'Tiny, Narrow', 'Small, Tiny', 'Tiny, Small', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "colossal"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Giant, Massive'
) < 1;

UPDATE questions
SET option1 = 'Miniature, Small',
    option2 = 'Huge, Gigantic',
    option3 = 'Giant, Large',
    option4 = 'Tiny, Small'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "tiny"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Miniature, Small';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "tiny"?', 'synonym', 'Miniature, Small', 'Miniature, Small', 'Huge, Gigantic', 'Giant, Large', 'Tiny, Small', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "tiny"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Miniature, Small'
) < 1;

UPDATE questions
SET option1 = 'Large, Huge',
    option2 = 'Small, Petite',
    option3 = 'Tiny, Small',
    option4 = 'Small, Tiny'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "diminutive"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Small, Petite';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "diminutive"?', 'synonym', 'Small, Petite', 'Large, Huge', 'Small, Petite', 'Tiny, Small', 'Small, Tiny', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "diminutive"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Small, Petite'
) < 1;

UPDATE questions
SET option1 = 'Tiny, Mini',
    option2 = 'Giant, Large',
    option3 = 'Huge, Big',
    option4 = 'Tiny, Small'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "minute"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Tiny, Mini';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "minute"?', 'synonym', 'Tiny, Mini', 'Tiny, Mini', 'Giant, Large', 'Huge, Big', 'Tiny, Small', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "minute"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Tiny, Mini'
) < 1;

UPDATE questions
SET option1 = 'Huge, Big',
    option2 = 'Tiny, Mini',
    option3 = 'Tiny, Small',
    option4 = 'Giant, Large'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "miniature"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Tiny, Small';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "miniature"?', 'synonym', 'Tiny, Small', 'Huge, Big', 'Tiny, Mini', 'Tiny, Small', 'Giant, Large', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "miniature"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Tiny, Small'
) < 1;

UPDATE questions
SET option1 = 'Afraid, Weak',
    option2 = 'Tiny, Small',
    option3 = 'Strong, Mighty',
    option4 = 'Small, Weak'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "puny"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Small, Weak';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "puny"?', 'synonym', 'Small, Weak', 'Afraid, Weak', 'Tiny, Small', 'Strong, Mighty', 'Small, Weak', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "puny"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Small, Weak'
) < 1;

UPDATE questions
SET option1 = 'Afraid, Timid',
    option2 = 'Afraid, Weak',
    option3 = 'Brave, Fearless',
    option4 = 'Cowardly, Afraid'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "courageous"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Brave, Fearless';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "courageous"?', 'synonym', 'Brave, Fearless', 'Afraid, Timid', 'Afraid, Weak', 'Brave, Fearless', 'Cowardly, Afraid', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "courageous"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Brave, Fearless'
) < 1;

UPDATE questions
SET option1 = 'Brave, Heroic',
    option2 = 'Afraid, Weak',
    option3 = 'Cowardly, Afraid',
    option4 = 'Afraid, Timid'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "valiant"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Brave, Heroic';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "valiant"?', 'synonym', 'Brave, Heroic', 'Brave, Heroic', 'Afraid, Weak', 'Cowardly, Afraid', 'Afraid, Timid', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "valiant"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Brave, Heroic'
) < 1;

UPDATE questions
SET option1 = 'Afraid, Timid',
    option2 = 'Cowardly, Afraid',
    option3 = 'Fearless, Bold',
    option4 = 'Afraid, Weak'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "dauntless"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Fearless, Bold';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "dauntless"?', 'synonym', 'Fearless, Bold', 'Afraid, Timid', 'Cowardly, Afraid', 'Fearless, Bold', 'Afraid, Weak', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "dauntless"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Fearless, Bold'
) < 1;

UPDATE questions
SET option1 = 'Afraid, Timid',
    option2 = 'Afraid, Weak',
    option3 = 'Fearless, Bold',
    option4 = 'Cowardly, Afraid'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "intrepid"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Fearless, Bold';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "intrepid"?', 'synonym', 'Fearless, Bold', 'Afraid, Timid', 'Afraid, Weak', 'Fearless, Bold', 'Cowardly, Afraid', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "intrepid"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Fearless, Bold'
) < 1;

UPDATE questions
SET option1 = 'Cowardly, Afraid',
    option2 = 'Courageous, Brave',
    option3 = 'Afraid, Weak',
    option4 = 'Afraid, Timid'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "plucky"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Courageous, Brave';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "plucky"?', 'synonym', 'Courageous, Brave', 'Cowardly, Afraid', 'Courageous, Brave', 'Afraid, Weak', 'Afraid, Timid', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "plucky"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Courageous, Brave'
) < 1;

UPDATE questions
SET option1 = 'Awful, Poor',
    option2 = 'Helpful, Useful',
    option3 = 'Harmful, Useless',
    option4 = 'Unhealthy, Harmful'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "beneficial"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Helpful, Useful';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "beneficial"?', 'synonym', 'Helpful, Useful', 'Awful, Poor', 'Helpful, Useful', 'Harmful, Useless', 'Unhealthy, Harmful', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "beneficial"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Helpful, Useful'
) < 1;

UPDATE questions
SET option1 = 'Harmful, Useless',
    option2 = 'Awful, Poor',
    option3 = 'Unhealthy, Harmful',
    option4 = 'Healthy, Wholesome'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "salubrious"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Healthy, Wholesome';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "salubrious"?', 'synonym', 'Healthy, Wholesome', 'Harmful, Useless', 'Awful, Poor', 'Unhealthy, Harmful', 'Healthy, Wholesome', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "salubrious"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Healthy, Wholesome'
) < 1;

UPDATE questions
SET option1 = 'Awful, Poor',
    option2 = 'Unhealthy, Harmful',
    option3 = 'Harmful, Useless',
    option4 = 'Amazing, Magnificent'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "splendid"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Amazing, Magnificent';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "splendid"?', 'synonym', 'Amazing, Magnificent', 'Awful, Poor', 'Unhealthy, Harmful', 'Harmful, Useless', 'Amazing, Magnificent', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "splendid"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Amazing, Magnificent'
) < 1;

UPDATE questions
SET option1 = 'Unworthy, Bad',
    option2 = 'Honourable, Good',
    option3 = 'Dishonourable, Bad',
    option4 = 'Good, Kind'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "noble"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Honourable, Good';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "noble"?', 'synonym', 'Honourable, Good', 'Unworthy, Bad', 'Honourable, Good', 'Dishonourable, Bad', 'Good, Kind', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "noble"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Honourable, Good'
) < 1;

UPDATE questions
SET option1 = 'Good, Admirable',
    option2 = 'Deserving, Good',
    option3 = 'Good, Kind',
    option4 = 'Unworthy, Bad'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "worthy"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Deserving, Good';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "worthy"?', 'synonym', 'Deserving, Good', 'Good, Admirable', 'Deserving, Good', 'Good, Kind', 'Unworthy, Bad', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "worthy"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Deserving, Good'
) < 1;

UPDATE questions
SET option1 = 'Evil, Wicked',
    option2 = 'Good, Admirable',
    option3 = 'Good, Kind',
    option4 = 'Honourable, Good'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "nefarious"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Evil, Wicked';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "nefarious"?', 'synonym', 'Evil, Wicked', 'Evil, Wicked', 'Good, Admirable', 'Good, Kind', 'Honourable, Good', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "nefarious"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Evil, Wicked'
) < 1;

UPDATE questions
SET option1 = 'Pleasant, Nice',
    option2 = 'Annoying, Irritating',
    option3 = 'Lovely, Pleasant',
    option4 = 'Notice, Watching'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "obnoxious"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Annoying, Irritating';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "obnoxious"?', 'synonym', 'Annoying, Irritating', 'Pleasant, Nice', 'Annoying, Irritating', 'Lovely, Pleasant', 'Notice, Watching', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "obnoxious"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Annoying, Irritating'
) < 1;

UPDATE questions
SET option1 = 'Good, Admirable',
    option2 = 'Hateful, Evil',
    option3 = 'Lovely, Pleasant',
    option4 = 'Hateful, Horrible'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "detestable"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Hateful, Horrible';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "detestable"?', 'synonym', 'Hateful, Horrible', 'Good, Admirable', 'Hateful, Evil', 'Lovely, Pleasant', 'Hateful, Horrible', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "detestable"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Hateful, Horrible'
) < 1;

UPDATE questions
SET option1 = 'Hateful, Evil',
    option2 = 'Hateful, Horrible',
    option3 = 'Lovely, Pleasant',
    option4 = 'Good, Admirable'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "despicable"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Hateful, Evil';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "despicable"?', 'synonym', 'Hateful, Evil', 'Hateful, Evil', 'Hateful, Horrible', 'Lovely, Pleasant', 'Good, Admirable', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "despicable"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Hateful, Evil'
) < 1;

UPDATE questions
SET option1 = 'Hateful, Evil',
    option2 = 'Hateful, Worthless',
    option3 = 'Admirable, Respectable',
    option4 = 'Good, Admirable'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "contemptible"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Hateful, Worthless';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "contemptible"?', 'synonym', 'Hateful, Worthless', 'Hateful, Evil', 'Hateful, Worthless', 'Admirable, Respectable', 'Good, Admirable', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "contemptible"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Hateful, Worthless'
) < 1;

UPDATE questions
SET option1 = 'Cheerful, Happy',
    option2 = 'Sad, Unhappy',
    option3 = 'Sad, Down',
    option4 = 'Happy, Joyful'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "sorrowful"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Sad, Unhappy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "sorrowful"?', 'synonym', 'Sad, Unhappy', 'Cheerful, Happy', 'Sad, Unhappy', 'Sad, Down', 'Happy, Joyful', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "sorrowful"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Sad, Unhappy'
) < 1;

UPDATE questions
SET option1 = 'Hateful, Horrible',
    option2 = 'Sad, Unhappy',
    option3 = 'Sad, Down',
    option4 = 'Cheerful, Happy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "depressed"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Sad, Unhappy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "depressed"?', 'synonym', 'Sad, Unhappy', 'Hateful, Horrible', 'Sad, Unhappy', 'Sad, Down', 'Cheerful, Happy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "depressed"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Sad, Unhappy'
) < 1;

UPDATE questions
SET option1 = 'Sad, Down',
    option2 = 'Hateful, Horrible',
    option3 = 'Sad, Unhappy',
    option4 = 'Cheerful, Happy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "dejected"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Sad, Down';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "dejected"?', 'synonym', 'Sad, Down', 'Sad, Down', 'Hateful, Horrible', 'Sad, Unhappy', 'Cheerful, Happy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "dejected"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Sad, Down'
) < 1;

UPDATE questions
SET option1 = 'Cheerful, Happy',
    option2 = 'Good, Admirable',
    option3 = 'Grow, Improve',
    option4 = 'Rot, Deteriorate'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "decay"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Rot, Deteriorate';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "decay"?', 'synonym', 'Rot, Deteriorate', 'Cheerful, Happy', 'Good, Admirable', 'Grow, Improve', 'Rot, Deteriorate', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "decay"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Rot, Deteriorate'
) < 1;

UPDATE questions
SET option1 = 'Protect, Save',
    option2 = 'Ruin, Destroy',
    option3 = 'Slowly, Later',
    option4 = 'Quickly, Immediately'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "preserve"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Protect, Save';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "preserve"?', 'synonym', 'Protect, Save', 'Protect, Save', 'Ruin, Destroy', 'Slowly, Later', 'Quickly, Immediately', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "preserve"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Protect, Save'
) < 1;

UPDATE questions
SET option1 = 'Glowing, Bright',
    option2 = 'Dark, Dull',
    option3 = 'Dull, Faded',
    option4 = 'Dull, Rough'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "luminous"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Glowing, Bright';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "luminous"?', 'synonym', 'Glowing, Bright', 'Glowing, Bright', 'Dark, Dull', 'Dull, Faded', 'Dull, Rough', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "luminous"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Glowing, Bright'
) < 1;

UPDATE questions
SET option1 = 'Shiny, Glossy',
    option2 = 'Bossy, Pushy',
    option3 = 'Gentle, Easy-going',
    option4 = 'Grow, Improve'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "domineering"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Bossy, Pushy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "domineering"?', 'synonym', 'Bossy, Pushy', 'Shiny, Glossy', 'Bossy, Pushy', 'Gentle, Easy-going', 'Grow, Improve', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "domineering"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Bossy, Pushy'
) < 1;

UPDATE questions
SET option1 = 'Quickly, Immediately',
    option2 = 'Protect, Save',
    option3 = 'Slowly, Later',
    option4 = 'Ruin, Destroy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "promptly"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Quickly, Immediately';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "promptly"?', 'synonym', 'Quickly, Immediately', 'Quickly, Immediately', 'Protect, Save', 'Slowly, Later', 'Ruin, Destroy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "promptly"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Quickly, Immediately'
) < 1;

UPDATE questions
SET option1 = 'Shiny, Glossy',
    option2 = 'Dull, Rough',
    option3 = 'Sadness, Misery',
    option4 = 'Shiny, Polished'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "glossy"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Shiny, Polished';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "glossy"?', 'synonym', 'Shiny, Polished', 'Shiny, Glossy', 'Dull, Rough', 'Sadness, Misery', 'Shiny, Polished', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "glossy"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Shiny, Polished'
) < 1;

UPDATE questions
SET option1 = 'Dull, Flat',
    option2 = 'Dark, Dull',
    option3 = 'Shiny, Glossy',
    option4 = 'Dull, Rough'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "matte"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Dull, Flat';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "matte"?', 'synonym', 'Dull, Flat', 'Dull, Flat', 'Dark, Dull', 'Shiny, Glossy', 'Dull, Rough', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "matte"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Dull, Flat'
) < 1;

UPDATE questions
SET option1 = 'Shiny, Polished',
    option2 = 'Dull, Rough',
    option3 = 'Sadness, Misery',
    option4 = 'Joy, Delight'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "glee"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Joy, Delight';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "glee"?', 'synonym', 'Joy, Delight', 'Shiny, Polished', 'Dull, Rough', 'Sadness, Misery', 'Joy, Delight', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "glee"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Joy, Delight'
) < 1;

UPDATE questions
SET option1 = 'Shine, Glow',
    option2 = 'Fade, Dim',
    option3 = 'Shiny, Polished',
    option4 = 'Shiny, Glossy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "radiate"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Shine, Glow';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "radiate"?', 'synonym', 'Shine, Glow', 'Shine, Glow', 'Fade, Dim', 'Shiny, Polished', 'Shiny, Glossy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "radiate"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Shine, Glow'
) < 1;

UPDATE questions
SET option1 = 'Demand, Refuse',
    option2 = 'Demand, Declare',
    option3 = 'Help, Ease',
    option4 = 'Beg, Implore'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "plead"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Beg, Implore';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "plead"?', 'synonym', 'Beg, Implore', 'Demand, Refuse', 'Demand, Declare', 'Help, Ease', 'Beg, Implore', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "plead"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Beg, Implore'
) < 1;

UPDATE questions
SET option1 = 'Calm, Reassure',
    option2 = 'Stillness, Calm',
    option3 = 'Calm, Relaxed',
    option4 = 'Panicked, Wild'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "frantic"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Panicked, Wild';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "frantic"?', 'synonym', 'Panicked, Wild', 'Calm, Reassure', 'Stillness, Calm', 'Calm, Relaxed', 'Panicked, Wild', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "frantic"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Panicked, Wild'
) < 1;

UPDATE questions
SET option1 = 'Encourage, Push',
    option2 = 'Suggest, Give in',
    option3 = 'Discourage, Prevent',
    option4 = 'Caring, Keen'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "urge"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Encourage, Push';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "urge"?', 'synonym', 'Encourage, Push', 'Encourage, Push', 'Suggest, Give in', 'Discourage, Prevent', 'Caring, Keen', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "urge"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Encourage, Push'
) < 1;

UPDATE questions
SET option1 = 'Uninterested, Indifferent',
    option2 = 'Discourage, Prevent',
    option3 = 'Differ, Contrast',
    option4 = 'Caring, Keen'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "apathetic"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Uninterested, Indifferent';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "apathetic"?', 'synonym', 'Uninterested, Indifferent', 'Uninterested, Indifferent', 'Discourage, Prevent', 'Differ, Contrast', 'Caring, Keen', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "apathetic"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Uninterested, Indifferent'
) < 1;

UPDATE questions
SET option1 = 'Demand, Declare',
    option2 = 'Suggest, Give in',
    option3 = 'Demand, Refuse',
    option4 = 'Ignore, Neglect'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "insist"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Demand, Declare';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "insist"?', 'synonym', 'Demand, Declare', 'Demand, Declare', 'Suggest, Give in', 'Demand, Refuse', 'Ignore, Neglect', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "insist"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Demand, Declare'
) < 1;

UPDATE questions
SET option1 = 'Fix, Strengthen',
    option2 = 'Wave, Undulation',
    option3 = 'Stillness, Calm',
    option4 = 'Damage, Weaken'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "cripple"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Damage, Weaken';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "cripple"?', 'synonym', 'Damage, Weaken', 'Fix, Strengthen', 'Wave, Undulation', 'Stillness, Calm', 'Damage, Weaken', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "cripple"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Damage, Weaken'
) < 1;

UPDATE questions
SET option1 = 'Important, Related',
    option2 = 'Look like, Match',
    option3 = 'Irrelevant, Unrelated',
    option4 = 'Differ, Contrast'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "resemble"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Look like, Match';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "resemble"?', 'synonym', 'Look like, Match', 'Important, Related', 'Look like, Match', 'Irrelevant, Unrelated', 'Differ, Contrast', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "resemble"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Look like, Match'
) < 1;

UPDATE questions
SET option1 = 'Continue, Straighten',
    option2 = 'Helped, Supported',
    option3 = 'Straighten, Support',
    option4 = 'Bend, Collapse'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "buckle"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Bend, Collapse';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "buckle"?', 'synonym', 'Bend, Collapse', 'Continue, Straighten', 'Helped, Supported', 'Straighten, Support', 'Bend, Collapse', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "buckle"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Bend, Collapse'
) < 1;

UPDATE questions
SET option1 = 'Damage, Weaken',
    option2 = 'Stillness, Calm',
    option3 = 'Wave, Undulation',
    option4 = 'Fix, Strengthen'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "ripple"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Wave, Undulation';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "ripple"?', 'synonym', 'Wave, Undulation', 'Damage, Weaken', 'Stillness, Calm', 'Wave, Undulation', 'Fix, Strengthen', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "ripple"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Wave, Undulation'
) < 1;

UPDATE questions
SET option1 = 'Ignore, Neglect',
    option2 = 'Ignoring, Overlooking',
    option3 = 'Pleasant, Nice',
    option4 = 'Notice, Watching'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "observation"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Notice, Watching';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "observation"?', 'synonym', 'Notice, Watching', 'Ignore, Neglect', 'Ignoring, Overlooking', 'Pleasant, Nice', 'Notice, Watching', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "observation"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Notice, Watching'
) < 1;

UPDATE questions
SET option1 = 'Winner, Hero',
    option2 = 'Smiled, Grinned',
    option3 = 'Differ, Contrast',
    option4 = 'Winced, Scowled'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "grimaced"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Winced, Scowled';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "grimaced"?', 'synonym', 'Winced, Scowled', 'Winner, Hero', 'Smiled, Grinned', 'Differ, Contrast', 'Winced, Scowled', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "grimaced"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Winced, Scowled'
) < 1;

UPDATE questions
SET option1 = 'Suggest, Give in',
    option2 = 'Ignorance, Confusion',
    option3 = 'Ignore, Neglect',
    option4 = 'Affect, Persuade'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "influence"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Affect, Persuade';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "influence"?', 'synonym', 'Affect, Persuade', 'Suggest, Give in', 'Ignorance, Confusion', 'Ignore, Neglect', 'Affect, Persuade', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "influence"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Affect, Persuade'
) < 1;

UPDATE questions
SET option1 = 'Freedom, Independence',
    option2 = 'Planned, Ordered',
    option3 = 'Control, Captivity',
    option4 = 'Ignore, Neglect'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "liberty"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Freedom, Independence';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "liberty"?', 'synonym', 'Freedom, Independence', 'Freedom, Independence', 'Planned, Ordered', 'Control, Captivity', 'Ignore, Neglect', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "liberty"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Freedom, Independence'
) < 1;

UPDATE questions
SET option1 = 'Old, Historic',
    option2 = 'Planned, Ordered',
    option3 = 'Loser, Quitter',
    option4 = 'Modern, New'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "ancient"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Old, Historic';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "ancient"?', 'synonym', 'Old, Historic', 'Old, Historic', 'Planned, Ordered', 'Loser, Quitter', 'Modern, New', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "ancient"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Old, Historic'
) < 1;

UPDATE questions
SET option1 = 'Loser, Quitter',
    option2 = 'Smiled, Grinned',
    option3 = 'Modern, New',
    option4 = 'Winner, Hero'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "champion"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Winner, Hero';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "champion"?', 'synonym', 'Winner, Hero', 'Loser, Quitter', 'Smiled, Grinned', 'Modern, New', 'Winner, Hero', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "champion"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Winner, Hero'
) < 1;

UPDATE questions
SET option1 = 'Past, Certain',
    option2 = 'Hobby, Pastime',
    option3 = 'Career, Occupation',
    option4 = 'Ruin, Destroy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "profession"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Career, Occupation';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "profession"?', 'synonym', 'Career, Occupation', 'Past, Certain', 'Hobby, Pastime', 'Career, Occupation', 'Ruin, Destroy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "profession"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Career, Occupation'
) < 1;

UPDATE questions
SET option1 = 'Planned, Ordered',
    option2 = 'Unplanned, Unexpected',
    option3 = 'Planned, Timed',
    option4 = 'Cancelled, Unplanned'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "random"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Unplanned, Unexpected';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "random"?', 'synonym', 'Unplanned, Unexpected', 'Planned, Ordered', 'Unplanned, Unexpected', 'Planned, Timed', 'Cancelled, Unplanned', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "random"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Unplanned, Unexpected'
) < 1;

UPDATE questions
SET option1 = 'Important, Related',
    option2 = 'Release, Allow',
    option3 = 'Irrelevant, Unrelated',
    option4 = 'Differ, Contrast'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "relevant"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Important, Related';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "relevant"?', 'synonym', 'Important, Related', 'Important, Related', 'Release, Allow', 'Irrelevant, Unrelated', 'Differ, Contrast', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "relevant"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Important, Related'
) < 1;

UPDATE questions
SET option1 = 'Planned, Timed',
    option2 = 'Cancelled, Unplanned',
    option3 = 'Planned, Ordered',
    option4 = 'Unplanned, Unexpected'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "scheduled"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Planned, Timed';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "scheduled"?', 'synonym', 'Planned, Timed', 'Planned, Timed', 'Cancelled, Unplanned', 'Planned, Ordered', 'Unplanned, Unexpected', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "scheduled"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Planned, Timed'
) < 1;

UPDATE questions
SET option1 = 'Straighten, Support',
    option2 = 'Continue, Straighten',
    option3 = 'Veer, Turn',
    option4 = 'Flexible, Agreeable'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "swerve"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Veer, Turn';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "swerve"?', 'synonym', 'Veer, Turn', 'Straighten, Support', 'Continue, Straighten', 'Veer, Turn', 'Flexible, Agreeable', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "swerve"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Veer, Turn'
) < 1;

UPDATE questions
SET option1 = 'Madness, Chaos',
    option2 = 'Calm, Certainty',
    option3 = 'Tension, Excitement',
    option4 = 'Sense, Reason'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "sanity"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Sense, Reason';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "sanity"?', 'synonym', 'Sense, Reason', 'Madness, Chaos', 'Calm, Certainty', 'Tension, Excitement', 'Sense, Reason', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "sanity"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Sense, Reason'
) < 1;

UPDATE questions
SET option1 = 'Soft, Gentle',
    option2 = 'Calm, Certainty',
    option3 = 'Piercing, Sharp',
    option4 = 'Flexible, Agreeable'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "shrill"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Piercing, Sharp';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "shrill"?', 'synonym', 'Piercing, Sharp', 'Soft, Gentle', 'Calm, Certainty', 'Piercing, Sharp', 'Flexible, Agreeable', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "shrill"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Piercing, Sharp'
) < 1;

UPDATE questions
SET option1 = 'Soft, Gentle',
    option2 = 'Flexible, Agreeable',
    option3 = 'Firm, Determined',
    option4 = 'Veer, Turn'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "stubborn"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Firm, Determined';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "stubborn"?', 'synonym', 'Firm, Determined', 'Soft, Gentle', 'Flexible, Agreeable', 'Firm, Determined', 'Veer, Turn', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "stubborn"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Firm, Determined'
) < 1;

UPDATE questions
SET option1 = 'Calm, Certainty',
    option2 = 'Sense, Reason',
    option3 = 'Keep, Continue',
    option4 = 'Tension, Excitement'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "suspense"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Tension, Excitement';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "suspense"?', 'synonym', 'Tension, Excitement', 'Calm, Certainty', 'Sense, Reason', 'Keep, Continue', 'Tension, Excitement', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "suspense"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Tension, Excitement'
) < 1;

UPDATE questions
SET option1 = 'Usual, Common',
    option2 = 'Unusual, Rare',
    option3 = 'Calm, Certainty',
    option4 = 'Slow, Relaxed'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "typical"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Usual, Common';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "typical"?', 'synonym', 'Usual, Common', 'Usual, Common', 'Unusual, Rare', 'Calm, Certainty', 'Slow, Relaxed', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "typical"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Usual, Common'
) < 1;

UPDATE questions
SET option1 = 'Calm, Certainty',
    option2 = 'Madness, Chaos',
    option3 = 'Drama, Exaggeration',
    option4 = 'Calmness, Simplicity'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "dramatics"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Drama, Exaggeration';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "dramatics"?', 'synonym', 'Drama, Exaggeration', 'Calm, Certainty', 'Madness, Chaos', 'Drama, Exaggeration', 'Calmness, Simplicity', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "dramatics"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Drama, Exaggeration'
) < 1;

UPDATE questions
SET option1 = 'Isolation, Void',
    option2 = 'Surroundings, Nature',
    option3 = 'Surround, Trouble',
    option4 = 'Exclude, Avoid'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "environment"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Surroundings, Nature';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "environment"?', 'synonym', 'Surroundings, Nature', 'Isolation, Void', 'Surroundings, Nature', 'Surround, Trouble', 'Exclude, Avoid', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "environment"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Surroundings, Nature'
) < 1;

UPDATE questions
SET option1 = 'Smelly, Stinky',
    option2 = 'Piece, Shard',
    option3 = 'Whole, Complete',
    option4 = 'Calm, Relaxed'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "fragment"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Piece, Shard';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "fragment"?', 'synonym', 'Piece, Shard', 'Smelly, Stinky', 'Piece, Shard', 'Whole, Complete', 'Calm, Relaxed', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "fragment"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Piece, Shard'
) < 1;

UPDATE questions
SET option1 = 'Prevent, Stop',
    option2 = 'Weak, Unclear',
    option3 = 'Plot, Scheme',
    option4 = 'Persuasive, Strong'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "conspire"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Plot, Scheme';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "conspire"?', 'synonym', 'Plot, Scheme', 'Prevent, Stop', 'Weak, Unclear', 'Plot, Scheme', 'Persuasive, Strong', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "conspire"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Plot, Scheme'
) < 1;

UPDATE questions
SET option1 = 'Rushed, Quick',
    option2 = 'Free, Assist',
    option3 = 'Helped, Supported',
    option4 = 'Slow, Relaxed'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "hurried"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Rushed, Quick';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "hurried"?', 'synonym', 'Rushed, Quick', 'Rushed, Quick', 'Free, Assist', 'Helped, Supported', 'Slow, Relaxed', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "hurried"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Rushed, Quick'
) < 1;

UPDATE questions
SET option1 = 'Surround, Trouble',
    option2 = 'Harassed, Troubled',
    option3 = 'Helped, Supported',
    option4 = 'Free, Assist'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "beleaguered"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Harassed, Troubled';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "beleaguered"?', 'synonym', 'Harassed, Troubled', 'Surround, Trouble', 'Harassed, Troubled', 'Helped, Supported', 'Free, Assist', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "beleaguered"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Harassed, Troubled'
) < 1;

UPDATE questions
SET option1 = 'Harassed, Troubled',
    option2 = 'Free, Assist',
    option3 = 'Surround, Trouble',
    option4 = 'Helped, Supported'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "beset"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Surround, Trouble';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "beset"?', 'synonym', 'Surround, Trouble', 'Harassed, Troubled', 'Free, Assist', 'Surround, Trouble', 'Helped, Supported', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "beset"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Surround, Trouble'
) < 1;

UPDATE questions
SET option1 = 'Bother, Trouble',
    option2 = 'Help, Ease',
    option3 = 'Harassed, Troubled',
    option4 = 'Surround, Trouble'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "plague"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Bother, Trouble';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "plague"?', 'synonym', 'Bother, Trouble', 'Bother, Trouble', 'Help, Ease', 'Harassed, Troubled', 'Surround, Trouble', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "plague"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Bother, Trouble'
) < 1;

UPDATE questions
SET option1 = 'Persuasive, Strong',
    option2 = 'Weak, Unclear',
    option3 = 'Refuse, Resist',
    option4 = 'Prevent, Stop'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "cogent"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Persuasive, Strong';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "cogent"?', 'synonym', 'Persuasive, Strong', 'Persuasive, Strong', 'Weak, Unclear', 'Refuse, Resist', 'Prevent, Stop', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "cogent"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Persuasive, Strong'
) < 1;

UPDATE questions
SET option1 = 'Sensible, Reasonable',
    option2 = 'Chatty, Talkative',
    option3 = 'Quiet, Silent',
    option4 = 'Silly, Confusing'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "logical"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Sensible, Reasonable';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "logical"?', 'synonym', 'Sensible, Reasonable', 'Sensible, Reasonable', 'Chatty, Talkative', 'Quiet, Silent', 'Silly, Confusing', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "logical"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Sensible, Reasonable'
) < 1;

UPDATE questions
SET option1 = 'Silly, Confusing',
    option2 = 'Quiet, Silent',
    option3 = 'Chatty, Talkative',
    option4 = 'Sensible, Reasonable'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "loquacious"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Chatty, Talkative';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "loquacious"?', 'synonym', 'Chatty, Talkative', 'Silly, Confusing', 'Quiet, Silent', 'Chatty, Talkative', 'Sensible, Reasonable', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "loquacious"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Chatty, Talkative'
) < 1;

UPDATE questions
SET option1 = 'Obey, Agree',
    option2 = 'Refuse, Resist',
    option3 = 'Weak, Unclear',
    option4 = 'Refuse, Deny'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "comply"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Obey, Agree';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "comply"?', 'synonym', 'Obey, Agree', 'Obey, Agree', 'Refuse, Resist', 'Weak, Unclear', 'Refuse, Deny', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "comply"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Obey, Agree'
) < 1;

UPDATE questions
SET option1 = 'Awful, Poor',
    option2 = 'Beauty, Glory',
    option3 = 'Release, Let go',
    option4 = 'Plainness, Dullness'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "splendour"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Beauty, Glory';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "splendour"?', 'synonym', 'Beauty, Glory', 'Awful, Poor', 'Beauty, Glory', 'Release, Let go', 'Plainness, Dullness', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "splendour"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Beauty, Glory'
) < 1;

UPDATE questions
SET option1 = 'Release, Let go',
    option2 = 'Grab, Snatch',
    option3 = 'Join, Attach',
    option4 = 'Cut, Separate'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "seize"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Grab, Snatch';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "seize"?', 'synonym', 'Grab, Snatch', 'Release, Let go', 'Grab, Snatch', 'Join, Attach', 'Cut, Separate', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "seize"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Grab, Snatch'
) < 1;

UPDATE questions
SET option1 = 'Control, Hold',
    option2 = 'Release, Allow',
    option3 = 'Repair, Fix',
    option4 = 'Damage, Ruin'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "renovate"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Repair, Fix';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "renovate"?', 'synonym', 'Repair, Fix', 'Control, Hold', 'Release, Allow', 'Repair, Fix', 'Damage, Ruin', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "renovate"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Repair, Fix'
) < 1;

UPDATE questions
SET option1 = 'Release, Allow',
    option2 = 'Repair, Fix',
    option3 = 'Control, Hold',
    option4 = 'Damage, Ruin'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "restrain"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Control, Hold';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "restrain"?', 'synonym', 'Control, Hold', 'Release, Allow', 'Repair, Fix', 'Control, Hold', 'Damage, Ruin', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "restrain"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Control, Hold'
) < 1;

UPDATE questions
SET option1 = 'Proud, Independent',
    option2 = 'Join, Attach',
    option3 = 'Release, Let go',
    option4 = 'Cut, Separate'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "sever"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Cut, Separate';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "sever"?', 'synonym', 'Cut, Separate', 'Proud, Independent', 'Join, Attach', 'Release, Let go', 'Cut, Separate', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "sever"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Cut, Separate'
) < 1;

UPDATE questions
SET option1 = 'Calm, Reassure',
    option2 = 'Moving, Mobile',
    option3 = 'Shock, Surprise',
    option4 = 'Still, Motionless'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "stationary"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Still, Motionless';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "stationary"?', 'synonym', 'Still, Motionless', 'Calm, Reassure', 'Moving, Mobile', 'Shock, Surprise', 'Still, Motionless', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "stationary"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Still, Motionless'
) < 1;

UPDATE questions
SET option1 = 'Keep, Continue',
    option2 = 'Release, Let go',
    option3 = 'Replace, Take over',
    option4 = 'Continue, Begin'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "supersede"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Replace, Take over';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "supersede"?', 'synonym', 'Replace, Take over', 'Keep, Continue', 'Release, Let go', 'Replace, Take over', 'Continue, Begin', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "supersede"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Replace, Take over'
) < 1;

UPDATE questions
SET option1 = 'Special, Rare',
    option2 = 'Unique, Extraordinary',
    option3 = 'Ordinary, Usual',
    option4 = 'Common, Ordinary'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "unique"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Special, Rare';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "unique"?', 'synonym', 'Special, Rare', 'Special, Rare', 'Unique, Extraordinary', 'Ordinary, Usual', 'Common, Ordinary', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "unique"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Special, Rare'
) < 1;

UPDATE questions
SET option1 = 'Proud, Independent',
    option2 = 'Release, Let go',
    option3 = 'Submissive, Obedient',
    option4 = 'Join, Attach'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "servile"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Submissive, Obedient';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "servile"?', 'synonym', 'Submissive, Obedient', 'Proud, Independent', 'Release, Let go', 'Submissive, Obedient', 'Join, Attach', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "servile"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Submissive, Obedient'
) < 1;

UPDATE questions
SET option1 = 'Shock, Surprise',
    option2 = 'Still, Motionless',
    option3 = 'Calm, Reassure',
    option4 = 'Moving, Mobile'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "startle"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Shock, Surprise';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "startle"?', 'synonym', 'Shock, Surprise', 'Shock, Surprise', 'Still, Motionless', 'Calm, Reassure', 'Moving, Mobile', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "startle"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Shock, Surprise'
) < 1;

UPDATE questions
SET option1 = 'Main, Head',
    option2 = 'Minor, Unimportant',
    option3 = 'Stand-in, Representative',
    option4 = 'Original, Principal'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "proxy"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Stand-in, Representative';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "proxy"?', 'synonym', 'Stand-in, Representative', 'Main, Head', 'Minor, Unimportant', 'Stand-in, Representative', 'Original, Principal', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "proxy"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Stand-in, Representative'
) < 1;

UPDATE questions
SET option1 = 'Detailed, Complete',
    option2 = 'Distracted, Careless',
    option3 = 'Careless, Rushed',
    option4 = 'Careful, Economical'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "thorough"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Detailed, Complete';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "thorough"?', 'synonym', 'Detailed, Complete', 'Detailed, Complete', 'Distracted, Careless', 'Careless, Rushed', 'Careful, Economical', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "thorough"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Detailed, Complete'
) < 1;

UPDATE questions
SET option1 = 'Promise, Vow',
    option2 = 'Lie, Break',
    option3 = 'Reveal, Show',
    option4 = 'Shock, Surprise'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "oath"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Promise, Vow';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "oath"?', 'synonym', 'Promise, Vow', 'Promise, Vow', 'Lie, Break', 'Reveal, Show', 'Shock, Surprise', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "oath"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Promise, Vow'
) < 1;

UPDATE questions
SET option1 = 'Distracted, Careless',
    option2 = 'Careless, Rushed',
    option3 = 'Focused, Alert',
    option4 = 'Calm, Reassure'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "attentive"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Focused, Alert';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "attentive"?', 'synonym', 'Focused, Alert', 'Distracted, Careless', 'Careless, Rushed', 'Focused, Alert', 'Calm, Reassure', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "attentive"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Focused, Alert'
) < 1;

UPDATE questions
SET option1 = 'Enemy, Stranger',
    option2 = 'Unusual, Original',
    option3 = 'Refuse, Resist',
    option4 = 'Friend, Partner'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "companion"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Friend, Partner';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "companion"?', 'synonym', 'Friend, Partner', 'Enemy, Stranger', 'Unusual, Original', 'Refuse, Resist', 'Friend, Partner', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "companion"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Friend, Partner'
) < 1;

UPDATE questions
SET option1 = 'Cowardly, Fearful',
    option2 = 'Brave, Courageous',
    option3 = 'Brave, Heroic',
    option4 = 'Cowardly, Afraid'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "valiant"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Brave, Courageous';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "valiant"?', 'synonym', 'Brave, Courageous', 'Cowardly, Fearful', 'Brave, Courageous', 'Brave, Heroic', 'Cowardly, Afraid', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "valiant"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Brave, Courageous'
) < 1;

UPDATE questions
SET option1 = 'Lie, Break',
    option2 = 'Reveal, Show',
    option3 = 'Costume, Hide',
    option4 = 'Guide, Clarify'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "disguise"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Costume, Hide';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "disguise"?', 'synonym', 'Costume, Hide', 'Lie, Break', 'Reveal, Show', 'Costume, Hide', 'Guide, Clarify', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "disguise"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Costume, Hide'
) < 1;

UPDATE questions
SET option1 = 'Simple, Plain',
    option2 = 'Enemy, Stranger',
    option3 = 'Detailed, Fancy',
    option4 = 'Detailed, Complete'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "elaborate"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Detailed, Fancy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "elaborate"?', 'synonym', 'Detailed, Fancy', 'Simple, Plain', 'Enemy, Stranger', 'Detailed, Fancy', 'Detailed, Complete', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "elaborate"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Detailed, Fancy'
) < 1;

UPDATE questions
SET option1 = 'Blessing, Success',
    option2 = 'Heavy, Awkward',
    option3 = 'Anxious, Uneasy',
    option4 = 'Light, Easy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "cumbersome"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Heavy, Awkward';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "cumbersome"?', 'synonym', 'Heavy, Awkward', 'Blessing, Success', 'Heavy, Awkward', 'Anxious, Uneasy', 'Light, Easy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "cumbersome"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Heavy, Awkward'
) < 1;

UPDATE questions
SET option1 = 'Worthless, Useless',
    option2 = 'Interrupt, Invade',
    option3 = 'Priceless, Valuable',
    option4 = 'Leave, Withdraw'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "invaluable"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Priceless, Valuable';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "invaluable"?', 'synonym', 'Priceless, Valuable', 'Worthless, Useless', 'Interrupt, Invade', 'Priceless, Valuable', 'Leave, Withdraw', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "invaluable"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Priceless, Valuable'
) < 1;

UPDATE questions
SET option1 = 'Wasteful, Extravagant',
    option2 = 'Careless, Rushed',
    option3 = 'Cowardly, Fearful',
    option4 = 'Careful, Economical'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "thrifty"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Careful, Economical';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "thrifty"?', 'synonym', 'Careful, Economical', 'Wasteful, Extravagant', 'Careless, Rushed', 'Cowardly, Fearful', 'Careful, Economical', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "thrifty"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Careful, Economical'
) < 1;

UPDATE questions
SET option1 = 'Shyness, Timidity',
    option2 = 'Blessing, Success',
    option3 = 'Worthless, Useless',
    option4 = 'Boldness, Nerve'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "audacity"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Boldness, Nerve';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "audacity"?', 'synonym', 'Boldness, Nerve', 'Shyness, Timidity', 'Blessing, Success', 'Worthless, Useless', 'Boldness, Nerve', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "audacity"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Boldness, Nerve'
) < 1;

UPDATE questions
SET option1 = 'Secretive, Distant',
    option2 = 'Disaster, Tragedy',
    option3 = 'Calm, Confident',
    option4 = 'Blessing, Success'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "calamity"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Disaster, Tragedy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "calamity"?', 'synonym', 'Disaster, Tragedy', 'Secretive, Distant', 'Disaster, Tragedy', 'Calm, Confident', 'Blessing, Success', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "calamity"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Disaster, Tragedy'
) < 1;

UPDATE questions
SET option1 = 'Calm, Reassure',
    option2 = 'Light, Easy',
    option3 = 'Anxious, Uneasy',
    option4 = 'Calm, Confident'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "apprehensive"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Anxious, Uneasy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "apprehensive"?', 'synonym', 'Anxious, Uneasy', 'Calm, Reassure', 'Light, Easy', 'Anxious, Uneasy', 'Calm, Confident', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "apprehensive"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Anxious, Uneasy'
) < 1;

UPDATE questions
SET option1 = 'Unusual, Original',
    option2 = 'Traditional, Normal',
    option3 = 'Ignoring, Unrelated',
    option4 = 'Enemy, Stranger'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "conventional"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Traditional, Normal';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "conventional"?', 'synonym', 'Traditional, Normal', 'Unusual, Original', 'Traditional, Normal', 'Ignoring, Unrelated', 'Enemy, Stranger', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "conventional"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Traditional, Normal'
) < 1;

DROP TABLE seed_quiz_id;

-- Year 5 Vocabulary Synonym Paper 3
INSERT INTO quizzes (title, description, created_by, stage_id, lock_after_attempt)
SELECT 'Year 5 Vocabulary Synonym Paper 3',
       'A 100-question Year 5 vocabulary exam asking students to identify synonym pairs.',
       1,
       (SELECT id FROM stages WHERE name = 'Year 5'),
       1
WHERE NOT EXISTS (SELECT 1 FROM quizzes WHERE title = 'Year 5 Vocabulary Synonym Paper 3');

DROP TABLE IF EXISTS seed_quiz_id;
CREATE TEMP TABLE seed_quiz_id(id INTEGER);
INSERT INTO seed_quiz_id SELECT id FROM quizzes WHERE title = 'Year 5 Vocabulary Synonym Paper 3' LIMIT 1;

UPDATE questions
SET option1 = 'Cruel, Harsh',
    option2 = 'Kind, Gentle',
    option3 = 'Worthless, Useless',
    option4 = 'Careful, Economical'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "ruthless"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Cruel, Harsh';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "ruthless"?', 'synonym', 'Cruel, Harsh', 'Cruel, Harsh', 'Kind, Gentle', 'Worthless, Useless', 'Careful, Economical', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "ruthless"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Cruel, Harsh'
) < 1;

UPDATE questions
SET option1 = 'Calm, Confident',
    option2 = 'Approaching, Open',
    option3 = 'Keep, Retain',
    option4 = 'Secretive, Distant'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "forthcoming"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Approaching, Open';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "forthcoming"?', 'synonym', 'Approaching, Open', 'Calm, Confident', 'Approaching, Open', 'Keep, Retain', 'Secretive, Distant', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "forthcoming"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Approaching, Open'
) < 1;

UPDATE questions
SET option1 = 'Full, Refilled',
    option2 = 'Dark, Dull',
    option3 = 'Dull, Faded',
    option4 = 'Shiny, Gleaming'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "lustrous"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Shiny, Gleaming';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "lustrous"?', 'synonym', 'Shiny, Gleaming', 'Full, Refilled', 'Dark, Dull', 'Dull, Faded', 'Shiny, Gleaming', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "lustrous"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Shiny, Gleaming'
) < 1;

UPDATE questions
SET option1 = 'Calm, Control',
    option2 = 'Remove, Expel',
    option3 = 'Choice, Freedom',
    option4 = 'Keep, Retain'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "oust"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Remove, Expel';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "oust"?', 'synonym', 'Remove, Expel', 'Calm, Control', 'Remove, Expel', 'Choice, Freedom', 'Keep, Retain', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "oust"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Remove, Expel'
) < 1;

UPDATE questions
SET option1 = 'Leave, Withdraw',
    option2 = 'Hide, Conceal',
    option3 = 'Lazy, Idle',
    option4 = 'Busy, Diligent'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "industrious"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Busy, Diligent';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "industrious"?', 'synonym', 'Busy, Diligent', 'Leave, Withdraw', 'Hide, Conceal', 'Lazy, Idle', 'Busy, Diligent', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "industrious"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Busy, Diligent'
) < 1;

UPDATE questions
SET option1 = 'Refined, Stylish',
    option2 = 'Simple, Basic',
    option3 = 'Simple, Plain',
    option4 = 'Full, Refilled'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "sophisticated"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Refined, Stylish';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "sophisticated"?', 'synonym', 'Refined, Stylish', 'Refined, Stylish', 'Simple, Basic', 'Simple, Plain', 'Full, Refilled', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "sophisticated"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Refined, Stylish'
) < 1;

UPDATE questions
SET option1 = 'Lazy, Idle',
    option2 = 'Leave, Withdraw',
    option3 = 'Busy, Diligent',
    option4 = 'Interrupt, Invade'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "intrude"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Interrupt, Invade';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "intrude"?', 'synonym', 'Interrupt, Invade', 'Lazy, Idle', 'Leave, Withdraw', 'Busy, Diligent', 'Interrupt, Invade', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "intrude"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Interrupt, Invade'
) < 1;

UPDATE questions
SET option1 = 'Empty, Drain',
    option2 = 'Full, Refilled',
    option3 = 'Empty, Drained',
    option4 = 'Refill, Restore'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "depleted"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Empty, Drained';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "depleted"?', 'synonym', 'Empty, Drained', 'Empty, Drain', 'Full, Refilled', 'Empty, Drained', 'Refill, Restore', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "depleted"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Empty, Drained'
) < 1;

UPDATE questions
SET option1 = 'Duty, Responsibility',
    option2 = 'Choice, Freedom',
    option3 = 'Emptying, Freeing',
    option4 = 'Keep, Retain'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "obligation"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Duty, Responsibility';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "obligation"?', 'synonym', 'Duty, Responsibility', 'Duty, Responsibility', 'Choice, Freedom', 'Emptying, Freeing', 'Keep, Retain', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "obligation"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Duty, Responsibility'
) < 1;

UPDATE questions
SET option1 = 'Leave, Withdraw',
    option2 = 'Emptying, Freeing',
    option3 = 'Kindness, Respect',
    option4 = 'Bullying, Trouble'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "harassment"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Bullying, Trouble';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "harassment"?', 'synonym', 'Bullying, Trouble', 'Leave, Withdraw', 'Emptying, Freeing', 'Kindness, Respect', 'Bullying, Trouble', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "harassment"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Bullying, Trouble'
) < 1;

UPDATE questions
SET option1 = 'Seller, Provider',
    option2 = 'Ignoring, Unrelated',
    option3 = 'Customer, Buyer',
    option4 = 'Begin, Continue'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "client"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Customer, Buyer';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "client"?', 'synonym', 'Customer, Buyer', 'Seller, Provider', 'Ignoring, Unrelated', 'Customer, Buyer', 'Begin, Continue', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "client"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Customer, Buyer'
) < 1;

UPDATE questions
SET option1 = 'Seller, Provider',
    option2 = 'Shorten, Reduce',
    option3 = 'Shortage, Lack',
    option4 = 'Lengthen, Expand'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "abbreviate"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Shorten, Reduce';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "abbreviate"?', 'synonym', 'Shorten, Reduce', 'Seller, Provider', 'Shorten, Reduce', 'Shortage, Lack', 'Lengthen, Expand', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "abbreviate"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Shorten, Reduce'
) < 1;

UPDATE questions
SET option1 = 'Unusual, Original',
    option2 = 'Ignoring, Unrelated',
    option3 = 'Traditional, Normal',
    option4 = 'About, Regarding'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "concerning"?'
  AND question_type = 'synonym'
  AND correct_answer = 'About, Regarding';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "concerning"?', 'synonym', 'About, Regarding', 'Unusual, Original', 'Ignoring, Unrelated', 'Traditional, Normal', 'About, Regarding', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "concerning"?'
      AND question_type = 'synonym'
      AND correct_answer = 'About, Regarding'
) < 1;

UPDATE questions
SET option1 = 'Choice, Freedom',
    option2 = 'Emptying, Freeing',
    option3 = 'Proud, Showy',
    option4 = 'Filling, Using'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "occupying"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Filling, Using';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "occupying"?', 'synonym', 'Filling, Using', 'Choice, Freedom', 'Emptying, Freeing', 'Proud, Showy', 'Filling, Using', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "occupying"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Filling, Using'
) < 1;

UPDATE questions
SET option1 = 'Ignoring, Unrelated',
    option2 = 'Begin, Continue',
    option3 = 'End, Halt',
    option4 = 'Defend, Protect'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "cease"?'
  AND question_type = 'synonym'
  AND correct_answer = 'End, Halt';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "cease"?', 'synonym', 'End, Halt', 'Ignoring, Unrelated', 'Begin, Continue', 'End, Halt', 'Defend, Protect', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "cease"?'
      AND question_type = 'synonym'
      AND correct_answer = 'End, Halt'
) < 1;

UPDATE questions
SET option1 = 'Tell, Notify',
    option2 = 'Leave, Withdraw',
    option3 = 'Lazy, Idle',
    option4 = 'Hide, Conceal'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "inform"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Tell, Notify';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "inform"?', 'synonym', 'Tell, Notify', 'Tell, Notify', 'Leave, Withdraw', 'Lazy, Idle', 'Hide, Conceal', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "inform"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Tell, Notify'
) < 1;

UPDATE questions
SET option1 = 'Settle, Fix',
    option2 = 'Uncertain, Confused',
    option3 = 'Perform, Stop',
    option4 = 'Determined, Settled'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "resolved"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Determined, Settled';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "resolved"?', 'synonym', 'Determined, Settled', 'Settle, Fix', 'Uncertain, Confused', 'Perform, Stop', 'Determined, Settled', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "resolved"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Determined, Settled'
) < 1;

UPDATE questions
SET option1 = 'Possibility, Chance',
    option2 = 'Defend, Protect',
    option3 = 'Impossibility, Past',
    option4 = 'Charge, Accuse'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "prosecute"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Charge, Accuse';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "prosecute"?', 'synonym', 'Charge, Accuse', 'Possibility, Chance', 'Defend, Protect', 'Impossibility, Past', 'Charge, Accuse', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "prosecute"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Charge, Accuse'
) < 1;

UPDATE questions
SET option1 = 'Modest, Humble',
    option2 = 'Defend, Protect',
    option3 = 'Filling, Using',
    option4 = 'Proud, Showy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "unassuming"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Modest, Humble';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "unassuming"?', 'synonym', 'Modest, Humble', 'Modest, Humble', 'Defend, Protect', 'Filling, Using', 'Proud, Showy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "unassuming"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Modest, Humble'
) < 1;

UPDATE questions
SET option1 = 'Defend, Protect',
    option2 = 'Possibility, Chance',
    option3 = 'Impossibility, Past',
    option4 = 'Charge, Accuse'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "prospect"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Possibility, Chance';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "prospect"?', 'synonym', 'Possibility, Chance', 'Defend, Protect', 'Possibility, Chance', 'Impossibility, Past', 'Charge, Accuse', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "prospect"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Possibility, Chance'
) < 1;

UPDATE questions
SET option1 = 'Persist, Survive',
    option2 = 'Quit, Give up',
    option3 = 'Impossibility, Past',
    option4 = 'Last, Survive'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "endure"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Last, Survive';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "endure"?', 'synonym', 'Last, Survive', 'Persist, Survive', 'Quit, Give up', 'Impossibility, Past', 'Last, Survive', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "endure"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Last, Survive'
) < 1;

UPDATE questions
SET option1 = 'Quit, Give up',
    option2 = 'Cheerful, Playful',
    option3 = 'Rise, Surface',
    option4 = 'Serious, Grave'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "solemn"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Serious, Grave';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "solemn"?', 'synonym', 'Serious, Grave', 'Quit, Give up', 'Cheerful, Playful', 'Rise, Surface', 'Serious, Grave', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "solemn"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Serious, Grave'
) < 1;

UPDATE questions
SET option1 = 'Rise, Surface',
    option2 = 'Sink, Drown',
    option3 = 'Sink, Dunk',
    option4 = 'Float, Rise'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "submerge"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Sink, Dunk';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "submerge"?', 'synonym', 'Sink, Dunk', 'Rise, Surface', 'Sink, Drown', 'Sink, Dunk', 'Float, Rise', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "submerge"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Sink, Dunk'
) < 1;

UPDATE questions
SET option1 = 'Rise, Surface',
    option2 = 'Sink, Dunk',
    option3 = 'Assurance, Comfort',
    option4 = 'Sign, Warning'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "omen"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Sign, Warning';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "omen"?', 'synonym', 'Sign, Warning', 'Rise, Surface', 'Sink, Dunk', 'Assurance, Comfort', 'Sign, Warning', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "omen"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Sign, Warning'
) < 1;

UPDATE questions
SET option1 = 'Pitiful, Weak',
    option2 = 'Impossibility, Past',
    option3 = 'Minor, Unimportant',
    option4 = 'Strong, Impressive'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "pathetic"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Pitiful, Weak';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "pathetic"?', 'synonym', 'Pitiful, Weak', 'Pitiful, Weak', 'Impossibility, Past', 'Minor, Unimportant', 'Strong, Impressive', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "pathetic"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Pitiful, Weak'
) < 1;

UPDATE questions
SET option1 = 'Minor, Unimportant',
    option2 = 'Original, Principal',
    option3 = 'Best, Main',
    option4 = 'Main, Head'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "principal"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Main, Head';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "principal"?', 'synonym', 'Main, Head', 'Minor, Unimportant', 'Original, Principal', 'Best, Main', 'Main, Head', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "principal"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Main, Head'
) < 1;

UPDATE questions
SET option1 = 'Odd, Unique',
    option2 = 'Modern, Plain',
    option3 = 'Plain, Ordinary',
    option4 = 'Normal, Plain'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "quirky"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Odd, Unique';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "quirky"?', 'synonym', 'Odd, Unique', 'Odd, Unique', 'Modern, Plain', 'Plain, Ordinary', 'Normal, Plain', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "quirky"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Odd, Unique'
) < 1;

UPDATE questions
SET option1 = 'Practise, Prepare',
    option2 = 'Perform, Stop',
    option3 = 'Build, Repair',
    option4 = 'Praise, Approve'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "rehearse"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Practise, Prepare';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "rehearse"?', 'synonym', 'Practise, Prepare', 'Practise, Prepare', 'Perform, Stop', 'Build, Repair', 'Praise, Approve', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "rehearse"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Practise, Prepare'
) < 1;

UPDATE questions
SET option1 = 'Dirty, Messy',
    option2 = 'Messy, Unclear',
    option3 = 'Clear, Readable',
    option4 = 'Unpleasant, Rude'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "legible"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Clear, Readable';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "legible"?', 'synonym', 'Clear, Readable', 'Dirty, Messy', 'Messy, Unclear', 'Clear, Readable', 'Unpleasant, Rude', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "legible"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Clear, Readable'
) < 1;

UPDATE questions
SET option1 = 'Shield, Protection',
    option2 = 'Signalled, Motioned',
    option3 = 'Hid, Ignored',
    option4 = 'Minor, Unimportant'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "gestured"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Signalled, Motioned';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "gestured"?', 'synonym', 'Signalled, Motioned', 'Shield, Protection', 'Signalled, Motioned', 'Hid, Ignored', 'Minor, Unimportant', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "gestured"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Signalled, Motioned'
) < 1;

UPDATE questions
SET option1 = 'Tiny, Small',
    option2 = 'Huge, Enormous',
    option3 = 'Dirty, Messy',
    option4 = 'Small, Tiny'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "immense"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Huge, Enormous';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "immense"?', 'synonym', 'Huge, Enormous', 'Tiny, Small', 'Huge, Enormous', 'Dirty, Messy', 'Small, Tiny', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "immense"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Huge, Enormous'
) < 1;

UPDATE questions
SET option1 = 'Hid, Ignored',
    option2 = 'Pleasure, Treat',
    option3 = 'Normal, Plain',
    option4 = 'Trial, Hardship'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "ordeal"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Trial, Hardship';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "ordeal"?', 'synonym', 'Trial, Hardship', 'Hid, Ignored', 'Pleasure, Treat', 'Normal, Plain', 'Trial, Hardship', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "ordeal"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Trial, Hardship'
) < 1;

UPDATE questions
SET option1 = 'Destroy, Flatten',
    option2 = 'Skilful, Nimble',
    option3 = 'Clumsy, Awkward',
    option4 = 'Build, Repair'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "demolish"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Destroy, Flatten';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "demolish"?', 'synonym', 'Destroy, Flatten', 'Destroy, Flatten', 'Skilful, Nimble', 'Clumsy, Awkward', 'Build, Repair', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "demolish"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Destroy, Flatten'
) < 1;

UPDATE questions
SET option1 = 'Messy, Unclear',
    option2 = 'Unpleasant, Rude',
    option3 = 'Nice, Pleasant',
    option4 = 'Pleasure, Treat'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "agreeable"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Nice, Pleasant';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "agreeable"?', 'synonym', 'Nice, Pleasant', 'Messy, Unclear', 'Unpleasant, Rude', 'Nice, Pleasant', 'Pleasure, Treat', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "agreeable"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Nice, Pleasant'
) < 1;

UPDATE questions
SET option1 = 'Hid, Ignored',
    option2 = 'Shield, Protection',
    option3 = 'Gun, Artillery',
    option4 = 'Foreign, Wild'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "cannon"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Gun, Artillery';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "cannon"?', 'synonym', 'Gun, Artillery', 'Hid, Ignored', 'Shield, Protection', 'Gun, Artillery', 'Foreign, Wild', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "cannon"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Gun, Artillery'
) < 1;

UPDATE questions
SET option1 = 'Face, Challenge',
    option2 = 'Carelessness, Guiltless',
    option3 = 'Avoid, Escape',
    option4 = 'Ignoring, Unrelated'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "confront"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Face, Challenge';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "confront"?', 'synonym', 'Face, Challenge', 'Face, Challenge', 'Carelessness, Guiltless', 'Avoid, Escape', 'Ignoring, Unrelated', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "confront"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Face, Challenge'
) < 1;

UPDATE questions
SET option1 = 'Skilful, Nimble',
    option2 = 'Clumsy, Awkward',
    option3 = 'Destroy, Flatten',
    option4 = 'Build, Repair'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "deft"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Skilful, Nimble';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "deft"?', 'synonym', 'Skilful, Nimble', 'Skilful, Nimble', 'Clumsy, Awkward', 'Destroy, Flatten', 'Build, Repair', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "deft"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Skilful, Nimble'
) < 1;

UPDATE questions
SET option1 = 'Household, Home',
    option2 = 'Plain, Ordinary',
    option3 = 'Build, Repair',
    option4 = 'Foreign, Wild'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "domestic"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Household, Home';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "domestic"?', 'synonym', 'Household, Home', 'Household, Home', 'Plain, Ordinary', 'Build, Repair', 'Foreign, Wild', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "domestic"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Household, Home'
) < 1;

UPDATE questions
SET option1 = 'Moderate, Careful',
    option2 = 'Empty, Deserted',
    option3 = 'Greedy, Hungry',
    option4 = 'Free, Help'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "gluttonous"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Greedy, Hungry';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "gluttonous"?', 'synonym', 'Greedy, Hungry', 'Moderate, Careful', 'Empty, Deserted', 'Greedy, Hungry', 'Free, Help', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "gluttonous"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Greedy, Hungry'
) < 1;

UPDATE questions
SET option1 = 'Dirty, Messy',
    option2 = 'Tiny, Small',
    option3 = 'Spotless, Perfect',
    option4 = 'Messy, Unclear'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "immaculate"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Spotless, Perfect';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "immaculate"?', 'synonym', 'Spotless, Perfect', 'Dirty, Messy', 'Tiny, Small', 'Spotless, Perfect', 'Messy, Unclear', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "immaculate"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Spotless, Perfect'
) < 1;

UPDATE questions
SET option1 = 'Foreign, Wild',
    option2 = 'Plain, Ordinary',
    option3 = 'Awful, Ordinary',
    option4 = 'Grand, Regal'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "majestic"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Grand, Regal';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "majestic"?', 'synonym', 'Grand, Regal', 'Foreign, Wild', 'Plain, Ordinary', 'Awful, Ordinary', 'Grand, Regal', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "majestic"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Grand, Regal'
) < 1;

UPDATE questions
SET option1 = 'Free, Help',
    option2 = 'Support, Agree',
    option3 = 'Control, Bully',
    option4 = 'Resist, Disagree'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "oppress"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Control, Bully';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "oppress"?', 'synonym', 'Control, Bully', 'Free, Help', 'Support, Agree', 'Control, Bully', 'Resist, Disagree', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "oppress"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Control, Bully'
) < 1;

UPDATE questions
SET option1 = 'Empty, Deserted',
    option2 = 'Occupied, Settled',
    option3 = 'Moderate, Careful',
    option4 = 'Dirty, Messy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "inhabited"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Occupied, Settled';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "inhabited"?', 'synonym', 'Occupied, Settled', 'Empty, Deserted', 'Occupied, Settled', 'Moderate, Careful', 'Dirty, Messy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "inhabited"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Occupied, Settled'
) < 1;

UPDATE questions
SET option1 = 'Clumsy, Slow',
    option2 = 'Agile, Quick',
    option3 = 'Fail, Decline',
    option4 = 'Clumsy, Awkward'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "nimble"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Agile, Quick';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "nimble"?', 'synonym', 'Agile, Quick', 'Clumsy, Slow', 'Agile, Quick', 'Fail, Decline', 'Clumsy, Awkward', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "nimble"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Agile, Quick'
) < 1;

UPDATE questions
SET option1 = 'Control, Bully',
    option2 = 'Support, Agree',
    option3 = 'Resist, Disagree',
    option4 = 'Free, Help'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "oppose"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Resist, Disagree';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "oppose"?', 'synonym', 'Resist, Disagree', 'Control, Bully', 'Support, Agree', 'Resist, Disagree', 'Free, Help', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "oppose"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Resist, Disagree'
) < 1;

UPDATE questions
SET option1 = 'Ignore, Literalise',
    option2 = 'Represent, Humanise',
    option3 = 'Important, Generous',
    option4 = 'Trivial, Small-minded'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "personify"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Represent, Humanise';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "personify"?', 'synonym', 'Represent, Humanise', 'Ignore, Literalise', 'Represent, Humanise', 'Important, Generous', 'Trivial, Small-minded', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "personify"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Represent, Humanise'
) < 1;

UPDATE questions
SET option1 = 'Support, Encourage',
    option2 = 'Fail, Decline',
    option3 = 'Improve, Advance',
    option4 = 'Prevent, Block'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "progress"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Improve, Advance';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "progress"?', 'synonym', 'Improve, Advance', 'Support, Encourage', 'Fail, Decline', 'Improve, Advance', 'Prevent, Block', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "progress"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Improve, Advance'
) < 1;

UPDATE questions
SET option1 = 'Repeat, Say',
    option2 = 'Worry, Frighten',
    option3 = 'Forget, Mumble',
    option4 = 'Comfort, Calm'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "reassure"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Comfort, Calm';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "reassure"?', 'synonym', 'Comfort, Calm', 'Repeat, Say', 'Worry, Frighten', 'Forget, Mumble', 'Comfort, Calm', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "reassure"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Comfort, Calm'
) < 1;

UPDATE questions
SET option1 = 'Well-behaved, Loyal',
    option2 = 'Desert, Wasteland',
    option3 = 'Calm, Control',
    option4 = 'Disobedient, Naughty'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "obedient"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Well-behaved, Loyal';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "obedient"?', 'synonym', 'Well-behaved, Loyal', 'Well-behaved, Loyal', 'Desert, Wasteland', 'Calm, Control', 'Disobedient, Naughty', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "obedient"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Well-behaved, Loyal'
) < 1;

UPDATE questions
SET option1 = 'Explosion, Burst',
    option2 = 'Control, Bully',
    option3 = 'Comfort, Calm',
    option4 = 'Calm, Control'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "outburst"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Explosion, Burst';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "outburst"?', 'synonym', 'Explosion, Burst', 'Explosion, Burst', 'Control, Bully', 'Comfort, Calm', 'Calm, Control', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "outburst"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Explosion, Burst'
) < 1;

UPDATE questions
SET option1 = 'Important, Generous',
    option2 = 'Trivial, Small-minded',
    option3 = 'Ignore, Literalise',
    option4 = 'Deter, Discourage'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "petty"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Trivial, Small-minded';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "petty"?', 'synonym', 'Trivial, Small-minded', 'Important, Generous', 'Trivial, Small-minded', 'Ignore, Literalise', 'Deter, Discourage', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "petty"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Trivial, Small-minded'
) < 1;

UPDATE questions
SET option1 = 'Seal, Mend',
    option2 = 'Pierce, Prick',
    option3 = 'Deter, Discourage',
    option4 = 'Trivial, Small-minded'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "puncture"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Pierce, Prick';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "puncture"?', 'synonym', 'Pierce, Prick', 'Seal, Mend', 'Pierce, Prick', 'Deter, Discourage', 'Trivial, Small-minded', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "puncture"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Pierce, Prick'
) < 1;

UPDATE questions
SET option1 = 'Guess, Memory',
    option2 = 'Forget, Mumble',
    option3 = 'Proof, Ticket',
    option4 = 'Repeat, Say'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "recite"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Repeat, Say';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "recite"?', 'synonym', 'Repeat, Say', 'Guess, Memory', 'Forget, Mumble', 'Proof, Ticket', 'Repeat, Say', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "recite"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Repeat, Say'
) < 1;

UPDATE questions
SET option1 = 'Grove, Farm',
    option2 = 'Desert, Wasteland',
    option3 = 'Deter, Discourage',
    option4 = 'Calm, Control'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "orchard"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Grove, Farm';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "orchard"?', 'synonym', 'Grove, Farm', 'Grove, Farm', 'Desert, Wasteland', 'Deter, Discourage', 'Calm, Control', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "orchard"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Grove, Farm'
) < 1;

UPDATE questions
SET option1 = 'Support, Encourage',
    option2 = 'Convince, Encourage',
    option3 = 'Deter, Discourage',
    option4 = 'Important, Generous'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "persuade"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Convince, Encourage';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "persuade"?', 'synonym', 'Convince, Encourage', 'Support, Encourage', 'Convince, Encourage', 'Deter, Discourage', 'Important, Generous', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "persuade"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Convince, Encourage'
) < 1;

UPDATE questions
SET option1 = 'Support, Encourage',
    option2 = 'Deter, Discourage',
    option3 = 'Convince, Encourage',
    option4 = 'Prevent, Block'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "promote"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Support, Encourage';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "promote"?', 'synonym', 'Support, Encourage', 'Support, Encourage', 'Deter, Discourage', 'Convince, Encourage', 'Prevent, Block', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "promote"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Support, Encourage'
) < 1;

UPDATE questions
SET option1 = 'Guess, Memory',
    option2 = 'Forget, Mumble',
    option3 = 'Proof, Ticket',
    option4 = 'Workplace, Office'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "receipt"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Proof, Ticket';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "receipt"?', 'synonym', 'Proof, Ticket', 'Guess, Memory', 'Forget, Mumble', 'Proof, Ticket', 'Workplace, Office', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "receipt"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Proof, Ticket'
) < 1;

UPDATE questions
SET option1 = 'Home, House',
    option2 = 'Forget, Mumble',
    option3 = 'Workplace, Office',
    option4 = 'Guess, Memory'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "residence"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Home, House';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "residence"?', 'synonym', 'Home, House', 'Home, House', 'Forget, Mumble', 'Workplace, Office', 'Guess, Memory', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "residence"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Home, House'
) < 1;

UPDATE questions
SET option1 = 'Sufficient, Enough',
    option2 = 'Deter, Discourage',
    option3 = 'Workplace, Office',
    option4 = 'Insufficient, Poor'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "adequate"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Sufficient, Enough';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "adequate"?', 'synonym', 'Sufficient, Enough', 'Sufficient, Enough', 'Deter, Discourage', 'Workplace, Office', 'Insufficient, Poor', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "adequate"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Sufficient, Enough'
) < 1;

UPDATE questions
SET option1 = 'Plenty, Lots',
    option2 = 'Deter, Discourage',
    option3 = 'Prevent, Block',
    option4 = 'Shortage, Lack'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "abundance"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Plenty, Lots';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "abundance"?', 'synonym', 'Plenty, Lots', 'Plenty, Lots', 'Deter, Discourage', 'Prevent, Block', 'Shortage, Lack', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "abundance"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Plenty, Lots'
) < 1;

UPDATE questions
SET option1 = 'Seal, Mend',
    option2 = 'Begin, Start',
    option3 = 'Guess, Memory',
    option4 = 'Finish, End'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "embark"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Begin, Start';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "embark"?', 'synonym', 'Begin, Start', 'Seal, Mend', 'Begin, Start', 'Guess, Memory', 'Finish, End', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "embark"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Begin, Start'
) < 1;

UPDATE questions
SET option1 = 'Carelessness, Guiltless',
    option2 = 'Morals, Sense',
    option3 = 'Handy, Useful',
    option4 = 'Awkward, Difficult'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "conscience"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Morals, Sense';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "conscience"?', 'synonym', 'Morals, Sense', 'Carelessness, Guiltless', 'Morals, Sense', 'Handy, Useful', 'Awkward, Difficult', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "conscience"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Morals, Sense'
) < 1;

UPDATE questions
SET option1 = 'Morals, Sense',
    option2 = 'Awkward, Difficult',
    option3 = 'Handy, Useful',
    option4 = 'Carelessness, Guiltless'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "convenient"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Handy, Useful';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "convenient"?', 'synonym', 'Handy, Useful', 'Morals, Sense', 'Awkward, Difficult', 'Handy, Useful', 'Carelessness, Guiltless', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "convenient"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Handy, Useful'
) < 1;

UPDATE questions
SET option1 = 'Kindness, Pity',
    option2 = 'Joy, Happiness',
    option3 = 'Carelessness, Guiltless',
    option4 = 'Cruelty, Harshness'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "mercy"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Kindness, Pity';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "mercy"?', 'synonym', 'Kindness, Pity', 'Kindness, Pity', 'Joy, Happiness', 'Carelessness, Guiltless', 'Cruelty, Harshness', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "mercy"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Kindness, Pity'
) < 1;

UPDATE questions
SET option1 = 'Notice, Respect',
    option2 = 'Miss, Overlook',
    option3 = 'Ignore, Overlook',
    option4 = 'Notice, Recognise'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "discern"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Notice, Recognise';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "discern"?', 'synonym', 'Notice, Recognise', 'Notice, Respect', 'Miss, Overlook', 'Ignore, Overlook', 'Notice, Recognise', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "discern"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Notice, Recognise'
) < 1;

UPDATE questions
SET option1 = 'Possible, Attainable',
    option2 = 'Impossible, Unlikely',
    option3 = 'Fail, Abandon',
    option4 = 'Achieve, Complete'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "accomplish"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Achieve, Complete';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "accomplish"?', 'synonym', 'Achieve, Complete', 'Possible, Attainable', 'Impossible, Unlikely', 'Fail, Abandon', 'Achieve, Complete', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "accomplish"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Achieve, Complete'
) < 1;

UPDATE questions
SET option1 = 'Hide, Conceal',
    option2 = 'Announce, Transmit',
    option3 = 'Carelessness, Guiltless',
    option4 = 'Distance, Far away'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "broadcast"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Announce, Transmit';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "broadcast"?', 'synonym', 'Announce, Transmit', 'Hide, Conceal', 'Announce, Transmit', 'Carelessness, Guiltless', 'Distance, Far away', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "broadcast"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Announce, Transmit'
) < 1;

UPDATE questions
SET option1 = 'Unavoidable, Certain',
    option2 = 'Thinkable, Likely',
    option3 = 'Worthless, Useless',
    option4 = 'Preventable, Unlikely'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "inevitable"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Unavoidable, Certain';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "inevitable"?', 'synonym', 'Unavoidable, Certain', 'Unavoidable, Certain', 'Thinkable, Likely', 'Worthless, Useless', 'Preventable, Unlikely', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "inevitable"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Unavoidable, Certain'
) < 1;

UPDATE questions
SET option1 = 'Cure, Solution',
    option2 = 'Harm, Problem',
    option3 = 'Preserve, Keep',
    option4 = 'Transform, Change'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "remedy"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Cure, Solution';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "remedy"?', 'synonym', 'Cure, Solution', 'Cure, Solution', 'Harm, Problem', 'Preserve, Keep', 'Transform, Change', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "remedy"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Cure, Solution'
) < 1;

UPDATE questions
SET option1 = 'Often, Frequently',
    option2 = 'Scuffle, Clash',
    option3 = 'Peace, Agreement',
    option4 = 'Awkward, Rude'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "skirmish"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Scuffle, Clash';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "skirmish"?', 'synonym', 'Scuffle, Clash', 'Often, Frequently', 'Scuffle, Clash', 'Peace, Agreement', 'Awkward, Rude', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "skirmish"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Scuffle, Clash'
) < 1;

UPDATE questions
SET option1 = 'Boredom, Dullness',
    option2 = 'Smoothness, Flatness',
    option3 = 'Excitement, Fun',
    option4 = 'Feel, Surface'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "tedium"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Boredom, Dullness';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "tedium"?', 'synonym', 'Boredom, Dullness', 'Boredom, Dullness', 'Smoothness, Flatness', 'Excitement, Fun', 'Feel, Surface', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "tedium"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Boredom, Dullness'
) < 1;

UPDATE questions
SET option1 = 'Area, Neighbourhood',
    option2 = 'Awkward, Rude',
    option3 = 'Harm, Problem',
    option4 = 'Distance, Far away'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "vicinity"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Area, Neighbourhood';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "vicinity"?', 'synonym', 'Area, Neighbourhood', 'Area, Neighbourhood', 'Awkward, Rude', 'Harm, Problem', 'Distance, Far away', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "vicinity"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Area, Neighbourhood'
) < 1;

UPDATE questions
SET option1 = 'Miserable, Awful',
    option2 = 'Happy, Content',
    option3 = 'Cheerful, Happy',
    option4 = 'Rude, Blunt'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "wretched"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Miserable, Awful';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "wretched"?', 'synonym', 'Miserable, Awful', 'Miserable, Awful', 'Happy, Content', 'Cheerful, Happy', 'Rude, Blunt', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "wretched"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Miserable, Awful'
) < 1;

UPDATE questions
SET option1 = 'Awkward, Rude',
    option2 = 'Moody, Gloomy',
    option3 = 'Polite, Charming',
    option4 = 'Cheerful, Happy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "suave"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Polite, Charming';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "suave"?', 'synonym', 'Polite, Charming', 'Awkward, Rude', 'Moody, Gloomy', 'Polite, Charming', 'Cheerful, Happy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "suave"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Polite, Charming'
) < 1;

UPDATE questions
SET option1 = 'Peace, Agreement',
    option2 = 'Often, Frequently',
    option3 = 'Rarely, Hardly',
    option4 = 'Cheerful, Happy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "seldom"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Rarely, Hardly';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "seldom"?', 'synonym', 'Rarely, Hardly', 'Peace, Agreement', 'Often, Frequently', 'Rarely, Hardly', 'Cheerful, Happy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "seldom"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Rarely, Hardly'
) < 1;

UPDATE questions
SET option1 = 'Plenty, Abundance',
    option2 = 'Examine, Inspect',
    option3 = 'Miss, Overlook',
    option4 = 'Ignore, Overlook'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "scrutinise"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Examine, Inspect';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "scrutinise"?', 'synonym', 'Examine, Inspect', 'Plenty, Abundance', 'Examine, Inspect', 'Miss, Overlook', 'Ignore, Overlook', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "scrutinise"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Examine, Inspect'
) < 1;

UPDATE questions
SET option1 = 'Polite, Charming',
    option2 = 'Awkward, Rude',
    option3 = 'Moody, Gloomy',
    option4 = 'Cheerful, Happy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "sullen"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Moody, Gloomy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "sullen"?', 'synonym', 'Moody, Gloomy', 'Polite, Charming', 'Awkward, Rude', 'Moody, Gloomy', 'Cheerful, Happy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "sullen"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Moody, Gloomy'
) < 1;

UPDATE questions
SET option1 = 'Rude, Blunt',
    option2 = 'Polite, Thoughtful',
    option3 = 'Awkward, Rude',
    option4 = 'Polite, Refined'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "tactful"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Polite, Thoughtful';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "tactful"?', 'synonym', 'Polite, Thoughtful', 'Rude, Blunt', 'Polite, Thoughtful', 'Awkward, Rude', 'Polite, Refined', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "tactful"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Polite, Thoughtful'
) < 1;

UPDATE questions
SET option1 = 'Pretence, Dishonesty',
    option2 = 'Often, Frequently',
    option3 = 'Preserve, Keep',
    option4 = 'Honesty, Truth'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "sincerity"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Honesty, Truth';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "sincerity"?', 'synonym', 'Honesty, Truth', 'Pretence, Dishonesty', 'Often, Frequently', 'Preserve, Keep', 'Honesty, Truth', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "sincerity"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Honesty, Truth'
) < 1;

UPDATE questions
SET option1 = 'Feel, Surface',
    option2 = 'Boredom, Dullness',
    option3 = 'Excitement, Fun',
    option4 = 'Smoothness, Flatness'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "texture"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Feel, Surface';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "texture"?', 'synonym', 'Feel, Surface', 'Feel, Surface', 'Boredom, Dullness', 'Excitement, Fun', 'Smoothness, Flatness', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "texture"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Feel, Surface'
) < 1;

UPDATE questions
SET option1 = 'Polite, Thoughtful',
    option2 = 'Polite, Refined',
    option3 = 'Rude, Crude',
    option4 = 'Rude, Blunt'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "uncouth"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Rude, Crude';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "uncouth"?', 'synonym', 'Rude, Crude', 'Polite, Thoughtful', 'Polite, Refined', 'Rude, Crude', 'Rude, Blunt', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "uncouth"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Rude, Crude'
) < 1;

UPDATE questions
SET option1 = 'Liquid, Solid',
    option2 = 'Limited, Fixed',
    option3 = 'Flexible, Adaptable',
    option4 = 'Polite, Refined'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "versatile"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Flexible, Adaptable';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "versatile"?', 'synonym', 'Flexible, Adaptable', 'Liquid, Solid', 'Limited, Fixed', 'Flexible, Adaptable', 'Polite, Refined', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "versatile"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Flexible, Adaptable'
) < 1;

UPDATE questions
SET option1 = 'Cruelty, Harshness',
    option2 = 'Joy, Happiness',
    option3 = 'Smoothness, Flatness',
    option4 = 'Sadness, Gloom'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "melancholy"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Sadness, Gloom';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "melancholy"?', 'synonym', 'Sadness, Gloom', 'Cruelty, Harshness', 'Joy, Happiness', 'Smoothness, Flatness', 'Sadness, Gloom', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "melancholy"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Sadness, Gloom'
) < 1;

UPDATE questions
SET option1 = 'Transform, Change',
    option2 = 'Owe, Keep',
    option3 = 'Praise, Approve',
    option4 = 'Preserve, Keep'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "revolutionise"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Transform, Change';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "revolutionise"?', 'synonym', 'Transform, Change', 'Transform, Change', 'Owe, Keep', 'Praise, Approve', 'Preserve, Keep', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "revolutionise"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Transform, Change'
) < 1;

UPDATE questions
SET option1 = 'Plenty, Abundance',
    option2 = 'Ignore, Overlook',
    option3 = 'Shortage, Lack',
    option4 = 'Examine, Inspect'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "scarcity"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Shortage, Lack';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "scarcity"?', 'synonym', 'Shortage, Lack', 'Plenty, Abundance', 'Ignore, Overlook', 'Shortage, Lack', 'Examine, Inspect', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "scarcity"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Shortage, Lack'
) < 1;

UPDATE questions
SET option1 = 'Dusk, Evening',
    option2 = 'Worsen, Increase',
    option3 = 'Dawn, Morning',
    option4 = 'Plenty, Abundance'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "twilight"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Dusk, Evening';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "twilight"?', 'synonym', 'Dusk, Evening', 'Dusk, Evening', 'Worsen, Increase', 'Dawn, Morning', 'Plenty, Abundance', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "twilight"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Dusk, Evening'
) < 1;

UPDATE questions
SET option1 = 'Limited, Fixed',
    option2 = 'Social, Together',
    option3 = 'Liquid, Solid',
    option4 = 'Steam, Mist'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "vapour"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Steam, Mist';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "vapour"?', 'synonym', 'Steam, Mist', 'Limited, Fixed', 'Social, Together', 'Liquid, Solid', 'Steam, Mist', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "vapour"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Steam, Mist'
) < 1;

UPDATE questions
SET option1 = 'Unhealthy, Bad',
    option2 = 'Healthy, Good',
    option3 = 'Late, Tardy',
    option4 = 'Sadness, Gloom'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "wholesome"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Healthy, Good';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "wholesome"?', 'synonym', 'Healthy, Good', 'Unhealthy, Bad', 'Healthy, Good', 'Late, Tardy', 'Sadness, Gloom', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "wholesome"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Healthy, Good'
) < 1;

UPDATE questions
SET option1 = 'Alone, Single',
    option2 = 'Plenty, Abundance',
    option3 = 'Late, Tardy',
    option4 = 'Social, Together'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "solitary"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Alone, Single';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "solitary"?', 'synonym', 'Alone, Single', 'Alone, Single', 'Plenty, Abundance', 'Late, Tardy', 'Social, Together', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "solitary"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Alone, Single'
) < 1;

UPDATE questions
SET option1 = 'Seal, Mend',
    option2 = 'Late, Tardy',
    option3 = 'Social, Together',
    option4 = 'Prompt, On time'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "punctual"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Prompt, On time';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "punctual"?', 'synonym', 'Prompt, On time', 'Seal, Mend', 'Late, Tardy', 'Social, Together', 'Prompt, On time', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "punctual"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Prompt, On time'
) < 1;

UPDATE questions
SET option1 = 'Worsen, Increase',
    option2 = 'Reduce, Ease',
    option3 = 'Giant, Large',
    option4 = 'Refuse, Deny'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "mitigate"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Reduce, Ease';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "mitigate"?', 'synonym', 'Reduce, Ease', 'Worsen, Increase', 'Reduce, Ease', 'Giant, Large', 'Refuse, Deny', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "mitigate"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Reduce, Ease'
) < 1;

UPDATE questions
SET option1 = 'Disagree, Deny',
    option2 = 'Discuss, Grant',
    option3 = 'Refuse, Deny',
    option4 = 'Agree, Support'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "confer"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Discuss, Grant';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "confer"?', 'synonym', 'Discuss, Grant', 'Disagree, Deny', 'Discuss, Grant', 'Refuse, Deny', 'Agree, Support', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "confer"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Discuss, Grant'
) < 1;

UPDATE questions
SET option1 = 'Doubt, Deny',
    option2 = 'Disagree, Deny',
    option3 = 'Agree, Support',
    option4 = 'Refuse, Deny'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "contradict"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Disagree, Deny';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "contradict"?', 'synonym', 'Disagree, Deny', 'Doubt, Deny', 'Disagree, Deny', 'Agree, Support', 'Refuse, Deny', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "contradict"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Disagree, Deny'
) < 1;

UPDATE questions
SET option1 = 'Disagree, Deny',
    option2 = 'Doubt, Deny',
    option3 = 'Refuse, Deny',
    option4 = 'Promise, Assure'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "guarantee"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Promise, Assure';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "guarantee"?', 'synonym', 'Promise, Assure', 'Disagree, Deny', 'Doubt, Deny', 'Refuse, Deny', 'Promise, Assure', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "guarantee"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Promise, Assure'
) < 1;

UPDATE questions
SET option1 = 'Lucky, Fortunate',
    option2 = 'Unlucky, Unfortunate',
    option3 = 'Late, Tardy',
    option4 = 'Safe, Harmless'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "hapless"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Unlucky, Unfortunate';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "hapless"?', 'synonym', 'Unlucky, Unfortunate', 'Lucky, Fortunate', 'Unlucky, Unfortunate', 'Late, Tardy', 'Safe, Harmless', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "hapless"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Unlucky, Unfortunate'
) < 1;

UPDATE questions
SET option1 = 'Sleeplessness, Restlessness',
    option2 = 'Sleep, Rest',
    option3 = 'Worthless, Useless',
    option4 = 'Polite, Kind'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "insomnia"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Sleeplessness, Restlessness';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "insomnia"?', 'synonym', 'Sleeplessness, Restlessness', 'Sleeplessness, Restlessness', 'Sleep, Rest', 'Worthless, Useless', 'Polite, Kind', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "insomnia"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Sleeplessness, Restlessness'
) < 1;

UPDATE questions
SET option1 = 'Serious, Sad',
    option2 = 'Playful, Humorous',
    option3 = 'Follower, Copycat',
    option4 = 'Strict, Harsh'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "jocular"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Playful, Humorous';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "jocular"?', 'synonym', 'Playful, Humorous', 'Serious, Sad', 'Playful, Humorous', 'Follower, Copycat', 'Strict, Harsh', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "jocular"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Playful, Humorous'
) < 1;

UPDATE questions
SET option1 = 'Agree, Support',
    option2 = 'Strict, Harsh',
    option3 = 'Gentle, Kind',
    option4 = 'Flexible, Easy-going'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "lenient"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Gentle, Kind';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "lenient"?', 'synonym', 'Gentle, Kind', 'Agree, Support', 'Strict, Harsh', 'Gentle, Kind', 'Flexible, Easy-going', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "lenient"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Gentle, Kind'
) < 1;

UPDATE questions
SET option1 = 'Shame, Dishonour',
    option2 = 'Praise, Approve',
    option3 = 'Blame, Criticise',
    option4 = 'Original, Copy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "reproach"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Blame, Criticise';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "reproach"?', 'synonym', 'Blame, Criticise', 'Shame, Dishonour', 'Praise, Approve', 'Blame, Criticise', 'Original, Copy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "reproach"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Blame, Criticise'
) < 1;

UPDATE questions
SET option1 = 'Modern, Plain',
    option2 = 'Satisfy, Extinguish',
    option3 = 'Dry, Ignite',
    option4 = 'Gentle, Kind'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "quench"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Satisfy, Extinguish';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "quench"?', 'synonym', 'Satisfy, Extinguish', 'Modern, Plain', 'Satisfy, Extinguish', 'Dry, Ignite', 'Gentle, Kind', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "quench"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Satisfy, Extinguish'
) < 1;

DROP TABLE seed_quiz_id;

-- Year 5 Vocabulary Synonym Paper 4
INSERT INTO quizzes (title, description, created_by, stage_id, lock_after_attempt)
SELECT 'Year 5 Vocabulary Synonym Paper 4',
       'A 65-question Year 5 vocabulary exam asking students to identify synonym pairs.',
       1,
       (SELECT id FROM stages WHERE name = 'Year 5'),
       1
WHERE NOT EXISTS (SELECT 1 FROM quizzes WHERE title = 'Year 5 Vocabulary Synonym Paper 4');

DROP TABLE IF EXISTS seed_quiz_id;
CREATE TEMP TABLE seed_quiz_id(id INTEGER);
INSERT INTO seed_quiz_id SELECT id FROM quizzes WHERE title = 'Year 5 Vocabulary Synonym Paper 4' LIMIT 1;

UPDATE questions
SET option1 = 'Explorer, Leader',
    option2 = 'Return, Give',
    option3 = 'Steal, Swipe',
    option4 = 'Follower, Copycat'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "pioneer"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Explorer, Leader';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "pioneer"?', 'synonym', 'Explorer, Leader', 'Explorer, Leader', 'Return, Give', 'Steal, Swipe', 'Follower, Copycat', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "pioneer"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Explorer, Leader'
) < 1;

UPDATE questions
SET option1 = 'Flexible, Easy-going',
    option2 = 'Ignoring, Overlooking',
    option3 = 'Modest, Simple',
    option4 = 'Stubborn, Firm'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "obstinate"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Stubborn, Firm';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "obstinate"?', 'synonym', 'Stubborn, Firm', 'Flexible, Easy-going', 'Ignoring, Overlooking', 'Modest, Simple', 'Stubborn, Firm', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "obstinate"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Stubborn, Firm'
) < 1;

UPDATE questions
SET option1 = 'Original, Copy',
    option2 = 'Essential, Required',
    option3 = 'Optional, Extra',
    option4 = 'Fairness, Justice'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "necessary"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Essential, Required';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "necessary"?', 'synonym', 'Essential, Required', 'Original, Copy', 'Essential, Required', 'Optional, Extra', 'Fairness, Justice', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "necessary"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Essential, Required'
) < 1;

UPDATE questions
SET option1 = 'Version, Performance',
    option2 = 'Original, Copy',
    option3 = 'Praise, Approve',
    option4 = 'Shame, Dishonour'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "rendition"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Version, Performance';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "rendition"?', 'synonym', 'Version, Performance', 'Version, Performance', 'Original, Copy', 'Praise, Approve', 'Shame, Dishonour', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "rendition"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Version, Performance'
) < 1;

UPDATE questions
SET option1 = 'Image, Name',
    option2 = 'Shame, Dishonour',
    option3 = 'Version, Performance',
    option4 = 'Original, Copy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "reputation"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Image, Name';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "reputation"?', 'synonym', 'Image, Name', 'Image, Name', 'Shame, Dishonour', 'Version, Performance', 'Original, Copy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "reputation"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Image, Name'
) < 1;

UPDATE questions
SET option1 = 'Bias, Unfairness',
    option2 = 'Ban, Forbid',
    option3 = 'Fairness, Justice',
    option4 = 'Past, Certain'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "prejudice"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Bias, Unfairness';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "prejudice"?', 'synonym', 'Bias, Unfairness', 'Bias, Unfairness', 'Ban, Forbid', 'Fairness, Justice', 'Past, Certain', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "prejudice"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Bias, Unfairness'
) < 1;

UPDATE questions
SET option1 = 'Stubborn, Firm',
    option2 = 'Flexible, Easy-going',
    option3 = 'Flashy, Showy',
    option4 = 'Modest, Simple'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "ostentatious"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Flashy, Showy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "ostentatious"?', 'synonym', 'Flashy, Showy', 'Stubborn, Firm', 'Flexible, Easy-going', 'Flashy, Showy', 'Modest, Simple', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "ostentatious"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Flashy, Showy'
) < 1;

UPDATE questions
SET option1 = 'Safe, Harmless',
    option2 = 'Starvation, Hunger',
    option3 = 'Toxic, Dangerous',
    option4 = 'Shame, Dishonour'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "noxious"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Toxic, Dangerous';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "noxious"?', 'synonym', 'Toxic, Dangerous', 'Safe, Harmless', 'Starvation, Hunger', 'Toxic, Dangerous', 'Shame, Dishonour', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "noxious"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Toxic, Dangerous'
) < 1;

UPDATE questions
SET option1 = 'Past, Certain',
    option2 = 'Fairness, Justice',
    option3 = 'Future, Possible',
    option4 = 'Allow, Permit'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "prospective"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Future, Possible';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "prospective"?', 'synonym', 'Future, Possible', 'Past, Certain', 'Fairness, Justice', 'Future, Possible', 'Allow, Permit', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "prospective"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Future, Possible'
) < 1;

UPDATE questions
SET option1 = 'Follower, Copycat',
    option2 = 'Return, Give',
    option3 = 'Steal, Swipe',
    option4 = 'Lose, Give'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "pilfer"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Steal, Swipe';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "pilfer"?', 'synonym', 'Steal, Swipe', 'Follower, Copycat', 'Return, Give', 'Steal, Swipe', 'Lose, Give', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "pilfer"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Steal, Swipe'
) < 1;

UPDATE questions
SET option1 = 'Ban, Forbid',
    option2 = 'Hidden, Unknown',
    option3 = 'Obtain, Get',
    option4 = 'Allow, Permit'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "prohibit"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Ban, Forbid';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "prohibit"?', 'synonym', 'Ban, Forbid', 'Ban, Forbid', 'Hidden, Unknown', 'Obtain, Get', 'Allow, Permit', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "prohibit"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Ban, Forbid'
) < 1;

UPDATE questions
SET option1 = 'Repay, Refund',
    option2 = 'Owe, Keep',
    option3 = 'Settle, Fix',
    option4 = 'Fight, Argue'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "reconcile"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Settle, Fix';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "reconcile"?', 'synonym', 'Settle, Fix', 'Repay, Refund', 'Owe, Keep', 'Settle, Fix', 'Fight, Argue', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "reconcile"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Settle, Fix'
) < 1;

UPDATE questions
SET option1 = 'Victory, Win',
    option2 = 'Grow, Improve',
    option3 = 'Freeze, Stop',
    option4 = 'Deadlock, Tie'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "stalemate"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Deadlock, Tie';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "stalemate"?', 'synonym', 'Deadlock, Tie', 'Victory, Win', 'Grow, Improve', 'Freeze, Stop', 'Deadlock, Tie', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "stalemate"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Deadlock, Tie'
) < 1;

UPDATE questions
SET option1 = 'Owe, Keep',
    option2 = 'Lose, Give',
    option3 = 'Detest, Hate',
    option4 = 'Love, Like'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "loathe"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Detest, Hate';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "loathe"?', 'synonym', 'Detest, Hate', 'Owe, Keep', 'Lose, Give', 'Detest, Hate', 'Love, Like', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "loathe"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Detest, Hate'
) < 1;

UPDATE questions
SET option1 = 'Hidden, Unknown',
    option2 = 'Allow, Permit',
    option3 = 'Lose, Give',
    option4 = 'Noticeable, Famous'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "prominent"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Noticeable, Famous';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "prominent"?', 'synonym', 'Noticeable, Famous', 'Hidden, Unknown', 'Allow, Permit', 'Lose, Give', 'Noticeable, Famous', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "prominent"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Noticeable, Famous'
) < 1;

UPDATE questions
SET option1 = 'Ban, Forbid',
    option2 = 'Disadvantage, Loss',
    option3 = 'Lose, Give',
    option4 = 'Obtain, Get'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "procure"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Obtain, Get';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "procure"?', 'synonym', 'Obtain, Get', 'Ban, Forbid', 'Disadvantage, Loss', 'Lose, Give', 'Obtain, Get', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "procure"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Obtain, Get'
) < 1;

UPDATE questions
SET option1 = 'Preserve, Keep',
    option2 = 'Owe, Keep',
    option3 = 'Fight, Argue',
    option4 = 'Repay, Refund'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "reimburse"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Repay, Refund';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "reimburse"?', 'synonym', 'Repay, Refund', 'Preserve, Keep', 'Owe, Keep', 'Fight, Argue', 'Repay, Refund', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "reimburse"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Repay, Refund'
) < 1;

UPDATE questions
SET option1 = 'Lose, Give',
    option2 = 'Old, Outdated',
    option3 = 'Hold, Stop',
    option4 = 'Release, Free'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "detain"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Hold, Stop';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "detain"?', 'synonym', 'Hold, Stop', 'Lose, Give', 'Old, Outdated', 'Hold, Stop', 'Release, Free', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "detain"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Hold, Stop'
) < 1;

UPDATE questions
SET option1 = 'Failure, Loss',
    option2 = 'Owe, Keep',
    option3 = 'Bore, Dull',
    option4 = 'Fascinate, Impress'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "mesmerise"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Fascinate, Impress';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "mesmerise"?', 'synonym', 'Fascinate, Impress', 'Failure, Loss', 'Owe, Keep', 'Bore, Dull', 'Fascinate, Impress', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "mesmerise"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Fascinate, Impress'
) < 1;

UPDATE questions
SET option1 = 'Food, Nutrition',
    option2 = 'Toxic, Dangerous',
    option3 = 'Safe, Harmless',
    option4 = 'Starvation, Hunger'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "nourishment"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Food, Nutrition';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "nourishment"?', 'synonym', 'Food, Nutrition', 'Food, Nutrition', 'Toxic, Dangerous', 'Safe, Harmless', 'Starvation, Hunger', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "nourishment"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Food, Nutrition'
) < 1;

UPDATE questions
SET option1 = 'Modern, Plain',
    option2 = 'Hold, Stop',
    option3 = 'Old, Outdated',
    option4 = 'Modern, New'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "obsolete"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Old, Outdated';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "obsolete"?', 'synonym', 'Old, Outdated', 'Modern, Plain', 'Hold, Stop', 'Old, Outdated', 'Modern, New', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "obsolete"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Old, Outdated'
) < 1;

UPDATE questions
SET option1 = 'Lose, Give',
    option2 = 'Failure, Loss',
    option3 = 'Benefit, Honour',
    option4 = 'Disadvantage, Loss'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "privilege"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Benefit, Honour';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "privilege"?', 'synonym', 'Benefit, Honour', 'Lose, Give', 'Failure, Loss', 'Benefit, Honour', 'Disadvantage, Loss', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "privilege"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Benefit, Honour'
) < 1;

UPDATE questions
SET option1 = 'Charming, Cute',
    option2 = 'Modern, New',
    option3 = 'Modern, Plain',
    option4 = 'Plain speech, Simplicity'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "quaint"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Charming, Cute';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "quaint"?', 'synonym', 'Charming, Cute', 'Charming, Cute', 'Modern, New', 'Modern, Plain', 'Plain speech, Simplicity', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "quaint"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Charming, Cute'
) < 1;

UPDATE questions
SET option1 = 'Smallness, Weakness',
    option2 = 'Achievement, Event',
    option3 = 'Failure, Loss',
    option4 = 'Disadvantage, Loss'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "milestone"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Achievement, Event';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "milestone"?', 'synonym', 'Achievement, Event', 'Smallness, Weakness', 'Achievement, Event', 'Failure, Loss', 'Disadvantage, Loss', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "milestone"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Achievement, Event'
) < 1;

UPDATE questions
SET option1 = 'Active, Obvious',
    option2 = 'Terms, Language',
    option3 = 'Plain speech, Simplicity',
    option4 = 'Modern, Plain'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "jargon"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Terms, Language';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "jargon"?', 'synonym', 'Terms, Language', 'Active, Obvious', 'Terms, Language', 'Plain speech, Simplicity', 'Modern, Plain', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "jargon"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Terms, Language'
) < 1;

UPDATE questions
SET option1 = 'Rude, Cheeky',
    option2 = 'Polite, Kind',
    option3 = 'Worthless, Useless',
    option4 = 'Priceless, Vital'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "invaluable"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Priceless, Vital';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "invaluable"?', 'synonym', 'Priceless, Vital', 'Rude, Cheeky', 'Polite, Kind', 'Worthless, Useless', 'Priceless, Vital', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "invaluable"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Priceless, Vital'
) < 1;

UPDATE questions
SET option1 = 'Peaceful, Balanced',
    option2 = 'Benefit, Honour',
    option3 = 'Noisy, Chaotic',
    option4 = 'Active, Obvious'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "harmonious"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Peaceful, Balanced';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "harmonious"?', 'synonym', 'Peaceful, Balanced', 'Peaceful, Balanced', 'Benefit, Honour', 'Noisy, Chaotic', 'Active, Obvious', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "harmonious"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Peaceful, Balanced'
) < 1;

UPDATE questions
SET option1 = 'Thanks, Appreciation',
    option2 = 'Weird, Ugly',
    option3 = 'Ungratefulness, Rudeness',
    option4 = 'Beautiful, Pretty'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "gratitude"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Thanks, Appreciation';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "gratitude"?', 'synonym', 'Thanks, Appreciation', 'Thanks, Appreciation', 'Weird, Ugly', 'Ungratefulness, Rudeness', 'Beautiful, Pretty', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "gratitude"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Thanks, Appreciation'
) < 1;

UPDATE questions
SET option1 = 'Size, Strength',
    option2 = 'Safe, Kind',
    option3 = 'Smallness, Weakness',
    option4 = 'Deadly, Bad'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "magnitude"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Size, Strength';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "magnitude"?', 'synonym', 'Size, Strength', 'Size, Strength', 'Safe, Kind', 'Smallness, Weakness', 'Deadly, Bad', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "magnitude"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Size, Strength'
) < 1;

UPDATE questions
SET option1 = 'Hidden, Unknown',
    option2 = 'Active, Obvious',
    option3 = 'Hidden, Dormant',
    option4 = 'Noisy, Chaotic'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "latent"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Hidden, Dormant';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "latent"?', 'synonym', 'Hidden, Dormant', 'Hidden, Unknown', 'Active, Obvious', 'Hidden, Dormant', 'Noisy, Chaotic', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "latent"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Hidden, Dormant'
) < 1;

UPDATE questions
SET option1 = 'Polite, Kind',
    option2 = 'Worthless, Useless',
    option3 = 'Ignorance, Confusion',
    option4 = 'Rude, Cheeky'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "insolent"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Rude, Cheeky';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "insolent"?', 'synonym', 'Rude, Cheeky', 'Polite, Kind', 'Worthless, Useless', 'Ignorance, Confusion', 'Rude, Cheeky', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "insolent"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Rude, Cheeky'
) < 1;

UPDATE questions
SET option1 = 'Rude, Cheeky',
    option2 = 'Polite, Kind',
    option3 = 'Hint, Clue',
    option4 = 'Ignorance, Confusion'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "inkling"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Hint, Clue';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "inkling"?', 'synonym', 'Hint, Clue', 'Rude, Cheeky', 'Polite, Kind', 'Hint, Clue', 'Ignorance, Confusion', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "inkling"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Hint, Clue'
) < 1;

UPDATE questions
SET option1 = 'Thanks, Appreciation',
    option2 = 'Weird, Ugly',
    option3 = 'Ungratefulness, Rudeness',
    option4 = 'Beautiful, Pretty'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "grotesque"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Weird, Ugly';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "grotesque"?', 'synonym', 'Weird, Ugly', 'Thanks, Appreciation', 'Weird, Ugly', 'Ungratefulness, Rudeness', 'Beautiful, Pretty', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "grotesque"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Weird, Ugly'
) < 1;

UPDATE questions
SET option1 = 'Simple, Plain',
    option2 = 'Advanced, Smart',
    option3 = 'Simple, Basic',
    option4 = 'Refined, Stylish'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "sophisticated"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Advanced, Smart';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "sophisticated"?', 'synonym', 'Advanced, Smart', 'Simple, Plain', 'Advanced, Smart', 'Simple, Basic', 'Refined, Stylish', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "sophisticated"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Advanced, Smart'
) < 1;

UPDATE questions
SET option1 = 'Holy, Precious',
    option2 = 'Ordinary, Common',
    option3 = 'Long, Wordy',
    option4 = 'Separate, Different'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "sacred"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Holy, Precious';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "sacred"?', 'synonym', 'Holy, Precious', 'Holy, Precious', 'Ordinary, Common', 'Long, Wordy', 'Separate, Different', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "sacred"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Holy, Precious'
) < 1;

UPDATE questions
SET option1 = 'Help, Allow',
    option2 = 'Tricked, Fooled',
    option3 = 'Simple, Basic',
    option4 = 'Helped, Paid'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "swindled"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Tricked, Fooled';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "swindled"?', 'synonym', 'Tricked, Fooled', 'Help, Allow', 'Tricked, Fooled', 'Simple, Basic', 'Helped, Paid', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "swindled"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Tricked, Fooled'
) < 1;

UPDATE questions
SET option1 = 'Brief, Concise',
    option2 = 'Continue, Begin',
    option3 = 'Long, Wordy',
    option4 = 'Ordinary, Common'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "succinct"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Brief, Concise';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "succinct"?', 'synonym', 'Brief, Concise', 'Brief, Concise', 'Continue, Begin', 'Long, Wordy', 'Ordinary, Common', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "succinct"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Brief, Concise'
) < 1;

UPDATE questions
SET option1 = 'Help, Allow',
    option2 = 'Block, Prevent',
    option3 = 'Helped, Paid',
    option4 = 'Refuse, Reject'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "thwart"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Block, Prevent';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "thwart"?', 'synonym', 'Block, Prevent', 'Help, Allow', 'Block, Prevent', 'Helped, Paid', 'Refuse, Reject', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "thwart"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Block, Prevent'
) < 1;

UPDATE questions
SET option1 = 'Separate, Different',
    option2 = 'Together, Same-time',
    option3 = 'Ordinary, Common',
    option4 = 'Grow, Improve'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "simultaneous"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Together, Same-time';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "simultaneous"?', 'synonym', 'Together, Same-time', 'Separate, Different', 'Together, Same-time', 'Ordinary, Common', 'Grow, Improve', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "simultaneous"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Together, Same-time'
) < 1;

UPDATE questions
SET option1 = 'Tiny, Weak',
    option2 = 'Grow, Improve',
    option3 = 'Ordinary, Common',
    option4 = 'Big, Solid'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "substantial"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Big, Solid';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "substantial"?', 'synonym', 'Big, Solid', 'Tiny, Weak', 'Grow, Improve', 'Ordinary, Common', 'Big, Solid', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "substantial"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Big, Solid'
) < 1;

UPDATE questions
SET option1 = 'Pause, Stop',
    option2 = 'Freeze, Stop',
    option3 = 'Grow, Improve',
    option4 = 'Separate, Different'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "stagnate"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Freeze, Stop';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "stagnate"?', 'synonym', 'Freeze, Stop', 'Pause, Stop', 'Freeze, Stop', 'Grow, Improve', 'Separate, Different', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "stagnate"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Freeze, Stop'
) < 1;

UPDATE questions
SET option1 = 'Size, Strength',
    option2 = 'Safe, Kind',
    option3 = 'Deadly, Bad',
    option4 = 'Smallness, Weakness'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "malignant"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Deadly, Bad';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "malignant"?', 'synonym', 'Deadly, Bad', 'Size, Strength', 'Safe, Kind', 'Deadly, Bad', 'Smallness, Weakness', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "malignant"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Deadly, Bad'
) < 1;

UPDATE questions
SET option1 = 'Refuse, Reject',
    option2 = 'Plead, Beg',
    option3 = 'Expand, Grow',
    option4 = 'Collapse, Break'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "implore"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Plead, Beg';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "implore"?', 'synonym', 'Plead, Beg', 'Refuse, Reject', 'Plead, Beg', 'Expand, Grow', 'Collapse, Break', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "implore"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Plead, Beg'
) < 1;

UPDATE questions
SET option1 = 'Booming, Loud',
    option2 = 'Blowing, Roaring',
    option3 = 'Calm, Still',
    option4 = 'Quiet, Soft'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "blasting"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Booming, Loud';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "blasting"?', 'synonym', 'Booming, Loud', 'Booming, Loud', 'Blowing, Roaring', 'Calm, Still', 'Quiet, Soft', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "blasting"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Booming, Loud'
) < 1;

UPDATE questions
SET option1 = 'Quiet, Soft',
    option2 = 'Blowing, Roaring',
    option3 = 'Booming, Loud',
    option4 = 'Calm, Still'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "gusting"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Blowing, Roaring';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "gusting"?', 'synonym', 'Blowing, Roaring', 'Quiet, Soft', 'Blowing, Roaring', 'Booming, Loud', 'Calm, Still', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "gusting"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Blowing, Roaring'
) < 1;

UPDATE questions
SET option1 = 'Pause, Stop',
    option2 = 'Continue, Begin',
    option3 = 'Keep, Continue',
    option4 = 'Freeze, Stop'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "suspend"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Pause, Stop';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "suspend"?', 'synonym', 'Pause, Stop', 'Pause, Stop', 'Continue, Begin', 'Keep, Continue', 'Freeze, Stop', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "suspend"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Pause, Stop'
) < 1;

UPDATE questions
SET option1 = 'Certainly, Definitely',
    option2 = 'Supposedly, Reportedly',
    option3 = 'Friendly, Warm',
    option4 = 'Cold, Distant'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "aloof"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Cold, Distant';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "aloof"?', 'synonym', 'Cold, Distant', 'Certainly, Definitely', 'Supposedly, Reportedly', 'Friendly, Warm', 'Cold, Distant', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "aloof"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Cold, Distant'
) < 1;

UPDATE questions
SET option1 = 'Cold, Distant',
    option2 = 'Friendly, Warm',
    option3 = 'Supposedly, Reportedly',
    option4 = 'Certainly, Definitely'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "allegedly"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Supposedly, Reportedly';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "allegedly"?', 'synonym', 'Supposedly, Reportedly', 'Cold, Distant', 'Friendly, Warm', 'Supposedly, Reportedly', 'Certainly, Definitely', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "allegedly"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Supposedly, Reportedly'
) < 1;

UPDATE questions
SET option1 = 'Near, Soon',
    option2 = 'Unknown, Minor',
    option3 = 'Famous, Noted',
    option4 = 'Distant, Far'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "eminent"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Famous, Noted';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "eminent"?', 'synonym', 'Famous, Noted', 'Near, Soon', 'Unknown, Minor', 'Famous, Noted', 'Distant, Far', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "eminent"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Famous, Noted'
) < 1;

UPDATE questions
SET option1 = 'Near, Soon',
    option2 = 'Cold, Distant',
    option3 = 'Unknown, Minor',
    option4 = 'Distant, Far'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "imminent"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Near, Soon';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "imminent"?', 'synonym', 'Near, Soon', 'Near, Soon', 'Cold, Distant', 'Unknown, Minor', 'Distant, Far', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "imminent"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Near, Soon'
) < 1;

UPDATE questions
SET option1 = 'Clear, Separate',
    option2 = 'Dull, Faded',
    option3 = 'Bright, Clear',
    option4 = 'Safe, Strong'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "vivid"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Bright, Clear';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "vivid"?', 'synonym', 'Bright, Clear', 'Clear, Separate', 'Dull, Faded', 'Bright, Clear', 'Safe, Strong', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "vivid"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Bright, Clear'
) < 1;

UPDATE questions
SET option1 = 'Worst, Least',
    option2 = 'Best, Main',
    option3 = 'Unknown, Minor',
    option4 = 'Main, Head'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "prime"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Best, Main';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "prime"?', 'synonym', 'Best, Main', 'Worst, Least', 'Best, Main', 'Unknown, Minor', 'Main, Head', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "prime"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Best, Main'
) < 1;

UPDATE questions
SET option1 = 'Energy, Motion',
    option2 = 'Set up, Fit',
    option3 = 'Laziness, Stillness',
    option4 = 'Remove, Take'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "inertia"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Laziness, Stillness';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "inertia"?', 'synonym', 'Laziness, Stillness', 'Energy, Motion', 'Set up, Fit', 'Laziness, Stillness', 'Remove, Take', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "inertia"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Laziness, Stillness'
) < 1;

UPDATE questions
SET option1 = 'Abuse, Use',
    option2 = 'Protect, Help',
    option3 = 'Shrink, Deflate',
    option4 = 'Burst, Blast'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "exploit"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Abuse, Use';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "exploit"?', 'synonym', 'Abuse, Use', 'Abuse, Use', 'Protect, Help', 'Shrink, Deflate', 'Burst, Blast', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "exploit"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Abuse, Use'
) < 1;

UPDATE questions
SET option1 = 'Kept, Saved',
    option2 = 'Worst, Least',
    option3 = 'Lost, Gave',
    option4 = 'Safe, Strong'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "retained"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Kept, Saved';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "retained"?', 'synonym', 'Kept, Saved', 'Kept, Saved', 'Worst, Least', 'Lost, Gave', 'Safe, Strong', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "retained"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Kept, Saved'
) < 1;

UPDATE questions
SET option1 = 'Weak, Exposed',
    option2 = 'Shrink, Deflate',
    option3 = 'Safe, Kind',
    option4 = 'Safe, Strong'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "vulnerable"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Weak, Exposed';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "vulnerable"?', 'synonym', 'Weak, Exposed', 'Weak, Exposed', 'Shrink, Deflate', 'Safe, Kind', 'Safe, Strong', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "vulnerable"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Weak, Exposed'
) < 1;

UPDATE questions
SET option1 = 'Energy, Motion',
    option2 = 'Remove, Take',
    option3 = 'Set up, Fit',
    option4 = 'Laziness, Stillness'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "install"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Set up, Fit';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "install"?', 'synonym', 'Set up, Fit', 'Energy, Motion', 'Remove, Take', 'Set up, Fit', 'Laziness, Stillness', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "install"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Set up, Fit'
) < 1;

UPDATE questions
SET option1 = 'Continued, Moved',
    option2 = 'Stuck, Halted',
    option3 = 'Grow, Improve',
    option4 = 'Continue, Begin'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "stalled"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Stuck, Halted';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "stalled"?', 'synonym', 'Stuck, Halted', 'Continued, Moved', 'Stuck, Halted', 'Grow, Improve', 'Continue, Begin', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "stalled"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Stuck, Halted'
) < 1;

UPDATE questions
SET option1 = 'Collapse, Break',
    option2 = 'Expand, Grow',
    option3 = 'Plead, Beg',
    option4 = 'Refuse, Reject'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "implode"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Collapse, Break';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "implode"?', 'synonym', 'Collapse, Break', 'Collapse, Break', 'Expand, Grow', 'Plead, Beg', 'Refuse, Reject', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "implode"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Collapse, Break'
) < 1;

UPDATE questions
SET option1 = 'Burst, Blast',
    option2 = 'Abuse, Use',
    option3 = 'Protect, Help',
    option4 = 'Shrink, Deflate'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "explode"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Burst, Blast';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "explode"?', 'synonym', 'Burst, Blast', 'Burst, Blast', 'Abuse, Use', 'Protect, Help', 'Shrink, Deflate', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "explode"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Burst, Blast'
) < 1;

UPDATE questions
SET option1 = 'Hide, Conceal',
    option2 = 'Admit, Own',
    option3 = 'Refuse, Deny',
    option4 = 'Deny, Hide'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "confess"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Admit, Own';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "confess"?', 'synonym', 'Admit, Own', 'Hide, Conceal', 'Admit, Own', 'Refuse, Deny', 'Deny, Hide', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "confess"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Admit, Own'
) < 1;

UPDATE questions
SET option1 = 'Remove, Take',
    option2 = 'Set up, Fit',
    option3 = 'Curious, Interested',
    option4 = 'Uninterested, Bored'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "inquisitive"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Curious, Interested';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "inquisitive"?', 'synonym', 'Curious, Interested', 'Remove, Take', 'Set up, Fit', 'Curious, Interested', 'Uninterested, Bored', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "inquisitive"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Curious, Interested'
) < 1;

UPDATE questions
SET option1 = 'Coldness, Indifference',
    option2 = 'Clear, Separate',
    option3 = 'Bright, Clear',
    option4 = 'Similar, Same'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "distinct"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Clear, Separate';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "distinct"?', 'synonym', 'Clear, Separate', 'Coldness, Indifference', 'Clear, Separate', 'Bright, Clear', 'Similar, Same', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "distinct"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Clear, Separate'
) < 1;

UPDATE questions
SET option1 = 'Deny, Hide',
    option2 = 'Feeling, Thought',
    option3 = 'Coldness, Indifference',
    option4 = 'Admit, Own'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "sentiment"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Feeling, Thought';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "sentiment"?', 'synonym', 'Feeling, Thought', 'Deny, Hide', 'Feeling, Thought', 'Coldness, Indifference', 'Admit, Own', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "sentiment"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Feeling, Thought'
) < 1;

UPDATE questions
SET option1 = 'Deny, Hide',
    option2 = 'Energy, Motion',
    option3 = 'Tiredness, Weariness',
    option4 = 'Energy, Strength'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "fatigue"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Tiredness, Weariness';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "fatigue"?', 'synonym', 'Tiredness, Weariness', 'Deny, Hide', 'Energy, Motion', 'Tiredness, Weariness', 'Energy, Strength', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "fatigue"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Tiredness, Weariness'
) < 1;

DROP TABLE seed_quiz_id;

-- Year 5 Vocabulary Antonym Paper 1
INSERT INTO quizzes (title, description, created_by, stage_id, lock_after_attempt)
SELECT 'Year 5 Vocabulary Antonym Paper 1',
       'A 100-question Year 5 vocabulary exam asking students to identify antonym pairs.',
       1,
       (SELECT id FROM stages WHERE name = 'Year 5'),
       1
WHERE NOT EXISTS (SELECT 1 FROM quizzes WHERE title = 'Year 5 Vocabulary Antonym Paper 1');

DROP TABLE IF EXISTS seed_quiz_id;
CREATE TEMP TABLE seed_quiz_id(id INTEGER);
INSERT INTO seed_quiz_id SELECT id FROM quizzes WHERE title = 'Year 5 Vocabulary Antonym Paper 1' LIMIT 1;

UPDATE questions
SET option1 = 'Kill, Destroy',
    option2 = 'Brave, Fearless',
    option3 = 'Invent, Fake',
    option4 = 'Destroy, Reveal'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "fabricate"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Destroy, Reveal';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "fabricate"?', 'antonym', 'Destroy, Reveal', 'Kill, Destroy', 'Brave, Fearless', 'Invent, Fake', 'Destroy, Reveal', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "fabricate"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Destroy, Reveal'
) < 1;

UPDATE questions
SET option1 = 'Firm, Stubborn',
    option2 = 'Steady, Firm',
    option3 = 'Flexible, Weak',
    option4 = 'Shaky, Weak'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "unwavering"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Shaky, Weak';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "unwavering"?', 'antonym', 'Shaky, Weak', 'Firm, Stubborn', 'Steady, Firm', 'Flexible, Weak', 'Shaky, Weak', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "unwavering"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Shaky, Weak'
) < 1;

UPDATE questions
SET option1 = 'Brave, Fearless',
    option2 = 'Clear, Simple',
    option3 = 'Incomprehensible, Mysterious',
    option4 = 'Unique, Extraordinary'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "unfathomable"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Clear, Simple';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "unfathomable"?', 'antonym', 'Clear, Simple', 'Brave, Fearless', 'Clear, Simple', 'Incomprehensible, Mysterious', 'Unique, Extraordinary', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "unfathomable"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Clear, Simple'
) < 1;

UPDATE questions
SET option1 = 'Flexible, Weak',
    option2 = 'Firm, Stubborn',
    option3 = 'Shaky, Weak',
    option4 = 'Steady, Firm'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "unyielding"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Flexible, Weak';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "unyielding"?', 'antonym', 'Flexible, Weak', 'Flexible, Weak', 'Firm, Stubborn', 'Shaky, Weak', 'Steady, Firm', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "unyielding"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Flexible, Weak'
) < 1;

UPDATE questions
SET option1 = 'Firm, Stubborn',
    option2 = 'Incomprehensible, Mysterious',
    option3 = 'Ordinary, Usual',
    option4 = 'Unique, Extraordinary'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "unprecedented"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Ordinary, Usual';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "unprecedented"?', 'antonym', 'Ordinary, Usual', 'Firm, Stubborn', 'Incomprehensible, Mysterious', 'Ordinary, Usual', 'Unique, Extraordinary', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "unprecedented"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Ordinary, Usual'
) < 1;

UPDATE questions
SET option1 = 'Afraid, Timid',
    option2 = 'Brave, Fearless',
    option3 = 'Firm, Stubborn',
    option4 = 'Steady, Firm'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "unflinching"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Afraid, Timid';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "unflinching"?', 'antonym', 'Afraid, Timid', 'Afraid, Timid', 'Brave, Fearless', 'Firm, Stubborn', 'Steady, Firm', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "unflinching"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Afraid, Timid'
) < 1;

UPDATE questions
SET option1 = 'Restore, Resurrect',
    option2 = 'Kill, Destroy',
    option3 = 'Reignite, Restart',
    option4 = 'Refill, Restore'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "revive"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Kill, Destroy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "revive"?', 'antonym', 'Kill, Destroy', 'Restore, Resurrect', 'Kill, Destroy', 'Reignite, Restart', 'Refill, Restore', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "revive"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Kill, Destroy'
) < 1;

UPDATE questions
SET option1 = 'Repeat, Restate',
    option2 = 'Refill, Restore',
    option3 = 'Age, Weaken',
    option4 = 'Refresh, Renew'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "rejuvenate"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Age, Weaken';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "rejuvenate"?', 'antonym', 'Age, Weaken', 'Repeat, Restate', 'Refill, Restore', 'Age, Weaken', 'Refresh, Renew', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "rejuvenate"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Age, Weaken'
) < 1;

UPDATE questions
SET option1 = 'Refill, Restore',
    option2 = 'Reignite, Restart',
    option3 = 'Forget, Ignore',
    option4 = 'Repeat, Restate'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "reiterate"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Forget, Ignore';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "reiterate"?', 'antonym', 'Forget, Ignore', 'Refill, Restore', 'Reignite, Restart', 'Forget, Ignore', 'Repeat, Restate', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "reiterate"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Forget, Ignore'
) < 1;

UPDATE questions
SET option1 = 'Repeat, Restate',
    option2 = 'Reignite, Restart',
    option3 = 'Extinguish, End',
    option4 = 'Restore, Resurrect'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "rekindle"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Extinguish, End';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "rekindle"?', 'antonym', 'Extinguish, End', 'Repeat, Restate', 'Reignite, Restart', 'Extinguish, End', 'Restore, Resurrect', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "rekindle"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Extinguish, End'
) < 1;

UPDATE questions
SET option1 = 'Repeat, Restate',
    option2 = 'Refill, Restore',
    option3 = 'Restore, Resurrect',
    option4 = 'Empty, Drain'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "replenish"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Empty, Drain';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "replenish"?', 'antonym', 'Empty, Drain', 'Repeat, Restate', 'Refill, Restore', 'Restore, Resurrect', 'Empty, Drain', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "replenish"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Empty, Drain'
) < 1;

UPDATE questions
SET option1 = 'Impassable, Unbreakable',
    option2 = 'Respectful',
    option3 = 'Rude, Insolent',
    option4 = 'Passable, Open'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "impertinent"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Respectful';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "impertinent"?', 'antonym', 'Respectful', 'Impassable, Unbreakable', 'Respectful', 'Rude, Insolent', 'Passable, Open', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "impertinent"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Respectful'
) < 1;

UPDATE questions
SET option1 = 'Repeat, Restate',
    option2 = 'Legal, Legitimate',
    option3 = 'Unlawful, Invalid',
    option4 = 'Unthinkable, Unimaginable'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "illegitimate"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Legal, Legitimate';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "illegitimate"?', 'antonym', 'Legal, Legitimate', 'Repeat, Restate', 'Legal, Legitimate', 'Unlawful, Invalid', 'Unthinkable, Unimaginable', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "illegitimate"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Legal, Legitimate'
) < 1;

UPDATE questions
SET option1 = 'Reignite, Restart',
    option2 = 'Certain, Definite',
    option3 = 'Doubtful, Uncertain',
    option4 = 'Rude, Insolent'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "irrefutable"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Doubtful, Uncertain';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "irrefutable"?', 'antonym', 'Doubtful, Uncertain', 'Reignite, Restart', 'Certain, Definite', 'Doubtful, Uncertain', 'Rude, Insolent', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "irrefutable"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Doubtful, Uncertain'
) < 1;

UPDATE questions
SET option1 = 'Respectful',
    option2 = 'Passable, Open',
    option3 = 'Rude, Insolent',
    option4 = 'Impassable, Unbreakable'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "impenetrable"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Passable, Open';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "impenetrable"?', 'antonym', 'Passable, Open', 'Respectful', 'Passable, Open', 'Rude, Insolent', 'Impassable, Unbreakable', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "impenetrable"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Passable, Open'
) < 1;

UPDATE questions
SET option1 = 'Thinkable, Likely',
    option2 = 'Impassable, Unbreakable',
    option3 = 'Certain, Definite',
    option4 = 'Unthinkable, Unimaginable'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "inconceivable"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Thinkable, Likely';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "inconceivable"?', 'antonym', 'Thinkable, Likely', 'Thinkable, Likely', 'Impassable, Unbreakable', 'Certain, Definite', 'Unthinkable, Unimaginable', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "inconceivable"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Thinkable, Likely'
) < 1;

UPDATE questions
SET option1 = 'Discourage, Depress',
    option2 = 'Confuse, Bewilder',
    option3 = 'Warn, Discourage',
    option4 = 'Guide, Clarify'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "disorient"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Guide, Clarify';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "disorient"?', 'antonym', 'Guide, Clarify', 'Discourage, Depress', 'Confuse, Bewilder', 'Warn, Discourage', 'Guide, Clarify', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "disorient"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Guide, Clarify'
) < 1;

UPDATE questions
SET option1 = 'Persuade, Encourage',
    option2 = 'Discourage, Depress',
    option3 = 'Warn, Discourage',
    option4 = 'Encourage, Cheer'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "dishearten"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Encourage, Cheer';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "dishearten"?', 'antonym', 'Encourage, Cheer', 'Persuade, Encourage', 'Discourage, Depress', 'Warn, Discourage', 'Encourage, Cheer', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "dishearten"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Encourage, Cheer'
) < 1;

UPDATE questions
SET option1 = 'Ignore, Neglect',
    option2 = 'Confuse, Bewilder',
    option3 = 'Notice, Respect',
    option4 = 'Discourage, Depress'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "disregard"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Notice, Respect';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "disregard"?', 'antonym', 'Notice, Respect', 'Ignore, Neglect', 'Confuse, Bewilder', 'Notice, Respect', 'Discourage, Depress', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "disregard"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Notice, Respect'
) < 1;

UPDATE questions
SET option1 = 'Confuse, Bewilder',
    option2 = 'Scatter, Eliminate',
    option3 = 'Gather, Keep',
    option4 = 'Warn, Discourage'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "dispel"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Gather, Keep';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "dispel"?', 'antonym', 'Gather, Keep', 'Confuse, Bewilder', 'Scatter, Eliminate', 'Gather, Keep', 'Warn, Discourage', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "dispel"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Gather, Keep'
) < 1;

UPDATE questions
SET option1 = 'Encourage, Cheer',
    option2 = 'Warn, Discourage',
    option3 = 'Persuade, Encourage',
    option4 = 'Discourage, Depress'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "dissuade"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Persuade, Encourage';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "dissuade"?', 'antonym', 'Persuade, Encourage', 'Encourage, Cheer', 'Warn, Discourage', 'Persuade, Encourage', 'Discourage, Depress', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "dissuade"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Persuade, Encourage'
) < 1;

UPDATE questions
SET option1 = 'Strengthen, Enable',
    option2 = 'Plain, Simplify',
    option3 = 'Decorate, Adorn',
    option4 = 'Weaken, Discourage'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "embellish"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Plain, Simplify';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "embellish"?', 'antonym', 'Plain, Simplify', 'Strengthen, Enable', 'Plain, Simplify', 'Decorate, Adorn', 'Weaken, Discourage', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "embellish"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Plain, Simplify'
) < 1;

UPDATE questions
SET option1 = 'Persist, Survive',
    option2 = 'Involve, Include',
    option3 = 'Quit, Give up',
    option4 = 'Teach, Inform'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "endure"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Quit, Give up';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "endure"?', 'antonym', 'Quit, Give up', 'Persist, Survive', 'Involve, Include', 'Quit, Give up', 'Teach, Inform', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "endure"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Quit, Give up'
) < 1;

UPDATE questions
SET option1 = 'Confuse, Mislead',
    option2 = 'Involve, Include',
    option3 = 'Teach, Inform',
    option4 = 'Persist, Survive'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "enlighten"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Confuse, Mislead';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "enlighten"?', 'antonym', 'Confuse, Mislead', 'Confuse, Mislead', 'Involve, Include', 'Teach, Inform', 'Persist, Survive', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "enlighten"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Confuse, Mislead'
) < 1;

UPDATE questions
SET option1 = 'Weaken, Discourage',
    option2 = 'Warn, Discourage',
    option3 = 'Decorate, Adorn',
    option4 = 'Strengthen, Enable'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "empower"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Weaken, Discourage';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "empower"?', 'antonym', 'Weaken, Discourage', 'Weaken, Discourage', 'Warn, Discourage', 'Decorate, Adorn', 'Strengthen, Enable', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "empower"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Weaken, Discourage'
) < 1;

UPDATE questions
SET option1 = 'Persist, Survive',
    option2 = 'Involve, Include',
    option3 = 'Exclude, Avoid',
    option4 = 'Teach, Inform'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "entail"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Exclude, Avoid';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "entail"?', 'antonym', 'Exclude, Avoid', 'Persist, Survive', 'Involve, Include', 'Exclude, Avoid', 'Teach, Inform', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "entail"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Exclude, Avoid'
) < 1;

UPDATE questions
SET option1 = 'Recklessly, Carelessly',
    option2 = 'Involve, Include',
    option3 = 'Full, Occupied',
    option4 = 'Cautiously, Carefully'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "warily"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Recklessly, Carelessly';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "warily"?', 'antonym', 'Recklessly, Carelessly', 'Recklessly, Carelessly', 'Involve, Include', 'Full, Occupied', 'Cautiously, Carefully', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "warily"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Recklessly, Carelessly'
) < 1;

UPDATE questions
SET option1 = 'Empty, Unoccupied',
    option2 = 'Forced, Required',
    option3 = 'Proud, Conceited',
    option4 = 'Optional, Free'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "voluntary"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Forced, Required';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "voluntary"?', 'antonym', 'Forced, Required', 'Empty, Unoccupied', 'Forced, Required', 'Proud, Conceited', 'Optional, Free', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "voluntary"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Forced, Required'
) < 1;

UPDATE questions
SET option1 = 'Proud, Conceited',
    option2 = 'Full, Occupied',
    option3 = 'Humble, Modest',
    option4 = 'Empty, Unoccupied'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "vain"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Humble, Modest';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "vain"?', 'antonym', 'Humble, Modest', 'Proud, Conceited', 'Full, Occupied', 'Humble, Modest', 'Empty, Unoccupied', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "vain"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Humble, Modest'
) < 1;

UPDATE questions
SET option1 = 'Humble, Modest',
    option2 = 'Proud, Conceited',
    option3 = 'Full, Occupied',
    option4 = 'Empty, Unoccupied'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "vacant"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Full, Occupied';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "vacant"?', 'antonym', 'Full, Occupied', 'Humble, Modest', 'Proud, Conceited', 'Full, Occupied', 'Empty, Unoccupied', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "vacant"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Full, Occupied'
) < 1;

UPDATE questions
SET option1 = 'Rural, Countryside',
    option2 = 'Proud, Conceited',
    option3 = 'Optional, Free',
    option4 = 'City, Metropolitan'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "urban"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Rural, Countryside';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "urban"?', 'antonym', 'Rural, Countryside', 'Rural, Countryside', 'Proud, Conceited', 'Optional, Free', 'City, Metropolitan', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "urban"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Rural, Countryside'
) < 1;

UPDATE questions
SET option1 = 'Uncover, Expose',
    option2 = 'Over, Extra',
    option3 = 'Involve, Include',
    option4 = 'Wrap, Cover'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "envelop"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Uncover, Expose';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "envelop"?', 'antonym', 'Uncover, Expose', 'Uncover, Expose', 'Over, Extra', 'Involve, Include', 'Wrap, Cover', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "envelop"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Uncover, Expose'
) < 1;

UPDATE questions
SET option1 = 'Calm, Reassure',
    option2 = 'Scare, Alarm',
    option3 = 'Remembered, Known',
    option4 = 'Lost, Neglected'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "forgotten"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Remembered, Known';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "forgotten"?', 'antonym', 'Remembered, Known', 'Calm, Reassure', 'Scare, Alarm', 'Remembered, Known', 'Lost, Neglected', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "forgotten"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Remembered, Known'
) < 1;

UPDATE questions
SET option1 = 'Go, Act',
    option2 = 'Empty, Unoccupied',
    option3 = 'Over, Extra',
    option4 = 'Pause, Waver'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "hesitate"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Go, Act';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "hesitate"?', 'antonym', 'Go, Act', 'Go, Act', 'Empty, Unoccupied', 'Over, Extra', 'Pause, Waver', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "hesitate"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Go, Act'
) < 1;

UPDATE questions
SET option1 = 'Demand, Declare',
    option2 = 'Understanding, Awareness',
    option3 = 'Confusion, Ignorance',
    option4 = 'Ignorance, Confusion'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "insight"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Confusion, Ignorance';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "insight"?', 'antonym', 'Confusion, Ignorance', 'Demand, Declare', 'Understanding, Awareness', 'Confusion, Ignorance', 'Ignorance, Confusion', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "insight"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Confusion, Ignorance'
) < 1;

UPDATE questions
SET option1 = 'Solitude, Separation',
    option2 = 'Student, Pupil',
    option3 = 'Ordinary, Boring',
    option4 = 'Teacher, Guide'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "mentor"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Student, Pupil';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "mentor"?', 'antonym', 'Student, Pupil', 'Solitude, Separation', 'Student, Pupil', 'Ordinary, Boring', 'Teacher, Guide', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "mentor"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Student, Pupil'
) < 1;

UPDATE questions
SET option1 = 'Wrap, Cover',
    option2 = 'Little, Moderate',
    option3 = 'Uncover, Expose',
    option4 = 'Over, Extra'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "excessive"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Little, Moderate';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "excessive"?', 'antonym', 'Little, Moderate', 'Wrap, Cover', 'Little, Moderate', 'Uncover, Expose', 'Over, Extra', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "excessive"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Little, Moderate'
) < 1;

UPDATE questions
SET option1 = 'Calm, Reassure',
    option2 = 'Scare, Alarm',
    option3 = 'Lost, Neglected',
    option4 = 'Calm, Relaxed'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "frighten"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Calm, Reassure';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "frighten"?', 'antonym', 'Calm, Reassure', 'Calm, Reassure', 'Scare, Alarm', 'Lost, Neglected', 'Calm, Relaxed', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "frighten"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Calm, Reassure'
) < 1;

UPDATE questions
SET option1 = 'Solitude, Separation',
    option2 = 'Villain, Nobody',
    option3 = 'Scare, Alarm',
    option4 = 'Hero, Star'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "idol"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Villain, Nobody';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "idol"?', 'antonym', 'Villain, Nobody', 'Solitude, Separation', 'Villain, Nobody', 'Scare, Alarm', 'Hero, Star', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "idol"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Villain, Nobody'
) < 1;

UPDATE questions
SET option1 = 'Teacher, Guide',
    option2 = 'Ordinary, Boring',
    option3 = 'Greedy, Selfish',
    option4 = 'Exciting, Fun'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "mundane"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Exciting, Fun';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "mundane"?', 'antonym', 'Exciting, Fun', 'Teacher, Guide', 'Ordinary, Boring', 'Greedy, Selfish', 'Exciting, Fun', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "mundane"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Exciting, Fun'
) < 1;

UPDATE questions
SET option1 = 'Hero, Star',
    option2 = 'Solitude, Separation',
    option3 = 'Company, Togetherness',
    option4 = 'Villain, Nobody'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "isolation"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Company, Togetherness';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "isolation"?', 'antonym', 'Company, Togetherness', 'Hero, Star', 'Solitude, Separation', 'Company, Togetherness', 'Villain, Nobody', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "isolation"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Company, Togetherness'
) < 1;

UPDATE questions
SET option1 = 'Weak, Fragile',
    option2 = 'Strong, Sturdy',
    option3 = 'Strong, Solid',
    option4 = 'Strong, Intense'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "robust"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Weak, Fragile';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "robust"?', 'antonym', 'Weak, Fragile', 'Weak, Fragile', 'Strong, Sturdy', 'Strong, Solid', 'Strong, Intense', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "robust"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Weak, Fragile'
) < 1;

UPDATE questions
SET option1 = 'Clever, Smart',
    option2 = 'Satisfy, Fill',
    option3 = 'Live, Endure',
    option4 = 'Foolish, Naive'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "shrewd"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Foolish, Naive';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "shrewd"?', 'antonym', 'Foolish, Naive', 'Clever, Smart', 'Satisfy, Fill', 'Live, Endure', 'Foolish, Naive', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "shrewd"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Foolish, Naive'
) < 1;

UPDATE questions
SET option1 = 'Generous, Kind',
    option2 = 'Strong, Solid',
    option3 = 'Weak, Fragile',
    option4 = 'Greedy, Selfish'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "stingy"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Generous, Kind';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "stingy"?', 'antonym', 'Generous, Kind', 'Generous, Kind', 'Strong, Solid', 'Weak, Fragile', 'Greedy, Selfish', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "stingy"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Generous, Kind'
) < 1;

UPDATE questions
SET option1 = 'Wary, Doubtful',
    option2 = 'Live, Endure',
    option3 = 'Die, Fail',
    option4 = 'Trusting, Sure'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "survive"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Die, Fail';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "survive"?', 'antonym', 'Die, Fail', 'Wary, Doubtful', 'Live, Endure', 'Die, Fail', 'Trusting, Sure', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "survive"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Die, Fail'
) < 1;

UPDATE questions
SET option1 = 'Responsible, Accountable',
    option2 = 'Irresponsible, Unlikely',
    option3 = 'Freedom, Independence',
    option4 = 'Live, Endure'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "liable"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Irresponsible, Unlikely';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "liable"?', 'antonym', 'Irresponsible, Unlikely', 'Responsible, Accountable', 'Irresponsible, Unlikely', 'Freedom, Independence', 'Live, Endure', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "liable"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Irresponsible, Unlikely'
) < 1;

UPDATE questions
SET option1 = 'Starve, Deprive',
    option2 = 'Clever, Smart',
    option3 = 'Satisfy, Fill',
    option4 = 'Die, Fail'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "sate"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Starve, Deprive';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "sate"?', 'antonym', 'Starve, Deprive', 'Starve, Deprive', 'Clever, Smart', 'Satisfy, Fill', 'Die, Fail', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "sate"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Starve, Deprive'
) < 1;

UPDATE questions
SET option1 = 'Clever, Smart',
    option2 = 'Weak, Fragile',
    option3 = 'Sneak, Lurk',
    option4 = 'March, Walk'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "skulk"?'
  AND question_type = 'antonym'
  AND correct_answer = 'March, Walk';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "skulk"?', 'antonym', 'March, Walk', 'Clever, Smart', 'Weak, Fragile', 'Sneak, Lurk', 'March, Walk', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "skulk"?'
      AND question_type = 'antonym'
      AND correct_answer = 'March, Walk'
) < 1;

UPDATE questions
SET option1 = 'Strong, Solid',
    option2 = 'Greedy, Selfish',
    option3 = 'Weak, Fragile',
    option4 = 'Generous, Kind'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "sturdy"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Weak, Fragile';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "sturdy"?', 'antonym', 'Weak, Fragile', 'Strong, Solid', 'Greedy, Selfish', 'Weak, Fragile', 'Generous, Kind', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "sturdy"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Weak, Fragile'
) < 1;

UPDATE questions
SET option1 = 'Die, Fail',
    option2 = 'Wary, Doubtful',
    option3 = 'Trusting, Sure',
    option4 = 'Live, Endure'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "suspicious"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Trusting, Sure';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "suspicious"?', 'antonym', 'Trusting, Sure', 'Die, Fail', 'Wary, Doubtful', 'Trusting, Sure', 'Live, Endure', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "suspicious"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Trusting, Sure'
) < 1;

UPDATE questions
SET option1 = 'Outfit, Same',
    option2 = 'Different, Odd',
    option3 = 'Satisfy, Fill',
    option4 = 'Share, Reveal'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "uniform"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Different, Odd';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "uniform"?', 'antonym', 'Different, Odd', 'Outfit, Same', 'Different, Odd', 'Satisfy, Fill', 'Share, Reveal', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "uniform"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Different, Odd'
) < 1;

UPDATE questions
SET option1 = 'Interrupt, Invade',
    option2 = 'Meddle, Interrupt',
    option3 = 'Help, Allow',
    option4 = 'Curious, Interested'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "interfere"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Help, Allow';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "interfere"?', 'antonym', 'Help, Allow', 'Interrupt, Invade', 'Meddle, Interrupt', 'Help, Allow', 'Curious, Interested', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "interfere"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Help, Allow'
) < 1;

UPDATE questions
SET option1 = 'Expose, Release',
    option2 = 'Share, Reveal',
    option3 = 'Communicate, Express',
    option4 = 'Shelter, Keep'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "harboured"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Expose, Release';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "harboured"?', 'antonym', 'Expose, Release', 'Expose, Release', 'Share, Reveal', 'Communicate, Express', 'Shelter, Keep', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "harboured"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Expose, Release'
) < 1;

UPDATE questions
SET option1 = 'Gentle, Weak',
    option2 = 'Strong, Intense',
    option3 = 'Weak, Fragile',
    option4 = 'Strong, Solid'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "fierce"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Gentle, Weak';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "fierce"?', 'antonym', 'Gentle, Weak', 'Gentle, Weak', 'Strong, Intense', 'Weak, Fragile', 'Strong, Solid', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "fierce"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Gentle, Weak'
) < 1;

UPDATE questions
SET option1 = 'Lose, Give',
    option2 = 'Get, Obtain',
    option3 = 'Impossible, Unlikely',
    option4 = 'Possible, Attainable'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "acquire"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Lose, Give';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "acquire"?', 'antonym', 'Lose, Give', 'Lose, Give', 'Get, Obtain', 'Impossible, Unlikely', 'Possible, Attainable', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "acquire"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Lose, Give'
) < 1;

UPDATE questions
SET option1 = 'Deny, Hide',
    option2 = 'Communicate, Express',
    option3 = 'Hide, Conceal',
    option4 = 'Share, Reveal'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "confide"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Hide, Conceal';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "confide"?', 'antonym', 'Hide, Conceal', 'Deny, Hide', 'Communicate, Express', 'Hide, Conceal', 'Share, Reveal', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "confide"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Hide, Conceal'
) < 1;

UPDATE questions
SET option1 = 'Share, Reveal',
    option2 = 'Dishonest, Tricksy',
    option3 = 'Awkward, Silly',
    option4 = 'Graceful, Smooth'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "clumsy"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Graceful, Smooth';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "clumsy"?', 'antonym', 'Graceful, Smooth', 'Share, Reveal', 'Dishonest, Tricksy', 'Awkward, Silly', 'Graceful, Smooth', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "clumsy"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Graceful, Smooth'
) < 1;

UPDATE questions
SET option1 = 'Hide, Conceal',
    option2 = 'Share, Reveal',
    option3 = 'Communicate, Express',
    option4 = 'Deny, Hide'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "convey"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Hide, Conceal';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "convey"?', 'antonym', 'Hide, Conceal', 'Hide, Conceal', 'Share, Reveal', 'Communicate, Express', 'Deny, Hide', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "convey"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Hide, Conceal'
) < 1;

UPDATE questions
SET option1 = 'Dishonest, Tricksy',
    option2 = 'Empty, Drain',
    option3 = 'Honest, Truthful',
    option4 = 'Refill, Restore'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "deplete"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Refill, Restore';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "deplete"?', 'antonym', 'Refill, Restore', 'Dishonest, Tricksy', 'Empty, Drain', 'Honest, Truthful', 'Refill, Restore', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "deplete"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Refill, Restore'
) < 1;

UPDATE questions
SET option1 = 'Awake, Energetic',
    option2 = 'Various, Mixed',
    option3 = 'Sleepy, Tired',
    option4 = 'Empty, Drain'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "drowsy"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Awake, Energetic';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "drowsy"?', 'antonym', 'Awake, Energetic', 'Awake, Energetic', 'Various, Mixed', 'Sleepy, Tired', 'Empty, Drain', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "drowsy"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Awake, Energetic'
) < 1;

UPDATE questions
SET option1 = 'Exact, Certain',
    option2 = 'Approximate, Calculated',
    option3 = 'Persist, Survive',
    option4 = 'Empty, Drain'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "estimated"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Exact, Certain';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "estimated"?', 'antonym', 'Exact, Certain', 'Exact, Certain', 'Approximate, Calculated', 'Persist, Survive', 'Empty, Drain', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "estimated"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Exact, Certain'
) < 1;

UPDATE questions
SET option1 = 'Dishonest, Tricksy',
    option2 = 'Refill, Restore',
    option3 = 'Empty, Drain',
    option4 = 'Honest, Truthful'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "deceitful"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Honest, Truthful';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "deceitful"?', 'antonym', 'Honest, Truthful', 'Dishonest, Tricksy', 'Refill, Restore', 'Empty, Drain', 'Honest, Truthful', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "deceitful"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Honest, Truthful'
) < 1;

UPDATE questions
SET option1 = 'Various, Mixed',
    option2 = 'Sleepy, Tired',
    option3 = 'Similar, Same',
    option4 = 'Outfit, Same'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "diverse"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Similar, Same';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "diverse"?', 'antonym', 'Similar, Same', 'Various, Mixed', 'Sleepy, Tired', 'Similar, Same', 'Outfit, Same', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "diverse"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Similar, Same'
) < 1;

UPDATE questions
SET option1 = 'Persist, Survive',
    option2 = 'Lose, Give',
    option3 = 'Quit, Give up',
    option4 = 'Last, Survive'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "endure"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Quit, Give up';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "endure"?', 'antonym', 'Quit, Give up', 'Persist, Survive', 'Lose, Give', 'Quit, Give up', 'Last, Survive', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "endure"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Quit, Give up'
) < 2;

UPDATE questions
SET option1 = 'Amazing, Fantastic',
    option2 = 'Awful, Ordinary',
    option3 = 'Ordinary, Boring',
    option4 = 'Plain, Ordinary'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "marvellous"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Awful, Ordinary';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "marvellous"?', 'antonym', 'Awful, Ordinary', 'Amazing, Fantastic', 'Awful, Ordinary', 'Ordinary, Boring', 'Plain, Ordinary', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "marvellous"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Awful, Ordinary'
) < 1;

UPDATE questions
SET option1 = 'Annoy, Anger',
    option2 = 'Possible, Attainable',
    option3 = 'Worried, Nervous',
    option4 = 'Pacify, Satisfy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "appease"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Annoy, Anger';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "appease"?', 'antonym', 'Annoy, Anger', 'Annoy, Anger', 'Possible, Attainable', 'Worried, Nervous', 'Pacify, Satisfy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "appease"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Annoy, Anger'
) < 1;

UPDATE questions
SET option1 = 'Pacify, Satisfy',
    option2 = 'Sweet-smelling, Aromatic',
    option3 = 'Smelly, Stinky',
    option4 = 'Piece, Shard'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "fragrant"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Smelly, Stinky';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "fragrant"?', 'antonym', 'Smelly, Stinky', 'Pacify, Satisfy', 'Sweet-smelling, Aromatic', 'Smelly, Stinky', 'Piece, Shard', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "fragrant"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Smelly, Stinky'
) < 1;

UPDATE questions
SET option1 = 'Collapse, Break',
    option2 = 'Real, Actual',
    option3 = 'Share, Reveal',
    option4 = 'Make-believe, Pretend'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "imaginary"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Real, Actual';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "imaginary"?', 'antonym', 'Real, Actual', 'Collapse, Break', 'Real, Actual', 'Share, Reveal', 'Make-believe, Pretend', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "imaginary"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Real, Actual'
) < 1;

UPDATE questions
SET option1 = 'Boredom, Calm',
    option2 = 'Nervous, Excited',
    option3 = 'Calm, Relaxed',
    option4 = 'Worried, Nervous'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "anxious"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Calm, Relaxed';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "anxious"?', 'antonym', 'Calm, Relaxed', 'Boredom, Calm', 'Nervous, Excited', 'Calm, Relaxed', 'Worried, Nervous', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "anxious"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Calm, Relaxed'
) < 1;

UPDATE questions
SET option1 = 'Impossible, Unlikely',
    option2 = 'Possible, Attainable',
    option3 = 'Get, Obtain',
    option4 = 'Achieve, Complete'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "achievable"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Impossible, Unlikely';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "achievable"?', 'antonym', 'Impossible, Unlikely', 'Impossible, Unlikely', 'Possible, Attainable', 'Get, Obtain', 'Achieve, Complete', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "achievable"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Impossible, Unlikely'
) < 1;

UPDATE questions
SET option1 = 'Pamphlet, Leaflet',
    option2 = 'Poster, Billboard',
    option3 = 'Possible, Attainable',
    option4 = 'Sweet-smelling, Aromatic'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "brochure"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Poster, Billboard';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "brochure"?', 'antonym', 'Poster, Billboard', 'Pamphlet, Leaflet', 'Poster, Billboard', 'Possible, Attainable', 'Sweet-smelling, Aromatic', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "brochure"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Poster, Billboard'
) < 1;

UPDATE questions
SET option1 = 'Victory, Win',
    option2 = 'Ready, Agreeable',
    option3 = 'Excitement, Rush',
    option4 = 'Defeat, Loss'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "triumph"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Defeat, Loss';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "triumph"?', 'antonym', 'Defeat, Loss', 'Victory, Win', 'Ready, Agreeable', 'Excitement, Rush', 'Defeat, Loss', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "triumph"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Defeat, Loss'
) < 1;

UPDATE questions
SET option1 = 'Victory, Win',
    option2 = 'Excitement, Rush',
    option3 = 'Calm, Relaxed',
    option4 = 'Boredom, Calm'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "thrill"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Boredom, Calm';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "thrill"?', 'antonym', 'Boredom, Calm', 'Victory, Win', 'Excitement, Rush', 'Calm, Relaxed', 'Boredom, Calm', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "thrill"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Boredom, Calm'
) < 1;

UPDATE questions
SET option1 = 'Debris, Rubble',
    option2 = 'Ready, Agreeable',
    option3 = 'Whole, Intact',
    option4 = 'Rubbish, Foolishness'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "wreckage"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Whole, Intact';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "wreckage"?', 'antonym', 'Whole, Intact', 'Debris, Rubble', 'Ready, Agreeable', 'Whole, Intact', 'Rubbish, Foolishness', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "wreckage"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Whole, Intact'
) < 1;

UPDATE questions
SET option1 = 'Ready, Agreeable',
    option2 = 'Unwilling, Refusing',
    option3 = 'Growing, Thriving',
    option4 = 'Fading, Shrivelling'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "withering"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Growing, Thriving';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "withering"?', 'antonym', 'Growing, Thriving', 'Ready, Agreeable', 'Unwilling, Refusing', 'Growing, Thriving', 'Fading, Shrivelling', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "withering"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Growing, Thriving'
) < 1;

UPDATE questions
SET option1 = 'Ready, Agreeable',
    option2 = 'Growing, Thriving',
    option3 = 'Unwilling, Refusing',
    option4 = 'Fading, Shrivelling'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "willing"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Unwilling, Refusing';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "willing"?', 'antonym', 'Unwilling, Refusing', 'Ready, Agreeable', 'Growing, Thriving', 'Unwilling, Refusing', 'Fading, Shrivelling', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "willing"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Unwilling, Refusing'
) < 1;

UPDATE questions
SET option1 = 'Rubbish, Foolishness',
    option2 = 'Accepting, Open-minded',
    option3 = 'Specific, Precise',
    option4 = 'Vague, General'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "nonspecific"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Specific, Precise';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "nonspecific"?', 'antonym', 'Specific, Precise', 'Rubbish, Foolishness', 'Accepting, Open-minded', 'Specific, Precise', 'Vague, General', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "nonspecific"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Specific, Precise'
) < 1;

UPDATE questions
SET option1 = 'Civilian, Bystander',
    option2 = 'Casual, Cool',
    option3 = 'Nervous, Excited',
    option4 = 'Soldier, Fighter'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "nonchalant"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Nervous, Excited';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "nonchalant"?', 'antonym', 'Nervous, Excited', 'Civilian, Bystander', 'Casual, Cool', 'Nervous, Excited', 'Soldier, Fighter', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "nonchalant"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Nervous, Excited'
) < 1;

UPDATE questions
SET option1 = 'Vague, General',
    option2 = 'Sense, Logic',
    option3 = 'Rubbish, Foolishness',
    option4 = 'Accepting, Open-minded'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "nonsense"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Sense, Logic';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "nonsense"?', 'antonym', 'Sense, Logic', 'Vague, General', 'Sense, Logic', 'Rubbish, Foolishness', 'Accepting, Open-minded', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "nonsense"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Sense, Logic'
) < 1;

UPDATE questions
SET option1 = 'Soldier, Fighter',
    option2 = 'Civilian, Bystander',
    option3 = 'Nervous, Excited',
    option4 = 'Casual, Cool'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "noncombatant"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Soldier, Fighter';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "noncombatant"?', 'antonym', 'Soldier, Fighter', 'Soldier, Fighter', 'Civilian, Bystander', 'Nervous, Excited', 'Casual, Cool', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "noncombatant"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Soldier, Fighter'
) < 1;

UPDATE questions
SET option1 = 'Accepting, Open-minded',
    option2 = 'Vague, General',
    option3 = 'Rubbish, Foolishness',
    option4 = 'Judgmental, Critical'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "nonjudgemental"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Judgmental, Critical';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "nonjudgemental"?', 'antonym', 'Judgmental, Critical', 'Accepting, Open-minded', 'Vague, General', 'Rubbish, Foolishness', 'Judgmental, Critical', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "nonjudgemental"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Judgmental, Critical'
) < 1;

UPDATE questions
SET option1 = 'Praise, Respect',
    option2 = 'Resent, Envy',
    option3 = 'Diminish, Mock',
    option4 = 'Charm, Trick'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "belittle"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Praise, Respect';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "belittle"?', 'antonym', 'Praise, Respect', 'Praise, Respect', 'Resent, Envy', 'Diminish, Mock', 'Charm, Trick', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "belittle"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Praise, Respect'
) < 1;

UPDATE questions
SET option1 = 'Bore, Repel',
    option2 = 'Diminish, Mock',
    option3 = 'Resent, Envy',
    option4 = 'Charm, Trick'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "beguile"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Bore, Repel';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "beguile"?', 'antonym', 'Bore, Repel', 'Bore, Repel', 'Diminish, Mock', 'Resent, Envy', 'Charm, Trick', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "beguile"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Bore, Repel'
) < 1;

UPDATE questions
SET option1 = 'Resent, Envy',
    option2 = 'Charm, Trick',
    option3 = 'Give, Allow',
    option4 = 'Praise, Respect'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "begrudge"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Give, Allow';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "begrudge"?', 'antonym', 'Give, Allow', 'Resent, Envy', 'Charm, Trick', 'Give, Allow', 'Praise, Respect', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "begrudge"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Give, Allow'
) < 1;

UPDATE questions
SET option1 = 'Beg, Plead',
    option2 = 'Resent, Envy',
    option3 = 'Confused, Puzzled',
    option4 = 'Refuse, Deny'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "beseech"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Refuse, Deny';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "beseech"?', 'antonym', 'Refuse, Deny', 'Beg, Plead', 'Resent, Envy', 'Confused, Puzzled', 'Refuse, Deny', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "beseech"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Refuse, Deny'
) < 1;

UPDATE questions
SET option1 = 'Beg, Plead',
    option2 = 'Confused, Puzzled',
    option3 = 'Clear, Certain',
    option4 = 'Charm, Trick'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "bewildered"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Clear, Certain';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "bewildered"?', 'antonym', 'Clear, Certain', 'Beg, Plead', 'Confused, Puzzled', 'Clear, Certain', 'Charm, Trick', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "bewildered"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Clear, Certain'
) < 1;

UPDATE questions
SET option1 = 'Simplify, Shorten',
    option2 = 'Complicate, Expand',
    option3 = 'Exhaust, Stretch',
    option4 = 'Examine, Study'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "oversimplify"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Complicate, Expand';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "oversimplify"?', 'antonym', 'Complicate, Expand', 'Simplify, Shorten', 'Complicate, Expand', 'Exhaust, Stretch', 'Examine, Study', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "oversimplify"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Complicate, Expand'
) < 1;

UPDATE questions
SET option1 = 'Exhaust, Stretch',
    option2 = 'Flood, Stun',
    option3 = 'Gentle, Mild',
    option4 = 'Domineering, Bossy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "overbearing"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Gentle, Mild';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "overbearing"?', 'antonym', 'Gentle, Mild', 'Exhaust, Stretch', 'Flood, Stun', 'Gentle, Mild', 'Domineering, Bossy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "overbearing"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Gentle, Mild'
) < 1;

UPDATE questions
SET option1 = 'Exhaust, Stretch',
    option2 = 'Relax, Rest',
    option3 = 'Simplify, Shorten',
    option4 = 'Domineering, Bossy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "overextend"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Relax, Rest';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "overextend"?', 'antonym', 'Relax, Rest', 'Exhaust, Stretch', 'Relax, Rest', 'Simplify, Shorten', 'Domineering, Bossy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "overextend"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Relax, Rest'
) < 1;

UPDATE questions
SET option1 = 'Calm, Manage',
    option2 = 'Flood, Stun',
    option3 = 'Examine, Study',
    option4 = 'Simplify, Shorten'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "overwhelm"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Calm, Manage';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "overwhelm"?', 'antonym', 'Calm, Manage', 'Calm, Manage', 'Flood, Stun', 'Examine, Study', 'Simplify, Shorten', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "overwhelm"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Calm, Manage'
) < 1;

UPDATE questions
SET option1 = 'Domineering, Bossy',
    option2 = 'Examine, Study',
    option3 = 'Flood, Stun',
    option4 = 'Ignore, Forget'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "overanalyse"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Ignore, Forget';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "overanalyse"?', 'antonym', 'Ignore, Forget', 'Domineering, Bossy', 'Examine, Study', 'Flood, Stun', 'Ignore, Forget', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "overanalyse"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Ignore, Forget'
) < 1;

UPDATE questions
SET option1 = 'Misunderstand, Mistake',
    option2 = 'Wrong name, Mistake',
    option3 = 'Misestimate, Mistake',
    option4 = 'Understand, Correct'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "misinterpret"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Understand, Correct';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "misinterpret"?', 'antonym', 'Understand, Correct', 'Misunderstand, Mistake', 'Wrong name, Mistake', 'Misestimate, Mistake', 'Understand, Correct', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "misinterpret"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Understand, Correct'
) < 1;

UPDATE questions
SET option1 = 'Estimate, Correct',
    option2 = 'Misestimate, Mistake',
    option3 = 'Misunderstand, Mistake',
    option4 = 'Wrong name, Mistake'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "miscalculate"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Estimate, Correct';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "miscalculate"?', 'antonym', 'Estimate, Correct', 'Estimate, Correct', 'Misestimate, Mistake', 'Misunderstand, Mistake', 'Wrong name, Mistake', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "miscalculate"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Estimate, Correct'
) < 1;

UPDATE questions
SET option1 = 'Wrongdoing, Misbehaviour',
    option2 = 'Wrong name, Mistake',
    option3 = 'Misestimate, Mistake',
    option4 = 'Good behaviour, Obedience'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "misconduct"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Good behaviour, Obedience';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "misconduct"?', 'antonym', 'Good behaviour, Obedience', 'Wrongdoing, Misbehaviour', 'Wrong name, Mistake', 'Misestimate, Mistake', 'Good behaviour, Obedience', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "misconduct"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Good behaviour, Obedience'
) < 1;

UPDATE questions
SET option1 = 'Understand, Correct',
    option2 = 'Falsify, Twist',
    option3 = 'Tell truth, Clarify',
    option4 = 'Misunderstand, Mistake'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "misrepresent"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Tell truth, Clarify';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "misrepresent"?', 'antonym', 'Tell truth, Clarify', 'Understand, Correct', 'Falsify, Twist', 'Tell truth, Clarify', 'Misunderstand, Mistake', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "misrepresent"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Tell truth, Clarify'
) < 1;

UPDATE questions
SET option1 = 'Misestimate, Mistake',
    option2 = 'Wrong name, Mistake',
    option3 = 'Misunderstand, Mistake',
    option4 = 'Correct name, Accurate'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "misnomer"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Correct name, Accurate';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "misnomer"?', 'antonym', 'Correct name, Accurate', 'Misestimate, Mistake', 'Wrong name, Mistake', 'Misunderstand, Mistake', 'Correct name, Accurate', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "misnomer"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Correct name, Accurate'
) < 1;

UPDATE questions
SET option1 = 'Obedient, Compliant',
    option2 = 'Excellent, Superior',
    option3 = 'Junior, Assistant',
    option4 = 'Poor, Inferior'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "substandard"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Excellent, Superior';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "substandard"?', 'antonym', 'Excellent, Superior', 'Obedient, Compliant', 'Excellent, Superior', 'Junior, Assistant', 'Poor, Inferior', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "substandard"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Excellent, Superior'
) < 1;

UPDATE questions
SET option1 = 'Wrong name, Mistake',
    option2 = 'Agitate, Release',
    option3 = 'Junior, Assistant',
    option4 = 'Tame, Restrain'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "subdue"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Agitate, Release';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "subdue"?', 'antonym', 'Agitate, Release', 'Wrong name, Mistake', 'Agitate, Release', 'Junior, Assistant', 'Tame, Restrain', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "subdue"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Agitate, Release'
) < 1;

UPDATE questions
SET option1 = 'Float, Rise',
    option2 = 'Rebellious, Independent',
    option3 = 'Obedient, Compliant',
    option4 = 'Sink, Drown'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "submerge"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Float, Rise';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "submerge"?', 'antonym', 'Float, Rise', 'Float, Rise', 'Rebellious, Independent', 'Obedient, Compliant', 'Sink, Drown', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "submerge"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Float, Rise'
) < 1;

UPDATE questions
SET option1 = 'Poor, Inferior',
    option2 = 'Junior, Assistant',
    option3 = 'Obedient, Compliant',
    option4 = 'Boss, Leader'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "subordinate"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Boss, Leader';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "subordinate"?', 'antonym', 'Boss, Leader', 'Poor, Inferior', 'Junior, Assistant', 'Obedient, Compliant', 'Boss, Leader', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "subordinate"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Boss, Leader'
) < 1;

DROP TABLE seed_quiz_id;

-- Year 5 Vocabulary Antonym Paper 2
INSERT INTO quizzes (title, description, created_by, stage_id, lock_after_attempt)
SELECT 'Year 5 Vocabulary Antonym Paper 2',
       'A 100-question Year 5 vocabulary exam asking students to identify antonym pairs.',
       1,
       (SELECT id FROM stages WHERE name = 'Year 5'),
       1
WHERE NOT EXISTS (SELECT 1 FROM quizzes WHERE title = 'Year 5 Vocabulary Antonym Paper 2');

DROP TABLE IF EXISTS seed_quiz_id;
CREATE TEMP TABLE seed_quiz_id(id INTEGER);
INSERT INTO seed_quiz_id SELECT id FROM quizzes WHERE title = 'Year 5 Vocabulary Antonym Paper 2' LIMIT 1;

UPDATE questions
SET option1 = 'Rebellious, Independent',
    option2 = 'Sink, Drown',
    option3 = 'Obedient, Compliant',
    option4 = 'Float, Rise'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "subservient"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Rebellious, Independent';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "subservient"?', 'antonym', 'Rebellious, Independent', 'Rebellious, Independent', 'Sink, Drown', 'Obedient, Compliant', 'Float, Rise', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "subservient"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Rebellious, Independent'
) < 1;

UPDATE questions
SET option1 = 'Tiny, Small',
    option2 = 'Vast, Huge',
    option3 = 'Huge, Giant',
    option4 = 'Giant, Massive'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "enormous"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Tiny, Small';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "enormous"?', 'antonym', 'Tiny, Small', 'Tiny, Small', 'Vast, Huge', 'Huge, Giant', 'Giant, Massive', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "enormous"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Tiny, Small'
) < 1;

UPDATE questions
SET option1 = 'Massive, Colossal',
    option2 = 'Giant, Massive',
    option3 = 'Tiny, Petite',
    option4 = 'Small, Petite'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "gargantuan"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Tiny, Petite';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "gargantuan"?', 'antonym', 'Tiny, Petite', 'Massive, Colossal', 'Giant, Massive', 'Tiny, Petite', 'Small, Petite', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "gargantuan"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Tiny, Petite'
) < 1;

UPDATE questions
SET option1 = 'Huge, Giant',
    option2 = 'Miniature, Small',
    option3 = 'Vast, Huge',
    option4 = 'Small, Tiny'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "immense"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Small, Tiny';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "immense"?', 'antonym', 'Small, Tiny', 'Huge, Giant', 'Miniature, Small', 'Vast, Huge', 'Small, Tiny', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "immense"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Small, Tiny'
) < 1;

UPDATE questions
SET option1 = 'Tiny, Mini',
    option2 = 'Huge, Expansive',
    option3 = 'Tiny, Narrow',
    option4 = 'Vast, Huge'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "vast"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Tiny, Narrow';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "vast"?', 'antonym', 'Tiny, Narrow', 'Tiny, Mini', 'Huge, Expansive', 'Tiny, Narrow', 'Vast, Huge', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "vast"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Tiny, Narrow'
) < 1;

UPDATE questions
SET option1 = 'Giant, Massive',
    option2 = 'Tiny, Small',
    option3 = 'Tiny, Mini',
    option4 = 'Small, Petite'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "colossal"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Tiny, Small';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "colossal"?', 'antonym', 'Tiny, Small', 'Giant, Massive', 'Tiny, Small', 'Tiny, Mini', 'Small, Petite', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "colossal"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Tiny, Small'
) < 1;

UPDATE questions
SET option1 = 'Tiny, Mini',
    option2 = 'Huge, Expansive',
    option3 = 'Miniature, Small',
    option4 = 'Huge, Gigantic'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "tiny"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Huge, Gigantic';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "tiny"?', 'antonym', 'Huge, Gigantic', 'Tiny, Mini', 'Huge, Expansive', 'Miniature, Small', 'Huge, Gigantic', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "tiny"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Huge, Gigantic'
) < 1;

UPDATE questions
SET option1 = 'Tiny, Small',
    option2 = 'Small, Petite',
    option3 = 'Miniature, Small',
    option4 = 'Large, Huge'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "diminutive"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Large, Huge';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "diminutive"?', 'antonym', 'Large, Huge', 'Tiny, Small', 'Small, Petite', 'Miniature, Small', 'Large, Huge', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "diminutive"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Large, Huge'
) < 1;

UPDATE questions
SET option1 = 'Tiny, Mini',
    option2 = 'Huge, Big',
    option3 = 'Giant, Large',
    option4 = 'Tiny, Small'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "minute"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Huge, Big';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "minute"?', 'antonym', 'Huge, Big', 'Tiny, Mini', 'Huge, Big', 'Giant, Large', 'Tiny, Small', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "minute"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Huge, Big'
) < 1;

UPDATE questions
SET option1 = 'Tiny, Small',
    option2 = 'Tiny, Mini',
    option3 = 'Giant, Large',
    option4 = 'Huge, Big'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "miniature"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Giant, Large';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "miniature"?', 'antonym', 'Giant, Large', 'Tiny, Small', 'Tiny, Mini', 'Giant, Large', 'Huge, Big', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "miniature"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Giant, Large'
) < 1;

UPDATE questions
SET option1 = 'Small, Weak',
    option2 = 'Miniature, Small',
    option3 = 'Small, Petite',
    option4 = 'Strong, Mighty'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "puny"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Strong, Mighty';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "puny"?', 'antonym', 'Strong, Mighty', 'Small, Weak', 'Miniature, Small', 'Small, Petite', 'Strong, Mighty', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "puny"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Strong, Mighty'
) < 1;

UPDATE questions
SET option1 = 'Afraid, Timid',
    option2 = 'Brave, Heroic',
    option3 = 'Fearless, Bold',
    option4 = 'Brave, Fearless'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "courageous"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Afraid, Timid';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "courageous"?', 'antonym', 'Afraid, Timid', 'Afraid, Timid', 'Brave, Heroic', 'Fearless, Bold', 'Brave, Fearless', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "courageous"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Afraid, Timid'
) < 1;

UPDATE questions
SET option1 = 'Courageous, Brave',
    option2 = 'Brave, Fearless',
    option3 = 'Cowardly, Afraid',
    option4 = 'Brave, Heroic'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "valiant"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Cowardly, Afraid';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "valiant"?', 'antonym', 'Cowardly, Afraid', 'Courageous, Brave', 'Brave, Fearless', 'Cowardly, Afraid', 'Brave, Heroic', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "valiant"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Cowardly, Afraid'
) < 1;

UPDATE questions
SET option1 = 'Brave, Fearless',
    option2 = 'Afraid, Weak',
    option3 = 'Small, Weak',
    option4 = 'Fearless, Bold'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "dauntless"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Afraid, Weak';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "dauntless"?', 'antonym', 'Afraid, Weak', 'Brave, Fearless', 'Afraid, Weak', 'Small, Weak', 'Fearless, Bold', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "dauntless"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Afraid, Weak'
) < 1;

UPDATE questions
SET option1 = 'Brave, Fearless',
    option2 = 'Afraid, Timid',
    option3 = 'Cowardly, Afraid',
    option4 = 'Fearless, Bold'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "intrepid"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Afraid, Timid';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "intrepid"?', 'antonym', 'Afraid, Timid', 'Brave, Fearless', 'Afraid, Timid', 'Cowardly, Afraid', 'Fearless, Bold', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "intrepid"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Afraid, Timid'
) < 1;

UPDATE questions
SET option1 = 'Brave, Fearless',
    option2 = 'Cowardly, Afraid',
    option3 = 'Brave, Heroic',
    option4 = 'Courageous, Brave'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "plucky"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Cowardly, Afraid';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "plucky"?', 'antonym', 'Cowardly, Afraid', 'Brave, Fearless', 'Cowardly, Afraid', 'Brave, Heroic', 'Courageous, Brave', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "plucky"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Cowardly, Afraid'
) < 1;

UPDATE questions
SET option1 = 'Helpful, Useful',
    option2 = 'Harmful, Useless',
    option3 = 'Charm, Trick',
    option4 = 'Unhealthy, Harmful'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "beneficial"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Harmful, Useless';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "beneficial"?', 'antonym', 'Harmful, Useless', 'Helpful, Useful', 'Harmful, Useless', 'Charm, Trick', 'Unhealthy, Harmful', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "beneficial"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Harmful, Useless'
) < 1;

UPDATE questions
SET option1 = 'Awful, Poor',
    option2 = 'Healthy, Wholesome',
    option3 = 'Harmful, Useless',
    option4 = 'Unhealthy, Harmful'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "salubrious"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Unhealthy, Harmful';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "salubrious"?', 'antonym', 'Unhealthy, Harmful', 'Awful, Poor', 'Healthy, Wholesome', 'Harmful, Useless', 'Unhealthy, Harmful', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "salubrious"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Unhealthy, Harmful'
) < 1;

UPDATE questions
SET option1 = 'Unhealthy, Harmful',
    option2 = 'Poor, Inferior',
    option3 = 'Awful, Poor',
    option4 = 'Amazing, Magnificent'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "splendid"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Awful, Poor';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "splendid"?', 'antonym', 'Awful, Poor', 'Unhealthy, Harmful', 'Poor, Inferior', 'Awful, Poor', 'Amazing, Magnificent', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "splendid"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Awful, Poor'
) < 1;

UPDATE questions
SET option1 = 'Dishonourable, Bad',
    option2 = 'Honourable, Good',
    option3 = 'Good, Kind',
    option4 = 'Deserving, Good'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "noble"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Dishonourable, Bad';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "noble"?', 'antonym', 'Dishonourable, Bad', 'Dishonourable, Bad', 'Honourable, Good', 'Good, Kind', 'Deserving, Good', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "noble"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Dishonourable, Bad'
) < 1;

UPDATE questions
SET option1 = 'Unworthy, Bad',
    option2 = 'Deserving, Good',
    option3 = 'Dishonourable, Bad',
    option4 = 'Honourable, Good'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "worthy"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Unworthy, Bad';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "worthy"?', 'antonym', 'Unworthy, Bad', 'Unworthy, Bad', 'Deserving, Good', 'Dishonourable, Bad', 'Honourable, Good', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "worthy"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Unworthy, Bad'
) < 1;

UPDATE questions
SET option1 = 'Evil, Wicked',
    option2 = 'Deserving, Good',
    option3 = 'Good, Kind',
    option4 = 'Honourable, Good'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "nefarious"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Good, Kind';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "nefarious"?', 'antonym', 'Good, Kind', 'Evil, Wicked', 'Deserving, Good', 'Good, Kind', 'Honourable, Good', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "nefarious"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Good, Kind'
) < 1;

UPDATE questions
SET option1 = 'Lovely, Pleasant',
    option2 = 'Annoying, Irritating',
    option3 = 'Pleasant, Nice',
    option4 = 'Notice, Watching'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "obnoxious"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Pleasant, Nice';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "obnoxious"?', 'antonym', 'Pleasant, Nice', 'Lovely, Pleasant', 'Annoying, Irritating', 'Pleasant, Nice', 'Notice, Watching', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "obnoxious"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Pleasant, Nice'
) < 1;

UPDATE questions
SET option1 = 'Hateful, Evil',
    option2 = 'Good, Admirable',
    option3 = 'Lovely, Pleasant',
    option4 = 'Hateful, Horrible'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "detestable"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Lovely, Pleasant';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "detestable"?', 'antonym', 'Lovely, Pleasant', 'Hateful, Evil', 'Good, Admirable', 'Lovely, Pleasant', 'Hateful, Horrible', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "detestable"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Lovely, Pleasant'
) < 1;

UPDATE questions
SET option1 = 'Lovely, Pleasant',
    option2 = 'Hateful, Evil',
    option3 = 'Hateful, Horrible',
    option4 = 'Good, Admirable'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "despicable"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Good, Admirable';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "despicable"?', 'antonym', 'Good, Admirable', 'Lovely, Pleasant', 'Hateful, Evil', 'Hateful, Horrible', 'Good, Admirable', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "despicable"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Good, Admirable'
) < 1;

UPDATE questions
SET option1 = 'Hateful, Evil',
    option2 = 'Hateful, Worthless',
    option3 = 'Admirable, Respectable',
    option4 = 'Hateful, Horrible'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "contemptible"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Admirable, Respectable';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "contemptible"?', 'antonym', 'Admirable, Respectable', 'Hateful, Evil', 'Hateful, Worthless', 'Admirable, Respectable', 'Hateful, Horrible', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "contemptible"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Admirable, Respectable'
) < 1;

UPDATE questions
SET option1 = 'Happy, Joyful',
    option2 = 'Sad, Down',
    option3 = 'Sad, Unhappy',
    option4 = 'Cheerful, Happy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "sorrowful"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Happy, Joyful';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "sorrowful"?', 'antonym', 'Happy, Joyful', 'Happy, Joyful', 'Sad, Down', 'Sad, Unhappy', 'Cheerful, Happy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "sorrowful"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Happy, Joyful'
) < 1;

UPDATE questions
SET option1 = 'Sad, Down',
    option2 = 'Cheerful, Happy',
    option3 = 'Sad, Unhappy',
    option4 = 'Hateful, Evil'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "depressed"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Cheerful, Happy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "depressed"?', 'antonym', 'Cheerful, Happy', 'Sad, Down', 'Cheerful, Happy', 'Sad, Unhappy', 'Hateful, Evil', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "depressed"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Cheerful, Happy'
) < 1;

UPDATE questions
SET option1 = 'Hateful, Evil',
    option2 = 'Cheerful, Happy',
    option3 = 'Sad, Down',
    option4 = 'Sad, Unhappy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "dejected"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Cheerful, Happy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "dejected"?', 'antonym', 'Cheerful, Happy', 'Hateful, Evil', 'Cheerful, Happy', 'Sad, Down', 'Sad, Unhappy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "dejected"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Cheerful, Happy'
) < 1;

UPDATE questions
SET option1 = 'Sad, Down',
    option2 = 'Rot, Deteriorate',
    option3 = 'Grow, Improve',
    option4 = 'Hateful, Evil'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "decay"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Grow, Improve';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "decay"?', 'antonym', 'Grow, Improve', 'Sad, Down', 'Rot, Deteriorate', 'Grow, Improve', 'Hateful, Evil', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "decay"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Grow, Improve'
) < 1;

UPDATE questions
SET option1 = 'Ruin, Destroy',
    option2 = 'Protect, Save',
    option3 = 'Slowly, Later',
    option4 = 'Quickly, Immediately'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "preserve"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Ruin, Destroy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "preserve"?', 'antonym', 'Ruin, Destroy', 'Ruin, Destroy', 'Protect, Save', 'Slowly, Later', 'Quickly, Immediately', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "preserve"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Ruin, Destroy'
) < 1;

UPDATE questions
SET option1 = 'Dull, Rough',
    option2 = 'Dark, Dull',
    option3 = 'Dull, Flat',
    option4 = 'Glowing, Bright'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "luminous"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Dark, Dull';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "luminous"?', 'antonym', 'Dark, Dull', 'Dull, Rough', 'Dark, Dull', 'Dull, Flat', 'Glowing, Bright', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "luminous"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Dark, Dull'
) < 1;

UPDATE questions
SET option1 = 'Glowing, Bright',
    option2 = 'Bossy, Pushy',
    option3 = 'Gentle, Easy-going',
    option4 = 'Rot, Deteriorate'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "domineering"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Gentle, Easy-going';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "domineering"?', 'antonym', 'Gentle, Easy-going', 'Glowing, Bright', 'Bossy, Pushy', 'Gentle, Easy-going', 'Rot, Deteriorate', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "domineering"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Gentle, Easy-going'
) < 1;

UPDATE questions
SET option1 = 'Protect, Save',
    option2 = 'Slowly, Later',
    option3 = 'Ruin, Destroy',
    option4 = 'Quickly, Immediately'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "promptly"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Slowly, Later';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "promptly"?', 'antonym', 'Slowly, Later', 'Protect, Save', 'Slowly, Later', 'Ruin, Destroy', 'Quickly, Immediately', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "promptly"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Slowly, Later'
) < 1;

UPDATE questions
SET option1 = 'Joy, Delight',
    option2 = 'Shiny, Polished',
    option3 = 'Dull, Flat',
    option4 = 'Dull, Rough'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "glossy"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Dull, Rough';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "glossy"?', 'antonym', 'Dull, Rough', 'Joy, Delight', 'Shiny, Polished', 'Dull, Flat', 'Dull, Rough', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "glossy"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Dull, Rough'
) < 1;

UPDATE questions
SET option1 = 'Shiny, Glossy',
    option2 = 'Dark, Dull',
    option3 = 'Dull, Flat',
    option4 = 'Shiny, Polished'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "matte"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Shiny, Glossy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "matte"?', 'antonym', 'Shiny, Glossy', 'Shiny, Glossy', 'Dark, Dull', 'Dull, Flat', 'Shiny, Polished', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "matte"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Shiny, Glossy'
) < 1;

UPDATE questions
SET option1 = 'Sadness, Misery',
    option2 = 'Dull, Rough',
    option3 = 'Joy, Delight',
    option4 = 'Shiny, Polished'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "glee"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Sadness, Misery';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "glee"?', 'antonym', 'Sadness, Misery', 'Sadness, Misery', 'Dull, Rough', 'Joy, Delight', 'Shiny, Polished', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "glee"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Sadness, Misery'
) < 1;

UPDATE questions
SET option1 = 'Shine, Glow',
    option2 = 'Shiny, Glossy',
    option3 = 'Fade, Dim',
    option4 = 'Shiny, Polished'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "radiate"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Fade, Dim';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "radiate"?', 'antonym', 'Fade, Dim', 'Shine, Glow', 'Shiny, Glossy', 'Fade, Dim', 'Shiny, Polished', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "radiate"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Fade, Dim'
) < 1;

UPDATE questions
SET option1 = 'Beg, Implore',
    option2 = 'Demand, Declare',
    option3 = 'Demand, Refuse',
    option4 = 'Bother, Trouble'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "plead"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Demand, Refuse';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "plead"?', 'antonym', 'Demand, Refuse', 'Beg, Implore', 'Demand, Declare', 'Demand, Refuse', 'Bother, Trouble', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "plead"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Demand, Refuse'
) < 1;

UPDATE questions
SET option1 = 'Calm, Reassure',
    option2 = 'Piece, Shard',
    option3 = 'Calm, Relaxed',
    option4 = 'Panicked, Wild'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "frantic"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Calm, Relaxed';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "frantic"?', 'antonym', 'Calm, Relaxed', 'Calm, Reassure', 'Piece, Shard', 'Calm, Relaxed', 'Panicked, Wild', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "frantic"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Calm, Relaxed'
) < 1;

UPDATE questions
SET option1 = 'Joy, Delight',
    option2 = 'Encourage, Push',
    option3 = 'Bossy, Pushy',
    option4 = 'Discourage, Prevent'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "urge"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Discourage, Prevent';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "urge"?', 'antonym', 'Discourage, Prevent', 'Joy, Delight', 'Encourage, Push', 'Bossy, Pushy', 'Discourage, Prevent', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "urge"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Discourage, Prevent'
) < 1;

UPDATE questions
SET option1 = 'Caring, Keen',
    option2 = 'Uninterested, Indifferent',
    option3 = 'Damage, Weaken',
    option4 = 'Differ, Contrast'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "apathetic"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Caring, Keen';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "apathetic"?', 'antonym', 'Caring, Keen', 'Caring, Keen', 'Uninterested, Indifferent', 'Damage, Weaken', 'Differ, Contrast', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "apathetic"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Caring, Keen'
) < 1;

UPDATE questions
SET option1 = 'Demand, Refuse',
    option2 = 'Suggest, Give in',
    option3 = 'Demand, Declare',
    option4 = 'Affect, Persuade'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "insist"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Suggest, Give in';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "insist"?', 'antonym', 'Suggest, Give in', 'Demand, Refuse', 'Suggest, Give in', 'Demand, Declare', 'Affect, Persuade', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "insist"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Suggest, Give in'
) < 1;

UPDATE questions
SET option1 = 'Stillness, Calm',
    option2 = 'Fix, Strengthen',
    option3 = 'Damage, Weaken',
    option4 = 'Wave, Undulation'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "cripple"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Fix, Strengthen';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "cripple"?', 'antonym', 'Fix, Strengthen', 'Stillness, Calm', 'Fix, Strengthen', 'Damage, Weaken', 'Wave, Undulation', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "cripple"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Fix, Strengthen'
) < 1;

UPDATE questions
SET option1 = 'Differ, Contrast',
    option2 = 'Look like, Match',
    option3 = 'Control, Hold',
    option4 = 'Important, Related'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "resemble"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Differ, Contrast';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "resemble"?', 'antonym', 'Differ, Contrast', 'Differ, Contrast', 'Look like, Match', 'Control, Hold', 'Important, Related', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "resemble"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Differ, Contrast'
) < 1;

UPDATE questions
SET option1 = 'Straighten, Support',
    option2 = 'Demand, Declare',
    option3 = 'Continue, Straighten',
    option4 = 'Bend, Collapse'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "buckle"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Straighten, Support';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "buckle"?', 'antonym', 'Straighten, Support', 'Straighten, Support', 'Demand, Declare', 'Continue, Straighten', 'Bend, Collapse', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "buckle"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Straighten, Support'
) < 1;

UPDATE questions
SET option1 = 'Fix, Strengthen',
    option2 = 'Stillness, Calm',
    option3 = 'Damage, Weaken',
    option4 = 'Wave, Undulation'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "ripple"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Stillness, Calm';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "ripple"?', 'antonym', 'Stillness, Calm', 'Fix, Strengthen', 'Stillness, Calm', 'Damage, Weaken', 'Wave, Undulation', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "ripple"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Stillness, Calm'
) < 1;

UPDATE questions
SET option1 = 'Pleasant, Nice',
    option2 = 'Annoying, Irritating',
    option3 = 'Ignoring, Overlooking',
    option4 = 'Notice, Watching'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "observation"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Ignoring, Overlooking';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "observation"?', 'antonym', 'Ignoring, Overlooking', 'Pleasant, Nice', 'Annoying, Irritating', 'Ignoring, Overlooking', 'Notice, Watching', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "observation"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Ignoring, Overlooking'
) < 1;

UPDATE questions
SET option1 = 'Winced, Scowled',
    option2 = 'Smiled, Grinned',
    option3 = 'Old, Historic',
    option4 = 'Winner, Hero'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "grimaced"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Smiled, Grinned';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "grimaced"?', 'antonym', 'Smiled, Grinned', 'Winced, Scowled', 'Smiled, Grinned', 'Old, Historic', 'Winner, Hero', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "grimaced"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Smiled, Grinned'
) < 1;

UPDATE questions
SET option1 = 'Ignore, Neglect',
    option2 = 'Demand, Declare',
    option3 = 'Suggest, Give in',
    option4 = 'Affect, Persuade'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "influence"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Ignore, Neglect';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "influence"?', 'antonym', 'Ignore, Neglect', 'Ignore, Neglect', 'Demand, Declare', 'Suggest, Give in', 'Affect, Persuade', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "influence"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Ignore, Neglect'
) < 1;

UPDATE questions
SET option1 = 'Important, Related',
    option2 = 'Freedom, Independence',
    option3 = 'Unplanned, Unexpected',
    option4 = 'Control, Captivity'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "liberty"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Control, Captivity';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "liberty"?', 'antonym', 'Control, Captivity', 'Important, Related', 'Freedom, Independence', 'Unplanned, Unexpected', 'Control, Captivity', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "liberty"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Control, Captivity'
) < 1;

UPDATE questions
SET option1 = 'Old, Historic',
    option2 = 'Important, Related',
    option3 = 'Modern, New',
    option4 = 'Winced, Scowled'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "ancient"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Modern, New';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "ancient"?', 'antonym', 'Modern, New', 'Old, Historic', 'Important, Related', 'Modern, New', 'Winced, Scowled', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "ancient"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Modern, New'
) < 1;

UPDATE questions
SET option1 = 'Winced, Scowled',
    option2 = 'Career, Occupation',
    option3 = 'Winner, Hero',
    option4 = 'Loser, Quitter'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "champion"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Loser, Quitter';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "champion"?', 'antonym', 'Loser, Quitter', 'Winced, Scowled', 'Career, Occupation', 'Winner, Hero', 'Loser, Quitter', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "champion"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Loser, Quitter'
) < 1;

UPDATE questions
SET option1 = 'Hobby, Pastime',
    option2 = 'Protect, Save',
    option3 = 'Planned, Timed',
    option4 = 'Career, Occupation'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "profession"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Hobby, Pastime';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "profession"?', 'antonym', 'Hobby, Pastime', 'Hobby, Pastime', 'Protect, Save', 'Planned, Timed', 'Career, Occupation', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "profession"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Hobby, Pastime'
) < 1;

UPDATE questions
SET option1 = 'Cancelled, Unplanned',
    option2 = 'Unplanned, Unexpected',
    option3 = 'Planned, Timed',
    option4 = 'Planned, Ordered'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "random"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Planned, Ordered';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "random"?', 'antonym', 'Planned, Ordered', 'Cancelled, Unplanned', 'Unplanned, Unexpected', 'Planned, Timed', 'Planned, Ordered', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "random"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Planned, Ordered'
) < 1;

UPDATE questions
SET option1 = 'Unplanned, Unexpected',
    option2 = 'Irrelevant, Unrelated',
    option3 = 'Look like, Match',
    option4 = 'Important, Related'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "relevant"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Irrelevant, Unrelated';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "relevant"?', 'antonym', 'Irrelevant, Unrelated', 'Unplanned, Unexpected', 'Irrelevant, Unrelated', 'Look like, Match', 'Important, Related', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "relevant"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Irrelevant, Unrelated'
) < 1;

UPDATE questions
SET option1 = 'Cancelled, Unplanned',
    option2 = 'Planned, Ordered',
    option3 = 'Unplanned, Unexpected',
    option4 = 'Planned, Timed'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "scheduled"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Cancelled, Unplanned';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "scheduled"?', 'antonym', 'Cancelled, Unplanned', 'Cancelled, Unplanned', 'Planned, Ordered', 'Unplanned, Unexpected', 'Planned, Timed', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "scheduled"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Cancelled, Unplanned'
) < 1;

UPDATE questions
SET option1 = 'Sense, Reason',
    option2 = 'Veer, Turn',
    option3 = 'Firm, Determined',
    option4 = 'Continue, Straighten'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "swerve"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Continue, Straighten';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "swerve"?', 'antonym', 'Continue, Straighten', 'Sense, Reason', 'Veer, Turn', 'Firm, Determined', 'Continue, Straighten', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "swerve"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Continue, Straighten'
) < 1;

UPDATE questions
SET option1 = 'Calm, Certainty',
    option2 = 'Tension, Excitement',
    option3 = 'Madness, Chaos',
    option4 = 'Sense, Reason'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "sanity"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Madness, Chaos';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "sanity"?', 'antonym', 'Madness, Chaos', 'Calm, Certainty', 'Tension, Excitement', 'Madness, Chaos', 'Sense, Reason', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "sanity"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Madness, Chaos'
) < 1;

UPDATE questions
SET option1 = 'Piercing, Sharp',
    option2 = 'Sense, Reason',
    option3 = 'Firm, Determined',
    option4 = 'Soft, Gentle'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "shrill"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Soft, Gentle';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "shrill"?', 'antonym', 'Soft, Gentle', 'Piercing, Sharp', 'Sense, Reason', 'Firm, Determined', 'Soft, Gentle', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "shrill"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Soft, Gentle'
) < 1;

UPDATE questions
SET option1 = 'Flexible, Agreeable',
    option2 = 'Planned, Timed',
    option3 = 'Firm, Determined',
    option4 = 'Veer, Turn'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "stubborn"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Flexible, Agreeable';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "stubborn"?', 'antonym', 'Flexible, Agreeable', 'Flexible, Agreeable', 'Planned, Timed', 'Firm, Determined', 'Veer, Turn', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "stubborn"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Flexible, Agreeable'
) < 1;

UPDATE questions
SET option1 = 'Sense, Reason',
    option2 = 'Calm, Certainty',
    option3 = 'Replace, Take over',
    option4 = 'Tension, Excitement'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "suspense"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Calm, Certainty';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "suspense"?', 'antonym', 'Calm, Certainty', 'Sense, Reason', 'Calm, Certainty', 'Replace, Take over', 'Tension, Excitement', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "suspense"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Calm, Certainty'
) < 1;

UPDATE questions
SET option1 = 'Rushed, Quick',
    option2 = 'Unusual, Rare',
    option3 = 'Usual, Common',
    option4 = 'Surroundings, Nature'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "typical"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Unusual, Rare';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "typical"?', 'antonym', 'Unusual, Rare', 'Rushed, Quick', 'Unusual, Rare', 'Usual, Common', 'Surroundings, Nature', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "typical"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Unusual, Rare'
) < 1;

UPDATE questions
SET option1 = 'Calmness, Simplicity',
    option2 = 'Calm, Certainty',
    option3 = 'Madness, Chaos',
    option4 = 'Drama, Exaggeration'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "dramatics"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Calmness, Simplicity';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "dramatics"?', 'antonym', 'Calmness, Simplicity', 'Calmness, Simplicity', 'Calm, Certainty', 'Madness, Chaos', 'Drama, Exaggeration', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "dramatics"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Calmness, Simplicity'
) < 1;

UPDATE questions
SET option1 = 'Surroundings, Nature',
    option2 = 'Exclude, Avoid',
    option3 = 'Surround, Trouble',
    option4 = 'Isolation, Void'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "environment"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Isolation, Void';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "environment"?', 'antonym', 'Isolation, Void', 'Surroundings, Nature', 'Exclude, Avoid', 'Surround, Trouble', 'Isolation, Void', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "environment"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Isolation, Void'
) < 1;

UPDATE questions
SET option1 = 'Sweet-smelling, Aromatic',
    option2 = 'Piece, Shard',
    option3 = 'Whole, Complete',
    option4 = 'Panicked, Wild'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "fragment"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Whole, Complete';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "fragment"?', 'antonym', 'Whole, Complete', 'Sweet-smelling, Aromatic', 'Piece, Shard', 'Whole, Complete', 'Panicked, Wild', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "fragment"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Whole, Complete'
) < 1;

UPDATE questions
SET option1 = 'Plot, Scheme',
    option2 = 'Persuasive, Strong',
    option3 = 'Weak, Unclear',
    option4 = 'Prevent, Stop'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "conspire"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Prevent, Stop';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "conspire"?', 'antonym', 'Prevent, Stop', 'Plot, Scheme', 'Persuasive, Strong', 'Weak, Unclear', 'Prevent, Stop', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "conspire"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Prevent, Stop'
) < 1;

UPDATE questions
SET option1 = 'Important, Related',
    option2 = 'Slow, Relaxed',
    option3 = 'Harassed, Troubled',
    option4 = 'Rushed, Quick'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "hurried"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Slow, Relaxed';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "hurried"?', 'antonym', 'Slow, Relaxed', 'Important, Related', 'Slow, Relaxed', 'Harassed, Troubled', 'Rushed, Quick', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "hurried"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Slow, Relaxed'
) < 1;

UPDATE questions
SET option1 = 'Helped, Supported',
    option2 = 'Harassed, Troubled',
    option3 = 'Surround, Trouble',
    option4 = 'Bother, Trouble'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "beleaguered"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Helped, Supported';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "beleaguered"?', 'antonym', 'Helped, Supported', 'Helped, Supported', 'Harassed, Troubled', 'Surround, Trouble', 'Bother, Trouble', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "beleaguered"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Helped, Supported'
) < 1;

UPDATE questions
SET option1 = 'Harassed, Troubled',
    option2 = 'Free, Assist',
    option3 = 'Bother, Trouble',
    option4 = 'Surround, Trouble'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "beset"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Free, Assist';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "beset"?', 'antonym', 'Free, Assist', 'Harassed, Troubled', 'Free, Assist', 'Bother, Trouble', 'Surround, Trouble', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "beset"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Free, Assist'
) < 1;

UPDATE questions
SET option1 = 'Surround, Trouble',
    option2 = 'Bother, Trouble',
    option3 = 'Help, Ease',
    option4 = 'Harassed, Troubled'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "plague"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Help, Ease';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "plague"?', 'antonym', 'Help, Ease', 'Surround, Trouble', 'Bother, Trouble', 'Help, Ease', 'Harassed, Troubled', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "plague"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Help, Ease'
) < 1;

UPDATE questions
SET option1 = 'Weak, Unclear',
    option2 = 'Persuasive, Strong',
    option3 = 'Plot, Scheme',
    option4 = 'Prevent, Stop'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "cogent"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Weak, Unclear';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "cogent"?', 'antonym', 'Weak, Unclear', 'Weak, Unclear', 'Persuasive, Strong', 'Plot, Scheme', 'Prevent, Stop', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "cogent"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Weak, Unclear'
) < 1;

UPDATE questions
SET option1 = 'Sensible, Reasonable',
    option2 = 'Quiet, Silent',
    option3 = 'Silly, Confusing',
    option4 = 'Chatty, Talkative'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "logical"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Silly, Confusing';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "logical"?', 'antonym', 'Silly, Confusing', 'Sensible, Reasonable', 'Quiet, Silent', 'Silly, Confusing', 'Chatty, Talkative', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "logical"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Silly, Confusing'
) < 1;

UPDATE questions
SET option1 = 'Sensible, Reasonable',
    option2 = 'Silly, Confusing',
    option3 = 'Chatty, Talkative',
    option4 = 'Quiet, Silent'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "loquacious"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Quiet, Silent';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "loquacious"?', 'antonym', 'Quiet, Silent', 'Sensible, Reasonable', 'Silly, Confusing', 'Chatty, Talkative', 'Quiet, Silent', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "loquacious"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Quiet, Silent'
) < 1;

UPDATE questions
SET option1 = 'Obey, Agree',
    option2 = 'Refuse, Resist',
    option3 = 'Persuasive, Strong',
    option4 = 'Friend, Partner'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "comply"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Refuse, Resist';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "comply"?', 'antonym', 'Refuse, Resist', 'Obey, Agree', 'Refuse, Resist', 'Persuasive, Strong', 'Friend, Partner', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "comply"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Refuse, Resist'
) < 1;

UPDATE questions
SET option1 = 'Amazing, Magnificent',
    option2 = 'Beauty, Glory',
    option3 = 'Release, Let go',
    option4 = 'Plainness, Dullness'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "splendour"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Plainness, Dullness';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "splendour"?', 'antonym', 'Plainness, Dullness', 'Amazing, Magnificent', 'Beauty, Glory', 'Release, Let go', 'Plainness, Dullness', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "splendour"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Plainness, Dullness'
) < 1;

UPDATE questions
SET option1 = 'Join, Attach',
    option2 = 'Cut, Separate',
    option3 = 'Release, Let go',
    option4 = 'Grab, Snatch'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "seize"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Release, Let go';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "seize"?', 'antonym', 'Release, Let go', 'Join, Attach', 'Cut, Separate', 'Release, Let go', 'Grab, Snatch', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "seize"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Release, Let go'
) < 1;

UPDATE questions
SET option1 = 'Damage, Ruin',
    option2 = 'Control, Hold',
    option3 = 'Release, Allow',
    option4 = 'Repair, Fix'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "renovate"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Damage, Ruin';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "renovate"?', 'antonym', 'Damage, Ruin', 'Damage, Ruin', 'Control, Hold', 'Release, Allow', 'Repair, Fix', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "renovate"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Damage, Ruin'
) < 1;

UPDATE questions
SET option1 = 'Repair, Fix',
    option2 = 'Control, Hold',
    option3 = 'Damage, Ruin',
    option4 = 'Release, Allow'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "restrain"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Release, Allow';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "restrain"?', 'antonym', 'Release, Allow', 'Repair, Fix', 'Control, Hold', 'Damage, Ruin', 'Release, Allow', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "restrain"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Release, Allow'
) < 1;

UPDATE questions
SET option1 = 'Grab, Snatch',
    option2 = 'Submissive, Obedient',
    option3 = 'Cut, Separate',
    option4 = 'Join, Attach'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "sever"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Join, Attach';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "sever"?', 'antonym', 'Join, Attach', 'Grab, Snatch', 'Submissive, Obedient', 'Cut, Separate', 'Join, Attach', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "sever"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Join, Attach'
) < 1;

UPDATE questions
SET option1 = 'Shock, Surprise',
    option2 = 'Calm, Reassure',
    option3 = 'Moving, Mobile',
    option4 = 'Still, Motionless'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "stationary"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Moving, Mobile';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "stationary"?', 'antonym', 'Moving, Mobile', 'Shock, Surprise', 'Calm, Reassure', 'Moving, Mobile', 'Still, Motionless', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "stationary"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Moving, Mobile'
) < 1;

UPDATE questions
SET option1 = 'Keep, Continue',
    option2 = 'Shock, Surprise',
    option3 = 'Replace, Take over',
    option4 = 'Cut, Separate'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "supersede"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Keep, Continue';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "supersede"?', 'antonym', 'Keep, Continue', 'Keep, Continue', 'Shock, Surprise', 'Replace, Take over', 'Cut, Separate', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "supersede"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Keep, Continue'
) < 1;

UPDATE questions
SET option1 = 'Special, Rare',
    option2 = 'Ordinary, Usual',
    option3 = 'Common, Ordinary',
    option4 = 'Unique, Extraordinary'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "unique"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Common, Ordinary';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "unique"?', 'antonym', 'Common, Ordinary', 'Special, Rare', 'Ordinary, Usual', 'Common, Ordinary', 'Unique, Extraordinary', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "unique"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Common, Ordinary'
) < 1;

UPDATE questions
SET option1 = 'Grab, Snatch',
    option2 = 'Proud, Independent',
    option3 = 'Cut, Separate',
    option4 = 'Submissive, Obedient'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "servile"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Proud, Independent';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "servile"?', 'antonym', 'Proud, Independent', 'Grab, Snatch', 'Proud, Independent', 'Cut, Separate', 'Submissive, Obedient', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "servile"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Proud, Independent'
) < 1;

UPDATE questions
SET option1 = 'Calm, Reassure',
    option2 = 'Shock, Surprise',
    option3 = 'Moving, Mobile',
    option4 = 'Still, Motionless'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "startle"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Calm, Reassure';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "startle"?', 'antonym', 'Calm, Reassure', 'Calm, Reassure', 'Shock, Surprise', 'Moving, Mobile', 'Still, Motionless', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "startle"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Calm, Reassure'
) < 1;

UPDATE questions
SET option1 = 'Minor, Unimportant',
    option2 = 'Stand-in, Representative',
    option3 = 'Original, Principal',
    option4 = 'Main, Head'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "proxy"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Original, Principal';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "proxy"?', 'antonym', 'Original, Principal', 'Minor, Unimportant', 'Stand-in, Representative', 'Original, Principal', 'Main, Head', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "proxy"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Original, Principal'
) < 1;

UPDATE questions
SET option1 = 'Careless, Rushed',
    option2 = 'Detailed, Complete',
    option3 = 'Distracted, Careless',
    option4 = 'Careful, Economical'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "thorough"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Careless, Rushed';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "thorough"?', 'antonym', 'Careless, Rushed', 'Careless, Rushed', 'Detailed, Complete', 'Distracted, Careless', 'Careful, Economical', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "thorough"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Careless, Rushed'
) < 1;

UPDATE questions
SET option1 = 'Promise, Vow',
    option2 = 'Brave, Courageous',
    option3 = 'Shock, Surprise',
    option4 = 'Lie, Break'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "oath"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Lie, Break';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "oath"?', 'antonym', 'Lie, Break', 'Promise, Vow', 'Brave, Courageous', 'Shock, Surprise', 'Lie, Break', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "oath"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Lie, Break'
) < 1;

UPDATE questions
SET option1 = 'Careless, Rushed',
    option2 = 'Focused, Alert',
    option3 = 'Distracted, Careless',
    option4 = 'Shock, Surprise'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "attentive"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Distracted, Careless';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "attentive"?', 'antonym', 'Distracted, Careless', 'Careless, Rushed', 'Focused, Alert', 'Distracted, Careless', 'Shock, Surprise', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "attentive"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Distracted, Careless'
) < 1;

UPDATE questions
SET option1 = 'Obey, Agree',
    option2 = 'Traditional, Normal',
    option3 = 'Enemy, Stranger',
    option4 = 'Friend, Partner'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "companion"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Enemy, Stranger';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "companion"?', 'antonym', 'Enemy, Stranger', 'Obey, Agree', 'Traditional, Normal', 'Enemy, Stranger', 'Friend, Partner', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "companion"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Enemy, Stranger'
) < 1;

UPDATE questions
SET option1 = 'Brave, Courageous',
    option2 = 'Cowardly, Fearful',
    option3 = 'Cowardly, Afraid',
    option4 = 'Brave, Heroic'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "valiant"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Cowardly, Fearful';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "valiant"?', 'antonym', 'Cowardly, Fearful', 'Brave, Courageous', 'Cowardly, Fearful', 'Cowardly, Afraid', 'Brave, Heroic', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "valiant"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Cowardly, Fearful'
) < 1;

UPDATE questions
SET option1 = 'Promise, Vow',
    option2 = 'Costume, Hide',
    option3 = 'Reveal, Show',
    option4 = 'Boldness, Nerve'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "disguise"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Reveal, Show';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "disguise"?', 'antonym', 'Reveal, Show', 'Promise, Vow', 'Costume, Hide', 'Reveal, Show', 'Boldness, Nerve', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "disguise"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Reveal, Show'
) < 1;

UPDATE questions
SET option1 = 'Simple, Plain',
    option2 = 'Detailed, Complete',
    option3 = 'Friend, Partner',
    option4 = 'Detailed, Fancy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "elaborate"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Simple, Plain';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "elaborate"?', 'antonym', 'Simple, Plain', 'Simple, Plain', 'Detailed, Complete', 'Friend, Partner', 'Detailed, Fancy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "elaborate"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Simple, Plain'
) < 1;

UPDATE questions
SET option1 = 'Heavy, Awkward',
    option2 = 'Light, Easy',
    option3 = 'Anxious, Uneasy',
    option4 = 'Disaster, Tragedy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "cumbersome"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Light, Easy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "cumbersome"?', 'antonym', 'Light, Easy', 'Heavy, Awkward', 'Light, Easy', 'Anxious, Uneasy', 'Disaster, Tragedy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "cumbersome"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Light, Easy'
) < 1;

UPDATE questions
SET option1 = 'Priceless, Vital',
    option2 = 'Priceless, Valuable',
    option3 = 'Interrupt, Invade',
    option4 = 'Worthless, Useless'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "invaluable"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Worthless, Useless';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "invaluable"?', 'antonym', 'Worthless, Useless', 'Priceless, Vital', 'Priceless, Valuable', 'Interrupt, Invade', 'Worthless, Useless', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "invaluable"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Worthless, Useless'
) < 1;

UPDATE questions
SET option1 = 'Careless, Rushed',
    option2 = 'Wasteful, Extravagant',
    option3 = 'Careful, Economical',
    option4 = 'Detailed, Complete'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "thrifty"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Wasteful, Extravagant';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "thrifty"?', 'antonym', 'Wasteful, Extravagant', 'Careless, Rushed', 'Wasteful, Extravagant', 'Careful, Economical', 'Detailed, Complete', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "thrifty"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Wasteful, Extravagant'
) < 1;

UPDATE questions
SET option1 = 'Anxious, Uneasy',
    option2 = 'Shyness, Timidity',
    option3 = 'Boldness, Nerve',
    option4 = 'Disaster, Tragedy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "audacity"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Shyness, Timidity';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "audacity"?', 'antonym', 'Shyness, Timidity', 'Anxious, Uneasy', 'Shyness, Timidity', 'Boldness, Nerve', 'Disaster, Tragedy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "audacity"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Shyness, Timidity'
) < 1;

UPDATE questions
SET option1 = 'Blessing, Success',
    option2 = 'Disaster, Tragedy',
    option3 = 'Boldness, Nerve',
    option4 = 'Shiny, Gleaming'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "calamity"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Blessing, Success';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "calamity"?', 'antonym', 'Blessing, Success', 'Blessing, Success', 'Disaster, Tragedy', 'Boldness, Nerve', 'Shiny, Gleaming', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "calamity"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Blessing, Success'
) < 1;

UPDATE questions
SET option1 = 'Disaster, Tragedy',
    option2 = 'Anxious, Uneasy',
    option3 = 'Calm, Confident',
    option4 = 'Light, Easy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "apprehensive"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Calm, Confident';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "apprehensive"?', 'antonym', 'Calm, Confident', 'Disaster, Tragedy', 'Anxious, Uneasy', 'Calm, Confident', 'Light, Easy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "apprehensive"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Calm, Confident'
) < 1;

UPDATE questions
SET option1 = 'About, Regarding',
    option2 = 'Unusual, Original',
    option3 = 'Traditional, Normal',
    option4 = 'Friend, Partner'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "conventional"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Unusual, Original';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "conventional"?', 'antonym', 'Unusual, Original', 'About, Regarding', 'Unusual, Original', 'Traditional, Normal', 'Friend, Partner', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "conventional"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Unusual, Original'
) < 1;

DROP TABLE seed_quiz_id;

-- Year 5 Vocabulary Antonym Paper 3
INSERT INTO quizzes (title, description, created_by, stage_id, lock_after_attempt)
SELECT 'Year 5 Vocabulary Antonym Paper 3',
       'A 100-question Year 5 vocabulary exam asking students to identify antonym pairs.',
       1,
       (SELECT id FROM stages WHERE name = 'Year 5'),
       1
WHERE NOT EXISTS (SELECT 1 FROM quizzes WHERE title = 'Year 5 Vocabulary Antonym Paper 3');

DROP TABLE IF EXISTS seed_quiz_id;
CREATE TEMP TABLE seed_quiz_id(id INTEGER);
INSERT INTO seed_quiz_id SELECT id FROM quizzes WHERE title = 'Year 5 Vocabulary Antonym Paper 3' LIMIT 1;

UPDATE questions
SET option1 = 'Kind, Gentle',
    option2 = 'Busy, Diligent',
    option3 = 'Cruel, Harsh',
    option4 = 'Careful, Economical'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "ruthless"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Kind, Gentle';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "ruthless"?', 'antonym', 'Kind, Gentle', 'Kind, Gentle', 'Busy, Diligent', 'Cruel, Harsh', 'Careful, Economical', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "ruthless"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Kind, Gentle'
) < 1;

UPDATE questions
SET option1 = 'Secretive, Distant',
    option2 = 'Approaching, Open',
    option3 = 'Disaster, Tragedy',
    option4 = 'Boldness, Nerve'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "forthcoming"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Secretive, Distant';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "forthcoming"?', 'antonym', 'Secretive, Distant', 'Secretive, Distant', 'Approaching, Open', 'Disaster, Tragedy', 'Boldness, Nerve', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "forthcoming"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Secretive, Distant'
) < 1;

UPDATE questions
SET option1 = 'Dull, Faded',
    option2 = 'Shiny, Gleaming',
    option3 = 'Dark, Dull',
    option4 = 'Busy, Diligent'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "lustrous"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Dull, Faded';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "lustrous"?', 'antonym', 'Dull, Faded', 'Dull, Faded', 'Shiny, Gleaming', 'Dark, Dull', 'Busy, Diligent', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "lustrous"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Dull, Faded'
) < 1;

UPDATE questions
SET option1 = 'Refined, Stylish',
    option2 = 'Remove, Expel',
    option3 = 'Duty, Responsibility',
    option4 = 'Keep, Retain'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "oust"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Keep, Retain';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "oust"?', 'antonym', 'Keep, Retain', 'Refined, Stylish', 'Remove, Expel', 'Duty, Responsibility', 'Keep, Retain', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "oust"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Keep, Retain'
) < 1;

UPDATE questions
SET option1 = 'Lazy, Idle',
    option2 = 'Leave, Withdraw',
    option3 = 'Interrupt, Invade',
    option4 = 'Busy, Diligent'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "industrious"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Lazy, Idle';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "industrious"?', 'antonym', 'Lazy, Idle', 'Lazy, Idle', 'Leave, Withdraw', 'Interrupt, Invade', 'Busy, Diligent', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "industrious"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Lazy, Idle'
) < 1;

UPDATE questions
SET option1 = 'Simple, Basic',
    option2 = 'Advanced, Smart',
    option3 = 'Simple, Plain',
    option4 = 'Refined, Stylish'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "sophisticated"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Simple, Plain';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "sophisticated"?', 'antonym', 'Simple, Plain', 'Simple, Basic', 'Advanced, Smart', 'Simple, Plain', 'Refined, Stylish', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "sophisticated"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Simple, Plain'
) < 1;

UPDATE questions
SET option1 = 'Leave, Withdraw',
    option2 = 'Lazy, Idle',
    option3 = 'Interrupt, Invade',
    option4 = 'Busy, Diligent'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "intrude"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Leave, Withdraw';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "intrude"?', 'antonym', 'Leave, Withdraw', 'Leave, Withdraw', 'Lazy, Idle', 'Interrupt, Invade', 'Busy, Diligent', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "intrude"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Leave, Withdraw'
) < 1;

UPDATE questions
SET option1 = 'Empty, Drained',
    option2 = 'Empty, Drain',
    option3 = 'Refined, Stylish',
    option4 = 'Full, Refilled'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "depleted"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Full, Refilled';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "depleted"?', 'antonym', 'Full, Refilled', 'Empty, Drained', 'Empty, Drain', 'Refined, Stylish', 'Full, Refilled', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "depleted"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Full, Refilled'
) < 1;

UPDATE questions
SET option1 = 'Duty, Responsibility',
    option2 = 'Remove, Expel',
    option3 = 'Emptying, Freeing',
    option4 = 'Choice, Freedom'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "obligation"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Choice, Freedom';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "obligation"?', 'antonym', 'Choice, Freedom', 'Duty, Responsibility', 'Remove, Expel', 'Emptying, Freeing', 'Choice, Freedom', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "obligation"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Choice, Freedom'
) < 1;

UPDATE questions
SET option1 = 'Filling, Using',
    option2 = 'Interrupt, Invade',
    option3 = 'Kindness, Respect',
    option4 = 'Bullying, Trouble'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "harassment"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Kindness, Respect';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "harassment"?', 'antonym', 'Kindness, Respect', 'Filling, Using', 'Interrupt, Invade', 'Kindness, Respect', 'Bullying, Trouble', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "harassment"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Kindness, Respect'
) < 1;

UPDATE questions
SET option1 = 'Seller, Provider',
    option2 = 'Customer, Buyer',
    option3 = 'End, Halt',
    option4 = 'About, Regarding'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "client"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Seller, Provider';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "client"?', 'antonym', 'Seller, Provider', 'Seller, Provider', 'Customer, Buyer', 'End, Halt', 'About, Regarding', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "client"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Seller, Provider'
) < 1;

UPDATE questions
SET option1 = 'Shorten, Reduce',
    option2 = 'Lengthen, Expand',
    option3 = 'End, Halt',
    option4 = 'Shortage, Lack'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "abbreviate"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Lengthen, Expand';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "abbreviate"?', 'antonym', 'Lengthen, Expand', 'Shorten, Reduce', 'Lengthen, Expand', 'End, Halt', 'Shortage, Lack', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "abbreviate"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Lengthen, Expand'
) < 1;

UPDATE questions
SET option1 = 'About, Regarding',
    option2 = 'Unusual, Original',
    option3 = 'Ignoring, Unrelated',
    option4 = 'Traditional, Normal'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "concerning"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Ignoring, Unrelated';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "concerning"?', 'antonym', 'Ignoring, Unrelated', 'About, Regarding', 'Unusual, Original', 'Ignoring, Unrelated', 'Traditional, Normal', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "concerning"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Ignoring, Unrelated'
) < 1;

UPDATE questions
SET option1 = 'Bullying, Trouble',
    option2 = 'Modest, Humble',
    option3 = 'Emptying, Freeing',
    option4 = 'Filling, Using'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "occupying"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Emptying, Freeing';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "occupying"?', 'antonym', 'Emptying, Freeing', 'Bullying, Trouble', 'Modest, Humble', 'Emptying, Freeing', 'Filling, Using', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "occupying"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Emptying, Freeing'
) < 1;

UPDATE questions
SET option1 = 'Begin, Continue',
    option2 = 'About, Regarding',
    option3 = 'End, Halt',
    option4 = 'Customer, Buyer'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "cease"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Begin, Continue';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "cease"?', 'antonym', 'Begin, Continue', 'Begin, Continue', 'About, Regarding', 'End, Halt', 'Customer, Buyer', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "cease"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Begin, Continue'
) < 1;

UPDATE questions
SET option1 = 'Tell, Notify',
    option2 = 'Lazy, Idle',
    option3 = 'Interrupt, Invade',
    option4 = 'Hide, Conceal'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "inform"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Hide, Conceal';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "inform"?', 'antonym', 'Hide, Conceal', 'Tell, Notify', 'Lazy, Idle', 'Interrupt, Invade', 'Hide, Conceal', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "inform"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Hide, Conceal'
) < 1;

UPDATE questions
SET option1 = 'Uncertain, Confused',
    option2 = 'Determined, Settled',
    option3 = 'Settle, Fix',
    option4 = 'Practise, Prepare'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "resolved"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Uncertain, Confused';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "resolved"?', 'antonym', 'Uncertain, Confused', 'Uncertain, Confused', 'Determined, Settled', 'Settle, Fix', 'Practise, Prepare', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "resolved"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Uncertain, Confused'
) < 1;

UPDATE questions
SET option1 = 'Possibility, Chance',
    option2 = 'Impossibility, Past',
    option3 = 'Defend, Protect',
    option4 = 'Charge, Accuse'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "prosecute"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Defend, Protect';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "prosecute"?', 'antonym', 'Defend, Protect', 'Possibility, Chance', 'Impossibility, Past', 'Defend, Protect', 'Charge, Accuse', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "prosecute"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Defend, Protect'
) < 1;

UPDATE questions
SET option1 = 'Filling, Using',
    option2 = 'Proud, Showy',
    option3 = 'Modest, Humble',
    option4 = 'Rude, Crude'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "unassuming"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Proud, Showy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "unassuming"?', 'antonym', 'Proud, Showy', 'Filling, Using', 'Proud, Showy', 'Modest, Humble', 'Rude, Crude', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "unassuming"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Proud, Showy'
) < 1;

UPDATE questions
SET option1 = 'Possibility, Chance',
    option2 = 'Defend, Protect',
    option3 = 'Charge, Accuse',
    option4 = 'Impossibility, Past'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "prospect"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Impossibility, Past';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "prospect"?', 'antonym', 'Impossibility, Past', 'Possibility, Chance', 'Defend, Protect', 'Charge, Accuse', 'Impossibility, Past', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "prospect"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Impossibility, Past'
) < 1;

UPDATE questions
SET option1 = 'Quit, Give up',
    option2 = 'Serious, Grave',
    option3 = 'Persist, Survive',
    option4 = 'Last, Survive'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "endure"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Quit, Give up';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "endure"?', 'antonym', 'Quit, Give up', 'Quit, Give up', 'Serious, Grave', 'Persist, Survive', 'Last, Survive', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "endure"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Quit, Give up'
) < 1;

UPDATE questions
SET option1 = 'Sign, Warning',
    option2 = 'Cheerful, Playful',
    option3 = 'Pitiful, Weak',
    option4 = 'Serious, Grave'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "solemn"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Cheerful, Playful';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "solemn"?', 'antonym', 'Cheerful, Playful', 'Sign, Warning', 'Cheerful, Playful', 'Pitiful, Weak', 'Serious, Grave', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "solemn"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Cheerful, Playful'
) < 1;

UPDATE questions
SET option1 = 'Sink, Dunk',
    option2 = 'Float, Rise',
    option3 = 'Sink, Drown',
    option4 = 'Rise, Surface'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "submerge"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Rise, Surface';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "submerge"?', 'antonym', 'Rise, Surface', 'Sink, Dunk', 'Float, Rise', 'Sink, Drown', 'Rise, Surface', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "submerge"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Rise, Surface'
) < 1;

UPDATE questions
SET option1 = 'Rise, Surface',
    option2 = 'Assurance, Comfort',
    option3 = 'Sign, Warning',
    option4 = 'Sink, Dunk'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "omen"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Assurance, Comfort';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "omen"?', 'antonym', 'Assurance, Comfort', 'Rise, Surface', 'Assurance, Comfort', 'Sign, Warning', 'Sink, Dunk', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "omen"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Assurance, Comfort'
) < 1;

UPDATE questions
SET option1 = 'Impossibility, Past',
    option2 = 'Main, Head',
    option3 = 'Pitiful, Weak',
    option4 = 'Strong, Impressive'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "pathetic"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Strong, Impressive';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "pathetic"?', 'antonym', 'Strong, Impressive', 'Impossibility, Past', 'Main, Head', 'Pitiful, Weak', 'Strong, Impressive', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "pathetic"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Strong, Impressive'
) < 1;

UPDATE questions
SET option1 = 'Main, Head',
    option2 = 'Minor, Unimportant',
    option3 = 'Original, Principal',
    option4 = 'Best, Main'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "principal"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Minor, Unimportant';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "principal"?', 'antonym', 'Minor, Unimportant', 'Main, Head', 'Minor, Unimportant', 'Original, Principal', 'Best, Main', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "principal"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Minor, Unimportant'
) < 1;

UPDATE questions
SET option1 = 'Modern, Plain',
    option2 = 'Odd, Unique',
    option3 = 'Normal, Plain',
    option4 = 'Main, Head'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "quirky"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Normal, Plain';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "quirky"?', 'antonym', 'Normal, Plain', 'Modern, Plain', 'Odd, Unique', 'Normal, Plain', 'Main, Head', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "quirky"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Normal, Plain'
) < 1;

UPDATE questions
SET option1 = 'Determined, Settled',
    option2 = 'Perform, Stop',
    option3 = 'Practise, Prepare',
    option4 = 'Comfort, Calm'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "rehearse"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Perform, Stop';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "rehearse"?', 'antonym', 'Perform, Stop', 'Determined, Settled', 'Perform, Stop', 'Practise, Prepare', 'Comfort, Calm', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "rehearse"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Perform, Stop'
) < 1;

UPDATE questions
SET option1 = 'Nice, Pleasant',
    option2 = 'Dirty, Messy',
    option3 = 'Messy, Unclear',
    option4 = 'Clear, Readable'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "legible"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Messy, Unclear';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "legible"?', 'antonym', 'Messy, Unclear', 'Nice, Pleasant', 'Dirty, Messy', 'Messy, Unclear', 'Clear, Readable', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "legible"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Messy, Unclear'
) < 1;

UPDATE questions
SET option1 = 'Minor, Unimportant',
    option2 = 'Main, Head',
    option3 = 'Signalled, Motioned',
    option4 = 'Hid, Ignored'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "gestured"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Hid, Ignored';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "gestured"?', 'antonym', 'Hid, Ignored', 'Minor, Unimportant', 'Main, Head', 'Signalled, Motioned', 'Hid, Ignored', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "gestured"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Hid, Ignored'
) < 1;

UPDATE questions
SET option1 = 'Huge, Enormous',
    option2 = 'Tiny, Small',
    option3 = 'Vast, Huge',
    option4 = 'Spotless, Perfect'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "immense"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Tiny, Small';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "immense"?', 'antonym', 'Tiny, Small', 'Huge, Enormous', 'Tiny, Small', 'Vast, Huge', 'Spotless, Perfect', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "immense"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Tiny, Small'
) < 1;

UPDATE questions
SET option1 = 'Nice, Pleasant',
    option2 = 'Trial, Hardship',
    option3 = 'Pleasure, Treat',
    option4 = 'Signalled, Motioned'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "ordeal"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Pleasure, Treat';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "ordeal"?', 'antonym', 'Pleasure, Treat', 'Nice, Pleasant', 'Trial, Hardship', 'Pleasure, Treat', 'Signalled, Motioned', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "ordeal"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Pleasure, Treat'
) < 1;

UPDATE questions
SET option1 = 'Clumsy, Awkward',
    option2 = 'Build, Repair',
    option3 = 'Skilful, Nimble',
    option4 = 'Destroy, Flatten'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "demolish"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Build, Repair';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "demolish"?', 'antonym', 'Build, Repair', 'Clumsy, Awkward', 'Build, Repair', 'Skilful, Nimble', 'Destroy, Flatten', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "demolish"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Build, Repair'
) < 1;

UPDATE questions
SET option1 = 'Clear, Readable',
    option2 = 'Nice, Pleasant',
    option3 = 'Unpleasant, Rude',
    option4 = 'Skilful, Nimble'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "agreeable"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Unpleasant, Rude';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "agreeable"?', 'antonym', 'Unpleasant, Rude', 'Clear, Readable', 'Nice, Pleasant', 'Unpleasant, Rude', 'Skilful, Nimble', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "agreeable"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Unpleasant, Rude'
) < 1;

UPDATE questions
SET option1 = 'Spotless, Perfect',
    option2 = 'Shield, Protection',
    option3 = 'Gun, Artillery',
    option4 = 'Face, Challenge'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "cannon"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Shield, Protection';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "cannon"?', 'antonym', 'Shield, Protection', 'Spotless, Perfect', 'Shield, Protection', 'Gun, Artillery', 'Face, Challenge', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "cannon"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Shield, Protection'
) < 1;

UPDATE questions
SET option1 = 'Handy, Useful',
    option2 = 'Avoid, Escape',
    option3 = 'About, Regarding',
    option4 = 'Face, Challenge'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "confront"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Avoid, Escape';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "confront"?', 'antonym', 'Avoid, Escape', 'Handy, Useful', 'Avoid, Escape', 'About, Regarding', 'Face, Challenge', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "confront"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Avoid, Escape'
) < 1;

UPDATE questions
SET option1 = 'Destroy, Flatten',
    option2 = 'Skilful, Nimble',
    option3 = 'Clumsy, Awkward',
    option4 = 'Build, Repair'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "deft"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Clumsy, Awkward';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "deft"?', 'antonym', 'Clumsy, Awkward', 'Destroy, Flatten', 'Skilful, Nimble', 'Clumsy, Awkward', 'Build, Repair', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "deft"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Clumsy, Awkward'
) < 1;

UPDATE questions
SET option1 = 'Household, Home',
    option2 = 'Foreign, Wild',
    option3 = 'Build, Repair',
    option4 = 'Grand, Regal'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "domestic"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Foreign, Wild';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "domestic"?', 'antonym', 'Foreign, Wild', 'Household, Home', 'Foreign, Wild', 'Build, Repair', 'Grand, Regal', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "domestic"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Foreign, Wild'
) < 1;

UPDATE questions
SET option1 = 'Greedy, Hungry',
    option2 = 'Moderate, Careful',
    option3 = 'Nice, Pleasant',
    option4 = 'Grand, Regal'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "gluttonous"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Moderate, Careful';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "gluttonous"?', 'antonym', 'Moderate, Careful', 'Greedy, Hungry', 'Moderate, Careful', 'Nice, Pleasant', 'Grand, Regal', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "gluttonous"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Moderate, Careful'
) < 1;

UPDATE questions
SET option1 = 'Tiny, Small',
    option2 = 'Spotless, Perfect',
    option3 = 'Huge, Enormous',
    option4 = 'Dirty, Messy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "immaculate"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Dirty, Messy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "immaculate"?', 'antonym', 'Dirty, Messy', 'Tiny, Small', 'Spotless, Perfect', 'Huge, Enormous', 'Dirty, Messy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "immaculate"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Dirty, Messy'
) < 1;

UPDATE questions
SET option1 = 'Awful, Ordinary',
    option2 = 'Household, Home',
    option3 = 'Plain, Ordinary',
    option4 = 'Grand, Regal'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "majestic"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Plain, Ordinary';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "majestic"?', 'antonym', 'Plain, Ordinary', 'Awful, Ordinary', 'Household, Home', 'Plain, Ordinary', 'Grand, Regal', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "majestic"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Plain, Ordinary'
) < 1;

UPDATE questions
SET option1 = 'Support, Agree',
    option2 = 'Free, Help',
    option3 = 'Resist, Disagree',
    option4 = 'Control, Bully'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "oppress"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Free, Help';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "oppress"?', 'antonym', 'Free, Help', 'Support, Agree', 'Free, Help', 'Resist, Disagree', 'Control, Bully', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "oppress"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Free, Help'
) < 1;

UPDATE questions
SET option1 = 'Unavoidable, Certain',
    option2 = 'Spotless, Perfect',
    option3 = 'Empty, Deserted',
    option4 = 'Occupied, Settled'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "inhabited"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Empty, Deserted';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "inhabited"?', 'antonym', 'Empty, Deserted', 'Unavoidable, Certain', 'Spotless, Perfect', 'Empty, Deserted', 'Occupied, Settled', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "inhabited"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Empty, Deserted'
) < 1;

UPDATE questions
SET option1 = 'Clumsy, Awkward',
    option2 = 'Skilful, Nimble',
    option3 = 'Agile, Quick',
    option4 = 'Clumsy, Slow'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "nimble"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Clumsy, Slow';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "nimble"?', 'antonym', 'Clumsy, Slow', 'Clumsy, Awkward', 'Skilful, Nimble', 'Agile, Quick', 'Clumsy, Slow', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "nimble"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Clumsy, Slow'
) < 1;

UPDATE questions
SET option1 = 'Control, Bully',
    option2 = 'Free, Help',
    option3 = 'Support, Agree',
    option4 = 'Resist, Disagree'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "oppose"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Support, Agree';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "oppose"?', 'antonym', 'Support, Agree', 'Control, Bully', 'Free, Help', 'Support, Agree', 'Resist, Disagree', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "oppose"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Support, Agree'
) < 1;

UPDATE questions
SET option1 = 'Trivial, Small-minded',
    option2 = 'Important, Generous',
    option3 = 'Represent, Humanise',
    option4 = 'Ignore, Literalise'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "personify"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Ignore, Literalise';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "personify"?', 'antonym', 'Ignore, Literalise', 'Trivial, Small-minded', 'Important, Generous', 'Represent, Humanise', 'Ignore, Literalise', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "personify"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Ignore, Literalise'
) < 1;

UPDATE questions
SET option1 = 'Improve, Advance',
    option2 = 'Prevent, Block',
    option3 = 'Fail, Decline',
    option4 = 'Support, Encourage'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "progress"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Fail, Decline';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "progress"?', 'antonym', 'Fail, Decline', 'Improve, Advance', 'Prevent, Block', 'Fail, Decline', 'Support, Encourage', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "progress"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Fail, Decline'
) < 1;

UPDATE questions
SET option1 = 'Comfort, Calm',
    option2 = 'Repeat, Say',
    option3 = 'Forget, Mumble',
    option4 = 'Worry, Frighten'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "reassure"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Worry, Frighten';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "reassure"?', 'antonym', 'Worry, Frighten', 'Comfort, Calm', 'Repeat, Say', 'Forget, Mumble', 'Worry, Frighten', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "reassure"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Worry, Frighten'
) < 1;

UPDATE questions
SET option1 = 'Well-behaved, Loyal',
    option2 = 'Resist, Disagree',
    option3 = 'Grove, Farm',
    option4 = 'Disobedient, Naughty'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "obedient"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Disobedient, Naughty';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "obedient"?', 'antonym', 'Disobedient, Naughty', 'Well-behaved, Loyal', 'Resist, Disagree', 'Grove, Farm', 'Disobedient, Naughty', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "obedient"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Disobedient, Naughty'
) < 1;

UPDATE questions
SET option1 = 'Control, Bully',
    option2 = 'Calm, Control',
    option3 = 'Explosion, Burst',
    option4 = 'Comfort, Calm'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "outburst"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Calm, Control';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "outburst"?', 'antonym', 'Calm, Control', 'Control, Bully', 'Calm, Control', 'Explosion, Burst', 'Comfort, Calm', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "outburst"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Calm, Control'
) < 1;

UPDATE questions
SET option1 = 'Trivial, Small-minded',
    option2 = 'Represent, Humanise',
    option3 = 'Important, Generous',
    option4 = 'Convince, Encourage'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "petty"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Important, Generous';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "petty"?', 'antonym', 'Important, Generous', 'Trivial, Small-minded', 'Represent, Humanise', 'Important, Generous', 'Convince, Encourage', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "petty"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Important, Generous'
) < 1;

UPDATE questions
SET option1 = 'Pierce, Prick',
    option2 = 'Support, Encourage',
    option3 = 'Seal, Mend',
    option4 = 'Trivial, Small-minded'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "puncture"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Seal, Mend';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "puncture"?', 'antonym', 'Seal, Mend', 'Pierce, Prick', 'Support, Encourage', 'Seal, Mend', 'Trivial, Small-minded', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "puncture"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Seal, Mend'
) < 1;

UPDATE questions
SET option1 = 'Guess, Memory',
    option2 = 'Forget, Mumble',
    option3 = 'Proof, Ticket',
    option4 = 'Repeat, Say'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "recite"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Forget, Mumble';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "recite"?', 'antonym', 'Forget, Mumble', 'Guess, Memory', 'Forget, Mumble', 'Proof, Ticket', 'Repeat, Say', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "recite"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Forget, Mumble'
) < 1;

UPDATE questions
SET option1 = 'Grove, Farm',
    option2 = 'Desert, Wasteland',
    option3 = 'Trial, Hardship',
    option4 = 'Well-behaved, Loyal'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "orchard"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Desert, Wasteland';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "orchard"?', 'antonym', 'Desert, Wasteland', 'Grove, Farm', 'Desert, Wasteland', 'Trial, Hardship', 'Well-behaved, Loyal', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "orchard"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Desert, Wasteland'
) < 1;

UPDATE questions
SET option1 = 'Convince, Encourage',
    option2 = 'Support, Encourage',
    option3 = 'Trivial, Small-minded',
    option4 = 'Deter, Discourage'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "persuade"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Deter, Discourage';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "persuade"?', 'antonym', 'Deter, Discourage', 'Convince, Encourage', 'Support, Encourage', 'Trivial, Small-minded', 'Deter, Discourage', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "persuade"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Deter, Discourage'
) < 1;

UPDATE questions
SET option1 = 'Support, Encourage',
    option2 = 'Convince, Encourage',
    option3 = 'Prevent, Block',
    option4 = 'Improve, Advance'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "promote"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Prevent, Block';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "promote"?', 'antonym', 'Prevent, Block', 'Support, Encourage', 'Convince, Encourage', 'Prevent, Block', 'Improve, Advance', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "promote"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Prevent, Block'
) < 1;

UPDATE questions
SET option1 = 'Proof, Ticket',
    option2 = 'Repeat, Say',
    option3 = 'Guess, Memory',
    option4 = 'Home, House'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "receipt"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Guess, Memory';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "receipt"?', 'antonym', 'Guess, Memory', 'Proof, Ticket', 'Repeat, Say', 'Guess, Memory', 'Home, House', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "receipt"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Guess, Memory'
) < 1;

UPDATE questions
SET option1 = 'Repeat, Say',
    option2 = 'Workplace, Office',
    option3 = 'Proof, Ticket',
    option4 = 'Home, House'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "residence"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Workplace, Office';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "residence"?', 'antonym', 'Workplace, Office', 'Repeat, Say', 'Workplace, Office', 'Proof, Ticket', 'Home, House', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "residence"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Workplace, Office'
) < 1;

UPDATE questions
SET option1 = 'Support, Encourage',
    option2 = 'Insufficient, Poor',
    option3 = 'Convince, Encourage',
    option4 = 'Sufficient, Enough'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "adequate"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Insufficient, Poor';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "adequate"?', 'antonym', 'Insufficient, Poor', 'Support, Encourage', 'Insufficient, Poor', 'Convince, Encourage', 'Sufficient, Enough', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "adequate"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Insufficient, Poor'
) < 1;

UPDATE questions
SET option1 = 'Plenty, Lots',
    option2 = 'Shortage, Lack',
    option3 = 'Shorten, Reduce',
    option4 = 'Sufficient, Enough'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "abundance"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Shortage, Lack';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "abundance"?', 'antonym', 'Shortage, Lack', 'Plenty, Lots', 'Shortage, Lack', 'Shorten, Reduce', 'Sufficient, Enough', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "abundance"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Shortage, Lack'
) < 1;

UPDATE questions
SET option1 = 'Support, Encourage',
    option2 = 'Finish, End',
    option3 = 'Handy, Useful',
    option4 = 'Begin, Start'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "embark"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Finish, End';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "embark"?', 'antonym', 'Finish, End', 'Support, Encourage', 'Finish, End', 'Handy, Useful', 'Begin, Start', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "embark"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Finish, End'
) < 1;

UPDATE questions
SET option1 = 'Morals, Sense',
    option2 = 'Handy, Useful',
    option3 = 'Carelessness, Guiltless',
    option4 = 'Awkward, Difficult'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "conscience"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Carelessness, Guiltless';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "conscience"?', 'antonym', 'Carelessness, Guiltless', 'Morals, Sense', 'Handy, Useful', 'Carelessness, Guiltless', 'Awkward, Difficult', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "conscience"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Carelessness, Guiltless'
) < 1;

UPDATE questions
SET option1 = 'Morals, Sense',
    option2 = 'Carelessness, Guiltless',
    option3 = 'Awkward, Difficult',
    option4 = 'Handy, Useful'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "convenient"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Awkward, Difficult';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "convenient"?', 'antonym', 'Awkward, Difficult', 'Morals, Sense', 'Carelessness, Guiltless', 'Awkward, Difficult', 'Handy, Useful', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "convenient"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Awkward, Difficult'
) < 1;

UPDATE questions
SET option1 = 'Sadness, Gloom',
    option2 = 'Joy, Happiness',
    option3 = 'Cruelty, Harshness',
    option4 = 'Kindness, Pity'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "mercy"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Cruelty, Harshness';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "mercy"?', 'antonym', 'Cruelty, Harshness', 'Sadness, Gloom', 'Joy, Happiness', 'Cruelty, Harshness', 'Kindness, Pity', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "mercy"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Cruelty, Harshness'
) < 1;

UPDATE questions
SET option1 = 'Miss, Overlook',
    option2 = 'Notice, Respect',
    option3 = 'Notice, Recognise',
    option4 = 'Ignore, Overlook'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "discern"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Miss, Overlook';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "discern"?', 'antonym', 'Miss, Overlook', 'Miss, Overlook', 'Notice, Respect', 'Notice, Recognise', 'Ignore, Overlook', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "discern"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Miss, Overlook'
) < 1;

UPDATE questions
SET option1 = 'Possible, Attainable',
    option2 = 'Achieve, Complete',
    option3 = 'Impossible, Unlikely',
    option4 = 'Fail, Abandon'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "accomplish"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Fail, Abandon';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "accomplish"?', 'antonym', 'Fail, Abandon', 'Possible, Attainable', 'Achieve, Complete', 'Impossible, Unlikely', 'Fail, Abandon', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "accomplish"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Fail, Abandon'
) < 1;

UPDATE questions
SET option1 = 'Hide, Conceal',
    option2 = 'Announce, Transmit',
    option3 = 'Morals, Sense',
    option4 = 'Notice, Recognise'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "broadcast"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Hide, Conceal';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "broadcast"?', 'antonym', 'Hide, Conceal', 'Hide, Conceal', 'Announce, Transmit', 'Morals, Sense', 'Notice, Recognise', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "broadcast"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Hide, Conceal'
) < 1;

UPDATE questions
SET option1 = 'Preventable, Unlikely',
    option2 = 'Thinkable, Likely',
    option3 = 'Unavoidable, Certain',
    option4 = 'Miserable, Awful'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "inevitable"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Preventable, Unlikely';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "inevitable"?', 'antonym', 'Preventable, Unlikely', 'Preventable, Unlikely', 'Thinkable, Likely', 'Unavoidable, Certain', 'Miserable, Awful', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "inevitable"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Preventable, Unlikely'
) < 1;

UPDATE questions
SET option1 = 'Harm, Problem',
    option2 = 'Transform, Change',
    option3 = 'Cure, Solution',
    option4 = 'Preserve, Keep'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "remedy"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Harm, Problem';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "remedy"?', 'antonym', 'Harm, Problem', 'Harm, Problem', 'Transform, Change', 'Cure, Solution', 'Preserve, Keep', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "remedy"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Harm, Problem'
) < 1;

UPDATE questions
SET option1 = 'Polite, Charming',
    option2 = 'Peace, Agreement',
    option3 = 'Often, Frequently',
    option4 = 'Scuffle, Clash'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "skirmish"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Peace, Agreement';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "skirmish"?', 'antonym', 'Peace, Agreement', 'Polite, Charming', 'Peace, Agreement', 'Often, Frequently', 'Scuffle, Clash', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "skirmish"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Peace, Agreement'
) < 1;

UPDATE questions
SET option1 = 'Feel, Surface',
    option2 = 'Smoothness, Flatness',
    option3 = 'Excitement, Fun',
    option4 = 'Boredom, Dullness'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "tedium"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Excitement, Fun';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "tedium"?', 'antonym', 'Excitement, Fun', 'Feel, Surface', 'Smoothness, Flatness', 'Excitement, Fun', 'Boredom, Dullness', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "tedium"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Excitement, Fun'
) < 1;

UPDATE questions
SET option1 = 'Area, Neighbourhood',
    option2 = 'Rarely, Hardly',
    option3 = 'Announce, Transmit',
    option4 = 'Distance, Far away'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "vicinity"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Distance, Far away';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "vicinity"?', 'antonym', 'Distance, Far away', 'Area, Neighbourhood', 'Rarely, Hardly', 'Announce, Transmit', 'Distance, Far away', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "vicinity"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Distance, Far away'
) < 1;

UPDATE questions
SET option1 = 'Miserable, Awful',
    option2 = 'Happy, Content',
    option3 = 'Cheerful, Happy',
    option4 = 'Polite, Thoughtful'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "wretched"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Happy, Content';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "wretched"?', 'antonym', 'Happy, Content', 'Miserable, Awful', 'Happy, Content', 'Cheerful, Happy', 'Polite, Thoughtful', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "wretched"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Happy, Content'
) < 1;

UPDATE questions
SET option1 = 'Awkward, Rude',
    option2 = 'Cheerful, Happy',
    option3 = 'Moody, Gloomy',
    option4 = 'Polite, Charming'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "suave"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Awkward, Rude';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "suave"?', 'antonym', 'Awkward, Rude', 'Awkward, Rude', 'Cheerful, Happy', 'Moody, Gloomy', 'Polite, Charming', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "suave"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Awkward, Rude'
) < 1;

UPDATE questions
SET option1 = 'Rarely, Hardly',
    option2 = 'Moody, Gloomy',
    option3 = 'Often, Frequently',
    option4 = 'Polite, Charming'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "seldom"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Often, Frequently';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "seldom"?', 'antonym', 'Often, Frequently', 'Rarely, Hardly', 'Moody, Gloomy', 'Often, Frequently', 'Polite, Charming', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "seldom"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Often, Frequently'
) < 1;

UPDATE questions
SET option1 = 'Shortage, Lack',
    option2 = 'Polite, Charming',
    option3 = 'Examine, Inspect',
    option4 = 'Ignore, Overlook'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "scrutinise"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Ignore, Overlook';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "scrutinise"?', 'antonym', 'Ignore, Overlook', 'Shortage, Lack', 'Polite, Charming', 'Examine, Inspect', 'Ignore, Overlook', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "scrutinise"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Ignore, Overlook'
) < 1;

UPDATE questions
SET option1 = 'Awkward, Rude',
    option2 = 'Polite, Charming',
    option3 = 'Cheerful, Happy',
    option4 = 'Moody, Gloomy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "sullen"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Cheerful, Happy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "sullen"?', 'antonym', 'Cheerful, Happy', 'Awkward, Rude', 'Polite, Charming', 'Cheerful, Happy', 'Moody, Gloomy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "sullen"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Cheerful, Happy'
) < 1;

UPDATE questions
SET option1 = 'Rude, Blunt',
    option2 = 'Polite, Charming',
    option3 = 'Polite, Thoughtful',
    option4 = 'Rude, Crude'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "tactful"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Rude, Blunt';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "tactful"?', 'antonym', 'Rude, Blunt', 'Rude, Blunt', 'Polite, Charming', 'Polite, Thoughtful', 'Rude, Crude', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "tactful"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Rude, Blunt'
) < 1;

UPDATE questions
SET option1 = 'Shortage, Lack',
    option2 = 'Examine, Inspect',
    option3 = 'Pretence, Dishonesty',
    option4 = 'Honesty, Truth'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "sincerity"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Pretence, Dishonesty';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "sincerity"?', 'antonym', 'Pretence, Dishonesty', 'Shortage, Lack', 'Examine, Inspect', 'Pretence, Dishonesty', 'Honesty, Truth', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "sincerity"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Pretence, Dishonesty'
) < 1;

UPDATE questions
SET option1 = 'Feel, Surface',
    option2 = 'Excitement, Fun',
    option3 = 'Boredom, Dullness',
    option4 = 'Smoothness, Flatness'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "texture"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Smoothness, Flatness';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "texture"?', 'antonym', 'Smoothness, Flatness', 'Feel, Surface', 'Excitement, Fun', 'Boredom, Dullness', 'Smoothness, Flatness', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "texture"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Smoothness, Flatness'
) < 1;

UPDATE questions
SET option1 = 'Rude, Crude',
    option2 = 'Rude, Blunt',
    option3 = 'Polite, Thoughtful',
    option4 = 'Polite, Refined'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "uncouth"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Polite, Refined';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "uncouth"?', 'antonym', 'Polite, Refined', 'Rude, Crude', 'Rude, Blunt', 'Polite, Thoughtful', 'Polite, Refined', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "uncouth"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Polite, Refined'
) < 1;

UPDATE questions
SET option1 = 'Liquid, Solid',
    option2 = 'Steam, Mist',
    option3 = 'Limited, Fixed',
    option4 = 'Flexible, Adaptable'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "versatile"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Limited, Fixed';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "versatile"?', 'antonym', 'Limited, Fixed', 'Liquid, Solid', 'Steam, Mist', 'Limited, Fixed', 'Flexible, Adaptable', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "versatile"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Limited, Fixed'
) < 1;

UPDATE questions
SET option1 = 'Sadness, Gloom',
    option2 = 'Joy, Happiness',
    option3 = 'Kindness, Pity',
    option4 = 'Healthy, Good'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "melancholy"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Joy, Happiness';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "melancholy"?', 'antonym', 'Joy, Happiness', 'Sadness, Gloom', 'Joy, Happiness', 'Kindness, Pity', 'Healthy, Good', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "melancholy"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Joy, Happiness'
) < 1;

UPDATE questions
SET option1 = 'Cure, Solution',
    option2 = 'Transform, Change',
    option3 = 'Preserve, Keep',
    option4 = 'Owe, Keep'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "revolutionise"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Preserve, Keep';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "revolutionise"?', 'antonym', 'Preserve, Keep', 'Cure, Solution', 'Transform, Change', 'Preserve, Keep', 'Owe, Keep', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "revolutionise"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Preserve, Keep'
) < 1;

UPDATE questions
SET option1 = 'Examine, Inspect',
    option2 = 'Alone, Single',
    option3 = 'Shortage, Lack',
    option4 = 'Plenty, Abundance'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "scarcity"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Plenty, Abundance';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "scarcity"?', 'antonym', 'Plenty, Abundance', 'Examine, Inspect', 'Alone, Single', 'Shortage, Lack', 'Plenty, Abundance', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "scarcity"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Plenty, Abundance'
) < 1;

UPDATE questions
SET option1 = 'Alone, Single',
    option2 = 'Dusk, Evening',
    option3 = 'Reduce, Ease',
    option4 = 'Dawn, Morning'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "twilight"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Dawn, Morning';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "twilight"?', 'antonym', 'Dawn, Morning', 'Alone, Single', 'Dusk, Evening', 'Reduce, Ease', 'Dawn, Morning', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "twilight"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Dawn, Morning'
) < 1;

UPDATE questions
SET option1 = 'Steam, Mist',
    option2 = 'Liquid, Solid',
    option3 = 'Limited, Fixed',
    option4 = 'Alone, Single'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "vapour"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Liquid, Solid';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "vapour"?', 'antonym', 'Liquid, Solid', 'Steam, Mist', 'Liquid, Solid', 'Limited, Fixed', 'Alone, Single', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "vapour"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Liquid, Solid'
) < 1;

UPDATE questions
SET option1 = 'Deserving, Good',
    option2 = 'Sadness, Gloom',
    option3 = 'Healthy, Good',
    option4 = 'Unhealthy, Bad'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "wholesome"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Unhealthy, Bad';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "wholesome"?', 'antonym', 'Unhealthy, Bad', 'Deserving, Good', 'Sadness, Gloom', 'Healthy, Good', 'Unhealthy, Bad', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "wholesome"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Unhealthy, Bad'
) < 1;

UPDATE questions
SET option1 = 'Alone, Single',
    option2 = 'Shortage, Lack',
    option3 = 'Social, Together',
    option4 = 'Prompt, On time'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "solitary"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Social, Together';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "solitary"?', 'antonym', 'Social, Together', 'Alone, Single', 'Shortage, Lack', 'Social, Together', 'Prompt, On time', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "solitary"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Social, Together'
) < 1;

UPDATE questions
SET option1 = 'Pierce, Prick',
    option2 = 'Late, Tardy',
    option3 = 'Promise, Assure',
    option4 = 'Prompt, On time'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "punctual"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Late, Tardy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "punctual"?', 'antonym', 'Late, Tardy', 'Pierce, Prick', 'Late, Tardy', 'Promise, Assure', 'Prompt, On time', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "punctual"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Late, Tardy'
) < 1;

UPDATE questions
SET option1 = 'Tiny, Small',
    option2 = 'Worsen, Increase',
    option3 = 'Promise, Assure',
    option4 = 'Reduce, Ease'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "mitigate"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Worsen, Increase';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "mitigate"?', 'antonym', 'Worsen, Increase', 'Tiny, Small', 'Worsen, Increase', 'Promise, Assure', 'Reduce, Ease', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "mitigate"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Worsen, Increase'
) < 1;

UPDATE questions
SET option1 = 'Discuss, Grant',
    option2 = 'Agree, Support',
    option3 = 'Disagree, Deny',
    option4 = 'Refuse, Deny'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "confer"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Refuse, Deny';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "confer"?', 'antonym', 'Refuse, Deny', 'Discuss, Grant', 'Agree, Support', 'Disagree, Deny', 'Refuse, Deny', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "confer"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Refuse, Deny'
) < 1;

UPDATE questions
SET option1 = 'Discuss, Grant',
    option2 = 'Disagree, Deny',
    option3 = 'Agree, Support',
    option4 = 'Refuse, Deny'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "contradict"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Agree, Support';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "contradict"?', 'antonym', 'Agree, Support', 'Discuss, Grant', 'Disagree, Deny', 'Agree, Support', 'Refuse, Deny', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "contradict"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Agree, Support'
) < 1;

UPDATE questions
SET option1 = 'Doubt, Deny',
    option2 = 'Promise, Assure',
    option3 = 'Refuse, Deny',
    option4 = 'Disagree, Deny'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "guarantee"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Doubt, Deny';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "guarantee"?', 'antonym', 'Doubt, Deny', 'Doubt, Deny', 'Promise, Assure', 'Refuse, Deny', 'Disagree, Deny', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "guarantee"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Doubt, Deny'
) < 1;

UPDATE questions
SET option1 = 'Sleeplessness, Restlessness',
    option2 = 'Lucky, Fortunate',
    option3 = 'Unlucky, Unfortunate',
    option4 = 'Prompt, On time'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "hapless"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Lucky, Fortunate';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "hapless"?', 'antonym', 'Lucky, Fortunate', 'Sleeplessness, Restlessness', 'Lucky, Fortunate', 'Unlucky, Unfortunate', 'Prompt, On time', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "hapless"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Lucky, Fortunate'
) < 1;

UPDATE questions
SET option1 = 'Sleeplessness, Restlessness',
    option2 = 'Sleep, Rest',
    option3 = 'Priceless, Vital',
    option4 = 'Rude, Cheeky'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "insomnia"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Sleep, Rest';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "insomnia"?', 'antonym', 'Sleep, Rest', 'Sleeplessness, Restlessness', 'Sleep, Rest', 'Priceless, Vital', 'Rude, Cheeky', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "insomnia"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Sleep, Rest'
) < 1;

UPDATE questions
SET option1 = 'Explorer, Leader',
    option2 = 'Serious, Sad',
    option3 = 'Playful, Humorous',
    option4 = 'Satisfy, Extinguish'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "jocular"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Serious, Sad';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "jocular"?', 'antonym', 'Serious, Sad', 'Explorer, Leader', 'Serious, Sad', 'Playful, Humorous', 'Satisfy, Extinguish', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "jocular"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Serious, Sad'
) < 1;

UPDATE questions
SET option1 = 'Gentle, Kind',
    option2 = 'Disagree, Deny',
    option3 = 'Strict, Harsh',
    option4 = 'Essential, Required'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "lenient"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Strict, Harsh';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "lenient"?', 'antonym', 'Strict, Harsh', 'Gentle, Kind', 'Disagree, Deny', 'Strict, Harsh', 'Essential, Required', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "lenient"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Strict, Harsh'
) < 1;

UPDATE questions
SET option1 = 'Version, Performance',
    option2 = 'Image, Name',
    option3 = 'Blame, Criticise',
    option4 = 'Praise, Approve'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "reproach"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Praise, Approve';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "reproach"?', 'antonym', 'Praise, Approve', 'Version, Performance', 'Image, Name', 'Blame, Criticise', 'Praise, Approve', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "reproach"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Praise, Approve'
) < 1;

UPDATE questions
SET option1 = 'Dry, Ignite',
    option2 = 'Charming, Cute',
    option3 = 'Gentle, Kind',
    option4 = 'Satisfy, Extinguish'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "quench"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Dry, Ignite';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "quench"?', 'antonym', 'Dry, Ignite', 'Dry, Ignite', 'Charming, Cute', 'Gentle, Kind', 'Satisfy, Extinguish', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "quench"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Dry, Ignite'
) < 1;

DROP TABLE seed_quiz_id;

-- Year 5 Vocabulary Antonym Paper 4
INSERT INTO quizzes (title, description, created_by, stage_id, lock_after_attempt)
SELECT 'Year 5 Vocabulary Antonym Paper 4',
       'A 65-question Year 5 vocabulary exam asking students to identify antonym pairs.',
       1,
       (SELECT id FROM stages WHERE name = 'Year 5'),
       1
WHERE NOT EXISTS (SELECT 1 FROM quizzes WHERE title = 'Year 5 Vocabulary Antonym Paper 4');

DROP TABLE IF EXISTS seed_quiz_id;
CREATE TEMP TABLE seed_quiz_id(id INTEGER);
INSERT INTO seed_quiz_id SELECT id FROM quizzes WHERE title = 'Year 5 Vocabulary Antonym Paper 4' LIMIT 1;

UPDATE questions
SET option1 = 'Follower, Copycat',
    option2 = 'Explorer, Leader',
    option3 = 'Return, Give',
    option4 = 'Steal, Swipe'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "pioneer"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Follower, Copycat';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "pioneer"?', 'antonym', 'Follower, Copycat', 'Follower, Copycat', 'Explorer, Leader', 'Return, Give', 'Steal, Swipe', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "pioneer"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Follower, Copycat'
) < 1;

UPDATE questions
SET option1 = 'Stubborn, Firm',
    option2 = 'Flashy, Showy',
    option3 = 'Flexible, Easy-going',
    option4 = 'Old, Outdated'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "obstinate"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Flexible, Easy-going';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "obstinate"?', 'antonym', 'Flexible, Easy-going', 'Stubborn, Firm', 'Flashy, Showy', 'Flexible, Easy-going', 'Old, Outdated', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "obstinate"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Flexible, Easy-going'
) < 1;

UPDATE questions
SET option1 = 'Bias, Unfairness',
    option2 = 'Optional, Extra',
    option3 = 'Essential, Required',
    option4 = 'Stubborn, Firm'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "necessary"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Optional, Extra';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "necessary"?', 'antonym', 'Optional, Extra', 'Bias, Unfairness', 'Optional, Extra', 'Essential, Required', 'Stubborn, Firm', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "necessary"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Optional, Extra'
) < 1;

UPDATE questions
SET option1 = 'Version, Performance',
    option2 = 'Original, Copy',
    option3 = 'Image, Name',
    option4 = 'Blame, Criticise'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "rendition"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Original, Copy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "rendition"?', 'antonym', 'Original, Copy', 'Version, Performance', 'Original, Copy', 'Image, Name', 'Blame, Criticise', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "rendition"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Original, Copy'
) < 1;

UPDATE questions
SET option1 = 'Original, Copy',
    option2 = 'Shame, Dishonour',
    option3 = 'Image, Name',
    option4 = 'Version, Performance'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "reputation"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Shame, Dishonour';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "reputation"?', 'antonym', 'Shame, Dishonour', 'Original, Copy', 'Shame, Dishonour', 'Image, Name', 'Version, Performance', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "reputation"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Shame, Dishonour'
) < 1;

UPDATE questions
SET option1 = 'Bias, Unfairness',
    option2 = 'Future, Possible',
    option3 = 'Ban, Forbid',
    option4 = 'Fairness, Justice'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "prejudice"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Fairness, Justice';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "prejudice"?', 'antonym', 'Fairness, Justice', 'Bias, Unfairness', 'Future, Possible', 'Ban, Forbid', 'Fairness, Justice', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "prejudice"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Fairness, Justice'
) < 1;

UPDATE questions
SET option1 = 'Steal, Swipe',
    option2 = 'Flashy, Showy',
    option3 = 'Modest, Simple',
    option4 = 'Stubborn, Firm'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "ostentatious"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Modest, Simple';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "ostentatious"?', 'antonym', 'Modest, Simple', 'Steal, Swipe', 'Flashy, Showy', 'Modest, Simple', 'Stubborn, Firm', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "ostentatious"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Modest, Simple'
) < 1;

UPDATE questions
SET option1 = 'Safe, Harmless',
    option2 = 'Food, Nutrition',
    option3 = 'Starvation, Hunger',
    option4 = 'Toxic, Dangerous'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "noxious"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Safe, Harmless';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "noxious"?', 'antonym', 'Safe, Harmless', 'Safe, Harmless', 'Food, Nutrition', 'Starvation, Hunger', 'Toxic, Dangerous', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "noxious"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Safe, Harmless'
) < 1;

UPDATE questions
SET option1 = 'Past, Certain',
    option2 = 'Bias, Unfairness',
    option3 = 'Ban, Forbid',
    option4 = 'Future, Possible'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "prospective"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Past, Certain';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "prospective"?', 'antonym', 'Past, Certain', 'Past, Certain', 'Bias, Unfairness', 'Ban, Forbid', 'Future, Possible', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "prospective"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Past, Certain'
) < 1;

UPDATE questions
SET option1 = 'Return, Give',
    option2 = 'Follower, Copycat',
    option3 = 'Steal, Swipe',
    option4 = 'Explorer, Leader'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "pilfer"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Return, Give';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "pilfer"?', 'antonym', 'Return, Give', 'Return, Give', 'Follower, Copycat', 'Steal, Swipe', 'Explorer, Leader', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "pilfer"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Return, Give'
) < 1;

UPDATE questions
SET option1 = 'Ban, Forbid',
    option2 = 'Noticeable, Famous',
    option3 = 'Obtain, Get',
    option4 = 'Allow, Permit'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "prohibit"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Allow, Permit';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "prohibit"?', 'antonym', 'Allow, Permit', 'Ban, Forbid', 'Noticeable, Famous', 'Obtain, Get', 'Allow, Permit', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "prohibit"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Allow, Permit'
) < 1;

UPDATE questions
SET option1 = 'Settle, Fix',
    option2 = 'Repay, Refund',
    option3 = 'Image, Name',
    option4 = 'Fight, Argue'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "reconcile"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Fight, Argue';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "reconcile"?', 'antonym', 'Fight, Argue', 'Settle, Fix', 'Repay, Refund', 'Image, Name', 'Fight, Argue', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "reconcile"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Fight, Argue'
) < 1;

UPDATE questions
SET option1 = 'Grow, Improve',
    option2 = 'Deadlock, Tie',
    option3 = 'Victory, Win',
    option4 = 'Freeze, Stop'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "stalemate"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Victory, Win';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "stalemate"?', 'antonym', 'Victory, Win', 'Grow, Improve', 'Deadlock, Tie', 'Victory, Win', 'Freeze, Stop', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "stalemate"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Victory, Win'
) < 1;

UPDATE questions
SET option1 = 'Lose, Give',
    option2 = 'Detest, Hate',
    option3 = 'Deadlock, Tie',
    option4 = 'Love, Like'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "loathe"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Love, Like';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "loathe"?', 'antonym', 'Love, Like', 'Lose, Give', 'Detest, Hate', 'Deadlock, Tie', 'Love, Like', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "loathe"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Love, Like'
) < 1;

UPDATE questions
SET option1 = 'Ban, Forbid',
    option2 = 'Hidden, Unknown',
    option3 = 'Noticeable, Famous',
    option4 = 'Allow, Permit'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "prominent"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Hidden, Unknown';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "prominent"?', 'antonym', 'Hidden, Unknown', 'Ban, Forbid', 'Hidden, Unknown', 'Noticeable, Famous', 'Allow, Permit', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "prominent"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Hidden, Unknown'
) < 1;

UPDATE questions
SET option1 = 'Obtain, Get',
    option2 = 'Ban, Forbid',
    option3 = 'Lose, Give',
    option4 = 'Noticeable, Famous'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "procure"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Lose, Give';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "procure"?', 'antonym', 'Lose, Give', 'Obtain, Get', 'Ban, Forbid', 'Lose, Give', 'Noticeable, Famous', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "procure"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Lose, Give'
) < 1;

UPDATE questions
SET option1 = 'Repay, Refund',
    option2 = 'Preserve, Keep',
    option3 = 'Owe, Keep',
    option4 = 'Settle, Fix'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "reimburse"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Owe, Keep';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "reimburse"?', 'antonym', 'Owe, Keep', 'Repay, Refund', 'Preserve, Keep', 'Owe, Keep', 'Settle, Fix', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "reimburse"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Owe, Keep'
) < 1;

UPDATE questions
SET option1 = 'Hold, Stop',
    option2 = 'Old, Outdated',
    option3 = 'Obtain, Get',
    option4 = 'Release, Free'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "detain"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Release, Free';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "detain"?', 'antonym', 'Release, Free', 'Hold, Stop', 'Old, Outdated', 'Obtain, Get', 'Release, Free', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "detain"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Release, Free'
) < 1;

UPDATE questions
SET option1 = 'Fascinate, Impress',
    option2 = 'Achievement, Event',
    option3 = 'Obtain, Get',
    option4 = 'Bore, Dull'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "mesmerise"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Bore, Dull';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "mesmerise"?', 'antonym', 'Bore, Dull', 'Fascinate, Impress', 'Achievement, Event', 'Obtain, Get', 'Bore, Dull', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "mesmerise"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Bore, Dull'
) < 1;

UPDATE questions
SET option1 = 'Starvation, Hunger',
    option2 = 'Toxic, Dangerous',
    option3 = 'Honourable, Good',
    option4 = 'Food, Nutrition'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "nourishment"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Starvation, Hunger';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "nourishment"?', 'antonym', 'Starvation, Hunger', 'Starvation, Hunger', 'Toxic, Dangerous', 'Honourable, Good', 'Food, Nutrition', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "nourishment"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Starvation, Hunger'
) < 1;

UPDATE questions
SET option1 = 'Modern, Plain',
    option2 = 'Hold, Stop',
    option3 = 'Old, Outdated',
    option4 = 'Modern, New'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "obsolete"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Modern, New';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "obsolete"?', 'antonym', 'Modern, New', 'Modern, Plain', 'Hold, Stop', 'Old, Outdated', 'Modern, New', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "obsolete"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Modern, New'
) < 1;

UPDATE questions
SET option1 = 'Disadvantage, Loss',
    option2 = 'Lose, Give',
    option3 = 'Failure, Loss',
    option4 = 'Benefit, Honour'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "privilege"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Disadvantage, Loss';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "privilege"?', 'antonym', 'Disadvantage, Loss', 'Disadvantage, Loss', 'Lose, Give', 'Failure, Loss', 'Benefit, Honour', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "privilege"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Disadvantage, Loss'
) < 1;

UPDATE questions
SET option1 = 'Modern, New',
    option2 = 'Modern, Plain',
    option3 = 'Plain speech, Simplicity',
    option4 = 'Charming, Cute'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "quaint"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Modern, Plain';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "quaint"?', 'antonym', 'Modern, Plain', 'Modern, New', 'Modern, Plain', 'Plain speech, Simplicity', 'Charming, Cute', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "quaint"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Modern, Plain'
) < 1;

UPDATE questions
SET option1 = 'Size, Strength',
    option2 = 'Achievement, Event',
    option3 = 'Disadvantage, Loss',
    option4 = 'Failure, Loss'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "milestone"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Failure, Loss';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "milestone"?', 'antonym', 'Failure, Loss', 'Size, Strength', 'Achievement, Event', 'Disadvantage, Loss', 'Failure, Loss', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "milestone"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Failure, Loss'
) < 1;

UPDATE questions
SET option1 = 'Terms, Language',
    option2 = 'Modern, Plain',
    option3 = 'Charming, Cute',
    option4 = 'Plain speech, Simplicity'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "jargon"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Plain speech, Simplicity';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "jargon"?', 'antonym', 'Plain speech, Simplicity', 'Terms, Language', 'Modern, Plain', 'Charming, Cute', 'Plain speech, Simplicity', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "jargon"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Plain speech, Simplicity'
) < 1;

UPDATE questions
SET option1 = 'Priceless, Valuable',
    option2 = 'Rude, Cheeky',
    option3 = 'Worthless, Useless',
    option4 = 'Priceless, Vital'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "invaluable"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Worthless, Useless';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "invaluable"?', 'antonym', 'Worthless, Useless', 'Priceless, Valuable', 'Rude, Cheeky', 'Worthless, Useless', 'Priceless, Vital', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "invaluable"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Worthless, Useless'
) < 1;

UPDATE questions
SET option1 = 'Peaceful, Balanced',
    option2 = 'Noisy, Chaotic',
    option3 = 'Benefit, Honour',
    option4 = 'Charming, Cute'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "harmonious"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Noisy, Chaotic';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "harmonious"?', 'antonym', 'Noisy, Chaotic', 'Peaceful, Balanced', 'Noisy, Chaotic', 'Benefit, Honour', 'Charming, Cute', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "harmonious"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Noisy, Chaotic'
) < 1;

UPDATE questions
SET option1 = 'Weird, Ugly',
    option2 = 'Thanks, Appreciation',
    option3 = 'Beautiful, Pretty',
    option4 = 'Ungratefulness, Rudeness'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "gratitude"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Ungratefulness, Rudeness';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "gratitude"?', 'antonym', 'Ungratefulness, Rudeness', 'Weird, Ugly', 'Thanks, Appreciation', 'Beautiful, Pretty', 'Ungratefulness, Rudeness', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "gratitude"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Ungratefulness, Rudeness'
) < 1;

UPDATE questions
SET option1 = 'Smallness, Weakness',
    option2 = 'Safe, Kind',
    option3 = 'Deadly, Bad',
    option4 = 'Size, Strength'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "magnitude"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Smallness, Weakness';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "magnitude"?', 'antonym', 'Smallness, Weakness', 'Smallness, Weakness', 'Safe, Kind', 'Deadly, Bad', 'Size, Strength', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "magnitude"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Smallness, Weakness'
) < 1;

UPDATE questions
SET option1 = 'Hidden, Unknown',
    option2 = 'Active, Obvious',
    option3 = 'Hint, Clue',
    option4 = 'Hidden, Dormant'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "latent"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Active, Obvious';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "latent"?', 'antonym', 'Active, Obvious', 'Hidden, Unknown', 'Active, Obvious', 'Hint, Clue', 'Hidden, Dormant', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "latent"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Active, Obvious'
) < 1;

UPDATE questions
SET option1 = 'Hint, Clue',
    option2 = 'Priceless, Vital',
    option3 = 'Polite, Kind',
    option4 = 'Rude, Cheeky'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "insolent"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Polite, Kind';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "insolent"?', 'antonym', 'Polite, Kind', 'Hint, Clue', 'Priceless, Vital', 'Polite, Kind', 'Rude, Cheeky', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "insolent"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Polite, Kind'
) < 1;

UPDATE questions
SET option1 = 'Ignorance, Confusion',
    option2 = 'Rude, Cheeky',
    option3 = 'Polite, Kind',
    option4 = 'Hint, Clue'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "inkling"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Ignorance, Confusion';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "inkling"?', 'antonym', 'Ignorance, Confusion', 'Ignorance, Confusion', 'Rude, Cheeky', 'Polite, Kind', 'Hint, Clue', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "inkling"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Ignorance, Confusion'
) < 1;

UPDATE questions
SET option1 = 'Beautiful, Pretty',
    option2 = 'Weird, Ugly',
    option3 = 'Thanks, Appreciation',
    option4 = 'Ungratefulness, Rudeness'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "grotesque"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Beautiful, Pretty';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "grotesque"?', 'antonym', 'Beautiful, Pretty', 'Beautiful, Pretty', 'Weird, Ugly', 'Thanks, Appreciation', 'Ungratefulness, Rudeness', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "grotesque"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Beautiful, Pretty'
) < 1;

UPDATE questions
SET option1 = 'Simple, Basic',
    option2 = 'Simple, Plain',
    option3 = 'Advanced, Smart',
    option4 = 'Refined, Stylish'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "sophisticated"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Simple, Basic';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "sophisticated"?', 'antonym', 'Simple, Basic', 'Simple, Basic', 'Simple, Plain', 'Advanced, Smart', 'Refined, Stylish', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "sophisticated"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Simple, Basic'
) < 1;

UPDATE questions
SET option1 = 'Ordinary, Common',
    option2 = 'Together, Same-time',
    option3 = 'Advanced, Smart',
    option4 = 'Holy, Precious'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "sacred"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Ordinary, Common';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "sacred"?', 'antonym', 'Ordinary, Common', 'Ordinary, Common', 'Together, Same-time', 'Advanced, Smart', 'Holy, Precious', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "sacred"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Ordinary, Common'
) < 1;

UPDATE questions
SET option1 = 'Big, Solid',
    option2 = 'Tricked, Fooled',
    option3 = 'Together, Same-time',
    option4 = 'Helped, Paid'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "swindled"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Helped, Paid';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "swindled"?', 'antonym', 'Helped, Paid', 'Big, Solid', 'Tricked, Fooled', 'Together, Same-time', 'Helped, Paid', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "swindled"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Helped, Paid'
) < 1;

UPDATE questions
SET option1 = 'Long, Wordy',
    option2 = 'Continue, Begin',
    option3 = 'Pause, Stop',
    option4 = 'Brief, Concise'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "succinct"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Long, Wordy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "succinct"?', 'antonym', 'Long, Wordy', 'Long, Wordy', 'Continue, Begin', 'Pause, Stop', 'Brief, Concise', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "succinct"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Long, Wordy'
) < 1;

UPDATE questions
SET option1 = 'Block, Prevent',
    option2 = 'Help, Allow',
    option3 = 'Achievement, Event',
    option4 = 'Helped, Paid'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "thwart"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Help, Allow';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "thwart"?', 'antonym', 'Help, Allow', 'Block, Prevent', 'Help, Allow', 'Achievement, Event', 'Helped, Paid', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "thwart"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Help, Allow'
) < 1;

UPDATE questions
SET option1 = 'Together, Same-time',
    option2 = 'Freeze, Stop',
    option3 = 'Advanced, Smart',
    option4 = 'Separate, Different'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "simultaneous"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Separate, Different';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "simultaneous"?', 'antonym', 'Separate, Different', 'Together, Same-time', 'Freeze, Stop', 'Advanced, Smart', 'Separate, Different', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "simultaneous"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Separate, Different'
) < 1;

UPDATE questions
SET option1 = 'Tricked, Fooled',
    option2 = 'Big, Solid',
    option3 = 'Freeze, Stop',
    option4 = 'Tiny, Weak'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "substantial"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Tiny, Weak';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "substantial"?', 'antonym', 'Tiny, Weak', 'Tricked, Fooled', 'Big, Solid', 'Freeze, Stop', 'Tiny, Weak', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "substantial"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Tiny, Weak'
) < 1;

UPDATE questions
SET option1 = 'Deadlock, Tie',
    option2 = 'Freeze, Stop',
    option3 = 'Pause, Stop',
    option4 = 'Grow, Improve'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "stagnate"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Grow, Improve';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "stagnate"?', 'antonym', 'Grow, Improve', 'Deadlock, Tie', 'Freeze, Stop', 'Pause, Stop', 'Grow, Improve', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "stagnate"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Grow, Improve'
) < 1;

UPDATE questions
SET option1 = 'Smallness, Weakness',
    option2 = 'Size, Strength',
    option3 = 'Safe, Kind',
    option4 = 'Deadly, Bad'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "malignant"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Safe, Kind';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "malignant"?', 'antonym', 'Safe, Kind', 'Smallness, Weakness', 'Size, Strength', 'Safe, Kind', 'Deadly, Bad', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "malignant"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Safe, Kind'
) < 1;

UPDATE questions
SET option1 = 'Collapse, Break',
    option2 = 'Plead, Beg',
    option3 = 'Refuse, Reject',
    option4 = 'Expand, Grow'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "implore"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Refuse, Reject';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "implore"?', 'antonym', 'Refuse, Reject', 'Collapse, Break', 'Plead, Beg', 'Refuse, Reject', 'Expand, Grow', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "implore"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Refuse, Reject'
) < 1;

UPDATE questions
SET option1 = 'Booming, Loud',
    option2 = 'Big, Solid',
    option3 = 'Blowing, Roaring',
    option4 = 'Quiet, Soft'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "blasting"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Quiet, Soft';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "blasting"?', 'antonym', 'Quiet, Soft', 'Booming, Loud', 'Big, Solid', 'Blowing, Roaring', 'Quiet, Soft', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "blasting"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Quiet, Soft'
) < 1;

UPDATE questions
SET option1 = 'Big, Solid',
    option2 = 'Calm, Still',
    option3 = 'Booming, Loud',
    option4 = 'Blowing, Roaring'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "gusting"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Calm, Still';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "gusting"?', 'antonym', 'Calm, Still', 'Big, Solid', 'Calm, Still', 'Booming, Loud', 'Blowing, Roaring', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "gusting"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Calm, Still'
) < 1;

UPDATE questions
SET option1 = 'Brief, Concise',
    option2 = 'Continue, Begin',
    option3 = 'Freeze, Stop',
    option4 = 'Pause, Stop'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "suspend"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Continue, Begin';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "suspend"?', 'antonym', 'Continue, Begin', 'Brief, Concise', 'Continue, Begin', 'Freeze, Stop', 'Pause, Stop', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "suspend"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Continue, Begin'
) < 1;

UPDATE questions
SET option1 = 'Certainly, Definitely',
    option2 = 'Cold, Distant',
    option3 = 'Friendly, Warm',
    option4 = 'Supposedly, Reportedly'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "aloof"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Friendly, Warm';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "aloof"?', 'antonym', 'Friendly, Warm', 'Certainly, Definitely', 'Cold, Distant', 'Friendly, Warm', 'Supposedly, Reportedly', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "aloof"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Friendly, Warm'
) < 1;

UPDATE questions
SET option1 = 'Supposedly, Reportedly',
    option2 = 'Friendly, Warm',
    option3 = 'Cold, Distant',
    option4 = 'Certainly, Definitely'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "allegedly"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Certainly, Definitely';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "allegedly"?', 'antonym', 'Certainly, Definitely', 'Supposedly, Reportedly', 'Friendly, Warm', 'Cold, Distant', 'Certainly, Definitely', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "allegedly"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Certainly, Definitely'
) < 1;

UPDATE questions
SET option1 = 'Abuse, Use',
    option2 = 'Famous, Noted',
    option3 = 'Near, Soon',
    option4 = 'Unknown, Minor'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "eminent"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Unknown, Minor';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "eminent"?', 'antonym', 'Unknown, Minor', 'Abuse, Use', 'Famous, Noted', 'Near, Soon', 'Unknown, Minor', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "eminent"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Unknown, Minor'
) < 1;

UPDATE questions
SET option1 = 'Distant, Far',
    option2 = 'Near, Soon',
    option3 = 'Cold, Distant',
    option4 = 'Famous, Noted'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "imminent"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Distant, Far';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "imminent"?', 'antonym', 'Distant, Far', 'Distant, Far', 'Near, Soon', 'Cold, Distant', 'Famous, Noted', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "imminent"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Distant, Far'
) < 1;

UPDATE questions
SET option1 = 'Bright, Clear',
    option2 = 'Clear, Separate',
    option3 = 'Near, Soon',
    option4 = 'Dull, Faded'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "vivid"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Dull, Faded';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "vivid"?', 'antonym', 'Dull, Faded', 'Bright, Clear', 'Clear, Separate', 'Near, Soon', 'Dull, Faded', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "vivid"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Dull, Faded'
) < 1;

UPDATE questions
SET option1 = 'Benefit, Honour',
    option2 = 'Worst, Least',
    option3 = 'Best, Main',
    option4 = 'Main, Head'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "prime"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Worst, Least';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "prime"?', 'antonym', 'Worst, Least', 'Benefit, Honour', 'Worst, Least', 'Best, Main', 'Main, Head', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "prime"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Worst, Least'
) < 1;

UPDATE questions
SET option1 = 'Remove, Take',
    option2 = 'Set up, Fit',
    option3 = 'Energy, Motion',
    option4 = 'Laziness, Stillness'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "inertia"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Energy, Motion';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "inertia"?', 'antonym', 'Energy, Motion', 'Remove, Take', 'Set up, Fit', 'Energy, Motion', 'Laziness, Stillness', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "inertia"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Energy, Motion'
) < 1;

UPDATE questions
SET option1 = 'Abuse, Use',
    option2 = 'Shrink, Deflate',
    option3 = 'Protect, Help',
    option4 = 'Burst, Blast'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "exploit"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Protect, Help';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "exploit"?', 'antonym', 'Protect, Help', 'Abuse, Use', 'Shrink, Deflate', 'Protect, Help', 'Burst, Blast', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "exploit"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Protect, Help'
) < 1;

UPDATE questions
SET option1 = 'Kept, Saved',
    option2 = 'Burst, Blast',
    option3 = 'Stuck, Halted',
    option4 = 'Lost, Gave'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "retained"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Lost, Gave';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "retained"?', 'antonym', 'Lost, Gave', 'Kept, Saved', 'Burst, Blast', 'Stuck, Halted', 'Lost, Gave', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "retained"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Lost, Gave'
) < 1;

UPDATE questions
SET option1 = 'Burst, Blast',
    option2 = 'Weak, Exposed',
    option3 = 'Kept, Saved',
    option4 = 'Safe, Strong'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "vulnerable"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Safe, Strong';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "vulnerable"?', 'antonym', 'Safe, Strong', 'Burst, Blast', 'Weak, Exposed', 'Kept, Saved', 'Safe, Strong', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "vulnerable"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Safe, Strong'
) < 1;

UPDATE questions
SET option1 = 'Remove, Take',
    option2 = 'Curious, Interested',
    option3 = 'Set up, Fit',
    option4 = 'Laziness, Stillness'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "install"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Remove, Take';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "install"?', 'antonym', 'Remove, Take', 'Remove, Take', 'Curious, Interested', 'Set up, Fit', 'Laziness, Stillness', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "install"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Remove, Take'
) < 1;

UPDATE questions
SET option1 = 'Continued, Moved',
    option2 = 'Continue, Begin',
    option3 = 'Stuck, Halted',
    option4 = 'Set up, Fit'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "stalled"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Continued, Moved';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "stalled"?', 'antonym', 'Continued, Moved', 'Continued, Moved', 'Continue, Begin', 'Stuck, Halted', 'Set up, Fit', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "stalled"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Continued, Moved'
) < 1;

UPDATE questions
SET option1 = 'Refuse, Reject',
    option2 = 'Plead, Beg',
    option3 = 'Expand, Grow',
    option4 = 'Collapse, Break'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "implode"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Expand, Grow';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "implode"?', 'antonym', 'Expand, Grow', 'Refuse, Reject', 'Plead, Beg', 'Expand, Grow', 'Collapse, Break', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "implode"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Expand, Grow'
) < 1;

UPDATE questions
SET option1 = 'Abuse, Use',
    option2 = 'Burst, Blast',
    option3 = 'Protect, Help',
    option4 = 'Shrink, Deflate'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "explode"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Shrink, Deflate';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "explode"?', 'antonym', 'Shrink, Deflate', 'Abuse, Use', 'Burst, Blast', 'Protect, Help', 'Shrink, Deflate', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "explode"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Shrink, Deflate'
) < 1;

UPDATE questions
SET option1 = 'Disagree, Deny',
    option2 = 'Deny, Hide',
    option3 = 'Hide, Conceal',
    option4 = 'Admit, Own'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "confess"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Deny, Hide';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "confess"?', 'antonym', 'Deny, Hide', 'Disagree, Deny', 'Deny, Hide', 'Hide, Conceal', 'Admit, Own', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "confess"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Deny, Hide'
) < 1;

UPDATE questions
SET option1 = 'Set up, Fit',
    option2 = 'Uninterested, Bored',
    option3 = 'Remove, Take',
    option4 = 'Curious, Interested'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "inquisitive"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Uninterested, Bored';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "inquisitive"?', 'antonym', 'Uninterested, Bored', 'Set up, Fit', 'Uninterested, Bored', 'Remove, Take', 'Curious, Interested', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "inquisitive"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Uninterested, Bored'
) < 1;

UPDATE questions
SET option1 = 'Similar, Same',
    option2 = 'Feeling, Thought',
    option3 = 'Clear, Separate',
    option4 = 'Bright, Clear'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "distinct"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Similar, Same';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "distinct"?', 'antonym', 'Similar, Same', 'Similar, Same', 'Feeling, Thought', 'Clear, Separate', 'Bright, Clear', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "distinct"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Similar, Same'
) < 1;

UPDATE questions
SET option1 = 'Feeling, Thought',
    option2 = 'Admit, Own',
    option3 = 'Coldness, Indifference',
    option4 = 'Deny, Hide'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "sentiment"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Coldness, Indifference';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "sentiment"?', 'antonym', 'Coldness, Indifference', 'Feeling, Thought', 'Admit, Own', 'Coldness, Indifference', 'Deny, Hide', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "sentiment"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Coldness, Indifference'
) < 1;

UPDATE questions
SET option1 = 'Energy, Strength',
    option2 = 'Clear, Separate',
    option3 = 'Tiredness, Weariness',
    option4 = 'Energy, Motion'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "fatigue"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Energy, Strength';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "fatigue"?', 'antonym', 'Energy, Strength', 'Energy, Strength', 'Clear, Separate', 'Tiredness, Weariness', 'Energy, Motion', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "fatigue"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Energy, Strength'
) < 1;

DROP TABLE seed_quiz_id;

COMMIT;
