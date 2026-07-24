BEGIN TRANSACTION;

INSERT OR IGNORE INTO stages (name, description)
VALUES ('Year 5', 'UK primary Year 5 students.');

-- Year 5 Vocabulary 8 Pages Synonym Paper 1
INSERT INTO quizzes (title, description, created_by, stage_id, lock_after_attempt)
SELECT 'Year 5 Vocabulary 8 Pages Synonym Paper 1',
       'A 100-question Year 5 vocabulary exam from the 8-page workbook asking students to identify synonym pairs.',
       1,
       (SELECT id FROM stages WHERE name = 'Year 5'),
       1
WHERE NOT EXISTS (SELECT 1 FROM quizzes WHERE title = 'Year 5 Vocabulary 8 Pages Synonym Paper 1');

DROP TABLE IF EXISTS seed_quiz_id;
CREATE TEMP TABLE seed_quiz_id(id INTEGER);
INSERT INTO seed_quiz_id SELECT id FROM quizzes WHERE title = 'Year 5 Vocabulary 8 Pages Synonym Paper 1' LIMIT 1;

UPDATE questions
SET option1 = 'Opponent, Rival',
    option2 = 'Friend, Ally',
    option3 = 'Rejection, Ignore',
    option4 = 'Timidity, Fear'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "adversary"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Opponent, Rival';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "adversary"?', 'synonym', 'Opponent, Rival', 'Opponent, Rival', 'Friend, Ally', 'Rejection, Ignore', 'Timidity, Fear', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "adversary"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Opponent, Rival'
) < 1;

UPDATE questions
SET option1 = 'Boldness, Nerve',
    option2 = 'Try-out, Performance',
    option3 = 'Rejection, Ignore',
    option4 = 'Timidity, Fear'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "audition"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Try-out, Performance';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "audition"?', 'synonym', 'Try-out, Performance', 'Boldness, Nerve', 'Try-out, Performance', 'Rejection, Ignore', 'Timidity, Fear', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "audition"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Try-out, Performance'
) < 1;

UPDATE questions
SET option1 = 'Enemy, Stranger',
    option2 = 'Caretaker, Keeper',
    option3 = 'Stranger, Visitor',
    option4 = 'Stranger, Intruder'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "custodian"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Caretaker, Keeper';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "custodian"?', 'synonym', 'Caretaker, Keeper', 'Enemy, Stranger', 'Caretaker, Keeper', 'Stranger, Visitor', 'Stranger, Intruder', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "custodian"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Caretaker, Keeper'
) < 1;

UPDATE questions
SET option1 = 'Happiness, Contentment',
    option2 = 'Unhappiness, Dissatisfaction',
    option3 = 'Difference, Mismatch',
    option4 = 'Agreement, Match'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "discrepancy"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Difference, Mismatch';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "discrepancy"?', 'synonym', 'Difference, Mismatch', 'Happiness, Contentment', 'Unhappiness, Dissatisfaction', 'Difference, Mismatch', 'Agreement, Match', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "discrepancy"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Difference, Mismatch'
) < 1;

UPDATE questions
SET option1 = 'Enemy, Stranger',
    option2 = 'Scorn, Disdain',
    option3 = 'Friend, Ally',
    option4 = 'Respect, Admiration'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "contempt"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Scorn, Disdain';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "contempt"?', 'synonym', 'Scorn, Disdain', 'Enemy, Stranger', 'Scorn, Disdain', 'Friend, Ally', 'Respect, Admiration', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "contempt"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Scorn, Disdain'
) < 1;

UPDATE questions
SET option1 = 'Try-out, Performance',
    option2 = 'Boldness, Nerve',
    option3 = 'Rejection, Ignore',
    option4 = 'Timidity, Fear'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "audacity"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Boldness, Nerve';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "audacity"?', 'synonym', 'Boldness, Nerve', 'Try-out, Performance', 'Boldness, Nerve', 'Rejection, Ignore', 'Timidity, Fear', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "audacity"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Boldness, Nerve'
) < 1;

UPDATE questions
SET option1 = 'Friend, Ally',
    option2 = 'Enemy, Stranger',
    option3 = 'Respect, Admiration',
    option4 = 'Stranger, Intruder'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "comrade"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Friend, Ally';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "comrade"?', 'synonym', 'Friend, Ally', 'Friend, Ally', 'Enemy, Stranger', 'Respect, Admiration', 'Stranger, Intruder', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "comrade"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Friend, Ally'
) < 1;

UPDATE questions
SET option1 = 'Rubble, Fragments',
    option2 = 'Agreement, Match',
    option3 = 'Whole, Entirety',
    option4 = 'Whole, Intact'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "debris"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Rubble, Fragments';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "debris"?', 'synonym', 'Rubble, Fragments', 'Rubble, Fragments', 'Agreement, Match', 'Whole, Entirety', 'Whole, Intact', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "debris"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Rubble, Fragments'
) < 1;

UPDATE questions
SET option1 = 'Happiness, Contentment',
    option2 = 'Agreement, Match',
    option3 = 'Focus, Attention',
    option4 = 'Unhappiness, Dissatisfaction'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "discontent"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Unhappiness, Dissatisfaction';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "discontent"?', 'synonym', 'Unhappiness, Dissatisfaction', 'Happiness, Contentment', 'Agreement, Match', 'Focus, Attention', 'Unhappiness, Dissatisfaction', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "discontent"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Unhappiness, Dissatisfaction'
) < 1;

UPDATE questions
SET option1 = 'Insult, Criticism',
    option2 = 'Excitement, Enthusiasm',
    option3 = 'Happiness, Contentment',
    option4 = 'Boredom, Laziness'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "eagerness"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Excitement, Enthusiasm';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "eagerness"?', 'synonym', 'Excitement, Enthusiasm', 'Insult, Criticism', 'Excitement, Enthusiasm', 'Happiness, Contentment', 'Boredom, Laziness', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "eagerness"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Excitement, Enthusiasm'
) < 1;

UPDATE questions
SET option1 = 'Dislike, Hatred',
    option2 = 'Single, Uniform',
    option3 = 'Timidity, Fear',
    option4 = 'Variety, Mixture'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "assortment"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Variety, Mixture';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "assortment"?', 'synonym', 'Variety, Mixture', 'Dislike, Hatred', 'Single, Uniform', 'Timidity, Fear', 'Variety, Mixture', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "assortment"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Variety, Mixture'
) < 1;

UPDATE questions
SET option1 = 'Single, Uniform',
    option2 = 'Dislike, Hatred',
    option3 = 'Liking, Bond',
    option4 = 'Variety, Mixture'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "affinity"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Liking, Bond';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "affinity"?', 'synonym', 'Liking, Bond', 'Single, Uniform', 'Dislike, Hatred', 'Liking, Bond', 'Variety, Mixture', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "affinity"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Liking, Bond'
) < 1;

UPDATE questions
SET option1 = 'Praise, Flattery',
    option2 = 'Individual, Lone',
    option3 = 'Whole, Entirety',
    option4 = 'Insult, Criticism'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "compliment"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Praise, Flattery';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "compliment"?', 'synonym', 'Praise, Flattery', 'Praise, Flattery', 'Individual, Lone', 'Whole, Entirety', 'Insult, Criticism', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "compliment"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Praise, Flattery'
) < 1;

UPDATE questions
SET option1 = 'Team, Panel',
    option2 = 'Insult, Criticism',
    option3 = 'Individual, Lone',
    option4 = 'Praise, Flattery'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "committee"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Team, Panel';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "committee"?', 'synonym', 'Team, Panel', 'Team, Panel', 'Insult, Criticism', 'Individual, Lone', 'Praise, Flattery', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "committee"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Team, Panel'
) < 1;

UPDATE questions
SET option1 = 'Unhappiness, Dissatisfaction',
    option2 = 'Interruption, Disturbance',
    option3 = 'Focus, Attention',
    option4 = 'Agreement, Match'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "distraction"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Interruption, Disturbance';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "distraction"?', 'synonym', 'Interruption, Disturbance', 'Unhappiness, Dissatisfaction', 'Interruption, Disturbance', 'Focus, Attention', 'Agreement, Match', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "distraction"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Interruption, Disturbance'
) < 1;

UPDATE questions
SET option1 = 'Focus, Attention',
    option2 = 'Accusation, Claim',
    option3 = 'Unlikely, Unsuitable',
    option4 = 'Proof, Fact'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "allegation"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Accusation, Claim';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "allegation"?', 'synonym', 'Accusation, Claim', 'Focus, Attention', 'Accusation, Claim', 'Unlikely, Unsuitable', 'Proof, Fact', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "allegation"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Accusation, Claim'
) < 1;

UPDATE questions
SET option1 = 'Stranger, Visitor',
    option2 = 'Resident, Inhabitant',
    option3 = 'Stranger, Intruder',
    option4 = 'Enemy, Stranger'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "citizen"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Resident, Inhabitant';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "citizen"?', 'synonym', 'Resident, Inhabitant', 'Stranger, Visitor', 'Resident, Inhabitant', 'Stranger, Intruder', 'Enemy, Stranger', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "citizen"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Resident, Inhabitant'
) < 1;

UPDATE questions
SET option1 = 'Whole, Entirety',
    option2 = 'Stranger, Visitor',
    option3 = 'Disaster, Tragedy',
    option4 = 'Miracle, Blessing'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "catastrophe"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Disaster, Tragedy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "catastrophe"?', 'synonym', 'Disaster, Tragedy', 'Whole, Entirety', 'Stranger, Visitor', 'Disaster, Tragedy', 'Miracle, Blessing', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "catastrophe"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Disaster, Tragedy'
) < 1;

UPDATE questions
SET option1 = 'Attempt, Effort',
    option2 = 'Neglect, Quit',
    option3 = 'Unlikely, Unsuitable',
    option4 = 'Focus, Attention'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "endeavour"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Attempt, Effort';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "endeavour"?', 'synonym', 'Attempt, Effort', 'Attempt, Effort', 'Neglect, Quit', 'Unlikely, Unsuitable', 'Focus, Attention', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "endeavour"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Attempt, Effort'
) < 1;

UPDATE questions
SET option1 = 'Talent, Skill',
    option2 = 'Likely, Suitable',
    option3 = 'Unlikely, Unsuitable',
    option4 = 'Weakness, Inability'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "apt"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Likely, Suitable';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "apt"?', 'synonym', 'Likely, Suitable', 'Talent, Skill', 'Likely, Suitable', 'Unlikely, Unsuitable', 'Weakness, Inability', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "apt"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Likely, Suitable'
) < 1;

UPDATE questions
SET option1 = 'Miracle, Blessing',
    option2 = 'Ruin, Chaos',
    option3 = 'Weakness, Inability',
    option4 = 'Design, Structure'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "architecture"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Design, Structure';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "architecture"?', 'synonym', 'Design, Structure', 'Miracle, Blessing', 'Ruin, Chaos', 'Weakness, Inability', 'Design, Structure', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "architecture"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Design, Structure'
) < 1;

UPDATE questions
SET option1 = 'Unlikely, Unsuitable',
    option2 = 'Likely, Suitable',
    option3 = 'Talent, Skill',
    option4 = 'Weakness, Inability'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "aptitude"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Talent, Skill';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "aptitude"?', 'synonym', 'Talent, Skill', 'Unlikely, Unsuitable', 'Likely, Suitable', 'Talent, Skill', 'Weakness, Inability', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "aptitude"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Talent, Skill'
) < 1;

UPDATE questions
SET option1 = 'Whole, Entirety',
    option2 = 'Part, Piece',
    option3 = 'Praise, Flattery',
    option4 = 'Insult, Criticism'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "component"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Part, Piece';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "component"?', 'synonym', 'Part, Piece', 'Whole, Entirety', 'Part, Piece', 'Praise, Flattery', 'Insult, Criticism', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "component"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Part, Piece'
) < 1;

UPDATE questions
SET option1 = 'Light, Easy',
    option2 = 'Neglect, Destroy',
    option3 = 'Inquisitiveness, Wonder',
    option4 = 'Indifference, Boredom'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "curiosity"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Inquisitiveness, Wonder';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "curiosity"?', 'synonym', 'Inquisitiveness, Wonder', 'Light, Easy', 'Neglect, Destroy', 'Inquisitiveness, Wonder', 'Indifference, Boredom', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "curiosity"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Inquisitiveness, Wonder'
) < 1;

UPDATE questions
SET option1 = 'Guess, Ignore',
    option2 = 'Laziness, Carelessness',
    option3 = 'Rich, Wealthy',
    option4 = 'Conclude, Reason'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "deduce"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Conclude, Reason';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "deduce"?', 'synonym', 'Conclude, Reason', 'Guess, Ignore', 'Laziness, Carelessness', 'Rich, Wealthy', 'Conclude, Reason', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "deduce"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Conclude, Reason'
) < 1;

UPDATE questions
SET option1 = 'Hard work, Effort',
    option2 = 'Ugly, Plain',
    option3 = 'Guess, Ignore',
    option4 = 'Laziness, Carelessness'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "diligence"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Hard work, Effort';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "diligence"?', 'synonym', 'Hard work, Effort', 'Hard work, Effort', 'Ugly, Plain', 'Guess, Ignore', 'Laziness, Carelessness', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "diligence"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Hard work, Effort'
) < 1;

UPDATE questions
SET option1 = 'Celebrate, Praise',
    option2 = 'Abandoned, Empty',
    option3 = 'Empty, Desolate',
    option4 = 'Fertile, Lush'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "barren"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Empty, Desolate';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "barren"?', 'synonym', 'Empty, Desolate', 'Celebrate, Praise', 'Abandoned, Empty', 'Empty, Desolate', 'Fertile, Lush', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "barren"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Empty, Desolate'
) < 1;

UPDATE questions
SET option1 = 'Beautiful, Lovely',
    option2 = 'Nonexistence, Nothing',
    option3 = 'Ugly, Plain',
    option4 = 'Life, Being'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "exquisite"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Beautiful, Lovely';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "exquisite"?', 'synonym', 'Beautiful, Lovely', 'Beautiful, Lovely', 'Nonexistence, Nothing', 'Ugly, Plain', 'Life, Being', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "exquisite"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Beautiful, Lovely'
) < 1;

UPDATE questions
SET option1 = 'Thrifty, Saver',
    option2 = 'Ugly, Plain',
    option3 = 'Indifference, Boredom',
    option4 = 'Wasteful, Spendthrift'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "frugal"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Thrifty, Saver';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "frugal"?', 'synonym', 'Thrifty, Saver', 'Thrifty, Saver', 'Ugly, Plain', 'Indifference, Boredom', 'Wasteful, Spendthrift', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "frugal"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Thrifty, Saver'
) < 1;

UPDATE questions
SET option1 = 'Proof, Fact',
    option2 = 'Attractive, Charming',
    option3 = 'Unattractive, Repellent',
    option4 = 'Confident, Calm'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "alluring"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Attractive, Charming';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "alluring"?', 'synonym', 'Attractive, Charming', 'Proof, Fact', 'Attractive, Charming', 'Unattractive, Repellent', 'Confident, Calm', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "alluring"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Attractive, Charming'
) < 1;

UPDATE questions
SET option1 = 'Confident, Calm',
    option2 = 'Unattractive, Repellent',
    option3 = 'Confuse, Misunderstand',
    option4 = 'Worried, Nervous'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "apprehensive"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Worried, Nervous';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "apprehensive"?', 'synonym', 'Worried, Nervous', 'Confident, Calm', 'Unattractive, Repellent', 'Confuse, Misunderstand', 'Worried, Nervous', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "apprehensive"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Worried, Nervous'
) < 1;

UPDATE questions
SET option1 = 'Neglect, Destroy',
    option2 = 'Light, Easy',
    option3 = 'Awkward, Bulky',
    option4 = 'Grow, Nurture'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "cumbersome"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Awkward, Bulky';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "cumbersome"?', 'synonym', 'Awkward, Bulky', 'Neglect, Destroy', 'Light, Easy', 'Awkward, Bulky', 'Grow, Nurture', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "cumbersome"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Awkward, Bulky'
) < 1;

UPDATE questions
SET option1 = 'Celebrate, Praise',
    option2 = 'Complain, Lament',
    option3 = 'Polite, Friendly',
    option4 = 'Ugly, Plain'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "bemoan"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Complain, Lament';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "bemoan"?', 'synonym', 'Complain, Lament', 'Celebrate, Praise', 'Complain, Lament', 'Polite, Friendly', 'Ugly, Plain', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "bemoan"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Complain, Lament'
) < 1;

UPDATE questions
SET option1 = 'Awkward, Bulky',
    option2 = 'Grow, Nurture',
    option3 = 'Neglect, Destroy',
    option4 = 'Light, Easy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "cultivate"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Grow, Nurture';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "cultivate"?', 'synonym', 'Grow, Nurture', 'Awkward, Bulky', 'Grow, Nurture', 'Neglect, Destroy', 'Light, Easy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "cultivate"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Grow, Nurture'
) < 1;

UPDATE questions
SET option1 = 'Past, Delayed',
    option2 = 'Upcoming, Approaching',
    option3 = 'Understand, Grasp',
    option4 = 'Confuse, Misunderstand'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "fathom"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Understand, Grasp';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "fathom"?', 'synonym', 'Understand, Grasp', 'Past, Delayed', 'Upcoming, Approaching', 'Understand, Grasp', 'Confuse, Misunderstand', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "fathom"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Understand, Grasp'
) < 1;

UPDATE questions
SET option1 = 'Life, Being',
    option2 = 'Ugly, Plain',
    option3 = 'Nonexistence, Nothing',
    option4 = 'Beautiful, Lovely'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "existence"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Life, Being';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "existence"?', 'synonym', 'Life, Being', 'Life, Being', 'Ugly, Plain', 'Nonexistence, Nothing', 'Beautiful, Lovely', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "existence"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Life, Being'
) < 1;

UPDATE questions
SET option1 = 'Celebrate, Praise',
    option2 = 'Blunt, Curt',
    option3 = 'Polite, Friendly',
    option4 = 'Complain, Lament'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "brusque"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Blunt, Curt';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "brusque"?', 'synonym', 'Blunt, Curt', 'Celebrate, Praise', 'Blunt, Curt', 'Polite, Friendly', 'Complain, Lament', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "brusque"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Blunt, Curt'
) < 1;

UPDATE questions
SET option1 = 'Wonderful, Lucky',
    option2 = 'Used, Active',
    option3 = 'Abandoned, Empty',
    option4 = 'Catastrophic, Terrible'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "disastrous"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Catastrophic, Terrible';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "disastrous"?', 'synonym', 'Catastrophic, Terrible', 'Wonderful, Lucky', 'Used, Active', 'Abandoned, Empty', 'Catastrophic, Terrible', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "disastrous"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Catastrophic, Terrible'
) < 1;

UPDATE questions
SET option1 = 'Local, Native',
    option2 = 'Past, Delayed',
    option3 = 'Unlucky, Unfortunate',
    option4 = 'Upcoming, Approaching'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "forthcoming"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Upcoming, Approaching';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "forthcoming"?', 'synonym', 'Upcoming, Approaching', 'Local, Native', 'Past, Delayed', 'Unlucky, Unfortunate', 'Upcoming, Approaching', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "forthcoming"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Upcoming, Approaching'
) < 1;

UPDATE questions
SET option1 = 'Alien, Exotic',
    option2 = 'Unlucky, Unfortunate',
    option3 = 'Local, Native',
    option4 = 'Past, Delayed'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "foreign"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Alien, Exotic';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "foreign"?', 'synonym', 'Alien, Exotic', 'Alien, Exotic', 'Unlucky, Unfortunate', 'Local, Native', 'Past, Delayed', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "foreign"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Alien, Exotic'
) < 1;

UPDATE questions
SET option1 = 'Rich, Wealthy',
    option2 = 'Love, Admire',
    option3 = 'Poor, Needy',
    option4 = 'Hate, Loathe'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "destitute"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Poor, Needy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "destitute"?', 'synonym', 'Poor, Needy', 'Rich, Wealthy', 'Love, Admire', 'Poor, Needy', 'Hate, Loathe', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "destitute"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Poor, Needy'
) < 1;

UPDATE questions
SET option1 = 'Abandoned, Empty',
    option2 = 'Used, Active',
    option3 = 'Catastrophic, Terrible',
    option4 = 'Wonderful, Lucky'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "disused"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Abandoned, Empty';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "disused"?', 'synonym', 'Abandoned, Empty', 'Abandoned, Empty', 'Used, Active', 'Catastrophic, Terrible', 'Wonderful, Lucky', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "disused"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Abandoned, Empty'
) < 1;

UPDATE questions
SET option1 = 'Local, Native',
    option2 = 'Lucky, Serendipitous',
    option3 = 'Past, Delayed',
    option4 = 'Unlucky, Unfortunate'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "fortuitous"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Lucky, Serendipitous';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "fortuitous"?', 'synonym', 'Lucky, Serendipitous', 'Local, Native', 'Lucky, Serendipitous', 'Past, Delayed', 'Unlucky, Unfortunate', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "fortuitous"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Lucky, Serendipitous'
) < 1;

UPDATE questions
SET option1 = 'Joking, Playful',
    option2 = 'Unlucky, Unfortunate',
    option3 = 'Lucky, Serendipitous',
    option4 = 'Serious, Respectful'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "flippant"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Joking, Playful';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "flippant"?', 'synonym', 'Joking, Playful', 'Joking, Playful', 'Unlucky, Unfortunate', 'Lucky, Serendipitous', 'Serious, Respectful', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "flippant"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Joking, Playful'
) < 1;

UPDATE questions
SET option1 = 'Ignore, Avoid',
    option2 = 'Crash, Smash',
    option3 = 'Avoid, Miss',
    option4 = 'Catch, Capture'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "collide"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Crash, Smash';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "collide"?', 'synonym', 'Crash, Smash', 'Ignore, Avoid', 'Crash, Smash', 'Avoid, Miss', 'Catch, Capture', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "collide"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Crash, Smash'
) < 1;

UPDATE questions
SET option1 = 'Love, Admire',
    option2 = 'Hate, Loathe',
    option3 = 'Rich, Wealthy',
    option4 = 'Poor, Needy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "despise"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Hate, Loathe';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "despise"?', 'synonym', 'Hate, Loathe', 'Love, Admire', 'Hate, Loathe', 'Rich, Wealthy', 'Poor, Needy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "despise"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Hate, Loathe'
) < 1;

UPDATE questions
SET option1 = 'Mumble, Incoherence',
    option2 = 'Escape, Evade',
    option3 = 'Articulation, Fluency',
    option4 = 'Catch, Capture'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "elude"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Escape, Evade';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "elude"?', 'synonym', 'Escape, Evade', 'Mumble, Incoherence', 'Escape, Evade', 'Articulation, Fluency', 'Catch, Capture', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "elude"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Escape, Evade'
) < 1;

UPDATE questions
SET option1 = 'Escape, Evade',
    option2 = 'Articulation, Fluency',
    option3 = 'Catch, Capture',
    option4 = 'Mumble, Incoherence'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "eloquence"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Articulation, Fluency';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "eloquence"?', 'synonym', 'Articulation, Fluency', 'Escape, Evade', 'Articulation, Fluency', 'Catch, Capture', 'Mumble, Incoherence', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "eloquence"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Articulation, Fluency'
) < 1;

UPDATE questions
SET option1 = 'Be honest, Show',
    option2 = 'Pretend, Fake',
    option3 = 'Local, Native',
    option4 = 'Serious, Respectful'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "feign"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Pretend, Fake';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "feign"?', 'synonym', 'Pretend, Fake', 'Be honest, Show', 'Pretend, Fake', 'Local, Native', 'Serious, Respectful', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "feign"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Pretend, Fake'
) < 1;

UPDATE questions
SET option1 = 'Happy, Cheerful',
    option2 = 'Sad, Unhappy',
    option3 = 'Sad, Gloomy',
    option4 = 'Bright, Cheerful'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "melancholy"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Sad, Gloomy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "melancholy"?', 'synonym', 'Sad, Gloomy', 'Happy, Cheerful', 'Sad, Unhappy', 'Sad, Gloomy', 'Bright, Cheerful', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "melancholy"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Sad, Gloomy'
) < 1;

UPDATE questions
SET option1 = 'Gloomy, Dark',
    option2 = 'Happy, Cheerful',
    option3 = 'Sad, Gloomy',
    option4 = 'Bright, Cheerful'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "dismal"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Gloomy, Dark';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "dismal"?', 'synonym', 'Gloomy, Dark', 'Gloomy, Dark', 'Happy, Cheerful', 'Sad, Gloomy', 'Bright, Cheerful', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "dismal"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Gloomy, Dark'
) < 1;

UPDATE questions
SET option1 = 'Happy, Cheerful',
    option2 = 'Happy, Overjoyed',
    option3 = 'Sad, Miserable',
    option4 = 'Sad, Unhappy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "joyful"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Happy, Cheerful';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "joyful"?', 'synonym', 'Happy, Cheerful', 'Happy, Cheerful', 'Happy, Overjoyed', 'Sad, Miserable', 'Sad, Unhappy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "joyful"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Happy, Cheerful'
) < 1;

UPDATE questions
SET option1 = 'Sad, Gloomy',
    option2 = 'Sad, Miserable',
    option3 = 'Sad, Unhappy',
    option4 = 'Happy, Joyful'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "cheerful"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Happy, Joyful';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "cheerful"?', 'synonym', 'Happy, Joyful', 'Sad, Gloomy', 'Sad, Miserable', 'Sad, Unhappy', 'Happy, Joyful', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "cheerful"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Happy, Joyful'
) < 1;

UPDATE questions
SET option1 = 'Happy, Overjoyed',
    option2 = 'Sad, Miserable',
    option3 = 'Sad, Unhappy',
    option4 = 'Happy, Cheerful'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "jubilant"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Happy, Overjoyed';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "jubilant"?', 'synonym', 'Happy, Overjoyed', 'Happy, Overjoyed', 'Sad, Miserable', 'Sad, Unhappy', 'Happy, Cheerful', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "jubilant"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Happy, Overjoyed'
) < 1;

UPDATE questions
SET option1 = 'Disappointed, Unhappy',
    option2 = 'Happy, Cheerful',
    option3 = 'Sad, Unhappy',
    option4 = 'Pleased, Happy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "gratified"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Pleased, Happy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "gratified"?', 'synonym', 'Pleased, Happy', 'Disappointed, Unhappy', 'Happy, Cheerful', 'Sad, Unhappy', 'Pleased, Happy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "gratified"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Pleased, Happy'
) < 1;

UPDATE questions
SET option1 = 'Happy, Joyful',
    option2 = 'Sad, Unhappy',
    option3 = 'Sad, Miserable',
    option4 = 'Sad, Gloomy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "blissful"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Happy, Joyful';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "blissful"?', 'synonym', 'Happy, Joyful', 'Happy, Joyful', 'Sad, Unhappy', 'Sad, Miserable', 'Sad, Gloomy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "blissful"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Happy, Joyful'
) < 1;

UPDATE questions
SET option1 = 'Calm, Cool',
    option2 = 'Angry, Furious',
    option3 = 'Please, Calm',
    option4 = 'Calm, Happy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "enraged"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Angry, Furious';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "enraged"?', 'synonym', 'Angry, Furious', 'Calm, Cool', 'Angry, Furious', 'Please, Calm', 'Calm, Happy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "enraged"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Angry, Furious'
) < 1;

UPDATE questions
SET option1 = 'Calm, Cool',
    option2 = 'Irritated, Angry',
    option3 = 'Furious, Mad',
    option4 = 'Calm, Happy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "infuriated"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Furious, Mad';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "infuriated"?', 'synonym', 'Furious, Mad', 'Calm, Cool', 'Irritated, Angry', 'Furious, Mad', 'Calm, Happy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "infuriated"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Furious, Mad'
) < 1;

UPDATE questions
SET option1 = 'Calm, Happy',
    option2 = 'Annoyed, Frustrated',
    option3 = 'Calm, Cool',
    option4 = 'Please, Calm'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "exasperated"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Annoyed, Frustrated';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "exasperated"?', 'synonym', 'Annoyed, Frustrated', 'Calm, Happy', 'Annoyed, Frustrated', 'Calm, Cool', 'Please, Calm', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "exasperated"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Annoyed, Frustrated'
) < 1;

UPDATE questions
SET option1 = 'Furious, Mad',
    option2 = 'Calm, Happy',
    option3 = 'Irritated, Angry',
    option4 = 'Calm, Cool'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "inflamed"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Irritated, Angry';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "inflamed"?', 'synonym', 'Irritated, Angry', 'Furious, Mad', 'Calm, Happy', 'Irritated, Angry', 'Calm, Cool', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "inflamed"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Irritated, Angry'
) < 1;

UPDATE questions
SET option1 = 'Calm, Cool',
    option2 = 'Annoy, Irritate',
    option3 = 'Calm, Happy',
    option4 = 'Please, Calm'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "nettle"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Annoy, Irritate';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "nettle"?', 'synonym', 'Annoy, Irritate', 'Calm, Cool', 'Annoy, Irritate', 'Calm, Happy', 'Please, Calm', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "nettle"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Annoy, Irritate'
) < 1;

UPDATE questions
SET option1 = 'Ignore, Look away',
    option2 = 'Stare, Gaze',
    option3 = 'Gawk, Stare',
    option4 = 'Ignore, Overlook'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "leer"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Gawk, Stare';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "leer"?', 'synonym', 'Gawk, Stare', 'Ignore, Look away', 'Stare, Gaze', 'Gawk, Stare', 'Ignore, Overlook', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "leer"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Gawk, Stare'
) < 1;

UPDATE questions
SET option1 = 'Stare, Gaze',
    option2 = 'Peek, Glance',
    option3 = 'Stare, Gawk',
    option4 = 'Gawk, Stare'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "glimpse"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Peek, Glance';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "glimpse"?', 'synonym', 'Peek, Glance', 'Stare, Gaze', 'Peek, Glance', 'Stare, Gawk', 'Gawk, Stare', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "glimpse"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Peek, Glance'
) < 1;

UPDATE questions
SET option1 = 'Ignore, Miss',
    option2 = 'Stare, Gawk',
    option3 = 'Ignore, Look away',
    option4 = 'Ignore, Overlook'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "ogle"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Stare, Gawk';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "ogle"?', 'synonym', 'Stare, Gawk', 'Ignore, Miss', 'Stare, Gawk', 'Ignore, Look away', 'Ignore, Overlook', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "ogle"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Stare, Gawk'
) < 1;

UPDATE questions
SET option1 = 'Ignore, Overlook',
    option2 = 'Ignore, Look away',
    option3 = 'Examine, Inspect',
    option4 = 'Ignore, Miss'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "scrutinize"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Examine, Inspect';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "scrutinize"?', 'synonym', 'Examine, Inspect', 'Ignore, Overlook', 'Ignore, Look away', 'Examine, Inspect', 'Ignore, Miss', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "scrutinize"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Examine, Inspect'
) < 1;

UPDATE questions
SET option1 = 'Ignore, Overlook',
    option2 = 'Ignore, Miss',
    option3 = 'Ignore, Look away',
    option4 = 'See, Observe'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "behold"?'
  AND question_type = 'synonym'
  AND correct_answer = 'See, Observe';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "behold"?', 'synonym', 'See, Observe', 'Ignore, Overlook', 'Ignore, Miss', 'Ignore, Look away', 'See, Observe', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "behold"?'
      AND question_type = 'synonym'
      AND correct_answer = 'See, Observe'
) < 1;

UPDATE questions
SET option1 = 'Glowing, Shiny',
    option2 = 'Dull, Dark',
    option3 = 'Ugly, Plain',
    option4 = 'Shiny, Radiant'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "resplendent"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Shiny, Radiant';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "resplendent"?', 'synonym', 'Shiny, Radiant', 'Glowing, Shiny', 'Dull, Dark', 'Ugly, Plain', 'Shiny, Radiant', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "resplendent"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Shiny, Radiant'
) < 1;

UPDATE questions
SET option1 = 'Ugly, Plain',
    option2 = 'Splendid, Amazing',
    option3 = 'Dull, Dark',
    option4 = 'Poor, Ugly'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "magnificent"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Splendid, Amazing';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "magnificent"?', 'synonym', 'Splendid, Amazing', 'Ugly, Plain', 'Splendid, Amazing', 'Dull, Dark', 'Poor, Ugly', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "magnificent"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Splendid, Amazing'
) < 1;

UPDATE questions
SET option1 = 'Ugly, Plain',
    option2 = 'Dull, Dark',
    option3 = 'Shiny, Radiant',
    option4 = 'Glowing, Shiny'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "radiant"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Glowing, Shiny';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "radiant"?', 'synonym', 'Glowing, Shiny', 'Ugly, Plain', 'Dull, Dark', 'Shiny, Radiant', 'Glowing, Shiny', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "radiant"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Glowing, Shiny'
) < 1;

UPDATE questions
SET option1 = 'Unfair, Mean',
    option2 = 'Dull, Dark',
    option3 = 'Poor, Ugly',
    option4 = 'Just, Nice'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "fair"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Just, Nice';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "fair"?', 'synonym', 'Just, Nice', 'Unfair, Mean', 'Dull, Dark', 'Poor, Ugly', 'Just, Nice', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "fair"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Just, Nice'
) < 1;

UPDATE questions
SET option1 = 'Ugly, Plain',
    option2 = 'Stunning, Gorgeous',
    option3 = 'Glowing, Shiny',
    option4 = 'Dull, Dark'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "ravishing"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Stunning, Gorgeous';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "ravishing"?', 'synonym', 'Stunning, Gorgeous', 'Ugly, Plain', 'Stunning, Gorgeous', 'Glowing, Shiny', 'Dull, Dark', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "ravishing"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Stunning, Gorgeous'
) < 1;

UPDATE questions
SET option1 = 'Unstable, Risky',
    option2 = 'Safe, Trustworthy',
    option3 = 'Risky, Hazardous',
    option4 = 'Safe, Secure'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "perilous"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Risky, Hazardous';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "perilous"?', 'synonym', 'Risky, Hazardous', 'Unstable, Risky', 'Safe, Trustworthy', 'Risky, Hazardous', 'Safe, Secure', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "perilous"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Risky, Hazardous'
) < 1;

UPDATE questions
SET option1 = 'Safe, Trustworthy',
    option2 = 'Safe, Secure',
    option3 = 'Risky, Hazardous',
    option4 = 'Unstable, Risky'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "precarious"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Unstable, Risky';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "precarious"?', 'synonym', 'Unstable, Risky', 'Safe, Trustworthy', 'Safe, Secure', 'Risky, Hazardous', 'Unstable, Risky', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "precarious"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Unstable, Risky'
) < 1;

UPDATE questions
SET option1 = 'Safe, Friendly',
    option2 = 'Scary, Dangerous',
    option3 = 'Dangerous, Hazardous',
    option4 = 'Safe, Trustworthy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "treacherous"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Dangerous, Hazardous';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "treacherous"?', 'synonym', 'Dangerous, Hazardous', 'Safe, Friendly', 'Scary, Dangerous', 'Dangerous, Hazardous', 'Safe, Trustworthy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "treacherous"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Dangerous, Hazardous'
) < 1;

UPDATE questions
SET option1 = 'Dangerous, Hazardous',
    option2 = 'Safe, Trustworthy',
    option3 = 'Scary, Dangerous',
    option4 = 'Safe, Friendly'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "threatening"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Scary, Dangerous';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "threatening"?', 'synonym', 'Scary, Dangerous', 'Dangerous, Hazardous', 'Safe, Trustworthy', 'Scary, Dangerous', 'Safe, Friendly', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "threatening"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Scary, Dangerous'
) < 1;

UPDATE questions
SET option1 = 'Dangerous, Risky',
    option2 = 'Safe, Trustworthy',
    option3 = 'Safe, Secure',
    option4 = 'Safe, Friendly'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "hazardous"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Dangerous, Risky';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "hazardous"?', 'synonym', 'Dangerous, Risky', 'Dangerous, Risky', 'Safe, Trustworthy', 'Safe, Secure', 'Safe, Friendly', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "hazardous"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Dangerous, Risky'
) < 1;

UPDATE questions
SET option1 = 'Calm, Composed',
    option2 = 'Peaceful, Calm',
    option3 = 'Calm, Collected',
    option4 = 'Nervous, Upset'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "unruffled"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Calm, Composed';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "unruffled"?', 'synonym', 'Calm, Composed', 'Calm, Composed', 'Peaceful, Calm', 'Calm, Collected', 'Nervous, Upset', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "unruffled"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Calm, Composed'
) < 1;

UPDATE questions
SET option1 = 'Calm, Quiet',
    option2 = 'Noisy, Chaotic',
    option3 = 'Calm, Peaceful',
    option4 = 'Busy, Chaotic'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "tranquil"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Calm, Peaceful';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "tranquil"?', 'synonym', 'Calm, Peaceful', 'Calm, Quiet', 'Noisy, Chaotic', 'Calm, Peaceful', 'Busy, Chaotic', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "tranquil"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Calm, Peaceful'
) < 1;

UPDATE questions
SET option1 = 'Safe, Friendly',
    option2 = 'Dull, Dark',
    option3 = 'Friendly, Warm',
    option4 = 'Distant, Detached'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "aloof"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Distant, Detached';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "aloof"?', 'synonym', 'Distant, Detached', 'Safe, Friendly', 'Dull, Dark', 'Friendly, Warm', 'Distant, Detached', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "aloof"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Distant, Detached'
) < 1;

UPDATE questions
SET option1 = 'Peaceful, Calm',
    option2 = 'Busy, Chaotic',
    option3 = 'Noisy, Chaotic',
    option4 = 'Calm, Composed'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "serene"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Peaceful, Calm';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "serene"?', 'synonym', 'Peaceful, Calm', 'Peaceful, Calm', 'Busy, Chaotic', 'Noisy, Chaotic', 'Calm, Composed', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "serene"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Peaceful, Calm'
) < 1;

UPDATE questions
SET option1 = 'Calm, Collected',
    option2 = 'Calm, Composed',
    option3 = 'Nervous, Upset',
    option4 = 'Calm, Peaceful'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "composed"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Calm, Collected';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "composed"?', 'synonym', 'Calm, Collected', 'Calm, Collected', 'Calm, Composed', 'Nervous, Upset', 'Calm, Peaceful', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "composed"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Calm, Collected'
) < 1;

UPDATE questions
SET option1 = 'Interesting, Captivating',
    option2 = 'Dull, Dark',
    option3 = 'Boring, Simple',
    option4 = 'Boring, Dull'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "fascinating"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Interesting, Captivating';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "fascinating"?', 'synonym', 'Interesting, Captivating', 'Interesting, Captivating', 'Dull, Dark', 'Boring, Simple', 'Boring, Dull', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "fascinating"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Interesting, Captivating'
) < 1;

UPDATE questions
SET option1 = 'Dull, Dark',
    option2 = 'Boring, Simple',
    option3 = 'Boring, Dull',
    option4 = 'Interesting, Captivating'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "engaging"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Interesting, Captivating';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "engaging"?', 'synonym', 'Interesting, Captivating', 'Dull, Dark', 'Boring, Simple', 'Boring, Dull', 'Interesting, Captivating', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "engaging"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Interesting, Captivating'
) < 1;

UPDATE questions
SET option1 = 'Fascinating, Curious',
    option2 = 'Boring, Simple',
    option3 = 'Attractive, Welcoming',
    option4 = 'Unappealing, Repelling'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "inviting"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Attractive, Welcoming';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "inviting"?', 'synonym', 'Attractive, Welcoming', 'Fascinating, Curious', 'Boring, Simple', 'Attractive, Welcoming', 'Unappealing, Repelling', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "inviting"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Attractive, Welcoming'
) < 1;

UPDATE questions
SET option1 = 'Fascinating, Curious',
    option2 = 'Boring, Simple',
    option3 = 'Glowing, Bright',
    option4 = 'Unappealing, Repelling'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "intriguing"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Fascinating, Curious';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "intriguing"?', 'synonym', 'Fascinating, Curious', 'Fascinating, Curious', 'Boring, Simple', 'Glowing, Bright', 'Unappealing, Repelling', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "intriguing"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Fascinating, Curious'
) < 1;

UPDATE questions
SET option1 = 'Ordinary, Humble',
    option2 = 'Calm, Controlled',
    option3 = 'Magical, Charming',
    option4 = 'Ordinary, Plain'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "bewitching"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Magical, Charming';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "bewitching"?', 'synonym', 'Magical, Charming', 'Ordinary, Humble', 'Calm, Controlled', 'Magical, Charming', 'Ordinary, Plain', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "bewitching"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Magical, Charming'
) < 1;

UPDATE questions
SET option1 = 'Glowing, Shiny',
    option2 = 'Dull, Faded',
    option3 = 'Dim, Dark',
    option4 = 'Dull, Dark'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "radiant"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Glowing, Shiny';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "radiant"?', 'synonym', 'Glowing, Shiny', 'Glowing, Shiny', 'Dull, Faded', 'Dim, Dark', 'Dull, Dark', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "radiant"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Glowing, Shiny'
) < 2;

UPDATE questions
SET option1 = 'Dull, Dirty',
    option2 = 'Dull, Faded',
    option3 = 'Bright, Clear',
    option4 = 'Dull, Dark'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "vivid"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Bright, Clear';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "vivid"?', 'synonym', 'Bright, Clear', 'Dull, Dirty', 'Dull, Faded', 'Bright, Clear', 'Dull, Dark', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "vivid"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Bright, Clear'
) < 1;

UPDATE questions
SET option1 = 'Dull, Faded',
    option2 = 'Dull, Matte',
    option3 = 'Dull, Dirty',
    option4 = 'Shiny, Glossy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "lustrous"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Shiny, Glossy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "lustrous"?', 'synonym', 'Shiny, Glossy', 'Dull, Faded', 'Dull, Matte', 'Dull, Dirty', 'Shiny, Glossy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "lustrous"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Shiny, Glossy'
) < 1;

UPDATE questions
SET option1 = 'Dull, Dark',
    option2 = 'Boring, Simple',
    option3 = 'Glowing, Bright',
    option4 = 'Dim, Dark'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "incandescent"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Glowing, Bright';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "incandescent"?', 'synonym', 'Glowing, Bright', 'Dull, Dark', 'Boring, Simple', 'Glowing, Bright', 'Dim, Dark', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "incandescent"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Glowing, Bright'
) < 1;

UPDATE questions
SET option1 = 'Dull, Faded',
    option2 = 'Dull, Matte',
    option3 = 'Dull, Dirty',
    option4 = 'Shiny, Sparkling'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "gleaming"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Shiny, Sparkling';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "gleaming"?', 'synonym', 'Shiny, Sparkling', 'Dull, Faded', 'Dull, Matte', 'Dull, Dirty', 'Shiny, Sparkling', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "gleaming"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Shiny, Sparkling'
) < 1;

UPDATE questions
SET option1 = 'Messy, Chaotic',
    option2 = 'Chaos, Disorder',
    option3 = 'Noisy, Chaotic',
    option4 = 'Neat, Organized'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "disorderly"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Messy, Chaotic';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "disorderly"?', 'synonym', 'Messy, Chaotic', 'Messy, Chaotic', 'Chaos, Disorder', 'Noisy, Chaotic', 'Neat, Organized', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "disorderly"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Messy, Chaotic'
) < 1;

UPDATE questions
SET option1 = 'Noisy, Chaotic',
    option2 = 'Calm, Controlled',
    option3 = 'Order, Calm',
    option4 = 'Calm, Quiet'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "tumultuous"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Noisy, Chaotic';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "tumultuous"?', 'synonym', 'Noisy, Chaotic', 'Noisy, Chaotic', 'Calm, Controlled', 'Order, Calm', 'Calm, Quiet', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "tumultuous"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Noisy, Chaotic'
) < 1;

UPDATE questions
SET option1 = 'Calm, Quiet',
    option2 = 'Calm, Controlled',
    option3 = 'Order, Calm',
    option4 = 'Chaos, Mayhem'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "pandemonium"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Chaos, Mayhem';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "pandemonium"?', 'synonym', 'Chaos, Mayhem', 'Calm, Quiet', 'Calm, Controlled', 'Order, Calm', 'Chaos, Mayhem', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "pandemonium"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Chaos, Mayhem'
) < 1;

UPDATE questions
SET option1 = 'Calm, Quiet',
    option2 = 'Chaos, Disorder',
    option3 = 'Ordinary, Humble',
    option4 = 'Order, Calm'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "mayhem"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Chaos, Disorder';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "mayhem"?', 'synonym', 'Chaos, Disorder', 'Calm, Quiet', 'Chaos, Disorder', 'Ordinary, Humble', 'Order, Calm', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "mayhem"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Chaos, Disorder'
) < 1;

UPDATE questions
SET option1 = 'Order, Calm',
    option2 = 'Calm, Controlled',
    option3 = 'Crazy, Wild',
    option4 = 'Calm, Quiet'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "berserk"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Crazy, Wild';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "berserk"?', 'synonym', 'Crazy, Wild', 'Order, Calm', 'Calm, Controlled', 'Crazy, Wild', 'Calm, Quiet', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "berserk"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Crazy, Wild'
) < 1;

UPDATE questions
SET option1 = 'Greedy, Overeating',
    option2 = 'Moderate, Frugal',
    option3 = 'Dull, Dirty',
    option4 = 'Shiny, Sparkling'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "gluttonous"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Greedy, Overeating';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "gluttonous"?', 'synonym', 'Greedy, Overeating', 'Greedy, Overeating', 'Moderate, Frugal', 'Dull, Dirty', 'Shiny, Sparkling', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "gluttonous"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Greedy, Overeating'
) < 1;

UPDATE questions
SET option1 = 'Free, Help',
    option2 = 'Free, Voluntary',
    option3 = 'Forced, Obliged',
    option4 = 'Nervous, Upset'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "compelled"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Forced, Obliged';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "compelled"?', 'synonym', 'Forced, Obliged', 'Free, Help', 'Free, Voluntary', 'Forced, Obliged', 'Nervous, Upset', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "compelled"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Forced, Obliged'
) < 1;

UPDATE questions
SET option1 = 'Chaos, Disorder',
    option2 = 'Grand, Noble',
    option3 = 'Ordinary, Humble',
    option4 = 'Order, Calm'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "majestic"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Grand, Noble';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "majestic"?', 'synonym', 'Grand, Noble', 'Chaos, Disorder', 'Grand, Noble', 'Ordinary, Humble', 'Order, Calm', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "majestic"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Grand, Noble'
) < 1;

UPDATE questions
SET option1 = 'Free, Help',
    option2 = 'Free, Voluntary',
    option3 = 'Calm, Controlled',
    option4 = 'Control, Dominate'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "oppress"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Control, Dominate';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "oppress"?', 'synonym', 'Control, Dominate', 'Free, Help', 'Free, Voluntary', 'Calm, Controlled', 'Control, Dominate', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "oppress"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Control, Dominate'
) < 1;

DROP TABLE seed_quiz_id;

-- Year 5 Vocabulary 8 Pages Synonym Paper 2
INSERT INTO quizzes (title, description, created_by, stage_id, lock_after_attempt)
SELECT 'Year 5 Vocabulary 8 Pages Synonym Paper 2',
       'A 100-question Year 5 vocabulary exam from the 8-page workbook asking students to identify synonym pairs.',
       1,
       (SELECT id FROM stages WHERE name = 'Year 5'),
       1
WHERE NOT EXISTS (SELECT 1 FROM quizzes WHERE title = 'Year 5 Vocabulary 8 Pages Synonym Paper 2');

DROP TABLE IF EXISTS seed_quiz_id;
CREATE TEMP TABLE seed_quiz_id(id INTEGER);
INSERT INTO seed_quiz_id SELECT id FROM quizzes WHERE title = 'Year 5 Vocabulary 8 Pages Synonym Paper 2' LIMIT 1;

UPDATE questions
SET option1 = 'Skilled, Expert',
    option2 = 'Unskilled, Inept',
    option3 = 'Inhabited, Settled',
    option4 = 'Empty, Uninhabited'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "populated"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Inhabited, Settled';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "populated"?', 'synonym', 'Inhabited, Settled', 'Skilled, Expert', 'Unskilled, Inept', 'Inhabited, Settled', 'Empty, Uninhabited', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "populated"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Inhabited, Settled'
) < 1;

UPDATE questions
SET option1 = 'Free, Voluntary',
    option2 = 'Refuse, Reject',
    option3 = 'Refuse, Demand',
    option4 = 'Beg, Plead'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "implore"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Beg, Plead';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "implore"?', 'synonym', 'Beg, Plead', 'Free, Voluntary', 'Refuse, Reject', 'Refuse, Demand', 'Beg, Plead', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "implore"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Beg, Plead'
) < 1;

UPDATE questions
SET option1 = 'Empty, Uninhabited',
    option2 = 'Skilled, Expert',
    option3 = 'Unskilled, Inept',
    option4 = 'Inhabited, Settled'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "proficient"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Skilled, Expert';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "proficient"?', 'synonym', 'Skilled, Expert', 'Empty, Uninhabited', 'Skilled, Expert', 'Unskilled, Inept', 'Inhabited, Settled', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "proficient"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Skilled, Expert'
) < 1;

UPDATE questions
SET option1 = 'Solo, Individual',
    option2 = 'Reword, Restate',
    option3 = 'Order, Calm',
    option4 = 'Quote, Copy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "paraphrase"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Reword, Restate';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "paraphrase"?', 'synonym', 'Reword, Restate', 'Solo, Individual', 'Reword, Restate', 'Order, Calm', 'Quote, Copy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "paraphrase"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Reword, Restate'
) < 1;

UPDATE questions
SET option1 = 'Waste, Trash',
    option2 = 'Pride, Satisfaction',
    option3 = 'Regret, Guilt',
    option4 = 'Reuse, Repurpose'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "recycle"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Reuse, Repurpose';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "recycle"?', 'synonym', 'Reuse, Repurpose', 'Waste, Trash', 'Pride, Satisfaction', 'Regret, Guilt', 'Reuse, Repurpose', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "recycle"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Reuse, Repurpose'
) < 1;

UPDATE questions
SET option1 = 'Insufficient, Lacking',
    option2 = 'Observation, Monitoring',
    option3 = 'Adequate, Enough',
    option4 = 'Ignoring, Neglect'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "surveillance"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Observation, Monitoring';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "surveillance"?', 'synonym', 'Observation, Monitoring', 'Insufficient, Lacking', 'Observation, Monitoring', 'Adequate, Enough', 'Ignoring, Neglect', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "surveillance"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Observation, Monitoring'
) < 1;

UPDATE questions
SET option1 = 'Shy, Aloof',
    option2 = 'Careless, Open',
    option3 = 'Careful, Cautious',
    option4 = 'Social, Friendly'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "guarded"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Careful, Cautious';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "guarded"?', 'synonym', 'Careful, Cautious', 'Shy, Aloof', 'Careless, Open', 'Careful, Cautious', 'Social, Friendly', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "guarded"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Careful, Cautious'
) < 1;

UPDATE questions
SET option1 = 'Clear, Fluent',
    option2 = 'Loud, Clear',
    option3 = 'Silent, Muffled',
    option4 = 'Messy, Chaotic'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "inaudible"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Silent, Muffled';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "inaudible"?', 'synonym', 'Silent, Muffled', 'Clear, Fluent', 'Loud, Clear', 'Silent, Muffled', 'Messy, Chaotic', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "inaudible"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Silent, Muffled'
) < 1;

UPDATE questions
SET option1 = 'Loud, Clear',
    option2 = 'Solo, Individual',
    option3 = 'Reword, Restate',
    option4 = 'Band, Ensemble'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "orchestra"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Band, Ensemble';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "orchestra"?', 'synonym', 'Band, Ensemble', 'Loud, Clear', 'Solo, Individual', 'Reword, Restate', 'Band, Ensemble', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "orchestra"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Band, Ensemble'
) < 1;

UPDATE questions
SET option1 = 'Calm, Soothe',
    option2 = 'Calm, Peaceful',
    option3 = 'Perfect, Peaceful',
    option4 = 'Agitated, Wild'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "placid"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Calm, Peaceful';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "placid"?', 'synonym', 'Calm, Peaceful', 'Calm, Soothe', 'Calm, Peaceful', 'Perfect, Peaceful', 'Agitated, Wild', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "placid"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Calm, Peaceful'
) < 1;

UPDATE questions
SET option1 = 'Reuse, Repurpose',
    option2 = 'Pride, Satisfaction',
    option3 = 'Regret, Guilt',
    option4 = 'Waste, Trash'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "remorse"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Regret, Guilt';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "remorse"?', 'synonym', 'Regret, Guilt', 'Reuse, Repurpose', 'Pride, Satisfaction', 'Regret, Guilt', 'Waste, Trash', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "remorse"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Regret, Guilt'
) < 1;

UPDATE questions
SET option1 = 'Solo, Individual',
    option2 = 'Poor, Failing',
    option3 = 'Shy, Aloof',
    option4 = 'Social, Friendly'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "gregarious"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Social, Friendly';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "gregarious"?', 'synonym', 'Social, Friendly', 'Solo, Individual', 'Poor, Failing', 'Shy, Aloof', 'Social, Friendly', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "gregarious"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Social, Friendly'
) < 1;

UPDATE questions
SET option1 = 'Normal, Ordinary',
    option2 = 'Messy, Chaotic',
    option3 = 'Perfect, Peaceful',
    option4 = 'Calm, Peaceful'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "idyllic"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Perfect, Peaceful';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "idyllic"?', 'synonym', 'Perfect, Peaceful', 'Normal, Ordinary', 'Messy, Chaotic', 'Perfect, Peaceful', 'Calm, Peaceful', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "idyllic"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Perfect, Peaceful'
) < 1;

UPDATE questions
SET option1 = 'Criticize, Harm',
    option2 = 'Keep, Gain',
    option3 = 'Pride, Satisfaction',
    option4 = 'Praise, Help'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "malign"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Criticize, Harm';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "malign"?', 'synonym', 'Criticize, Harm', 'Criticize, Harm', 'Keep, Gain', 'Pride, Satisfaction', 'Praise, Help', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "malign"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Criticize, Harm'
) < 1;

UPDATE questions
SET option1 = 'Ordinary, Small',
    option2 = 'Normal, Ordinary',
    option3 = 'Sensible, Normal',
    option4 = 'Strange, Odd'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "peculiar"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Strange, Odd';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "peculiar"?', 'synonym', 'Strange, Odd', 'Ordinary, Small', 'Normal, Ordinary', 'Sensible, Normal', 'Strange, Odd', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "peculiar"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Strange, Odd'
) < 1;

UPDATE questions
SET option1 = 'Wealthy, Thriving',
    option2 = 'Annoy, Stir',
    option3 = 'Calm, Soothe',
    option4 = 'Poor, Failing'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "prosperous"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Wealthy, Thriving';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "prosperous"?', 'synonym', 'Wealthy, Thriving', 'Wealthy, Thriving', 'Annoy, Stir', 'Calm, Soothe', 'Poor, Failing', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "prosperous"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Wealthy, Thriving'
) < 1;

UPDATE questions
SET option1 = 'Keep, Gain',
    option2 = 'Give up, Forfeit',
    option3 = 'Amazing, Fantastic',
    option4 = 'Insufficient, Lacking'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "sacrificed"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Give up, Forfeit';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "sacrificed"?', 'synonym', 'Give up, Forfeit', 'Keep, Gain', 'Give up, Forfeit', 'Amazing, Fantastic', 'Insufficient, Lacking', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "sacrificed"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Give up, Forfeit'
) < 1;

UPDATE questions
SET option1 = 'Ignoring, Neglect',
    option2 = 'Insufficient, Lacking',
    option3 = 'Adequate, Enough',
    option4 = 'Enough, Sufficient'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "sufficient"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Adequate, Enough';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "sufficient"?', 'synonym', 'Adequate, Enough', 'Ignoring, Neglect', 'Insufficient, Lacking', 'Adequate, Enough', 'Enough, Sufficient', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "sufficient"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Adequate, Enough'
) < 1;

UPDATE questions
SET option1 = 'Calm, Soothe',
    option2 = 'Wealthy, Thriving',
    option3 = 'Poor, Failing',
    option4 = 'Annoy, Stir'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "provoke"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Annoy, Stir';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "provoke"?', 'synonym', 'Annoy, Stir', 'Calm, Soothe', 'Wealthy, Thriving', 'Poor, Failing', 'Annoy, Stir', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "provoke"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Annoy, Stir'
) < 1;

UPDATE questions
SET option1 = 'Worn, Old',
    option2 = 'Ordinary, Small',
    option3 = 'Strange, Odd',
    option4 = 'New, Fresh'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "threadbare"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Worn, Old';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "threadbare"?', 'synonym', 'Worn, Old', 'Worn, Old', 'Ordinary, Small', 'Strange, Odd', 'New, Fresh', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "threadbare"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Worn, Old'
) < 1;

UPDATE questions
SET option1 = 'Ordinary, Small',
    option2 = 'Amazing, Fantastic',
    option3 = 'Insufficient, Lacking',
    option4 = 'Normal, Ordinary'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "stupendous"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Amazing, Fantastic';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "stupendous"?', 'synonym', 'Amazing, Fantastic', 'Ordinary, Small', 'Amazing, Fantastic', 'Insufficient, Lacking', 'Normal, Ordinary', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "stupendous"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Amazing, Fantastic'
) < 1;

UPDATE questions
SET option1 = 'Difficult, Tough',
    option2 = 'Insufficient, Lacking',
    option3 = 'Adequate, Enough',
    option4 = 'Enough, Sufficient'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "adequate"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Enough, Sufficient';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "adequate"?', 'synonym', 'Enough, Sufficient', 'Difficult, Tough', 'Insufficient, Lacking', 'Adequate, Enough', 'Enough, Sufficient', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "adequate"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Enough, Sufficient'
) < 1;

UPDATE questions
SET option1 = 'Sensible, Normal',
    option2 = 'Plenty, Lots',
    option3 = 'Silly, Ridiculous',
    option4 = 'Scarcity, Shortage'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "abundance"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Plenty, Lots';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "abundance"?', 'synonym', 'Plenty, Lots', 'Sensible, Normal', 'Plenty, Lots', 'Silly, Ridiculous', 'Scarcity, Shortage', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "abundance"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Plenty, Lots'
) < 1;

UPDATE questions
SET option1 = 'Sensible, Normal',
    option2 = 'Trainee, Learner',
    option3 = 'Expert, Master',
    option4 = 'Annoy, Provoke'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "apprentice"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Trainee, Learner';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "apprentice"?', 'synonym', 'Trainee, Learner', 'Sensible, Normal', 'Trainee, Learner', 'Expert, Master', 'Annoy, Provoke', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "apprentice"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Trainee, Learner'
) < 1;

UPDATE questions
SET option1 = 'Handy, Useful',
    option2 = 'Inconvenient, Awkward',
    option3 = 'Morals, Awareness',
    option4 = 'Carelessness, Ignorance'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "conscience"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Morals, Awareness';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "conscience"?', 'synonym', 'Morals, Awareness', 'Handy, Useful', 'Inconvenient, Awkward', 'Morals, Awareness', 'Carelessness, Ignorance', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "conscience"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Morals, Awareness'
) < 1;

UPDATE questions
SET option1 = 'Morals, Awareness',
    option2 = 'Handy, Useful',
    option3 = 'Inconvenient, Awkward',
    option4 = 'Carelessness, Ignorance'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "convenient"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Handy, Useful';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "convenient"?', 'synonym', 'Handy, Useful', 'Morals, Awareness', 'Handy, Useful', 'Inconvenient, Awkward', 'Carelessness, Ignorance', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "convenient"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Handy, Useful'
) < 1;

UPDATE questions
SET option1 = 'Silly, Ridiculous',
    option2 = 'Difficult, Tough',
    option3 = 'Enough, Sufficient',
    option4 = 'Easy, Simple'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "arduous"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Difficult, Tough';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "arduous"?', 'synonym', 'Difficult, Tough', 'Silly, Ridiculous', 'Difficult, Tough', 'Enough, Sufficient', 'Easy, Simple', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "arduous"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Difficult, Tough'
) < 1;

UPDATE questions
SET option1 = 'Plenty, Lots',
    option2 = 'Sensible, Normal',
    option3 = 'Scarcity, Shortage',
    option4 = 'Silly, Ridiculous'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "absurd"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Silly, Ridiculous';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "absurd"?', 'synonym', 'Silly, Ridiculous', 'Plenty, Lots', 'Sensible, Normal', 'Scarcity, Shortage', 'Silly, Ridiculous', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "absurd"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Silly, Ridiculous'
) < 1;

UPDATE questions
SET option1 = 'Lazy, Careless',
    option2 = 'Easy, Simple',
    option3 = 'Modern item, New thing',
    option4 = 'Relic, Object'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "artefact"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Relic, Object';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "artefact"?', 'synonym', 'Relic, Object', 'Lazy, Careless', 'Easy, Simple', 'Modern item, New thing', 'Relic, Object', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "artefact"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Relic, Object'
) < 1;

UPDATE questions
SET option1 = 'Differ, Clash',
    option2 = 'Clear, Empty',
    option3 = 'Clear, Obvious',
    option4 = 'Crowded, Packed'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "congested"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Crowded, Packed';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "congested"?', 'synonym', 'Crowded, Packed', 'Differ, Clash', 'Clear, Empty', 'Clear, Obvious', 'Crowded, Packed', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "congested"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Crowded, Packed'
) < 1;

UPDATE questions
SET option1 = 'Clear, Empty',
    option2 = 'Clear, Obvious',
    option3 = 'Mysterious, Puzzling',
    option4 = 'Straighten, Unbend'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "cryptic"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Mysterious, Puzzling';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "cryptic"?', 'synonym', 'Mysterious, Puzzling', 'Clear, Empty', 'Clear, Obvious', 'Mysterious, Puzzling', 'Straighten, Unbend', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "cryptic"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Mysterious, Puzzling'
) < 1;

UPDATE questions
SET option1 = 'Ignore, Conceal',
    option2 = 'Leave, Separate',
    option3 = 'Join, Attend',
    option4 = 'Introduce, Inform'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "acquaint"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Introduce, Inform';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "acquaint"?', 'synonym', 'Introduce, Inform', 'Ignore, Conceal', 'Leave, Separate', 'Join, Attend', 'Introduce, Inform', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "acquaint"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Introduce, Inform'
) < 1;

UPDATE questions
SET option1 = 'Lazy, Careless',
    option2 = 'Distant, Far',
    option3 = 'Diligent, Hardworking',
    option4 = 'Together, Joined'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "assiduous"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Diligent, Hardworking';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "assiduous"?', 'synonym', 'Diligent, Hardworking', 'Lazy, Careless', 'Distant, Far', 'Diligent, Hardworking', 'Together, Joined', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "assiduous"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Diligent, Hardworking'
) < 1;

UPDATE questions
SET option1 = 'Distant, Detached',
    option2 = 'Friendly, Warm',
    option3 = 'Distant, Far',
    option4 = 'Detach, Disobey'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "aloof"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Distant, Detached';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "aloof"?', 'synonym', 'Distant, Detached', 'Distant, Detached', 'Friendly, Warm', 'Distant, Far', 'Detach, Disobey', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "aloof"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Distant, Detached'
) < 1;

UPDATE questions
SET option1 = 'Detach, Disobey',
    option2 = 'Distant, Detached',
    option3 = 'Nearby, Beside',
    option4 = 'Distant, Far'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "adjacent"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Nearby, Beside';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "adjacent"?', 'synonym', 'Nearby, Beside', 'Detach, Disobey', 'Distant, Detached', 'Nearby, Beside', 'Distant, Far', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "adjacent"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Nearby, Beside'
) < 1;

UPDATE questions
SET option1 = 'Ignore, Avoid',
    option2 = 'Twist, Bend',
    option3 = 'Agree, Support',
    option4 = 'Straighten, Unbend'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "contort"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Twist, Bend';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "contort"?', 'synonym', 'Twist, Bend', 'Ignore, Avoid', 'Twist, Bend', 'Agree, Support', 'Straighten, Unbend', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "contort"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Twist, Bend'
) < 1;

UPDATE questions
SET option1 = 'Leave, Separate',
    option2 = 'Ignore, Conceal',
    option3 = 'Join, Attend',
    option4 = 'Introduce, Inform'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "accompany"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Join, Attend';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "accompany"?', 'synonym', 'Join, Attend', 'Leave, Separate', 'Ignore, Conceal', 'Join, Attend', 'Introduce, Inform', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "accompany"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Join, Attend'
) < 1;

UPDATE questions
SET option1 = 'Calm, Soothe',
    option2 = 'Release, Free',
    option3 = 'Annoy, Provoke',
    option4 = 'Together, Joined'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "appease"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Calm, Soothe';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "appease"?', 'synonym', 'Calm, Soothe', 'Calm, Soothe', 'Release, Free', 'Annoy, Provoke', 'Together, Joined', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "appease"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Calm, Soothe'
) < 1;

UPDATE questions
SET option1 = 'Release, Free',
    option2 = 'Kidnap, Seize',
    option3 = 'Leave, Separate',
    option4 = 'Free, Untangle'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "abduct"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Kidnap, Seize';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "abduct"?', 'synonym', 'Kidnap, Seize', 'Release, Free', 'Kidnap, Seize', 'Leave, Separate', 'Free, Untangle', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "abduct"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Kidnap, Seize'
) < 1;

UPDATE questions
SET option1 = 'Agree, Support',
    option2 = 'Ignore, Avoid',
    option3 = 'Straighten, Unbend',
    option4 = 'Discuss, Consult'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "confer"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Discuss, Consult';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "confer"?', 'synonym', 'Discuss, Consult', 'Agree, Support', 'Ignore, Avoid', 'Straighten, Unbend', 'Discuss, Consult', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "confer"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Discuss, Consult'
) < 1;

UPDATE questions
SET option1 = 'Twist, Bend',
    option2 = 'Agree, Support',
    option3 = 'Straighten, Unbend',
    option4 = 'Disagree, Oppose'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "contradict"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Disagree, Oppose';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "contradict"?', 'synonym', 'Disagree, Oppose', 'Twist, Bend', 'Agree, Support', 'Straighten, Unbend', 'Disagree, Oppose', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "contradict"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Disagree, Oppose'
) < 1;

UPDATE questions
SET option1 = 'Together, Joined',
    option2 = 'Distant, Far',
    option3 = 'Stick, Obey',
    option4 = 'Detach, Disobey'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "adhere (to)"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Stick, Obey';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "adhere (to)"?', 'synonym', 'Stick, Obey', 'Together, Joined', 'Distant, Far', 'Stick, Obey', 'Detach, Disobey', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "adhere (to)"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Stick, Obey'
) < 1;

UPDATE questions
SET option1 = 'Detach, Disobey',
    option2 = 'Apart, Separated',
    option3 = 'Leave, Separate',
    option4 = 'Together, Joined'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "asunder"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Apart, Separated';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "asunder"?', 'synonym', 'Apart, Separated', 'Detach, Disobey', 'Apart, Separated', 'Leave, Separate', 'Together, Joined', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "asunder"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Apart, Separated'
) < 1;

UPDATE questions
SET option1 = 'Ignore, Avoid',
    option2 = 'Agree, Support',
    option3 = 'Match, Communicate',
    option4 = 'Differ, Clash'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "correspond"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Match, Communicate';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "correspond"?', 'synonym', 'Match, Communicate', 'Ignore, Avoid', 'Agree, Support', 'Match, Communicate', 'Differ, Clash', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "correspond"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Match, Communicate'
) < 1;

UPDATE questions
SET option1 = 'Free, Untangle',
    option2 = 'Stay, Freeze',
    option3 = 'Entangle, Involve',
    option4 = 'Release, Free'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "embroil"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Entangle, Involve';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "embroil"?', 'synonym', 'Entangle, Involve', 'Free, Untangle', 'Stay, Freeze', 'Entangle, Involve', 'Release, Free', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "embroil"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Entangle, Involve'
) < 1;

UPDATE questions
SET option1 = 'Rejected, Removed',
    option2 = 'Free, Untangle',
    option3 = 'Chosen, Selected',
    option4 = 'Hidden, Unclear'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "elected"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Chosen, Selected';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "elected"?', 'synonym', 'Chosen, Selected', 'Rejected, Removed', 'Free, Untangle', 'Chosen, Selected', 'Hidden, Unclear', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "elected"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Chosen, Selected'
) < 1;

UPDATE questions
SET option1 = 'Collect, Gather',
    option2 = 'Guess, Ignore',
    option3 = 'Encourage, Cheer',
    option4 = 'Discourage, Upset'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "dishearten"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Discourage, Upset';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "dishearten"?', 'synonym', 'Discourage, Upset', 'Collect, Gather', 'Guess, Ignore', 'Encourage, Cheer', 'Discourage, Upset', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "dishearten"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Discourage, Upset'
) < 1;

UPDATE questions
SET option1 = 'Ignore, Avoid',
    option2 = 'Inform, Clarify',
    option3 = 'Guess, Ignore',
    option4 = 'Identify, Detect'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "diagnose"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Identify, Detect';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "diagnose"?', 'synonym', 'Identify, Detect', 'Ignore, Avoid', 'Inform, Clarify', 'Guess, Ignore', 'Identify, Detect', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "diagnose"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Identify, Detect'
) < 1;

UPDATE questions
SET option1 = 'Playful, Silly',
    option2 = 'Hidden, Unclear',
    option3 = 'Serious, Sincere',
    option4 = 'Guess, Ignore'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "earnest"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Serious, Sincere';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "earnest"?', 'synonym', 'Serious, Sincere', 'Playful, Silly', 'Hidden, Unclear', 'Serious, Sincere', 'Guess, Ignore', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "earnest"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Serious, Sincere'
) < 1;

UPDATE questions
SET option1 = 'Develop, Grow',
    option2 = 'Hidden, Unclear',
    option3 = 'Stay, Freeze',
    option4 = 'Clear, Obvious'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "evident"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Clear, Obvious';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "evident"?', 'synonym', 'Clear, Obvious', 'Develop, Grow', 'Hidden, Unclear', 'Stay, Freeze', 'Clear, Obvious', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "evident"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Clear, Obvious'
) < 1;

UPDATE questions
SET option1 = 'Surprise, Unknown',
    option2 = 'Playful, Silly',
    option3 = 'Predict, Prediction',
    option4 = 'Surprise, Hide'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "forecast"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Predict, Prediction';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "forecast"?', 'synonym', 'Predict, Prediction', 'Surprise, Unknown', 'Playful, Silly', 'Predict, Prediction', 'Surprise, Hide', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "forecast"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Predict, Prediction'
) < 1;

UPDATE questions
SET option1 = 'Dispute, Argument',
    option2 = 'Agreement, Harmony',
    option3 = 'Agree, Support',
    option4 = 'Ignore, Avoid'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "controversy"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Dispute, Argument';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "controversy"?', 'synonym', 'Dispute, Argument', 'Dispute, Argument', 'Agreement, Harmony', 'Agree, Support', 'Ignore, Avoid', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "controversy"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Dispute, Argument'
) < 1;

UPDATE questions
SET option1 = 'Deceive, Fool',
    option2 = 'Improve, Repair',
    option3 = 'Decay, Decline',
    option4 = 'Inform, Clarify'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "delude"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Deceive, Fool';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "delude"?', 'synonym', 'Deceive, Fool', 'Deceive, Fool', 'Improve, Repair', 'Decay, Decline', 'Inform, Clarify', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "delude"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Deceive, Fool'
) < 1;

UPDATE questions
SET option1 = 'Inform, Clarify',
    option2 = 'Improve, Repair',
    option3 = 'Deceive, Fool',
    option4 = 'Decay, Decline'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "deteriorate"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Decay, Decline';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "deteriorate"?', 'synonym', 'Decay, Decline', 'Inform, Clarify', 'Improve, Repair', 'Deceive, Fool', 'Decay, Decline', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "deteriorate"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Decay, Decline'
) < 1;

UPDATE questions
SET option1 = 'Stay, Freeze',
    option2 = 'Develop, Grow',
    option3 = 'Hidden, Unclear',
    option4 = 'Stay, Remain'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "evolve"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Develop, Grow';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "evolve"?', 'synonym', 'Develop, Grow', 'Stay, Freeze', 'Develop, Grow', 'Hidden, Unclear', 'Stay, Remain', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "evolve"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Develop, Grow'
) < 1;

UPDATE questions
SET option1 = 'Downplay, Reduce',
    option2 = 'Stay, Remain',
    option3 = 'Leave, Escape',
    option4 = 'Overstate, Stretch'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "exaggerate"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Overstate, Stretch';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "exaggerate"?', 'synonym', 'Overstate, Stretch', 'Downplay, Reduce', 'Stay, Remain', 'Leave, Escape', 'Overstate, Stretch', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "exaggerate"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Overstate, Stretch'
) < 1;

UPDATE questions
SET option1 = 'Neglect, Ignore',
    option2 = 'Effort, Drive',
    option3 = 'Hide, Conceal',
    option4 = 'Avoid, Ignore'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "campaign"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Effort, Drive';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "campaign"?', 'synonym', 'Effort, Drive', 'Neglect, Ignore', 'Effort, Drive', 'Hide, Conceal', 'Avoid, Ignore', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "campaign"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Effort, Drive'
) < 1;

UPDATE questions
SET option1 = 'Nervous, Panicked',
    option2 = 'Enhance, Match',
    option3 = 'Calm, Collected',
    option4 = 'Clash, Spoil'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "composed"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Calm, Collected';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "composed"?', 'synonym', 'Calm, Collected', 'Nervous, Panicked', 'Enhance, Match', 'Calm, Collected', 'Clash, Spoil', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "composed"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Calm, Collected'
) < 1;

UPDATE questions
SET option1 = 'Hand out, Distribute',
    option2 = 'Collect, Gather',
    option3 = 'Calm, Collected',
    option4 = 'Encourage, Cheer'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "dispense"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Hand out, Distribute';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "dispense"?', 'synonym', 'Hand out, Distribute', 'Hand out, Distribute', 'Collect, Gather', 'Calm, Collected', 'Encourage, Cheer', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "dispense"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Hand out, Distribute'
) < 1;

UPDATE questions
SET option1 = 'Dislike, Repel',
    option2 = 'Reveal, Tell',
    option3 = 'Hide, Conceal',
    option4 = 'Confuse, Scramble'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "divulge"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Reveal, Tell';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "divulge"?', 'synonym', 'Reveal, Tell', 'Dislike, Repel', 'Reveal, Tell', 'Hide, Conceal', 'Confuse, Scramble', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "divulge"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Reveal, Tell'
) < 1;

UPDATE questions
SET option1 = 'Leave, Escape',
    option2 = 'Stay, Freeze',
    option3 = 'Stay, Remain',
    option4 = 'Avoid, Ignore'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "evacuate"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Leave, Escape';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "evacuate"?', 'synonym', 'Leave, Escape', 'Leave, Escape', 'Stay, Freeze', 'Stay, Remain', 'Avoid, Ignore', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "evacuate"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Leave, Escape'
) < 1;

UPDATE questions
SET option1 = 'Calm, Collected',
    option2 = 'Clash, Spoil',
    option3 = 'Nervous, Panicked',
    option4 = 'Enhance, Match'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "complemented"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Enhance, Match';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "complemented"?', 'synonym', 'Enhance, Match', 'Calm, Collected', 'Clash, Spoil', 'Nervous, Panicked', 'Enhance, Match', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "complemented"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Enhance, Match'
) < 1;

UPDATE questions
SET option1 = 'Confuse, Scramble',
    option2 = 'Decode, Understand',
    option3 = 'Inform, Clarify',
    option4 = 'Hide, Conceal'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "decipher"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Decode, Understand';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "decipher"?', 'synonym', 'Decode, Understand', 'Confuse, Scramble', 'Decode, Understand', 'Inform, Clarify', 'Hide, Conceal', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "decipher"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Decode, Understand'
) < 1;

UPDATE questions
SET option1 = 'Imitate, Copy',
    option2 = 'Stay, Remain',
    option3 = 'Help, Aid',
    option4 = 'Avoid, Ignore'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "emulate"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Imitate, Copy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "emulate"?', 'synonym', 'Imitate, Copy', 'Imitate, Copy', 'Stay, Remain', 'Help, Aid', 'Avoid, Ignore', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "emulate"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Imitate, Copy'
) < 1;

UPDATE questions
SET option1 = 'Dislike, Repel',
    option2 = 'Repel, Discourage',
    option3 = 'Free, Independent',
    option4 = 'Charm, Delight'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "enamour"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Charm, Delight';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "enamour"?', 'synonym', 'Charm, Delight', 'Dislike, Repel', 'Repel, Discourage', 'Free, Independent', 'Charm, Delight', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "enamour"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Charm, Delight'
) < 1;

UPDATE questions
SET option1 = 'Dislike, Repel',
    option2 = 'Free, Independent',
    option3 = 'Repel, Discourage',
    option4 = 'Tempt, Lure'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "entice"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Tempt, Lure';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "entice"?', 'synonym', 'Tempt, Lure', 'Dislike, Repel', 'Free, Independent', 'Repel, Discourage', 'Tempt, Lure', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "entice"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Tempt, Lure'
) < 1;

UPDATE questions
SET option1 = 'Resentment, Anger',
    option2 = 'Forgiveness, Peace',
    option3 = 'Repel, Discourage',
    option4 = 'Slowly, Later'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "grudge"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Resentment, Anger';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "grudge"?', 'synonym', 'Resentment, Anger', 'Resentment, Anger', 'Forgiveness, Peace', 'Repel, Discourage', 'Slowly, Later', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "grudge"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Resentment, Anger'
) < 1;

UPDATE questions
SET option1 = 'Obstacle, Problem',
    option2 = 'Help, Aid',
    option3 = 'Avoid, Ignore',
    option4 = 'Advance, Give'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "hindrance"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Obstacle, Problem';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "hindrance"?', 'synonym', 'Obstacle, Problem', 'Obstacle, Problem', 'Help, Aid', 'Avoid, Ignore', 'Advance, Give', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "hindrance"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Obstacle, Problem'
) < 1;

UPDATE questions
SET option1 = 'Physical, Solid',
    option2 = 'Immediately, Quickly',
    option3 = 'Slowly, Later',
    option4 = 'Invisible, Abstract'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "intangible"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Invisible, Abstract';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "intangible"?', 'synonym', 'Invisible, Abstract', 'Physical, Solid', 'Immediately, Quickly', 'Slowly, Later', 'Invisible, Abstract', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "intangible"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Invisible, Abstract'
) < 1;

UPDATE questions
SET option1 = 'Free, Independent',
    option2 = 'Invisible, Abstract',
    option3 = 'Wise, Sensible',
    option4 = 'Foolish, Rash'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "judicious"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Wise, Sensible';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "judicious"?', 'synonym', 'Wise, Sensible', 'Free, Independent', 'Invisible, Abstract', 'Wise, Sensible', 'Foolish, Rash', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "judicious"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Wise, Sensible'
) < 1;

UPDATE questions
SET option1 = 'Energy, Alertness',
    option2 = 'Repel, Discourage',
    option3 = 'Forgiveness, Peace',
    option4 = 'Tiredness, Sluggishness'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "lethargy"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Tiredness, Sluggishness';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "lethargy"?', 'synonym', 'Tiredness, Sluggishness', 'Energy, Alertness', 'Repel, Discourage', 'Forgiveness, Peace', 'Tiredness, Sluggishness', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "lethargy"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Tiredness, Sluggishness'
) < 1;

UPDATE questions
SET option1 = 'Invisible, Abstract',
    option2 = 'Immediately, Quickly',
    option3 = 'Physical, Solid',
    option4 = 'Slowly, Later'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "instantly"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Immediately, Quickly';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "instantly"?', 'synonym', 'Immediately, Quickly', 'Invisible, Abstract', 'Immediately, Quickly', 'Physical, Solid', 'Slowly, Later', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "instantly"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Immediately, Quickly'
) < 1;

UPDATE questions
SET option1 = 'Advance, Give',
    option2 = 'Remove, Retreat',
    option3 = 'Advancing, Staying',
    option4 = 'Balance, Steady'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "withdraw"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Remove, Retreat';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "withdraw"?', 'synonym', 'Remove, Retreat', 'Advance, Give', 'Remove, Retreat', 'Advancing, Staying', 'Balance, Steady', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "withdraw"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Remove, Retreat'
) < 1;

UPDATE questions
SET option1 = 'Oddity, Exception',
    option2 = 'Terrible, Horrible',
    option3 = 'Normality, Usual',
    option4 = 'Wonderful, Pleasant'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "abominable"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Terrible, Horrible';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "abominable"?', 'synonym', 'Terrible, Horrible', 'Oddity, Exception', 'Terrible, Horrible', 'Normality, Usual', 'Wonderful, Pleasant', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "abominable"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Terrible, Horrible'
) < 1;

UPDATE questions
SET option1 = 'Free, Independent',
    option2 = 'Repel, Discourage',
    option3 = 'Trapped, Controlled',
    option4 = 'Dislike, Repel'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "enslaved"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Trapped, Controlled';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "enslaved"?', 'synonym', 'Trapped, Controlled', 'Free, Independent', 'Repel, Discourage', 'Trapped, Controlled', 'Dislike, Repel', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "enslaved"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Trapped, Controlled'
) < 1;

UPDATE questions
SET option1 = 'Greed, Possessions',
    option2 = 'Simplicity, Contentment',
    option3 = 'Slightly, Barely',
    option4 = 'Free, Independent'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "materialism"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Greed, Possessions';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "materialism"?', 'synonym', 'Greed, Possessions', 'Greed, Possessions', 'Simplicity, Contentment', 'Slightly, Barely', 'Free, Independent', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "materialism"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Greed, Possessions'
) < 1;

UPDATE questions
SET option1 = 'Wobble, Stagger',
    option2 = 'Balance, Steady',
    option3 = 'Advance, Give',
    option4 = 'Keep, Preserve'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "totter"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Wobble, Stagger';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "totter"?', 'synonym', 'Wobble, Stagger', 'Wobble, Stagger', 'Balance, Steady', 'Advance, Give', 'Keep, Preserve', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "totter"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Wobble, Stagger'
) < 1;

UPDATE questions
SET option1 = 'Slightly, Barely',
    option2 = 'Vague, Messy',
    option3 = 'Likely, Probably',
    option4 = 'Doubtfully, Unlikely'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "presumably"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Likely, Probably';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "presumably"?', 'synonym', 'Likely, Probably', 'Slightly, Barely', 'Vague, Messy', 'Likely, Probably', 'Doubtfully, Unlikely', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "presumably"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Likely, Probably'
) < 1;

UPDATE questions
SET option1 = 'Greatly, Much',
    option2 = 'Doubtfully, Unlikely',
    option3 = 'Enhance, Match',
    option4 = 'Slightly, Barely'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "considerably"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Greatly, Much';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "considerably"?', 'synonym', 'Greatly, Much', 'Greatly, Much', 'Doubtfully, Unlikely', 'Enhance, Match', 'Slightly, Barely', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "considerably"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Greatly, Much'
) < 1;

UPDATE questions
SET option1 = 'Shrine, Table',
    option2 = 'Keep, Preserve',
    option3 = 'Change, Modify',
    option4 = '—'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "alter"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Change, Modify';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "alter"?', 'synonym', 'Change, Modify', 'Shrine, Table', 'Keep, Preserve', 'Change, Modify', '—', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "alter"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Change, Modify'
) < 1;

UPDATE questions
SET option1 = 'Keep, Preserve',
    option2 = 'Change, Modify',
    option3 = 'Shrine, Table',
    option4 = '—'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "altar"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Shrine, Table';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "altar"?', 'synonym', 'Shrine, Table', 'Keep, Preserve', 'Change, Modify', 'Shrine, Table', '—', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "altar"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Shrine, Table'
) < 1;

UPDATE questions
SET option1 = 'Clear, Fluent',
    option2 = 'Tongue-tied, Mumbled',
    option3 = 'Slowly, Later',
    option4 = 'Physical, Solid'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "inarticulate"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Tongue-tied, Mumbled';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "inarticulate"?', 'synonym', 'Tongue-tied, Mumbled', 'Clear, Fluent', 'Tongue-tied, Mumbled', 'Slowly, Later', 'Physical, Solid', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "inarticulate"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Tongue-tied, Mumbled'
) < 1;

UPDATE questions
SET option1 = 'Normality, Usual',
    option2 = 'Oddity, Exception',
    option3 = 'Release, Free',
    option4 = 'Change, Modify'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "aberration"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Oddity, Exception';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "aberration"?', 'synonym', 'Oddity, Exception', 'Normality, Usual', 'Oddity, Exception', 'Release, Free', 'Change, Modify', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "aberration"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Oddity, Exception'
) < 1;

UPDATE questions
SET option1 = 'Uniqueness, Specialness',
    option2 = 'Care, Skill',
    option3 = 'Plainness, Normality',
    option4 = 'Normality, Usual'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "ordinariness"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Plainness, Normality';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "ordinariness"?', 'synonym', 'Plainness, Normality', 'Uniqueness, Specialness', 'Care, Skill', 'Plainness, Normality', 'Normality, Usual', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "ordinariness"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Plainness, Normality'
) < 1;

UPDATE questions
SET option1 = 'Brave, Calm',
    option2 = 'Lazy, Unmotivated',
    option3 = 'Determined, Eager',
    option4 = 'Release, Free'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "ambitious"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Determined, Eager';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "ambitious"?', 'synonym', 'Determined, Eager', 'Brave, Calm', 'Lazy, Unmotivated', 'Determined, Eager', 'Release, Free', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "ambitious"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Determined, Eager'
) < 1;

UPDATE questions
SET option1 = 'Release, Free',
    option2 = 'Sudden, Sharp',
    option3 = 'Gradual, Gentle',
    option4 = 'Kidnap, Seize'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "abduct"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Kidnap, Seize';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "abduct"?', 'synonym', 'Kidnap, Seize', 'Release, Free', 'Sudden, Sharp', 'Gradual, Gentle', 'Kidnap, Seize', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "abduct"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Kidnap, Seize'
) < 2;

UPDATE questions
SET option1 = 'Vague, Messy',
    option2 = 'Care, Skill',
    option3 = 'Smooth, Polite',
    option4 = 'Misconduct, Negligence'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "malpractice"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Misconduct, Negligence';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "malpractice"?', 'synonym', 'Misconduct, Negligence', 'Vague, Messy', 'Care, Skill', 'Smooth, Polite', 'Misconduct, Negligence', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "malpractice"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Misconduct, Negligence'
) < 1;

UPDATE questions
SET option1 = 'Bravery, Calm',
    option2 = 'Calm, Relaxed',
    option3 = 'Brave, Calm',
    option4 = 'Fear, Dread'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "phobia"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Fear, Dread';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "phobia"?', 'synonym', 'Fear, Dread', 'Bravery, Calm', 'Calm, Relaxed', 'Brave, Calm', 'Fear, Dread', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "phobia"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Fear, Dread'
) < 1;

UPDATE questions
SET option1 = 'Refuse, Reject',
    option2 = 'Delayed, Slow',
    option3 = 'Plead, Beg',
    option4 = 'Refuse, Demand'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "implore"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Plead, Beg';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "implore"?', 'synonym', 'Plead, Beg', 'Refuse, Reject', 'Delayed, Slow', 'Plead, Beg', 'Refuse, Demand', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "implore"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Plead, Beg'
) < 1;

UPDATE questions
SET option1 = 'Brave, Calm',
    option2 = 'Calm, Relaxed',
    option3 = 'Bravery, Calm',
    option4 = 'Frightened, Petrified'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "terrified"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Frightened, Petrified';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "terrified"?', 'synonym', 'Frightened, Petrified', 'Brave, Calm', 'Calm, Relaxed', 'Bravery, Calm', 'Frightened, Petrified', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "terrified"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Frightened, Petrified'
) < 1;

UPDATE questions
SET option1 = 'Worried, Shocked',
    option2 = 'Bravery, Calm',
    option3 = 'Calm, Relaxed',
    option4 = 'Brave, Calm'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "alarmed"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Worried, Shocked';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "alarmed"?', 'synonym', 'Worried, Shocked', 'Worried, Shocked', 'Bravery, Calm', 'Calm, Relaxed', 'Brave, Calm', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "alarmed"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Worried, Shocked'
) < 1;

UPDATE questions
SET option1 = 'Refuse, Demand',
    option2 = 'Accurate, Exact',
    option3 = 'Vague, Messy',
    option4 = 'Truth, Facts'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "precise"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Accurate, Exact';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "precise"?', 'synonym', 'Accurate, Exact', 'Refuse, Demand', 'Accurate, Exact', 'Vague, Messy', 'Truth, Facts', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "precise"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Accurate, Exact'
) < 1;

UPDATE questions
SET option1 = 'Kidnap, Seize',
    option2 = 'Release, Free',
    option3 = 'Gradual, Gentle',
    option4 = 'Sudden, Sharp'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "abrupt"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Sudden, Sharp';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "abrupt"?', 'synonym', 'Sudden, Sharp', 'Kidnap, Seize', 'Release, Free', 'Gradual, Gentle', 'Sudden, Sharp', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "abrupt"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Sudden, Sharp'
) < 1;

UPDATE questions
SET option1 = 'Unfashionable, Old',
    option2 = 'Trendy, Stylish',
    option3 = 'Surprise, Hide',
    option4 = 'Brave, Calm'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "fashionable"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Trendy, Stylish';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "fashionable"?', 'synonym', 'Trendy, Stylish', 'Unfashionable, Old', 'Trendy, Stylish', 'Surprise, Hide', 'Brave, Calm', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "fashionable"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Trendy, Stylish'
) < 1;

UPDATE questions
SET option1 = 'Rough, Harsh',
    option2 = 'Rude, Impolite',
    option3 = 'Polite, Respectful',
    option4 = 'Smooth, Polite'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "coarse"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Rough, Harsh';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "coarse"?', 'synonym', 'Rough, Harsh', 'Rough, Harsh', 'Rude, Impolite', 'Polite, Respectful', 'Smooth, Polite', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "coarse"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Rough, Harsh'
) < 1;

UPDATE questions
SET option1 = 'Rude, Impolite',
    option2 = 'Polite, Respectful',
    option3 = 'Rough, Harsh',
    option4 = 'Smooth, Polite'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "courteous"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Polite, Respectful';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "courteous"?', 'synonym', 'Polite, Respectful', 'Rude, Impolite', 'Polite, Respectful', 'Rough, Harsh', 'Smooth, Polite', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "courteous"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Polite, Respectful'
) < 1;

UPDATE questions
SET option1 = 'Persuasion, Influence',
    option2 = 'Truth, Facts',
    option3 = 'Vague, Messy',
    option4 = 'Accurate, Exact'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "propaganda"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Persuasion, Influence';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "propaganda"?', 'synonym', 'Persuasion, Influence', 'Persuasion, Influence', 'Truth, Facts', 'Vague, Messy', 'Accurate, Exact', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "propaganda"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Persuasion, Influence'
) < 1;

UPDATE questions
SET option1 = 'Predict, Anticipate',
    option2 = 'Hint, Suggest',
    option3 = 'Surprise, Hide',
    option4 = 'Miss, Ignore'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "foresee"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Predict, Anticipate';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "foresee"?', 'synonym', 'Predict, Anticipate', 'Predict, Anticipate', 'Hint, Suggest', 'Surprise, Hide', 'Miss, Ignore', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "foresee"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Predict, Anticipate'
) < 1;

UPDATE questions
SET option1 = 'Hint, Suggest',
    option2 = 'Surprise, Unknown',
    option3 = 'Miss, Ignore',
    option4 = 'Surprise, Hide'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "foreshadow"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Hint, Suggest';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "foreshadow"?', 'synonym', 'Hint, Suggest', 'Hint, Suggest', 'Surprise, Unknown', 'Miss, Ignore', 'Surprise, Hide', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "foreshadow"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Hint, Suggest'
) < 1;

UPDATE questions
SET option1 = 'Advance, Give',
    option2 = 'Advancing, Staying',
    option3 = 'Remove, Retreat',
    option4 = 'Retreating, Leaving'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "withdrawing"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Retreating, Leaving';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "withdrawing"?', 'synonym', 'Retreating, Leaving', 'Advance, Give', 'Advancing, Staying', 'Remove, Retreat', 'Retreating, Leaving', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "withdrawing"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Retreating, Leaving'
) < 1;

DROP TABLE seed_quiz_id;

-- Year 5 Vocabulary 8 Pages Synonym Paper 3
INSERT INTO quizzes (title, description, created_by, stage_id, lock_after_attempt)
SELECT 'Year 5 Vocabulary 8 Pages Synonym Paper 3',
       'A 7-question Year 5 vocabulary exam from the 8-page workbook asking students to identify synonym pairs.',
       1,
       (SELECT id FROM stages WHERE name = 'Year 5'),
       1
WHERE NOT EXISTS (SELECT 1 FROM quizzes WHERE title = 'Year 5 Vocabulary 8 Pages Synonym Paper 3');

DROP TABLE IF EXISTS seed_quiz_id;
CREATE TEMP TABLE seed_quiz_id(id INTEGER);
INSERT INTO seed_quiz_id SELECT id FROM quizzes WHERE title = 'Year 5 Vocabulary 8 Pages Synonym Paper 3' LIMIT 1;

UPDATE questions
SET option1 = 'Refuse, Demand',
    option2 = 'Worthless, Useless',
    option3 = 'Delayed, Slow',
    option4 = 'Instant, Quick'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "immediate"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Instant, Quick';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "immediate"?', 'synonym', 'Instant, Quick', 'Refuse, Demand', 'Worthless, Useless', 'Delayed, Slow', 'Instant, Quick', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "immediate"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Instant, Quick'
) < 1;

UPDATE questions
SET option1 = 'Rude, Impolite',
    option2 = 'Belief, Certainty',
    option3 = 'Smooth, Polite',
    option4 = 'Doubt, Uncertainty'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "conviction"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Belief, Certainty';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "conviction"?', 'synonym', 'Belief, Certainty', 'Rude, Impolite', 'Belief, Certainty', 'Smooth, Polite', 'Doubt, Uncertainty', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "conviction"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Belief, Certainty'
) < 1;

UPDATE questions
SET option1 = 'Avoid, Master',
    option2 = 'Worthless, Useless',
    option3 = 'Delayed, Slow',
    option4 = 'Try, Experiment'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "dabble"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Try, Experiment';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "dabble"?', 'synonym', 'Try, Experiment', 'Avoid, Master', 'Worthless, Useless', 'Delayed, Slow', 'Try, Experiment', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "dabble"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Try, Experiment'
) < 1;

UPDATE questions
SET option1 = 'Delayed, Slow',
    option2 = 'Worthless, Useless',
    option3 = 'Priceless, Essential',
    option4 = 'Release, Let go'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "invaluable"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Priceless, Essential';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "invaluable"?', 'synonym', 'Priceless, Essential', 'Delayed, Slow', 'Worthless, Useless', 'Priceless, Essential', 'Release, Let go', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "invaluable"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Priceless, Essential'
) < 1;

UPDATE questions
SET option1 = 'Brave, Calm',
    option2 = 'Lot, Plenty',
    option3 = 'Bit, Little',
    option4 = 'Release, Let go'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "trifle"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Bit, Little';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "trifle"?', 'synonym', 'Bit, Little', 'Brave, Calm', 'Lot, Plenty', 'Bit, Little', 'Release, Let go', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "trifle"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Bit, Little'
) < 1;

UPDATE questions
SET option1 = 'Release, Let go',
    option2 = 'Worthless, Useless',
    option3 = 'Grip, Grasp',
    option4 = 'Lot, Plenty'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "clutches"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Grip, Grasp';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "clutches"?', 'synonym', 'Grip, Grasp', 'Release, Let go', 'Worthless, Useless', 'Grip, Grasp', 'Lot, Plenty', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "clutches"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Grip, Grasp'
) < 1;

UPDATE questions
SET option1 = 'Joy, Brightness',
    option2 = 'Worthless, Useless',
    option3 = 'Release, Let go',
    option4 = 'Sadness, Darkness'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are synonyms of "gloom"?'
  AND question_type = 'synonym'
  AND correct_answer = 'Sadness, Darkness';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are synonyms of "gloom"?', 'synonym', 'Sadness, Darkness', 'Joy, Brightness', 'Worthless, Useless', 'Release, Let go', 'Sadness, Darkness', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are synonyms of "gloom"?'
      AND question_type = 'synonym'
      AND correct_answer = 'Sadness, Darkness'
) < 1;

DROP TABLE seed_quiz_id;

-- Year 5 Vocabulary 8 Pages Antonym Paper 1
INSERT INTO quizzes (title, description, created_by, stage_id, lock_after_attempt)
SELECT 'Year 5 Vocabulary 8 Pages Antonym Paper 1',
       'A 100-question Year 5 vocabulary exam from the 8-page workbook asking students to identify antonym pairs.',
       1,
       (SELECT id FROM stages WHERE name = 'Year 5'),
       1
WHERE NOT EXISTS (SELECT 1 FROM quizzes WHERE title = 'Year 5 Vocabulary 8 Pages Antonym Paper 1');

DROP TABLE IF EXISTS seed_quiz_id;
CREATE TEMP TABLE seed_quiz_id(id INTEGER);
INSERT INTO seed_quiz_id SELECT id FROM quizzes WHERE title = 'Year 5 Vocabulary 8 Pages Antonym Paper 1' LIMIT 1;

UPDATE questions
SET option1 = 'Opponent, Rival',
    option2 = 'Friend, Ally',
    option3 = 'Try-out, Performance',
    option4 = 'Boldness, Nerve'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "adversary"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Friend, Ally';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "adversary"?', 'antonym', 'Friend, Ally', 'Opponent, Rival', 'Friend, Ally', 'Try-out, Performance', 'Boldness, Nerve', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "adversary"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Friend, Ally'
) < 1;

UPDATE questions
SET option1 = 'Boldness, Nerve',
    option2 = 'Try-out, Performance',
    option3 = 'Timidity, Fear',
    option4 = 'Rejection, Ignore'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "audition"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Rejection, Ignore';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "audition"?', 'antonym', 'Rejection, Ignore', 'Boldness, Nerve', 'Try-out, Performance', 'Timidity, Fear', 'Rejection, Ignore', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "audition"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Rejection, Ignore'
) < 1;

UPDATE questions
SET option1 = 'Caretaker, Keeper',
    option2 = 'Enemy, Stranger',
    option3 = 'Stranger, Intruder',
    option4 = 'Stranger, Visitor'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "custodian"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Stranger, Intruder';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "custodian"?', 'antonym', 'Stranger, Intruder', 'Caretaker, Keeper', 'Enemy, Stranger', 'Stranger, Intruder', 'Stranger, Visitor', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "custodian"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Stranger, Intruder'
) < 1;

UPDATE questions
SET option1 = 'Agreement, Match',
    option2 = 'Unhappiness, Dissatisfaction',
    option3 = 'Happiness, Contentment',
    option4 = 'Difference, Mismatch'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "discrepancy"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Agreement, Match';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "discrepancy"?', 'antonym', 'Agreement, Match', 'Agreement, Match', 'Unhappiness, Dissatisfaction', 'Happiness, Contentment', 'Difference, Mismatch', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "discrepancy"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Agreement, Match'
) < 1;

UPDATE questions
SET option1 = 'Enemy, Stranger',
    option2 = 'Friend, Ally',
    option3 = 'Respect, Admiration',
    option4 = 'Scorn, Disdain'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "contempt"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Respect, Admiration';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "contempt"?', 'antonym', 'Respect, Admiration', 'Enemy, Stranger', 'Friend, Ally', 'Respect, Admiration', 'Scorn, Disdain', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "contempt"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Respect, Admiration'
) < 1;

UPDATE questions
SET option1 = 'Timidity, Fear',
    option2 = 'Rejection, Ignore',
    option3 = 'Try-out, Performance',
    option4 = 'Boldness, Nerve'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "audacity"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Timidity, Fear';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "audacity"?', 'antonym', 'Timidity, Fear', 'Timidity, Fear', 'Rejection, Ignore', 'Try-out, Performance', 'Boldness, Nerve', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "audacity"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Timidity, Fear'
) < 1;

UPDATE questions
SET option1 = 'Enemy, Stranger',
    option2 = 'Stranger, Intruder',
    option3 = 'Scorn, Disdain',
    option4 = 'Friend, Ally'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "comrade"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Enemy, Stranger';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "comrade"?', 'antonym', 'Enemy, Stranger', 'Enemy, Stranger', 'Stranger, Intruder', 'Scorn, Disdain', 'Friend, Ally', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "comrade"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Enemy, Stranger'
) < 1;

UPDATE questions
SET option1 = 'Agreement, Match',
    option2 = 'Whole, Intact',
    option3 = 'Unhappiness, Dissatisfaction',
    option4 = 'Rubble, Fragments'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "debris"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Whole, Intact';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "debris"?', 'antonym', 'Whole, Intact', 'Agreement, Match', 'Whole, Intact', 'Unhappiness, Dissatisfaction', 'Rubble, Fragments', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "debris"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Whole, Intact'
) < 1;

UPDATE questions
SET option1 = 'Happiness, Contentment',
    option2 = 'Interruption, Disturbance',
    option3 = 'Unhappiness, Dissatisfaction',
    option4 = 'Difference, Mismatch'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "discontent"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Happiness, Contentment';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "discontent"?', 'antonym', 'Happiness, Contentment', 'Happiness, Contentment', 'Interruption, Disturbance', 'Unhappiness, Dissatisfaction', 'Difference, Mismatch', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "discontent"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Happiness, Contentment'
) < 1;

UPDATE questions
SET option1 = 'Excitement, Enthusiasm',
    option2 = 'Unhappiness, Dissatisfaction',
    option3 = 'Boldness, Nerve',
    option4 = 'Boredom, Laziness'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "eagerness"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Boredom, Laziness';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "eagerness"?', 'antonym', 'Boredom, Laziness', 'Excitement, Enthusiasm', 'Unhappiness, Dissatisfaction', 'Boldness, Nerve', 'Boredom, Laziness', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "eagerness"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Boredom, Laziness'
) < 1;

UPDATE questions
SET option1 = 'Boldness, Nerve',
    option2 = 'Liking, Bond',
    option3 = 'Variety, Mixture',
    option4 = 'Single, Uniform'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "assortment"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Single, Uniform';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "assortment"?', 'antonym', 'Single, Uniform', 'Boldness, Nerve', 'Liking, Bond', 'Variety, Mixture', 'Single, Uniform', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "assortment"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Single, Uniform'
) < 1;

UPDATE questions
SET option1 = 'Dislike, Hatred',
    option2 = 'Liking, Bond',
    option3 = 'Accusation, Claim',
    option4 = 'Variety, Mixture'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "affinity"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Dislike, Hatred';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "affinity"?', 'antonym', 'Dislike, Hatred', 'Dislike, Hatred', 'Liking, Bond', 'Accusation, Claim', 'Variety, Mixture', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "affinity"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Dislike, Hatred'
) < 1;

UPDATE questions
SET option1 = 'Team, Panel',
    option2 = 'Praise, Flattery',
    option3 = 'Insult, Criticism',
    option4 = 'Part, Piece'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "compliment"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Insult, Criticism';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "compliment"?', 'antonym', 'Insult, Criticism', 'Team, Panel', 'Praise, Flattery', 'Insult, Criticism', 'Part, Piece', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "compliment"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Insult, Criticism'
) < 1;

UPDATE questions
SET option1 = 'Individual, Lone',
    option2 = 'Praise, Flattery',
    option3 = 'Team, Panel',
    option4 = 'Insult, Criticism'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "committee"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Individual, Lone';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "committee"?', 'antonym', 'Individual, Lone', 'Individual, Lone', 'Praise, Flattery', 'Team, Panel', 'Insult, Criticism', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "committee"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Individual, Lone'
) < 1;

UPDATE questions
SET option1 = 'Unhappiness, Dissatisfaction',
    option2 = 'Focus, Attention',
    option3 = 'Interruption, Disturbance',
    option4 = 'Difference, Mismatch'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "distraction"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Focus, Attention';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "distraction"?', 'antonym', 'Focus, Attention', 'Unhappiness, Dissatisfaction', 'Focus, Attention', 'Interruption, Disturbance', 'Difference, Mismatch', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "distraction"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Focus, Attention'
) < 1;

UPDATE questions
SET option1 = 'Likely, Suitable',
    option2 = 'Proof, Fact',
    option3 = 'Unlikely, Unsuitable',
    option4 = 'Accusation, Claim'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "allegation"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Proof, Fact';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "allegation"?', 'antonym', 'Proof, Fact', 'Likely, Suitable', 'Proof, Fact', 'Unlikely, Unsuitable', 'Accusation, Claim', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "allegation"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Proof, Fact'
) < 1;

UPDATE questions
SET option1 = 'Disaster, Tragedy',
    option2 = 'Stranger, Intruder',
    option3 = 'Stranger, Visitor',
    option4 = 'Resident, Inhabitant'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "citizen"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Stranger, Visitor';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "citizen"?', 'antonym', 'Stranger, Visitor', 'Disaster, Tragedy', 'Stranger, Intruder', 'Stranger, Visitor', 'Resident, Inhabitant', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "citizen"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Stranger, Visitor'
) < 1;

UPDATE questions
SET option1 = 'Miracle, Blessing',
    option2 = 'Stranger, Visitor',
    option3 = 'Disaster, Tragedy',
    option4 = 'Praise, Flattery'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "catastrophe"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Miracle, Blessing';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "catastrophe"?', 'antonym', 'Miracle, Blessing', 'Miracle, Blessing', 'Stranger, Visitor', 'Disaster, Tragedy', 'Praise, Flattery', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "catastrophe"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Miracle, Blessing'
) < 1;

UPDATE questions
SET option1 = 'Likely, Suitable',
    option2 = 'Attempt, Effort',
    option3 = 'Team, Panel',
    option4 = 'Neglect, Quit'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "endeavour"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Neglect, Quit';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "endeavour"?', 'antonym', 'Neglect, Quit', 'Likely, Suitable', 'Attempt, Effort', 'Team, Panel', 'Neglect, Quit', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "endeavour"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Neglect, Quit'
) < 1;

UPDATE questions
SET option1 = 'Unlikely, Unsuitable',
    option2 = 'Talent, Skill',
    option3 = 'Likely, Suitable',
    option4 = 'Weakness, Inability'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "apt"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Unlikely, Unsuitable';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "apt"?', 'antonym', 'Unlikely, Unsuitable', 'Unlikely, Unsuitable', 'Talent, Skill', 'Likely, Suitable', 'Weakness, Inability', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "apt"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Unlikely, Unsuitable'
) < 1;

UPDATE questions
SET option1 = 'Ruin, Chaos',
    option2 = 'Design, Structure',
    option3 = 'Talent, Skill',
    option4 = 'Accusation, Claim'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "architecture"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Ruin, Chaos';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "architecture"?', 'antonym', 'Ruin, Chaos', 'Ruin, Chaos', 'Design, Structure', 'Talent, Skill', 'Accusation, Claim', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "architecture"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Ruin, Chaos'
) < 1;

UPDATE questions
SET option1 = 'Talent, Skill',
    option2 = 'Unlikely, Unsuitable',
    option3 = 'Weakness, Inability',
    option4 = 'Likely, Suitable'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "aptitude"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Weakness, Inability';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "aptitude"?', 'antonym', 'Weakness, Inability', 'Talent, Skill', 'Unlikely, Unsuitable', 'Weakness, Inability', 'Likely, Suitable', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "aptitude"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Weakness, Inability'
) < 1;

UPDATE questions
SET option1 = 'Whole, Entirety',
    option2 = 'Insult, Criticism',
    option3 = 'Part, Piece',
    option4 = 'Praise, Flattery'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "component"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Whole, Entirety';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "component"?', 'antonym', 'Whole, Entirety', 'Whole, Entirety', 'Insult, Criticism', 'Part, Piece', 'Praise, Flattery', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "component"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Whole, Entirety'
) < 1;

UPDATE questions
SET option1 = 'Inquisitiveness, Wonder',
    option2 = 'Indifference, Boredom',
    option3 = 'Awkward, Bulky',
    option4 = 'Grow, Nurture'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "curiosity"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Indifference, Boredom';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "curiosity"?', 'antonym', 'Indifference, Boredom', 'Inquisitiveness, Wonder', 'Indifference, Boredom', 'Awkward, Bulky', 'Grow, Nurture', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "curiosity"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Indifference, Boredom'
) < 1;

UPDATE questions
SET option1 = 'Conclude, Reason',
    option2 = 'Hard work, Effort',
    option3 = 'Guess, Ignore',
    option4 = 'Poor, Needy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "deduce"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Guess, Ignore';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "deduce"?', 'antonym', 'Guess, Ignore', 'Conclude, Reason', 'Hard work, Effort', 'Guess, Ignore', 'Poor, Needy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "deduce"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Guess, Ignore'
) < 1;

UPDATE questions
SET option1 = 'Laziness, Carelessness',
    option2 = 'Hard work, Effort',
    option3 = 'Conclude, Reason',
    option4 = 'Inquisitiveness, Wonder'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "diligence"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Laziness, Carelessness';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "diligence"?', 'antonym', 'Laziness, Carelessness', 'Laziness, Carelessness', 'Hard work, Effort', 'Conclude, Reason', 'Inquisitiveness, Wonder', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "diligence"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Laziness, Carelessness'
) < 1;

UPDATE questions
SET option1 = 'Abandoned, Empty',
    option2 = 'Empty, Desolate',
    option3 = 'Fertile, Lush',
    option4 = 'Beautiful, Lovely'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "barren"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Fertile, Lush';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "barren"?', 'antonym', 'Fertile, Lush', 'Abandoned, Empty', 'Empty, Desolate', 'Fertile, Lush', 'Beautiful, Lovely', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "barren"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Fertile, Lush'
) < 1;

UPDATE questions
SET option1 = 'Nonexistence, Nothing',
    option2 = 'Ugly, Plain',
    option3 = 'Life, Being',
    option4 = 'Beautiful, Lovely'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "exquisite"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Ugly, Plain';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "exquisite"?', 'antonym', 'Ugly, Plain', 'Nonexistence, Nothing', 'Ugly, Plain', 'Life, Being', 'Beautiful, Lovely', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "exquisite"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Ugly, Plain'
) < 1;

UPDATE questions
SET option1 = 'Thrifty, Saver',
    option2 = 'Beautiful, Lovely',
    option3 = 'Wasteful, Spendthrift',
    option4 = 'Inquisitiveness, Wonder'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "frugal"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Wasteful, Spendthrift';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "frugal"?', 'antonym', 'Wasteful, Spendthrift', 'Thrifty, Saver', 'Beautiful, Lovely', 'Wasteful, Spendthrift', 'Inquisitiveness, Wonder', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "frugal"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Wasteful, Spendthrift'
) < 1;

UPDATE questions
SET option1 = 'Worried, Nervous',
    option2 = 'Unattractive, Repellent',
    option3 = 'Attractive, Charming',
    option4 = 'Accusation, Claim'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "alluring"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Unattractive, Repellent';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "alluring"?', 'antonym', 'Unattractive, Repellent', 'Worried, Nervous', 'Unattractive, Repellent', 'Attractive, Charming', 'Accusation, Claim', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "alluring"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Unattractive, Repellent'
) < 1;

UPDATE questions
SET option1 = 'Calm, Soothe',
    option2 = 'Attractive, Charming',
    option3 = 'Worried, Nervous',
    option4 = 'Confident, Calm'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "apprehensive"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Confident, Calm';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "apprehensive"?', 'antonym', 'Confident, Calm', 'Calm, Soothe', 'Attractive, Charming', 'Worried, Nervous', 'Confident, Calm', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "apprehensive"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Confident, Calm'
) < 1;

UPDATE questions
SET option1 = 'Awkward, Bulky',
    option2 = 'Neglect, Destroy',
    option3 = 'Grow, Nurture',
    option4 = 'Light, Easy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "cumbersome"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Light, Easy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "cumbersome"?', 'antonym', 'Light, Easy', 'Awkward, Bulky', 'Neglect, Destroy', 'Grow, Nurture', 'Light, Easy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "cumbersome"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Light, Easy'
) < 1;

UPDATE questions
SET option1 = 'Blunt, Curt',
    option2 = 'Ugly, Plain',
    option3 = 'Complain, Lament',
    option4 = 'Celebrate, Praise'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "bemoan"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Celebrate, Praise';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "bemoan"?', 'antonym', 'Celebrate, Praise', 'Blunt, Curt', 'Ugly, Plain', 'Complain, Lament', 'Celebrate, Praise', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "bemoan"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Celebrate, Praise'
) < 1;

UPDATE questions
SET option1 = 'Grow, Nurture',
    option2 = 'Light, Easy',
    option3 = 'Neglect, Destroy',
    option4 = 'Awkward, Bulky'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "cultivate"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Neglect, Destroy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "cultivate"?', 'antonym', 'Neglect, Destroy', 'Grow, Nurture', 'Light, Easy', 'Neglect, Destroy', 'Awkward, Bulky', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "cultivate"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Neglect, Destroy'
) < 1;

UPDATE questions
SET option1 = 'Confuse, Misunderstand',
    option2 = 'Upcoming, Approaching',
    option3 = 'Understand, Grasp',
    option4 = 'Past, Delayed'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "fathom"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Confuse, Misunderstand';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "fathom"?', 'antonym', 'Confuse, Misunderstand', 'Confuse, Misunderstand', 'Upcoming, Approaching', 'Understand, Grasp', 'Past, Delayed', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "fathom"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Confuse, Misunderstand'
) < 1;

UPDATE questions
SET option1 = 'Life, Being',
    option2 = 'Nonexistence, Nothing',
    option3 = 'Beautiful, Lovely',
    option4 = 'Ugly, Plain'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "existence"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Nonexistence, Nothing';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "existence"?', 'antonym', 'Nonexistence, Nothing', 'Life, Being', 'Nonexistence, Nothing', 'Beautiful, Lovely', 'Ugly, Plain', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "existence"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Nonexistence, Nothing'
) < 1;

UPDATE questions
SET option1 = 'Polite, Friendly',
    option2 = 'Complain, Lament',
    option3 = 'Life, Being',
    option4 = 'Blunt, Curt'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "brusque"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Polite, Friendly';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "brusque"?', 'antonym', 'Polite, Friendly', 'Polite, Friendly', 'Complain, Lament', 'Life, Being', 'Blunt, Curt', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "brusque"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Polite, Friendly'
) < 1;

UPDATE questions
SET option1 = 'Wonderful, Lucky',
    option2 = 'Used, Active',
    option3 = 'Catastrophic, Terrible',
    option4 = 'Abandoned, Empty'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "disastrous"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Wonderful, Lucky';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "disastrous"?', 'antonym', 'Wonderful, Lucky', 'Wonderful, Lucky', 'Used, Active', 'Catastrophic, Terrible', 'Abandoned, Empty', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "disastrous"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Wonderful, Lucky'
) < 1;

UPDATE questions
SET option1 = 'Upcoming, Approaching',
    option2 = 'Alien, Exotic',
    option3 = 'Past, Delayed',
    option4 = 'Lucky, Serendipitous'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "forthcoming"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Past, Delayed';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "forthcoming"?', 'antonym', 'Past, Delayed', 'Upcoming, Approaching', 'Alien, Exotic', 'Past, Delayed', 'Lucky, Serendipitous', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "forthcoming"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Past, Delayed'
) < 1;

UPDATE questions
SET option1 = 'Upcoming, Approaching',
    option2 = 'Local, Native',
    option3 = 'Alien, Exotic',
    option4 = 'Lucky, Serendipitous'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "foreign"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Local, Native';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "foreign"?', 'antonym', 'Local, Native', 'Upcoming, Approaching', 'Local, Native', 'Alien, Exotic', 'Lucky, Serendipitous', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "foreign"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Local, Native'
) < 1;

UPDATE questions
SET option1 = 'Poor, Needy',
    option2 = 'Love, Admire',
    option3 = 'Rich, Wealthy',
    option4 = 'Hate, Loathe'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "destitute"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Rich, Wealthy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "destitute"?', 'antonym', 'Rich, Wealthy', 'Poor, Needy', 'Love, Admire', 'Rich, Wealthy', 'Hate, Loathe', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "destitute"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Rich, Wealthy'
) < 1;

UPDATE questions
SET option1 = 'Abandoned, Empty',
    option2 = 'Wonderful, Lucky',
    option3 = 'Used, Active',
    option4 = 'Catastrophic, Terrible'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "disused"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Used, Active';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "disused"?', 'antonym', 'Used, Active', 'Abandoned, Empty', 'Wonderful, Lucky', 'Used, Active', 'Catastrophic, Terrible', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "disused"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Used, Active'
) < 1;

UPDATE questions
SET option1 = 'Unlucky, Unfortunate',
    option2 = 'Alien, Exotic',
    option3 = 'Upcoming, Approaching',
    option4 = 'Lucky, Serendipitous'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "fortuitous"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Unlucky, Unfortunate';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "fortuitous"?', 'antonym', 'Unlucky, Unfortunate', 'Unlucky, Unfortunate', 'Alien, Exotic', 'Upcoming, Approaching', 'Lucky, Serendipitous', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "fortuitous"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Unlucky, Unfortunate'
) < 1;

UPDATE questions
SET option1 = 'Joking, Playful',
    option2 = 'Serious, Respectful',
    option3 = 'Lucky, Serendipitous',
    option4 = 'Upcoming, Approaching'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "flippant"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Serious, Respectful';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "flippant"?', 'antonym', 'Serious, Respectful', 'Joking, Playful', 'Serious, Respectful', 'Lucky, Serendipitous', 'Upcoming, Approaching', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "flippant"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Serious, Respectful'
) < 1;

UPDATE questions
SET option1 = 'Ignore, Avoid',
    option2 = 'Abandoned, Empty',
    option3 = 'Crash, Smash',
    option4 = 'Avoid, Miss'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "collide"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Avoid, Miss';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "collide"?', 'antonym', 'Avoid, Miss', 'Ignore, Avoid', 'Abandoned, Empty', 'Crash, Smash', 'Avoid, Miss', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "collide"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Avoid, Miss'
) < 1;

UPDATE questions
SET option1 = 'Rich, Wealthy',
    option2 = 'Poor, Needy',
    option3 = 'Love, Admire',
    option4 = 'Hate, Loathe'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "despise"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Love, Admire';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "despise"?', 'antonym', 'Love, Admire', 'Rich, Wealthy', 'Poor, Needy', 'Love, Admire', 'Hate, Loathe', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "despise"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Love, Admire'
) < 1;

UPDATE questions
SET option1 = 'Mumble, Incoherence',
    option2 = 'Articulation, Fluency',
    option3 = 'Escape, Evade',
    option4 = 'Catch, Capture'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "elude"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Catch, Capture';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "elude"?', 'antonym', 'Catch, Capture', 'Mumble, Incoherence', 'Articulation, Fluency', 'Escape, Evade', 'Catch, Capture', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "elude"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Catch, Capture'
) < 1;

UPDATE questions
SET option1 = 'Mumble, Incoherence',
    option2 = 'Articulation, Fluency',
    option3 = 'Catch, Capture',
    option4 = 'Escape, Evade'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "eloquence"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Mumble, Incoherence';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "eloquence"?', 'antonym', 'Mumble, Incoherence', 'Mumble, Incoherence', 'Articulation, Fluency', 'Catch, Capture', 'Escape, Evade', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "eloquence"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Mumble, Incoherence'
) < 1;

UPDATE questions
SET option1 = 'Joking, Playful',
    option2 = 'Pretend, Fake',
    option3 = 'Be honest, Show',
    option4 = 'Alien, Exotic'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "feign"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Be honest, Show';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "feign"?', 'antonym', 'Be honest, Show', 'Joking, Playful', 'Pretend, Fake', 'Be honest, Show', 'Alien, Exotic', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "feign"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Be honest, Show'
) < 1;

UPDATE questions
SET option1 = 'Happy, Cheerful',
    option2 = 'Happy, Overjoyed',
    option3 = 'Sad, Gloomy',
    option4 = 'Happy, Joyful'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "melancholy"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Happy, Cheerful';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "melancholy"?', 'antonym', 'Happy, Cheerful', 'Happy, Cheerful', 'Happy, Overjoyed', 'Sad, Gloomy', 'Happy, Joyful', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "melancholy"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Happy, Cheerful'
) < 1;

UPDATE questions
SET option1 = 'Happy, Cheerful',
    option2 = 'Sad, Gloomy',
    option3 = 'Gloomy, Dark',
    option4 = 'Bright, Cheerful'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "dismal"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Bright, Cheerful';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "dismal"?', 'antonym', 'Bright, Cheerful', 'Happy, Cheerful', 'Sad, Gloomy', 'Gloomy, Dark', 'Bright, Cheerful', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "dismal"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Bright, Cheerful'
) < 1;

UPDATE questions
SET option1 = 'Sad, Miserable',
    option2 = 'Sad, Unhappy',
    option3 = 'Happy, Overjoyed',
    option4 = 'Happy, Cheerful'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "joyful"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Sad, Unhappy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "joyful"?', 'antonym', 'Sad, Unhappy', 'Sad, Miserable', 'Sad, Unhappy', 'Happy, Overjoyed', 'Happy, Cheerful', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "joyful"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Sad, Unhappy'
) < 1;

UPDATE questions
SET option1 = 'Happy, Joyful',
    option2 = 'Gloomy, Dark',
    option3 = 'Sad, Gloomy',
    option4 = 'Happy, Cheerful'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "cheerful"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Sad, Gloomy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "cheerful"?', 'antonym', 'Sad, Gloomy', 'Happy, Joyful', 'Gloomy, Dark', 'Sad, Gloomy', 'Happy, Cheerful', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "cheerful"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Sad, Gloomy'
) < 1;

UPDATE questions
SET option1 = 'Happy, Overjoyed',
    option2 = 'Sad, Unhappy',
    option3 = 'Happy, Cheerful',
    option4 = 'Sad, Miserable'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "jubilant"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Sad, Miserable';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "jubilant"?', 'antonym', 'Sad, Miserable', 'Happy, Overjoyed', 'Sad, Unhappy', 'Happy, Cheerful', 'Sad, Miserable', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "jubilant"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Sad, Miserable'
) < 1;

UPDATE questions
SET option1 = 'Happy, Overjoyed',
    option2 = 'Disappointed, Unhappy',
    option3 = 'Happy, Joyful',
    option4 = 'Pleased, Happy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "gratified"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Disappointed, Unhappy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "gratified"?', 'antonym', 'Disappointed, Unhappy', 'Happy, Overjoyed', 'Disappointed, Unhappy', 'Happy, Joyful', 'Pleased, Happy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "gratified"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Disappointed, Unhappy'
) < 1;

UPDATE questions
SET option1 = 'Sad, Miserable',
    option2 = 'Happy, Overjoyed',
    option3 = 'Happy, Joyful',
    option4 = 'Pleased, Happy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "blissful"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Sad, Miserable';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "blissful"?', 'antonym', 'Sad, Miserable', 'Sad, Miserable', 'Happy, Overjoyed', 'Happy, Joyful', 'Pleased, Happy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "blissful"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Sad, Miserable'
) < 1;

UPDATE questions
SET option1 = 'Calm, Happy',
    option2 = 'Happy, Joyful',
    option3 = 'Angry, Furious',
    option4 = 'Pleased, Happy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "enraged"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Calm, Happy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "enraged"?', 'antonym', 'Calm, Happy', 'Calm, Happy', 'Happy, Joyful', 'Angry, Furious', 'Pleased, Happy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "enraged"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Calm, Happy'
) < 1;

UPDATE questions
SET option1 = 'Furious, Mad',
    option2 = 'Calm, Cool',
    option3 = 'Irritated, Angry',
    option4 = 'Calm, Happy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "infuriated"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Calm, Happy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "infuriated"?', 'antonym', 'Calm, Happy', 'Furious, Mad', 'Calm, Cool', 'Irritated, Angry', 'Calm, Happy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "infuriated"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Calm, Happy'
) < 1;

UPDATE questions
SET option1 = 'Calm, Happy',
    option2 = 'Pleased, Happy',
    option3 = 'Annoyed, Frustrated',
    option4 = 'Happy, Joyful'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "exasperated"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Calm, Happy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "exasperated"?', 'antonym', 'Calm, Happy', 'Calm, Happy', 'Pleased, Happy', 'Annoyed, Frustrated', 'Happy, Joyful', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "exasperated"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Calm, Happy'
) < 1;

UPDATE questions
SET option1 = 'Irritated, Angry',
    option2 = 'Calm, Cool',
    option3 = 'Calm, Happy',
    option4 = 'Furious, Mad'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "inflamed"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Calm, Cool';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "inflamed"?', 'antonym', 'Calm, Cool', 'Irritated, Angry', 'Calm, Cool', 'Calm, Happy', 'Furious, Mad', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "inflamed"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Calm, Cool'
) < 1;

UPDATE questions
SET option1 = 'Irritated, Angry',
    option2 = 'Please, Calm',
    option3 = 'Calm, Happy',
    option4 = 'Annoy, Irritate'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "nettle"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Please, Calm';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "nettle"?', 'antonym', 'Please, Calm', 'Irritated, Angry', 'Please, Calm', 'Calm, Happy', 'Annoy, Irritate', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "nettle"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Please, Calm'
) < 1;

UPDATE questions
SET option1 = 'Gawk, Stare',
    option2 = 'Ignore, Look away',
    option3 = 'Ignore, Overlook',
    option4 = 'Stare, Gawk'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "leer"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Ignore, Look away';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "leer"?', 'antonym', 'Ignore, Look away', 'Gawk, Stare', 'Ignore, Look away', 'Ignore, Overlook', 'Stare, Gawk', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "leer"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Ignore, Look away'
) < 1;

UPDATE questions
SET option1 = 'Peek, Glance',
    option2 = 'Stare, Gawk',
    option3 = 'Gawk, Stare',
    option4 = 'Stare, Gaze'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "glimpse"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Stare, Gaze';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "glimpse"?', 'antonym', 'Stare, Gaze', 'Peek, Glance', 'Stare, Gawk', 'Gawk, Stare', 'Stare, Gaze', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "glimpse"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Stare, Gaze'
) < 1;

UPDATE questions
SET option1 = 'Stare, Gaze',
    option2 = 'Stare, Gawk',
    option3 = 'Gawk, Stare',
    option4 = 'Ignore, Look away'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "ogle"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Ignore, Look away';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "ogle"?', 'antonym', 'Ignore, Look away', 'Stare, Gaze', 'Stare, Gawk', 'Gawk, Stare', 'Ignore, Look away', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "ogle"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Ignore, Look away'
) < 1;

UPDATE questions
SET option1 = 'Ignore, Miss',
    option2 = 'Examine, Inspect',
    option3 = 'Ignore, Look away',
    option4 = 'Ignore, Overlook'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "scrutinize"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Ignore, Overlook';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "scrutinize"?', 'antonym', 'Ignore, Overlook', 'Ignore, Miss', 'Examine, Inspect', 'Ignore, Look away', 'Ignore, Overlook', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "scrutinize"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Ignore, Overlook'
) < 1;

UPDATE questions
SET option1 = 'See, Observe',
    option2 = 'Ignore, Look away',
    option3 = 'Ignore, Overlook',
    option4 = 'Ignore, Miss'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "behold"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Ignore, Miss';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "behold"?', 'antonym', 'Ignore, Miss', 'See, Observe', 'Ignore, Look away', 'Ignore, Overlook', 'Ignore, Miss', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "behold"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Ignore, Miss'
) < 1;

UPDATE questions
SET option1 = 'Stunning, Gorgeous',
    option2 = 'Dull, Dark',
    option3 = 'Shiny, Radiant',
    option4 = 'Glowing, Shiny'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "resplendent"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Dull, Dark';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "resplendent"?', 'antonym', 'Dull, Dark', 'Stunning, Gorgeous', 'Dull, Dark', 'Shiny, Radiant', 'Glowing, Shiny', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "resplendent"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Dull, Dark'
) < 1;

UPDATE questions
SET option1 = 'Poor, Ugly',
    option2 = 'Splendid, Amazing',
    option3 = 'Ugly, Plain',
    option4 = 'Shiny, Radiant'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "magnificent"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Poor, Ugly';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "magnificent"?', 'antonym', 'Poor, Ugly', 'Poor, Ugly', 'Splendid, Amazing', 'Ugly, Plain', 'Shiny, Radiant', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "magnificent"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Poor, Ugly'
) < 1;

UPDATE questions
SET option1 = 'Glowing, Shiny',
    option2 = 'Stunning, Gorgeous',
    option3 = 'Shiny, Radiant',
    option4 = 'Dull, Dark'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "radiant"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Dull, Dark';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "radiant"?', 'antonym', 'Dull, Dark', 'Glowing, Shiny', 'Stunning, Gorgeous', 'Shiny, Radiant', 'Dull, Dark', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "radiant"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Dull, Dark'
) < 1;

UPDATE questions
SET option1 = 'Unfair, Mean',
    option2 = 'Unstable, Risky',
    option3 = 'Splendid, Amazing',
    option4 = 'Just, Nice'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "fair"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Unfair, Mean';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "fair"?', 'antonym', 'Unfair, Mean', 'Unfair, Mean', 'Unstable, Risky', 'Splendid, Amazing', 'Just, Nice', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "fair"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Unfair, Mean'
) < 1;

UPDATE questions
SET option1 = 'Stunning, Gorgeous',
    option2 = 'Dull, Dark',
    option3 = 'Glowing, Shiny',
    option4 = 'Ugly, Plain'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "ravishing"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Ugly, Plain';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "ravishing"?', 'antonym', 'Ugly, Plain', 'Stunning, Gorgeous', 'Dull, Dark', 'Glowing, Shiny', 'Ugly, Plain', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "ravishing"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Ugly, Plain'
) < 1;

UPDATE questions
SET option1 = 'Safe, Secure',
    option2 = 'Dangerous, Risky',
    option3 = 'Unstable, Risky',
    option4 = 'Risky, Hazardous'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "perilous"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Safe, Secure';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "perilous"?', 'antonym', 'Safe, Secure', 'Safe, Secure', 'Dangerous, Risky', 'Unstable, Risky', 'Risky, Hazardous', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "perilous"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Safe, Secure'
) < 1;

UPDATE questions
SET option1 = 'Dangerous, Risky',
    option2 = 'Safe, Secure',
    option3 = 'Unstable, Risky',
    option4 = 'Risky, Hazardous'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "precarious"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Safe, Secure';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "precarious"?', 'antonym', 'Safe, Secure', 'Dangerous, Risky', 'Safe, Secure', 'Unstable, Risky', 'Risky, Hazardous', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "precarious"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Safe, Secure'
) < 1;

UPDATE questions
SET option1 = 'Safe, Trustworthy',
    option2 = 'Safe, Friendly',
    option3 = 'Dangerous, Hazardous',
    option4 = 'Scary, Dangerous'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "treacherous"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Safe, Trustworthy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "treacherous"?', 'antonym', 'Safe, Trustworthy', 'Safe, Trustworthy', 'Safe, Friendly', 'Dangerous, Hazardous', 'Scary, Dangerous', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "treacherous"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Safe, Trustworthy'
) < 1;

UPDATE questions
SET option1 = 'Safe, Friendly',
    option2 = 'Dangerous, Hazardous',
    option3 = 'Safe, Trustworthy',
    option4 = 'Scary, Dangerous'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "threatening"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Safe, Friendly';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "threatening"?', 'antonym', 'Safe, Friendly', 'Safe, Friendly', 'Dangerous, Hazardous', 'Safe, Trustworthy', 'Scary, Dangerous', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "threatening"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Safe, Friendly'
) < 1;

UPDATE questions
SET option1 = 'Risky, Hazardous',
    option2 = 'Unstable, Risky',
    option3 = 'Dangerous, Risky',
    option4 = 'Safe, Secure'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "hazardous"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Safe, Secure';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "hazardous"?', 'antonym', 'Safe, Secure', 'Risky, Hazardous', 'Unstable, Risky', 'Dangerous, Risky', 'Safe, Secure', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "hazardous"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Safe, Secure'
) < 1;

UPDATE questions
SET option1 = 'Calm, Collected',
    option2 = 'Calm, Peaceful',
    option3 = 'Nervous, Upset',
    option4 = 'Calm, Composed'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "unruffled"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Nervous, Upset';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "unruffled"?', 'antonym', 'Nervous, Upset', 'Calm, Collected', 'Calm, Peaceful', 'Nervous, Upset', 'Calm, Composed', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "unruffled"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Nervous, Upset'
) < 1;

UPDATE questions
SET option1 = 'Noisy, Chaotic',
    option2 = 'Peaceful, Calm',
    option3 = 'Calm, Peaceful',
    option4 = 'Calm, Composed'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "tranquil"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Noisy, Chaotic';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "tranquil"?', 'antonym', 'Noisy, Chaotic', 'Noisy, Chaotic', 'Peaceful, Calm', 'Calm, Peaceful', 'Calm, Composed', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "tranquil"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Noisy, Chaotic'
) < 1;

UPDATE questions
SET option1 = 'Calm, Peaceful',
    option2 = 'Distant, Detached',
    option3 = 'Friendly, Warm',
    option4 = 'Safe, Friendly'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "aloof"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Friendly, Warm';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "aloof"?', 'antonym', 'Friendly, Warm', 'Calm, Peaceful', 'Distant, Detached', 'Friendly, Warm', 'Safe, Friendly', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "aloof"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Friendly, Warm'
) < 1;

UPDATE questions
SET option1 = 'Peaceful, Calm',
    option2 = 'Calm, Composed',
    option3 = 'Busy, Chaotic',
    option4 = 'Calm, Collected'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "serene"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Busy, Chaotic';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "serene"?', 'antonym', 'Busy, Chaotic', 'Peaceful, Calm', 'Calm, Composed', 'Busy, Chaotic', 'Calm, Collected', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "serene"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Busy, Chaotic'
) < 1;

UPDATE questions
SET option1 = 'Nervous, Upset',
    option2 = 'Calm, Collected',
    option3 = 'Peaceful, Calm',
    option4 = 'Calm, Peaceful'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "composed"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Nervous, Upset';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "composed"?', 'antonym', 'Nervous, Upset', 'Nervous, Upset', 'Calm, Collected', 'Peaceful, Calm', 'Calm, Peaceful', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "composed"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Nervous, Upset'
) < 1;

UPDATE questions
SET option1 = 'Boring, Dull',
    option2 = 'Fascinating, Curious',
    option3 = 'Dull, Dark',
    option4 = 'Interesting, Captivating'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "fascinating"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Boring, Dull';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "fascinating"?', 'antonym', 'Boring, Dull', 'Boring, Dull', 'Fascinating, Curious', 'Dull, Dark', 'Interesting, Captivating', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "fascinating"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Boring, Dull'
) < 1;

UPDATE questions
SET option1 = 'Dull, Dark',
    option2 = 'Dull, Faded',
    option3 = 'Boring, Dull',
    option4 = 'Interesting, Captivating'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "engaging"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Boring, Dull';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "engaging"?', 'antonym', 'Boring, Dull', 'Dull, Dark', 'Dull, Faded', 'Boring, Dull', 'Interesting, Captivating', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "engaging"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Boring, Dull'
) < 1;

UPDATE questions
SET option1 = 'Fascinating, Curious',
    option2 = 'Attractive, Welcoming',
    option3 = 'Boring, Simple',
    option4 = 'Unappealing, Repelling'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "inviting"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Unappealing, Repelling';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "inviting"?', 'antonym', 'Unappealing, Repelling', 'Fascinating, Curious', 'Attractive, Welcoming', 'Boring, Simple', 'Unappealing, Repelling', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "inviting"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Unappealing, Repelling'
) < 1;

UPDATE questions
SET option1 = 'Attractive, Welcoming',
    option2 = 'Fascinating, Curious',
    option3 = 'Glowing, Bright',
    option4 = 'Boring, Simple'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "intriguing"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Boring, Simple';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "intriguing"?', 'antonym', 'Boring, Simple', 'Attractive, Welcoming', 'Fascinating, Curious', 'Glowing, Bright', 'Boring, Simple', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "intriguing"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Boring, Simple'
) < 1;

UPDATE questions
SET option1 = 'Ordinary, Plain',
    option2 = 'Calm, Controlled',
    option3 = 'Magical, Charming',
    option4 = 'Crazy, Wild'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "bewitching"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Ordinary, Plain';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "bewitching"?', 'antonym', 'Ordinary, Plain', 'Ordinary, Plain', 'Calm, Controlled', 'Magical, Charming', 'Crazy, Wild', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "bewitching"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Ordinary, Plain'
) < 1;

UPDATE questions
SET option1 = 'Shiny, Glossy',
    option2 = 'Shiny, Sparkling',
    option3 = 'Glowing, Shiny',
    option4 = 'Dull, Dark'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "radiant"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Dull, Dark';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "radiant"?', 'antonym', 'Dull, Dark', 'Shiny, Glossy', 'Shiny, Sparkling', 'Glowing, Shiny', 'Dull, Dark', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "radiant"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Dull, Dark'
) < 2;

UPDATE questions
SET option1 = 'Bright, Clear',
    option2 = 'Dull, Faded',
    option3 = 'Dull, Matte',
    option4 = 'Glowing, Bright'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "vivid"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Dull, Faded';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "vivid"?', 'antonym', 'Dull, Faded', 'Bright, Clear', 'Dull, Faded', 'Dull, Matte', 'Glowing, Bright', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "vivid"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Dull, Faded'
) < 1;

UPDATE questions
SET option1 = 'Glowing, Shiny',
    option2 = 'Dull, Matte',
    option3 = 'Shiny, Glossy',
    option4 = 'Shiny, Sparkling'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "lustrous"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Dull, Matte';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "lustrous"?', 'antonym', 'Dull, Matte', 'Glowing, Shiny', 'Dull, Matte', 'Shiny, Glossy', 'Shiny, Sparkling', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "lustrous"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Dull, Matte'
) < 1;

UPDATE questions
SET option1 = 'Boring, Simple',
    option2 = 'Fascinating, Curious',
    option3 = 'Glowing, Bright',
    option4 = 'Dim, Dark'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "incandescent"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Dim, Dark';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "incandescent"?', 'antonym', 'Dim, Dark', 'Boring, Simple', 'Fascinating, Curious', 'Glowing, Bright', 'Dim, Dark', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "incandescent"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Dim, Dark'
) < 1;

UPDATE questions
SET option1 = 'Shiny, Glossy',
    option2 = 'Shiny, Sparkling',
    option3 = 'Dull, Dirty',
    option4 = 'Glowing, Shiny'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "gleaming"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Dull, Dirty';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "gleaming"?', 'antonym', 'Dull, Dirty', 'Shiny, Glossy', 'Shiny, Sparkling', 'Dull, Dirty', 'Glowing, Shiny', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "gleaming"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Dull, Dirty'
) < 1;

UPDATE questions
SET option1 = 'Noisy, Chaotic',
    option2 = 'Chaos, Disorder',
    option3 = 'Neat, Organized',
    option4 = 'Messy, Chaotic'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "disorderly"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Neat, Organized';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "disorderly"?', 'antonym', 'Neat, Organized', 'Noisy, Chaotic', 'Chaos, Disorder', 'Neat, Organized', 'Messy, Chaotic', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "disorderly"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Neat, Organized'
) < 1;

UPDATE questions
SET option1 = 'Messy, Chaotic',
    option2 = 'Noisy, Chaotic',
    option3 = 'Calm, Peaceful',
    option4 = 'Calm, Quiet'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "tumultuous"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Calm, Quiet';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "tumultuous"?', 'antonym', 'Calm, Quiet', 'Messy, Chaotic', 'Noisy, Chaotic', 'Calm, Peaceful', 'Calm, Quiet', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "tumultuous"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Calm, Quiet'
) < 1;

UPDATE questions
SET option1 = 'Chaos, Mayhem',
    option2 = 'Order, Calm',
    option3 = 'Calm, Quiet',
    option4 = 'Chaos, Disorder'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "pandemonium"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Order, Calm';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "pandemonium"?', 'antonym', 'Order, Calm', 'Chaos, Mayhem', 'Order, Calm', 'Calm, Quiet', 'Chaos, Disorder', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "pandemonium"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Order, Calm'
) < 1;

UPDATE questions
SET option1 = 'Order, Calm',
    option2 = 'Grand, Noble',
    option3 = 'Chaos, Disorder',
    option4 = 'Ordinary, Humble'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "mayhem"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Order, Calm';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "mayhem"?', 'antonym', 'Order, Calm', 'Order, Calm', 'Grand, Noble', 'Chaos, Disorder', 'Ordinary, Humble', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "mayhem"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Order, Calm'
) < 1;

UPDATE questions
SET option1 = 'Calm, Controlled',
    option2 = 'Magical, Charming',
    option3 = 'Crazy, Wild',
    option4 = 'Order, Calm'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "berserk"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Calm, Controlled';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "berserk"?', 'antonym', 'Calm, Controlled', 'Calm, Controlled', 'Magical, Charming', 'Crazy, Wild', 'Order, Calm', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "berserk"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Calm, Controlled'
) < 1;

UPDATE questions
SET option1 = 'Moderate, Frugal',
    option2 = 'Greedy, Overeating',
    option3 = 'Dull, Dirty',
    option4 = 'Shiny, Sparkling'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "gluttonous"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Moderate, Frugal';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "gluttonous"?', 'antonym', 'Moderate, Frugal', 'Moderate, Frugal', 'Greedy, Overeating', 'Dull, Dirty', 'Shiny, Sparkling', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "gluttonous"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Moderate, Frugal'
) < 1;

UPDATE questions
SET option1 = 'Calm, Collected',
    option2 = 'Forced, Obliged',
    option3 = 'Free, Help',
    option4 = 'Free, Voluntary'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "compelled"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Free, Voluntary';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "compelled"?', 'antonym', 'Free, Voluntary', 'Calm, Collected', 'Forced, Obliged', 'Free, Help', 'Free, Voluntary', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "compelled"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Free, Voluntary'
) < 1;

UPDATE questions
SET option1 = 'Chaos, Disorder',
    option2 = 'Grand, Noble',
    option3 = 'Order, Calm',
    option4 = 'Ordinary, Humble'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "majestic"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Ordinary, Humble';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "majestic"?', 'antonym', 'Ordinary, Humble', 'Chaos, Disorder', 'Grand, Noble', 'Order, Calm', 'Ordinary, Humble', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "majestic"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Ordinary, Humble'
) < 1;

UPDATE questions
SET option1 = 'Free, Help',
    option2 = 'Free, Voluntary',
    option3 = 'Calm, Controlled',
    option4 = 'Control, Dominate'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "oppress"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Free, Help';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "oppress"?', 'antonym', 'Free, Help', 'Free, Help', 'Free, Voluntary', 'Calm, Controlled', 'Control, Dominate', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "oppress"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Free, Help'
) < 1;

DROP TABLE seed_quiz_id;

-- Year 5 Vocabulary 8 Pages Antonym Paper 2
INSERT INTO quizzes (title, description, created_by, stage_id, lock_after_attempt)
SELECT 'Year 5 Vocabulary 8 Pages Antonym Paper 2',
       'A 100-question Year 5 vocabulary exam from the 8-page workbook asking students to identify antonym pairs.',
       1,
       (SELECT id FROM stages WHERE name = 'Year 5'),
       1
WHERE NOT EXISTS (SELECT 1 FROM quizzes WHERE title = 'Year 5 Vocabulary 8 Pages Antonym Paper 2');

DROP TABLE IF EXISTS seed_quiz_id;
CREATE TEMP TABLE seed_quiz_id(id INTEGER);
INSERT INTO seed_quiz_id SELECT id FROM quizzes WHERE title = 'Year 5 Vocabulary 8 Pages Antonym Paper 2' LIMIT 1;

UPDATE questions
SET option1 = 'Inhabited, Settled',
    option2 = 'Skilled, Expert',
    option3 = 'Empty, Uninhabited',
    option4 = 'Unskilled, Inept'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "populated"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Empty, Uninhabited';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "populated"?', 'antonym', 'Empty, Uninhabited', 'Inhabited, Settled', 'Skilled, Expert', 'Empty, Uninhabited', 'Unskilled, Inept', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "populated"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Empty, Uninhabited'
) < 1;

UPDATE questions
SET option1 = 'Plead, Beg',
    option2 = 'Beg, Plead',
    option3 = 'Reuse, Repurpose',
    option4 = 'Refuse, Reject'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "implore"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Refuse, Reject';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "implore"?', 'antonym', 'Refuse, Reject', 'Plead, Beg', 'Beg, Plead', 'Reuse, Repurpose', 'Refuse, Reject', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "implore"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Refuse, Reject'
) < 1;

UPDATE questions
SET option1 = 'Empty, Uninhabited',
    option2 = 'Inhabited, Settled',
    option3 = 'Skilled, Expert',
    option4 = 'Unskilled, Inept'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "proficient"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Unskilled, Inept';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "proficient"?', 'antonym', 'Unskilled, Inept', 'Empty, Uninhabited', 'Inhabited, Settled', 'Skilled, Expert', 'Unskilled, Inept', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "proficient"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Unskilled, Inept'
) < 1;

UPDATE questions
SET option1 = 'Band, Ensemble',
    option2 = 'Reuse, Repurpose',
    option3 = 'Reword, Restate',
    option4 = 'Quote, Copy'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "paraphrase"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Quote, Copy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "paraphrase"?', 'antonym', 'Quote, Copy', 'Band, Ensemble', 'Reuse, Repurpose', 'Reword, Restate', 'Quote, Copy', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "paraphrase"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Quote, Copy'
) < 1;

UPDATE questions
SET option1 = 'Reuse, Repurpose',
    option2 = 'Pride, Satisfaction',
    option3 = 'Regret, Guilt',
    option4 = 'Waste, Trash'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "recycle"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Waste, Trash';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "recycle"?', 'antonym', 'Waste, Trash', 'Reuse, Repurpose', 'Pride, Satisfaction', 'Regret, Guilt', 'Waste, Trash', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "recycle"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Waste, Trash'
) < 1;

UPDATE questions
SET option1 = 'Observation, Monitoring',
    option2 = 'Adequate, Enough',
    option3 = 'Ignoring, Neglect',
    option4 = 'Regret, Guilt'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "surveillance"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Ignoring, Neglect';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "surveillance"?', 'antonym', 'Ignoring, Neglect', 'Observation, Monitoring', 'Adequate, Enough', 'Ignoring, Neglect', 'Regret, Guilt', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "surveillance"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Ignoring, Neglect'
) < 1;

UPDATE questions
SET option1 = 'Careful, Cautious',
    option2 = 'Social, Friendly',
    option3 = 'Calm, Peaceful',
    option4 = 'Careless, Open'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "guarded"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Careless, Open';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "guarded"?', 'antonym', 'Careless, Open', 'Careful, Cautious', 'Social, Friendly', 'Calm, Peaceful', 'Careless, Open', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "guarded"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Careless, Open'
) < 1;

UPDATE questions
SET option1 = 'Regret, Guilt',
    option2 = 'Silent, Muffled',
    option3 = 'Loud, Clear',
    option4 = 'Perfect, Peaceful'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "inaudible"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Loud, Clear';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "inaudible"?', 'antonym', 'Loud, Clear', 'Regret, Guilt', 'Silent, Muffled', 'Loud, Clear', 'Perfect, Peaceful', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "inaudible"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Loud, Clear'
) < 1;

UPDATE questions
SET option1 = 'Social, Friendly',
    option2 = 'Solo, Individual',
    option3 = 'Reword, Restate',
    option4 = 'Band, Ensemble'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "orchestra"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Solo, Individual';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "orchestra"?', 'antonym', 'Solo, Individual', 'Social, Friendly', 'Solo, Individual', 'Reword, Restate', 'Band, Ensemble', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "orchestra"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Solo, Individual'
) < 1;

UPDATE questions
SET option1 = 'Calm, Peaceful',
    option2 = 'Calm, Soothe',
    option3 = 'Agitated, Wild',
    option4 = 'Perfect, Peaceful'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "placid"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Agitated, Wild';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "placid"?', 'antonym', 'Agitated, Wild', 'Calm, Peaceful', 'Calm, Soothe', 'Agitated, Wild', 'Perfect, Peaceful', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "placid"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Agitated, Wild'
) < 1;

UPDATE questions
SET option1 = 'Regret, Guilt',
    option2 = 'Waste, Trash',
    option3 = 'Reuse, Repurpose',
    option4 = 'Pride, Satisfaction'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "remorse"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Pride, Satisfaction';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "remorse"?', 'antonym', 'Pride, Satisfaction', 'Regret, Guilt', 'Waste, Trash', 'Reuse, Repurpose', 'Pride, Satisfaction', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "remorse"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Pride, Satisfaction'
) < 1;

UPDATE questions
SET option1 = 'Wealthy, Thriving',
    option2 = 'Social, Friendly',
    option3 = 'Shy, Aloof',
    option4 = 'Careful, Cautious'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "gregarious"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Shy, Aloof';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "gregarious"?', 'antonym', 'Shy, Aloof', 'Wealthy, Thriving', 'Social, Friendly', 'Shy, Aloof', 'Careful, Cautious', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "gregarious"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Shy, Aloof'
) < 1;

UPDATE questions
SET option1 = 'Perfect, Peaceful',
    option2 = 'Strange, Odd',
    option3 = 'Messy, Chaotic',
    option4 = 'Calm, Peaceful'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "idyllic"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Messy, Chaotic';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "idyllic"?', 'antonym', 'Messy, Chaotic', 'Perfect, Peaceful', 'Strange, Odd', 'Messy, Chaotic', 'Calm, Peaceful', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "idyllic"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Messy, Chaotic'
) < 1;

UPDATE questions
SET option1 = 'Praise, Help',
    option2 = 'Criticize, Harm',
    option3 = 'Give up, Forfeit',
    option4 = 'Pride, Satisfaction'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "malign"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Praise, Help';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "malign"?', 'antonym', 'Praise, Help', 'Praise, Help', 'Criticize, Harm', 'Give up, Forfeit', 'Pride, Satisfaction', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "malign"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Praise, Help'
) < 1;

UPDATE questions
SET option1 = 'Strange, Odd',
    option2 = 'Annoy, Stir',
    option3 = 'Calm, Peaceful',
    option4 = 'Normal, Ordinary'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "peculiar"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Normal, Ordinary';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "peculiar"?', 'antonym', 'Normal, Ordinary', 'Strange, Odd', 'Annoy, Stir', 'Calm, Peaceful', 'Normal, Ordinary', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "peculiar"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Normal, Ordinary'
) < 1;

UPDATE questions
SET option1 = 'Poor, Failing',
    option2 = 'Wealthy, Thriving',
    option3 = 'Annoy, Stir',
    option4 = 'Calm, Soothe'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "prosperous"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Poor, Failing';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "prosperous"?', 'antonym', 'Poor, Failing', 'Poor, Failing', 'Wealthy, Thriving', 'Annoy, Stir', 'Calm, Soothe', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "prosperous"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Poor, Failing'
) < 1;

UPDATE questions
SET option1 = 'Keep, Gain',
    option2 = 'Give up, Forfeit',
    option3 = 'Amazing, Fantastic',
    option4 = 'Adequate, Enough'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "sacrificed"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Keep, Gain';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "sacrificed"?', 'antonym', 'Keep, Gain', 'Keep, Gain', 'Give up, Forfeit', 'Amazing, Fantastic', 'Adequate, Enough', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "sacrificed"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Keep, Gain'
) < 1;

UPDATE questions
SET option1 = 'Insufficient, Lacking',
    option2 = 'Enough, Sufficient',
    option3 = 'Adequate, Enough',
    option4 = 'Observation, Monitoring'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "sufficient"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Insufficient, Lacking';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "sufficient"?', 'antonym', 'Insufficient, Lacking', 'Insufficient, Lacking', 'Enough, Sufficient', 'Adequate, Enough', 'Observation, Monitoring', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "sufficient"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Insufficient, Lacking'
) < 1;

UPDATE questions
SET option1 = 'Annoy, Stir',
    option2 = 'Calm, Soothe',
    option3 = 'Wealthy, Thriving',
    option4 = 'Poor, Failing'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "provoke"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Calm, Soothe';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "provoke"?', 'antonym', 'Calm, Soothe', 'Annoy, Stir', 'Calm, Soothe', 'Wealthy, Thriving', 'Poor, Failing', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "provoke"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Calm, Soothe'
) < 1;

UPDATE questions
SET option1 = 'New, Fresh',
    option2 = 'Worn, Old',
    option3 = 'Strange, Odd',
    option4 = 'Give up, Forfeit'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "threadbare"?'
  AND question_type = 'antonym'
  AND correct_answer = 'New, Fresh';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "threadbare"?', 'antonym', 'New, Fresh', 'New, Fresh', 'Worn, Old', 'Strange, Odd', 'Give up, Forfeit', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "threadbare"?'
      AND question_type = 'antonym'
      AND correct_answer = 'New, Fresh'
) < 1;

UPDATE questions
SET option1 = 'Amazing, Fantastic',
    option2 = 'Normal, Ordinary',
    option3 = 'Adequate, Enough',
    option4 = 'Ordinary, Small'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "stupendous"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Ordinary, Small';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "stupendous"?', 'antonym', 'Ordinary, Small', 'Amazing, Fantastic', 'Normal, Ordinary', 'Adequate, Enough', 'Ordinary, Small', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "stupendous"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Ordinary, Small'
) < 1;

UPDATE questions
SET option1 = 'Adequate, Enough',
    option2 = 'Enough, Sufficient',
    option3 = 'Insufficient, Lacking',
    option4 = 'Difficult, Tough'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "adequate"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Insufficient, Lacking';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "adequate"?', 'antonym', 'Insufficient, Lacking', 'Adequate, Enough', 'Enough, Sufficient', 'Insufficient, Lacking', 'Difficult, Tough', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "adequate"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Insufficient, Lacking'
) < 1;

UPDATE questions
SET option1 = 'Scarcity, Shortage',
    option2 = 'Plenty, Lots',
    option3 = 'Silly, Ridiculous',
    option4 = 'Sensible, Normal'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "abundance"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Scarcity, Shortage';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "abundance"?', 'antonym', 'Scarcity, Shortage', 'Scarcity, Shortage', 'Plenty, Lots', 'Silly, Ridiculous', 'Sensible, Normal', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "abundance"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Scarcity, Shortage'
) < 1;

UPDATE questions
SET option1 = 'Trainee, Learner',
    option2 = 'Expert, Master',
    option3 = 'Silly, Ridiculous',
    option4 = 'Calm, Soothe'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "apprentice"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Expert, Master';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "apprentice"?', 'antonym', 'Expert, Master', 'Trainee, Learner', 'Expert, Master', 'Silly, Ridiculous', 'Calm, Soothe', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "apprentice"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Expert, Master'
) < 1;

UPDATE questions
SET option1 = 'Handy, Useful',
    option2 = 'Inconvenient, Awkward',
    option3 = 'Carelessness, Ignorance',
    option4 = 'Morals, Awareness'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "conscience"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Carelessness, Ignorance';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "conscience"?', 'antonym', 'Carelessness, Ignorance', 'Handy, Useful', 'Inconvenient, Awkward', 'Carelessness, Ignorance', 'Morals, Awareness', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "conscience"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Carelessness, Ignorance'
) < 1;

UPDATE questions
SET option1 = 'Inconvenient, Awkward',
    option2 = 'Morals, Awareness',
    option3 = 'Carelessness, Ignorance',
    option4 = 'Handy, Useful'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "convenient"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Inconvenient, Awkward';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "convenient"?', 'antonym', 'Inconvenient, Awkward', 'Inconvenient, Awkward', 'Morals, Awareness', 'Carelessness, Ignorance', 'Handy, Useful', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "convenient"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Inconvenient, Awkward'
) < 1;

UPDATE questions
SET option1 = 'Difficult, Tough',
    option2 = 'Enough, Sufficient',
    option3 = 'Silly, Ridiculous',
    option4 = 'Easy, Simple'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "arduous"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Easy, Simple';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "arduous"?', 'antonym', 'Easy, Simple', 'Difficult, Tough', 'Enough, Sufficient', 'Silly, Ridiculous', 'Easy, Simple', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "arduous"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Easy, Simple'
) < 1;

UPDATE questions
SET option1 = 'Sensible, Normal',
    option2 = 'Plenty, Lots',
    option3 = 'Scarcity, Shortage',
    option4 = 'Silly, Ridiculous'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "absurd"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Sensible, Normal';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "absurd"?', 'antonym', 'Sensible, Normal', 'Sensible, Normal', 'Plenty, Lots', 'Scarcity, Shortage', 'Silly, Ridiculous', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "absurd"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Sensible, Normal'
) < 1;

UPDATE questions
SET option1 = 'Relic, Object',
    option2 = 'Difficult, Tough',
    option3 = 'Modern item, New thing',
    option4 = 'Diligent, Hardworking'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "artefact"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Modern item, New thing';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "artefact"?', 'antonym', 'Modern item, New thing', 'Relic, Object', 'Difficult, Tough', 'Modern item, New thing', 'Diligent, Hardworking', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "artefact"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Modern item, New thing'
) < 1;

UPDATE questions
SET option1 = 'Crowded, Packed',
    option2 = 'Discuss, Consult',
    option3 = 'Clear, Obvious',
    option4 = 'Clear, Empty'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "congested"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Clear, Empty';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "congested"?', 'antonym', 'Clear, Empty', 'Crowded, Packed', 'Discuss, Consult', 'Clear, Obvious', 'Clear, Empty', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "congested"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Clear, Empty'
) < 1;

UPDATE questions
SET option1 = 'Clear, Obvious',
    option2 = 'Twist, Bend',
    option3 = 'Mysterious, Puzzling',
    option4 = 'Clear, Empty'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "cryptic"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Clear, Obvious';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "cryptic"?', 'antonym', 'Clear, Obvious', 'Clear, Obvious', 'Twist, Bend', 'Mysterious, Puzzling', 'Clear, Empty', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "cryptic"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Clear, Obvious'
) < 1;

UPDATE questions
SET option1 = 'Leave, Separate',
    option2 = 'Join, Attend',
    option3 = 'Introduce, Inform',
    option4 = 'Ignore, Conceal'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "acquaint"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Ignore, Conceal';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "acquaint"?', 'antonym', 'Ignore, Conceal', 'Leave, Separate', 'Join, Attend', 'Introduce, Inform', 'Ignore, Conceal', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "acquaint"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Ignore, Conceal'
) < 1;

UPDATE questions
SET option1 = 'Distant, Detached',
    option2 = 'Lazy, Careless',
    option3 = 'Apart, Separated',
    option4 = 'Diligent, Hardworking'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "assiduous"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Lazy, Careless';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "assiduous"?', 'antonym', 'Lazy, Careless', 'Distant, Detached', 'Lazy, Careless', 'Apart, Separated', 'Diligent, Hardworking', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "assiduous"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Lazy, Careless'
) < 1;

UPDATE questions
SET option1 = 'Diligent, Hardworking',
    option2 = 'Distant, Detached',
    option3 = 'Friendly, Warm',
    option4 = 'Distant, Far'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "aloof"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Friendly, Warm';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "aloof"?', 'antonym', 'Friendly, Warm', 'Diligent, Hardworking', 'Distant, Detached', 'Friendly, Warm', 'Distant, Far', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "aloof"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Friendly, Warm'
) < 1;

UPDATE questions
SET option1 = 'Nearby, Beside',
    option2 = 'Stick, Obey',
    option3 = 'Distant, Far',
    option4 = 'Distant, Detached'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "adjacent"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Distant, Far';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "adjacent"?', 'antonym', 'Distant, Far', 'Nearby, Beside', 'Stick, Obey', 'Distant, Far', 'Distant, Detached', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "adjacent"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Distant, Far'
) < 1;

UPDATE questions
SET option1 = 'Twist, Bend',
    option2 = 'Disagree, Oppose',
    option3 = 'Straighten, Unbend',
    option4 = 'Discuss, Consult'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "contort"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Straighten, Unbend';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "contort"?', 'antonym', 'Straighten, Unbend', 'Twist, Bend', 'Disagree, Oppose', 'Straighten, Unbend', 'Discuss, Consult', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "contort"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Straighten, Unbend'
) < 1;

UPDATE questions
SET option1 = 'Leave, Separate',
    option2 = 'Introduce, Inform',
    option3 = 'Ignore, Conceal',
    option4 = 'Join, Attend'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "accompany"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Leave, Separate';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "accompany"?', 'antonym', 'Leave, Separate', 'Leave, Separate', 'Introduce, Inform', 'Ignore, Conceal', 'Join, Attend', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "accompany"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Leave, Separate'
) < 1;

UPDATE questions
SET option1 = 'Apart, Separated',
    option2 = 'Trainee, Learner',
    option3 = 'Calm, Soothe',
    option4 = 'Annoy, Provoke'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "appease"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Annoy, Provoke';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "appease"?', 'antonym', 'Annoy, Provoke', 'Apart, Separated', 'Trainee, Learner', 'Calm, Soothe', 'Annoy, Provoke', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "appease"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Annoy, Provoke'
) < 1;

UPDATE questions
SET option1 = 'Release, Free',
    option2 = 'Nearby, Beside',
    option3 = 'Kidnap, Seize',
    option4 = 'Calm, Soothe'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "abduct"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Release, Free';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "abduct"?', 'antonym', 'Release, Free', 'Release, Free', 'Nearby, Beside', 'Kidnap, Seize', 'Calm, Soothe', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "abduct"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Release, Free'
) < 1;

UPDATE questions
SET option1 = 'Ignore, Avoid',
    option2 = 'Disagree, Oppose',
    option3 = 'Discuss, Consult',
    option4 = 'Twist, Bend'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "confer"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Ignore, Avoid';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "confer"?', 'antonym', 'Ignore, Avoid', 'Ignore, Avoid', 'Disagree, Oppose', 'Discuss, Consult', 'Twist, Bend', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "confer"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Ignore, Avoid'
) < 1;

UPDATE questions
SET option1 = 'Disagree, Oppose',
    option2 = 'Agree, Support',
    option3 = 'Straighten, Unbend',
    option4 = 'Twist, Bend'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "contradict"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Agree, Support';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "contradict"?', 'antonym', 'Agree, Support', 'Disagree, Oppose', 'Agree, Support', 'Straighten, Unbend', 'Twist, Bend', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "contradict"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Agree, Support'
) < 1;

UPDATE questions
SET option1 = 'Apart, Separated',
    option2 = 'Detach, Disobey',
    option3 = 'Distant, Detached',
    option4 = 'Stick, Obey'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "adhere (to)"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Detach, Disobey';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "adhere (to)"?', 'antonym', 'Detach, Disobey', 'Apart, Separated', 'Detach, Disobey', 'Distant, Detached', 'Stick, Obey', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "adhere (to)"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Detach, Disobey'
) < 1;

UPDATE questions
SET option1 = 'Together, Joined',
    option2 = 'Apart, Separated',
    option3 = 'Calm, Soothe',
    option4 = 'Stick, Obey'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "asunder"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Together, Joined';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "asunder"?', 'antonym', 'Together, Joined', 'Together, Joined', 'Apart, Separated', 'Calm, Soothe', 'Stick, Obey', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "asunder"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Together, Joined'
) < 1;

UPDATE questions
SET option1 = 'Disagree, Oppose',
    option2 = 'Discuss, Consult',
    option3 = 'Differ, Clash',
    option4 = 'Match, Communicate'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "correspond"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Differ, Clash';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "correspond"?', 'antonym', 'Differ, Clash', 'Disagree, Oppose', 'Discuss, Consult', 'Differ, Clash', 'Match, Communicate', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "correspond"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Differ, Clash'
) < 1;

UPDATE questions
SET option1 = 'Release, Free',
    option2 = 'Free, Untangle',
    option3 = 'Entangle, Involve',
    option4 = 'Develop, Grow'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "embroil"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Free, Untangle';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "embroil"?', 'antonym', 'Free, Untangle', 'Release, Free', 'Free, Untangle', 'Entangle, Involve', 'Develop, Grow', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "embroil"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Free, Untangle'
) < 1;

UPDATE questions
SET option1 = 'Chosen, Selected',
    option2 = 'Clear, Obvious',
    option3 = 'Identify, Detect',
    option4 = 'Rejected, Removed'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "elected"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Rejected, Removed';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "elected"?', 'antonym', 'Rejected, Removed', 'Chosen, Selected', 'Clear, Obvious', 'Identify, Detect', 'Rejected, Removed', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "elected"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Rejected, Removed'
) < 1;

UPDATE questions
SET option1 = 'Identify, Detect',
    option2 = 'Hand out, Distribute',
    option3 = 'Encourage, Cheer',
    option4 = 'Discourage, Upset'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "dishearten"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Encourage, Cheer';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "dishearten"?', 'antonym', 'Encourage, Cheer', 'Identify, Detect', 'Hand out, Distribute', 'Encourage, Cheer', 'Discourage, Upset', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "dishearten"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Encourage, Cheer'
) < 1;

UPDATE questions
SET option1 = 'Discourage, Upset',
    option2 = 'Inform, Clarify',
    option3 = 'Guess, Ignore',
    option4 = 'Identify, Detect'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "diagnose"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Guess, Ignore';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "diagnose"?', 'antonym', 'Guess, Ignore', 'Discourage, Upset', 'Inform, Clarify', 'Guess, Ignore', 'Identify, Detect', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "diagnose"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Guess, Ignore'
) < 1;

UPDATE questions
SET option1 = 'Serious, Sincere',
    option2 = 'Playful, Silly',
    option3 = 'Entangle, Involve',
    option4 = 'Clear, Obvious'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "earnest"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Playful, Silly';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "earnest"?', 'antonym', 'Playful, Silly', 'Serious, Sincere', 'Playful, Silly', 'Entangle, Involve', 'Clear, Obvious', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "earnest"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Playful, Silly'
) < 1;

UPDATE questions
SET option1 = 'Stay, Freeze',
    option2 = 'Clear, Obvious',
    option3 = 'Hidden, Unclear',
    option4 = 'Develop, Grow'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "evident"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Hidden, Unclear';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "evident"?', 'antonym', 'Hidden, Unclear', 'Stay, Freeze', 'Clear, Obvious', 'Hidden, Unclear', 'Develop, Grow', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "evident"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Hidden, Unclear'
) < 1;

UPDATE questions
SET option1 = 'Predict, Prediction',
    option2 = 'Surprise, Hide',
    option3 = 'Discourage, Upset',
    option4 = 'Surprise, Unknown'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "forecast"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Surprise, Unknown';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "forecast"?', 'antonym', 'Surprise, Unknown', 'Predict, Prediction', 'Surprise, Hide', 'Discourage, Upset', 'Surprise, Unknown', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "forecast"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Surprise, Unknown'
) < 1;

UPDATE questions
SET option1 = 'Agreement, Harmony',
    option2 = 'Dispute, Argument',
    option3 = 'Agree, Support',
    option4 = 'Discuss, Consult'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "controversy"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Agreement, Harmony';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "controversy"?', 'antonym', 'Agreement, Harmony', 'Agreement, Harmony', 'Dispute, Argument', 'Agree, Support', 'Discuss, Consult', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "controversy"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Agreement, Harmony'
) < 1;

UPDATE questions
SET option1 = 'Improve, Repair',
    option2 = 'Inform, Clarify',
    option3 = 'Deceive, Fool',
    option4 = 'Decay, Decline'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "delude"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Inform, Clarify';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "delude"?', 'antonym', 'Inform, Clarify', 'Improve, Repair', 'Inform, Clarify', 'Deceive, Fool', 'Decay, Decline', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "delude"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Inform, Clarify'
) < 1;

UPDATE questions
SET option1 = 'Deceive, Fool',
    option2 = 'Inform, Clarify',
    option3 = 'Improve, Repair',
    option4 = 'Decay, Decline'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "deteriorate"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Improve, Repair';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "deteriorate"?', 'antonym', 'Improve, Repair', 'Deceive, Fool', 'Inform, Clarify', 'Improve, Repair', 'Decay, Decline', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "deteriorate"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Improve, Repair'
) < 1;

UPDATE questions
SET option1 = 'Clear, Obvious',
    option2 = 'Stay, Freeze',
    option3 = 'Develop, Grow',
    option4 = 'Stay, Remain'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "evolve"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Stay, Freeze';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "evolve"?', 'antonym', 'Stay, Freeze', 'Clear, Obvious', 'Stay, Freeze', 'Develop, Grow', 'Stay, Remain', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "evolve"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Stay, Freeze'
) < 1;

UPDATE questions
SET option1 = 'Leave, Escape',
    option2 = 'Overstate, Stretch',
    option3 = 'Stay, Remain',
    option4 = 'Downplay, Reduce'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "exaggerate"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Downplay, Reduce';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "exaggerate"?', 'antonym', 'Downplay, Reduce', 'Leave, Escape', 'Overstate, Stretch', 'Stay, Remain', 'Downplay, Reduce', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "exaggerate"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Downplay, Reduce'
) < 1;

UPDATE questions
SET option1 = 'Neglect, Ignore',
    option2 = 'Reveal, Tell',
    option3 = 'Effort, Drive',
    option4 = 'Calm, Collected'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "campaign"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Neglect, Ignore';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "campaign"?', 'antonym', 'Neglect, Ignore', 'Neglect, Ignore', 'Reveal, Tell', 'Effort, Drive', 'Calm, Collected', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "campaign"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Neglect, Ignore'
) < 1;

UPDATE questions
SET option1 = 'Calm, Collected',
    option2 = 'Clash, Spoil',
    option3 = 'Nervous, Panicked',
    option4 = 'Enhance, Match'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "composed"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Nervous, Panicked';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "composed"?', 'antonym', 'Nervous, Panicked', 'Calm, Collected', 'Clash, Spoil', 'Nervous, Panicked', 'Enhance, Match', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "composed"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Nervous, Panicked'
) < 1;

UPDATE questions
SET option1 = 'Collect, Gather',
    option2 = 'Hand out, Distribute',
    option3 = 'Discourage, Upset',
    option4 = 'Calm, Collected'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "dispense"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Collect, Gather';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "dispense"?', 'antonym', 'Collect, Gather', 'Collect, Gather', 'Hand out, Distribute', 'Discourage, Upset', 'Calm, Collected', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "dispense"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Collect, Gather'
) < 1;

UPDATE questions
SET option1 = 'Reveal, Tell',
    option2 = 'Hide, Conceal',
    option3 = 'Hand out, Distribute',
    option4 = 'Effort, Drive'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "divulge"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Hide, Conceal';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "divulge"?', 'antonym', 'Hide, Conceal', 'Reveal, Tell', 'Hide, Conceal', 'Hand out, Distribute', 'Effort, Drive', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "divulge"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Hide, Conceal'
) < 1;

UPDATE questions
SET option1 = 'Imitate, Copy',
    option2 = 'Leave, Escape',
    option3 = 'Stay, Remain',
    option4 = 'Stay, Freeze'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "evacuate"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Stay, Remain';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "evacuate"?', 'antonym', 'Stay, Remain', 'Imitate, Copy', 'Leave, Escape', 'Stay, Remain', 'Stay, Freeze', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "evacuate"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Stay, Remain'
) < 1;

UPDATE questions
SET option1 = 'Enhance, Match',
    option2 = 'Calm, Collected',
    option3 = 'Clash, Spoil',
    option4 = 'Nervous, Panicked'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "complemented"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Clash, Spoil';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "complemented"?', 'antonym', 'Clash, Spoil', 'Enhance, Match', 'Calm, Collected', 'Clash, Spoil', 'Nervous, Panicked', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "complemented"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Clash, Spoil'
) < 1;

UPDATE questions
SET option1 = 'Decode, Understand',
    option2 = 'Deceive, Fool',
    option3 = 'Confuse, Scramble',
    option4 = 'Decay, Decline'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "decipher"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Confuse, Scramble';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "decipher"?', 'antonym', 'Confuse, Scramble', 'Decode, Understand', 'Deceive, Fool', 'Confuse, Scramble', 'Decay, Decline', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "decipher"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Confuse, Scramble'
) < 1;

UPDATE questions
SET option1 = 'Leave, Escape',
    option2 = 'Stay, Remain',
    option3 = 'Imitate, Copy',
    option4 = 'Avoid, Ignore'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "emulate"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Avoid, Ignore';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "emulate"?', 'antonym', 'Avoid, Ignore', 'Leave, Escape', 'Stay, Remain', 'Imitate, Copy', 'Avoid, Ignore', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "emulate"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Avoid, Ignore'
) < 1;

UPDATE questions
SET option1 = 'Dislike, Repel',
    option2 = 'Repel, Discourage',
    option3 = 'Tempt, Lure',
    option4 = 'Charm, Delight'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "enamour"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Dislike, Repel';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "enamour"?', 'antonym', 'Dislike, Repel', 'Dislike, Repel', 'Repel, Discourage', 'Tempt, Lure', 'Charm, Delight', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "enamour"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Dislike, Repel'
) < 1;

UPDATE questions
SET option1 = 'Dislike, Repel',
    option2 = 'Tempt, Lure',
    option3 = 'Repel, Discourage',
    option4 = 'Charm, Delight'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "entice"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Repel, Discourage';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "entice"?', 'antonym', 'Repel, Discourage', 'Dislike, Repel', 'Tempt, Lure', 'Repel, Discourage', 'Charm, Delight', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "entice"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Repel, Discourage'
) < 1;

UPDATE questions
SET option1 = 'Tiredness, Sluggishness',
    option2 = 'Resentment, Anger',
    option3 = 'Forgiveness, Peace',
    option4 = 'Enhance, Match'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "grudge"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Forgiveness, Peace';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "grudge"?', 'antonym', 'Forgiveness, Peace', 'Tiredness, Sluggishness', 'Resentment, Anger', 'Forgiveness, Peace', 'Enhance, Match', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "grudge"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Forgiveness, Peace'
) < 1;

UPDATE questions
SET option1 = 'Obstacle, Problem',
    option2 = 'Avoid, Ignore',
    option3 = 'Help, Aid',
    option4 = 'Invisible, Abstract'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "hindrance"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Help, Aid';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "hindrance"?', 'antonym', 'Help, Aid', 'Obstacle, Problem', 'Avoid, Ignore', 'Help, Aid', 'Invisible, Abstract', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "hindrance"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Help, Aid'
) < 1;

UPDATE questions
SET option1 = 'Slowly, Later',
    option2 = 'Invisible, Abstract',
    option3 = 'Immediately, Quickly',
    option4 = 'Physical, Solid'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "intangible"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Physical, Solid';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "intangible"?', 'antonym', 'Physical, Solid', 'Slowly, Later', 'Invisible, Abstract', 'Immediately, Quickly', 'Physical, Solid', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "intangible"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Physical, Solid'
) < 1;

UPDATE questions
SET option1 = 'Invisible, Abstract',
    option2 = 'Terrible, Horrible',
    option3 = 'Wise, Sensible',
    option4 = 'Foolish, Rash'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "judicious"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Foolish, Rash';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "judicious"?', 'antonym', 'Foolish, Rash', 'Invisible, Abstract', 'Terrible, Horrible', 'Wise, Sensible', 'Foolish, Rash', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "judicious"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Foolish, Rash'
) < 1;

UPDATE questions
SET option1 = 'Energy, Alertness',
    option2 = 'Resentment, Anger',
    option3 = 'Tempt, Lure',
    option4 = 'Tiredness, Sluggishness'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "lethargy"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Energy, Alertness';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "lethargy"?', 'antonym', 'Energy, Alertness', 'Energy, Alertness', 'Resentment, Anger', 'Tempt, Lure', 'Tiredness, Sluggishness', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "lethargy"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Energy, Alertness'
) < 1;

UPDATE questions
SET option1 = 'Immediately, Quickly',
    option2 = 'Slowly, Later',
    option3 = 'Invisible, Abstract',
    option4 = 'Physical, Solid'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "instantly"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Slowly, Later';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "instantly"?', 'antonym', 'Slowly, Later', 'Immediately, Quickly', 'Slowly, Later', 'Invisible, Abstract', 'Physical, Solid', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "instantly"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Slowly, Later'
) < 1;

UPDATE questions
SET option1 = 'Obstacle, Problem',
    option2 = 'Advance, Give',
    option3 = 'Retreating, Leaving',
    option4 = 'Remove, Retreat'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "withdraw"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Advance, Give';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "withdraw"?', 'antonym', 'Advance, Give', 'Obstacle, Problem', 'Advance, Give', 'Retreating, Leaving', 'Remove, Retreat', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "withdraw"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Advance, Give'
) < 1;

UPDATE questions
SET option1 = 'Oddity, Exception',
    option2 = 'Terrible, Horrible',
    option3 = 'Normality, Usual',
    option4 = 'Wonderful, Pleasant'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "abominable"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Wonderful, Pleasant';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "abominable"?', 'antonym', 'Wonderful, Pleasant', 'Oddity, Exception', 'Terrible, Horrible', 'Normality, Usual', 'Wonderful, Pleasant', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "abominable"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Wonderful, Pleasant'
) < 1;

UPDATE questions
SET option1 = 'Repel, Discourage',
    option2 = 'Trapped, Controlled',
    option3 = 'Dislike, Repel',
    option4 = 'Free, Independent'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "enslaved"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Free, Independent';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "enslaved"?', 'antonym', 'Free, Independent', 'Repel, Discourage', 'Trapped, Controlled', 'Dislike, Repel', 'Free, Independent', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "enslaved"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Free, Independent'
) < 1;

UPDATE questions
SET option1 = 'Remove, Retreat',
    option2 = 'Simplicity, Contentment',
    option3 = 'Greed, Possessions',
    option4 = 'Free, Independent'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "materialism"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Simplicity, Contentment';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "materialism"?', 'antonym', 'Simplicity, Contentment', 'Remove, Retreat', 'Simplicity, Contentment', 'Greed, Possessions', 'Free, Independent', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "materialism"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Simplicity, Contentment'
) < 1;

UPDATE questions
SET option1 = 'Wobble, Stagger',
    option2 = 'Tongue-tied, Mumbled',
    option3 = 'Balance, Steady',
    option4 = 'Advance, Give'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "totter"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Balance, Steady';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "totter"?', 'antonym', 'Balance, Steady', 'Wobble, Stagger', 'Tongue-tied, Mumbled', 'Balance, Steady', 'Advance, Give', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "totter"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Balance, Steady'
) < 1;

UPDATE questions
SET option1 = 'Doubtfully, Unlikely',
    option2 = 'Likely, Probably',
    option3 = 'Greatly, Much',
    option4 = 'Wobble, Stagger'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "presumably"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Doubtfully, Unlikely';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "presumably"?', 'antonym', 'Doubtfully, Unlikely', 'Doubtfully, Unlikely', 'Likely, Probably', 'Greatly, Much', 'Wobble, Stagger', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "presumably"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Doubtfully, Unlikely'
) < 1;

UPDATE questions
SET option1 = 'Likely, Probably',
    option2 = 'Slightly, Barely',
    option3 = 'Enhance, Match',
    option4 = 'Greatly, Much'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "considerably"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Slightly, Barely';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "considerably"?', 'antonym', 'Slightly, Barely', 'Likely, Probably', 'Slightly, Barely', 'Enhance, Match', 'Greatly, Much', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "considerably"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Slightly, Barely'
) < 1;

UPDATE questions
SET option1 = 'Shrine, Table',
    option2 = 'Keep, Preserve',
    option3 = '—',
    option4 = 'Change, Modify'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "alter"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Keep, Preserve';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "alter"?', 'antonym', 'Keep, Preserve', 'Shrine, Table', 'Keep, Preserve', '—', 'Change, Modify', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "alter"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Keep, Preserve'
) < 1;

UPDATE questions
SET option1 = 'Shrine, Table',
    option2 = 'Change, Modify',
    option3 = '—',
    option4 = 'Keep, Preserve'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "altar"?'
  AND question_type = 'antonym'
  AND correct_answer = '—';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "altar"?', 'antonym', '—', 'Shrine, Table', 'Change, Modify', '—', 'Keep, Preserve', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "altar"?'
      AND question_type = 'antonym'
      AND correct_answer = '—'
) < 1;

UPDATE questions
SET option1 = 'Tongue-tied, Mumbled',
    option2 = 'Invisible, Abstract',
    option3 = 'Clear, Fluent',
    option4 = 'Immediately, Quickly'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "inarticulate"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Clear, Fluent';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "inarticulate"?', 'antonym', 'Clear, Fluent', 'Tongue-tied, Mumbled', 'Invisible, Abstract', 'Clear, Fluent', 'Immediately, Quickly', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "inarticulate"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Clear, Fluent'
) < 1;

UPDATE questions
SET option1 = 'Oddity, Exception',
    option2 = 'Normality, Usual',
    option3 = 'Terrible, Horrible',
    option4 = 'Change, Modify'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "aberration"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Normality, Usual';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "aberration"?', 'antonym', 'Normality, Usual', 'Oddity, Exception', 'Normality, Usual', 'Terrible, Horrible', 'Change, Modify', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "aberration"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Normality, Usual'
) < 1;

UPDATE questions
SET option1 = 'Normality, Usual',
    option2 = 'Uniqueness, Specialness',
    option3 = 'Misconduct, Negligence',
    option4 = 'Plainness, Normality'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "ordinariness"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Uniqueness, Specialness';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "ordinariness"?', 'antonym', 'Uniqueness, Specialness', 'Normality, Usual', 'Uniqueness, Specialness', 'Misconduct, Negligence', 'Plainness, Normality', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "ordinariness"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Uniqueness, Specialness'
) < 1;

UPDATE questions
SET option1 = 'Lazy, Unmotivated',
    option2 = 'Determined, Eager',
    option3 = 'Frightened, Petrified',
    option4 = 'Fear, Dread'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "ambitious"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Lazy, Unmotivated';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "ambitious"?', 'antonym', 'Lazy, Unmotivated', 'Lazy, Unmotivated', 'Determined, Eager', 'Frightened, Petrified', 'Fear, Dread', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "ambitious"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Lazy, Unmotivated'
) < 1;

UPDATE questions
SET option1 = 'Gradual, Gentle',
    option2 = 'Sudden, Sharp',
    option3 = 'Release, Free',
    option4 = 'Kidnap, Seize'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "abduct"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Release, Free';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "abduct"?', 'antonym', 'Release, Free', 'Gradual, Gentle', 'Sudden, Sharp', 'Release, Free', 'Kidnap, Seize', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "abduct"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Release, Free'
) < 2;

UPDATE questions
SET option1 = 'Care, Skill',
    option2 = 'Accurate, Exact',
    option3 = 'Misconduct, Negligence',
    option4 = 'Rough, Harsh'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "malpractice"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Care, Skill';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "malpractice"?', 'antonym', 'Care, Skill', 'Care, Skill', 'Accurate, Exact', 'Misconduct, Negligence', 'Rough, Harsh', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "malpractice"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Care, Skill'
) < 1;

UPDATE questions
SET option1 = 'Fear, Dread',
    option2 = 'Bravery, Calm',
    option3 = 'Calm, Relaxed',
    option4 = 'Brave, Calm'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "phobia"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Bravery, Calm';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "phobia"?', 'antonym', 'Bravery, Calm', 'Fear, Dread', 'Bravery, Calm', 'Calm, Relaxed', 'Brave, Calm', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "phobia"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Bravery, Calm'
) < 1;

UPDATE questions
SET option1 = 'Delayed, Slow',
    option2 = 'Fear, Dread',
    option3 = 'Plead, Beg',
    option4 = 'Refuse, Demand'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "implore"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Refuse, Demand';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "implore"?', 'antonym', 'Refuse, Demand', 'Delayed, Slow', 'Fear, Dread', 'Plead, Beg', 'Refuse, Demand', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "implore"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Refuse, Demand'
) < 1;

UPDATE questions
SET option1 = 'Brave, Calm',
    option2 = 'Bravery, Calm',
    option3 = 'Frightened, Petrified',
    option4 = 'Calm, Relaxed'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "terrified"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Brave, Calm';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "terrified"?', 'antonym', 'Brave, Calm', 'Brave, Calm', 'Bravery, Calm', 'Frightened, Petrified', 'Calm, Relaxed', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "terrified"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Brave, Calm'
) < 1;

UPDATE questions
SET option1 = 'Calm, Relaxed',
    option2 = 'Bravery, Calm',
    option3 = 'Brave, Calm',
    option4 = 'Worried, Shocked'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "alarmed"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Calm, Relaxed';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "alarmed"?', 'antonym', 'Calm, Relaxed', 'Calm, Relaxed', 'Bravery, Calm', 'Brave, Calm', 'Worried, Shocked', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "alarmed"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Calm, Relaxed'
) < 1;

UPDATE questions
SET option1 = 'Truth, Facts',
    option2 = 'Vague, Messy',
    option3 = 'Accurate, Exact',
    option4 = 'Fear, Dread'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "precise"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Vague, Messy';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "precise"?', 'antonym', 'Vague, Messy', 'Truth, Facts', 'Vague, Messy', 'Accurate, Exact', 'Fear, Dread', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "precise"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Vague, Messy'
) < 1;

UPDATE questions
SET option1 = 'Kidnap, Seize',
    option2 = 'Gradual, Gentle',
    option3 = 'Release, Free',
    option4 = 'Sudden, Sharp'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "abrupt"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Gradual, Gentle';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "abrupt"?', 'antonym', 'Gradual, Gentle', 'Kidnap, Seize', 'Gradual, Gentle', 'Release, Free', 'Sudden, Sharp', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "abrupt"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Gradual, Gentle'
) < 1;

UPDATE questions
SET option1 = 'Unfashionable, Old',
    option2 = 'Trendy, Stylish',
    option3 = 'Predict, Anticipate',
    option4 = 'Hint, Suggest'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "fashionable"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Unfashionable, Old';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "fashionable"?', 'antonym', 'Unfashionable, Old', 'Unfashionable, Old', 'Trendy, Stylish', 'Predict, Anticipate', 'Hint, Suggest', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "fashionable"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Unfashionable, Old'
) < 1;

UPDATE questions
SET option1 = 'Rude, Impolite',
    option2 = 'Smooth, Polite',
    option3 = 'Rough, Harsh',
    option4 = 'Polite, Respectful'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "coarse"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Smooth, Polite';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "coarse"?', 'antonym', 'Smooth, Polite', 'Rude, Impolite', 'Smooth, Polite', 'Rough, Harsh', 'Polite, Respectful', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "coarse"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Smooth, Polite'
) < 1;

UPDATE questions
SET option1 = 'Rough, Harsh',
    option2 = 'Polite, Respectful',
    option3 = 'Rude, Impolite',
    option4 = 'Smooth, Polite'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "courteous"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Rude, Impolite';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "courteous"?', 'antonym', 'Rude, Impolite', 'Rough, Harsh', 'Polite, Respectful', 'Rude, Impolite', 'Smooth, Polite', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "courteous"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Rude, Impolite'
) < 1;

UPDATE questions
SET option1 = 'Persuasion, Influence',
    option2 = 'Accurate, Exact',
    option3 = 'Rough, Harsh',
    option4 = 'Truth, Facts'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "propaganda"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Truth, Facts';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "propaganda"?', 'antonym', 'Truth, Facts', 'Persuasion, Influence', 'Accurate, Exact', 'Rough, Harsh', 'Truth, Facts', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "propaganda"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Truth, Facts'
) < 1;

UPDATE questions
SET option1 = 'Miss, Ignore',
    option2 = 'Surprise, Hide',
    option3 = 'Predict, Anticipate',
    option4 = 'Hint, Suggest'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "foresee"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Miss, Ignore';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "foresee"?', 'antonym', 'Miss, Ignore', 'Miss, Ignore', 'Surprise, Hide', 'Predict, Anticipate', 'Hint, Suggest', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "foresee"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Miss, Ignore'
) < 1;

UPDATE questions
SET option1 = 'Miss, Ignore',
    option2 = 'Predict, Anticipate',
    option3 = 'Surprise, Hide',
    option4 = 'Hint, Suggest'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "foreshadow"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Surprise, Hide';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "foreshadow"?', 'antonym', 'Surprise, Hide', 'Miss, Ignore', 'Predict, Anticipate', 'Surprise, Hide', 'Hint, Suggest', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "foreshadow"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Surprise, Hide'
) < 1;

UPDATE questions
SET option1 = 'Instant, Quick',
    option2 = 'Retreating, Leaving',
    option3 = 'Advancing, Staying',
    option4 = 'Remove, Retreat'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "withdrawing"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Advancing, Staying';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "withdrawing"?', 'antonym', 'Advancing, Staying', 'Instant, Quick', 'Retreating, Leaving', 'Advancing, Staying', 'Remove, Retreat', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "withdrawing"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Advancing, Staying'
) < 1;

DROP TABLE seed_quiz_id;

-- Year 5 Vocabulary 8 Pages Antonym Paper 3
INSERT INTO quizzes (title, description, created_by, stage_id, lock_after_attempt)
SELECT 'Year 5 Vocabulary 8 Pages Antonym Paper 3',
       'A 7-question Year 5 vocabulary exam from the 8-page workbook asking students to identify antonym pairs.',
       1,
       (SELECT id FROM stages WHERE name = 'Year 5'),
       1
WHERE NOT EXISTS (SELECT 1 FROM quizzes WHERE title = 'Year 5 Vocabulary 8 Pages Antonym Paper 3');

DROP TABLE IF EXISTS seed_quiz_id;
CREATE TEMP TABLE seed_quiz_id(id INTEGER);
INSERT INTO seed_quiz_id SELECT id FROM quizzes WHERE title = 'Year 5 Vocabulary 8 Pages Antonym Paper 3' LIMIT 1;

UPDATE questions
SET option1 = 'Delayed, Slow',
    option2 = 'Refuse, Demand',
    option3 = 'Instant, Quick',
    option4 = 'Plead, Beg'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "immediate"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Delayed, Slow';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "immediate"?', 'antonym', 'Delayed, Slow', 'Delayed, Slow', 'Refuse, Demand', 'Instant, Quick', 'Plead, Beg', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "immediate"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Delayed, Slow'
) < 1;

UPDATE questions
SET option1 = 'Polite, Respectful',
    option2 = 'Doubt, Uncertainty',
    option3 = 'Rough, Harsh',
    option4 = 'Belief, Certainty'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "conviction"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Doubt, Uncertainty';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "conviction"?', 'antonym', 'Doubt, Uncertainty', 'Polite, Respectful', 'Doubt, Uncertainty', 'Rough, Harsh', 'Belief, Certainty', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "conviction"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Doubt, Uncertainty'
) < 1;

UPDATE questions
SET option1 = 'Belief, Certainty',
    option2 = 'Instant, Quick',
    option3 = 'Try, Experiment',
    option4 = 'Avoid, Master'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "dabble"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Avoid, Master';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "dabble"?', 'antonym', 'Avoid, Master', 'Belief, Certainty', 'Instant, Quick', 'Try, Experiment', 'Avoid, Master', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "dabble"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Avoid, Master'
) < 1;

UPDATE questions
SET option1 = 'Instant, Quick',
    option2 = 'Priceless, Essential',
    option3 = 'Sadness, Darkness',
    option4 = 'Worthless, Useless'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "invaluable"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Worthless, Useless';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "invaluable"?', 'antonym', 'Worthless, Useless', 'Instant, Quick', 'Priceless, Essential', 'Sadness, Darkness', 'Worthless, Useless', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "invaluable"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Worthless, Useless'
) < 1;

UPDATE questions
SET option1 = 'Lot, Plenty',
    option2 = 'Bit, Little',
    option3 = 'Release, Let go',
    option4 = 'Frightened, Petrified'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "trifle"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Lot, Plenty';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "trifle"?', 'antonym', 'Lot, Plenty', 'Lot, Plenty', 'Bit, Little', 'Release, Let go', 'Frightened, Petrified', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "trifle"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Lot, Plenty'
) < 1;

UPDATE questions
SET option1 = 'Release, Let go',
    option2 = 'Belief, Certainty',
    option3 = 'Priceless, Essential',
    option4 = 'Grip, Grasp'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "clutches"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Release, Let go';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "clutches"?', 'antonym', 'Release, Let go', 'Release, Let go', 'Belief, Certainty', 'Priceless, Essential', 'Grip, Grasp', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "clutches"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Release, Let go'
) < 1;

UPDATE questions
SET option1 = 'Joy, Brightness',
    option2 = 'Sadness, Darkness',
    option3 = 'Priceless, Essential',
    option4 = 'Bit, Little'
WHERE quiz_id = (SELECT id FROM seed_quiz_id)
  AND question_text = 'Which pair of words are antonyms of "gloom"?'
  AND question_type = 'antonym'
  AND correct_answer = 'Joy, Brightness';

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
SELECT (SELECT id FROM seed_quiz_id), 'Which pair of words are antonyms of "gloom"?', 'antonym', 'Joy, Brightness', 'Joy, Brightness', 'Sadness, Darkness', 'Priceless, Essential', 'Bit, Little', 1
WHERE (
    SELECT COUNT(*) FROM questions
    WHERE quiz_id = (SELECT id FROM seed_quiz_id)
      AND question_text = 'Which pair of words are antonyms of "gloom"?'
      AND question_type = 'antonym'
      AND correct_answer = 'Joy, Brightness'
) < 1;

DROP TABLE seed_quiz_id;

COMMIT;
