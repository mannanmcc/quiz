BEGIN TRANSACTION;

INSERT OR IGNORE INTO stages (name, description)
VALUES ('Year 5', 'UK primary Year 5 students.');

INSERT INTO quizzes (title, description, created_by, stage_id, lock_after_attempt, is_archived)
SELECT 'FSCE Exam English for Level 5 Paper 3 - Spelling and Vocabulary',
       'A 100-question FSCE-style Level 5 English paper using statutory spelling words, with missing-word, spelling-choice, and synonym or meaning-clue questions.',
       1,
       (SELECT id FROM stages WHERE name = 'Year 5'),
       1,
       0
WHERE NOT EXISTS (SELECT 1 FROM quizzes WHERE title = 'FSCE Exam English for Level 5 Paper 3 - Spelling and Vocabulary')
  AND NOT EXISTS (SELECT 1 FROM deleted_seed_quizzes WHERE title = 'FSCE Exam English for Level 5 Paper 3 - Spelling and Vocabulary');

UPDATE quizzes
SET description = 'A 100-question FSCE-style Level 5 English paper using statutory spelling words, with missing-word, spelling-choice, and synonym or meaning-clue questions.',
    stage_id = (SELECT id FROM stages WHERE name = 'Year 5'),
    lock_after_attempt = 1,
    is_archived = 0
WHERE title = 'FSCE Exam English for Level 5 Paper 3 - Spelling and Vocabulary';

DROP TABLE IF EXISTS seed_fsce_level5_english_paper3_id;
CREATE TEMP TABLE seed_fsce_level5_english_paper3_id(id INTEGER);
INSERT INTO seed_fsce_level5_english_paper3_id
SELECT id FROM quizzes WHERE title = 'FSCE Exam English for Level 5 Paper 3 - Spelling and Vocabulary' LIMIT 1;

DELETE FROM questions
WHERE quiz_id = (SELECT id FROM seed_fsce_level5_english_paper3_id);

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
VALUES
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Complete the missing word: The hotel can accomm__ate four families.', 'missing', 'accommodate', 'acommodate', 'accommodate', 'acommodatte', 'accomadate', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Choose the correct spelling.', 'spelling', 'accompany', 'acompony', 'accompany', 'acompany', 'accompanie', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Which word means "following what was said or written"?', 'synonym', 'according', 'available', 'according', 'apparent', 'average', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Complete the missing word: With practice, you can ach__ve your target.', 'missing', 'achieve', 'acheive', 'achieve', 'achive', 'acheeve', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Choose the correct spelling.', 'spelling', 'aggressive', 'agressive', 'aggressive', 'agresive', 'aggresive', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Which word means "not professional or not expert"?', 'synonym', 'amateur', 'average', 'amateur', 'ancient', 'apparent', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Complete the missing word: The museum displayed anc__nt coins.', 'missing', 'ancient', 'ancient', 'antient', 'ancent', 'anshient', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Choose the correct spelling.', 'spelling', 'apparent', 'apparant', 'apparent', 'aparent', 'apperent', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Which word means "to value or be grateful for"?', 'synonym', 'appreciate', 'achieve', 'appreciate', 'criticise', 'persuade', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Complete the missing word: The label was att__hed to the parcel.', 'missing', 'attached', 'attatched', 'attached', 'atached', 'attachd', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Choose the correct spelling.', 'spelling', 'available', 'availible', 'available', 'avaliable', 'availabl', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Which word means "usual or typical"?', 'synonym', 'average', 'awkward', 'average', 'available', 'ancient', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Complete the missing word: It was an awk__rd question to answer.', 'missing', 'awkward', 'awkward', 'akward', 'awkwud', 'awkwerd', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Choose the correct spelling.', 'spelling', 'bargain', 'bargin', 'bargain', 'bargen', 'bargein', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Which word means "a purple mark caused by injury"?', 'synonym', 'bruise', 'bruise', 'bargain', 'muscle', 'stomach', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Complete the missing word: Put each animal into the correct cat__ory.', 'missing', 'category', 'catagory', 'category', 'categery', 'catogory', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Choose the correct spelling.', 'spelling', 'cemetery', 'cemetary', 'cemetery', 'cemetry', 'semetery', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Which word means "a group chosen to make decisions"?', 'synonym', 'committee', 'community', 'committee', 'competition', 'government', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Complete the missing word: We can comm__icate by email.', 'missing', 'communicate', 'comunicate', 'communicate', 'communcate', 'communicait', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Choose the correct spelling.', 'spelling', 'community', 'comunity', 'community', 'communtiy', 'communitty', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Which word means "a contest or event where people try to win"?', 'synonym', 'competition', 'committee', 'competition', 'community', 'convenience', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Complete the missing word: His con__ience told him to be honest.', 'missing', 'conscience', 'concience', 'conscience', 'conscence', 'conshience', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Choose the correct spelling.', 'spelling', 'conscious', 'concious', 'conscious', 'consious', 'conscous', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Which word means "public disagreement or argument"?', 'synonym', 'controversy', 'convenience', 'controversy', 'correspond', 'conscience', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Complete the missing word: The shop is open late for your conv__ience.', 'missing', 'convenience', 'convinience', 'convenience', 'conveniance', 'convenence', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Choose the correct spelling.', 'spelling', 'correspond', 'corispond', 'correspond', 'correspound', 'corespond', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Which word means "to find fault with or judge negatively"?', 'synonym', 'criticise', 'appreciate', 'criticise', 'recommend', 'recognise', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Complete the missing word: The child''s cur__sity led her to open the box.', 'missing', 'curiosity', 'curiousity', 'curiosity', 'curiosty', 'curiosety', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Choose the correct spelling.', 'spelling', 'definite', 'definate', 'definite', 'defenite', 'definit', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Which word means "needing something very badly"?', 'synonym', 'desperate', 'definite', 'desperate', 'determined', 'disastrous', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Complete the missing word: She was det__mined to finish the race.', 'missing', 'determined', 'determind', 'determined', 'deturmined', 'determinied', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Choose the correct spelling.', 'spelling', 'develop', 'develope', 'develop', 'devellop', 'develup', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Which word means "a book that gives word meanings and spellings"?', 'synonym', 'dictionary', 'dictionary', 'language', 'programme', 'system', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Complete the missing word: The flood had dis__trous results.', 'missing', 'disastrous', 'disasterous', 'disastrous', 'disastress', 'disastrus', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Choose the correct spelling.', 'spelling', 'embarrass', 'embarass', 'embarrass', 'embaras', 'embarras', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Which word means "the natural world around us"?', 'synonym', 'environment', 'existence', 'environment', 'equipment', 'explanation', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Complete the missing word: The climbers were equ__ped with ropes.', 'missing', 'equipped', 'equiped', 'equipped', 'equipt', 'equippd', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Choose the correct spelling.', 'spelling', 'especially', 'especialy', 'especially', 'expecially', 'especialley', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Which word means "to make something seem larger or more important than it is"?', 'synonym', 'exaggerate', 'exaggerate', 'explain', 'develop', 'interrupt', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Complete the missing word: Her work was exc__lent.', 'missing', 'excellent', 'excelent', 'excellent', 'excellant', 'exelent', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Choose the correct spelling.', 'spelling', 'existence', 'existance', 'existence', 'exsistence', 'existense', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Which word means "a reason that makes something clear"?', 'synonym', 'explanation', 'explanation', 'exaggeration', 'existence', 'experience', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Complete the missing word: The route was fam__iar to the driver.', 'missing', 'familiar', 'familliar', 'familiar', 'familier', 'familar', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Choose the correct spelling.', 'spelling', 'foreign', 'foriegn', 'foreign', 'forign', 'forein', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Which word is the correct spelling of the number after thirty-nine?', 'synonym', 'forty', 'fourty', 'forty', 'fortey', 'fourtye', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Complete the missing word: We visit the library freq__ntly.', 'missing', 'frequently', 'frequentley', 'frequently', 'frequantly', 'freqently', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Choose the correct spelling.', 'spelling', 'government', 'goverment', 'government', 'govornment', 'governmant', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Which word means "a promise that something will happen or work"?', 'synonym', 'guarantee', 'guarantee', 'government', 'hindrance', 'identity', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Complete the missing word: It is wrong to har__s another pupil.', 'missing', 'harass', 'harrass', 'harass', 'haras', 'harras', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Choose the correct spelling.', 'spelling', 'hindrance', 'hinderance', 'hindrance', 'hindrence', 'hindrince', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Which word means "who or what a person is"?', 'synonym', 'identity', 'identity', 'individual', 'signature', 'symbol', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Complete the missing word: The teacher wanted an imm__iate answer.', 'missing', 'immediate', 'immediate', 'imediate', 'immediat', 'immeadiate', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Choose the correct spelling.', 'spelling', 'individual', 'individuel', 'individual', 'indivdual', 'indavidual', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Which word means "to get in the way of something"?', 'synonym', 'interfere', 'interrupt', 'interfere', 'communicate', 'correspond', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Complete the missing word: Please do not int__rupt the speaker.', 'missing', 'interrupt', 'interupt', 'interrupt', 'inturrupt', 'interrup', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Choose the correct spelling.', 'spelling', 'language', 'langauge', 'language', 'languge', 'langwage', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Which word means "free time for rest or enjoyment"?', 'synonym', 'leisure', 'language', 'leisure', 'lightning', 'neighbour', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Complete the missing word: A flash of light__ng lit the sky.', 'missing', 'lightning', 'lightening', 'lightning', 'litening', 'lighting', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Choose the correct spelling.', 'spelling', 'marvellous', 'marvelous', 'marvellous', 'marvulous', 'marvellus', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Which word means "playfully naughty or causing trouble"?', 'synonym', 'mischievous', 'mischievous', 'marvellous', 'aggressive', 'awkward', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Complete the missing word: A pulled mus__e can be painful.', 'missing', 'muscle', 'musle', 'muscle', 'mussel', 'muscel', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Choose the correct spelling.', 'spelling', 'necessary', 'neccessary', 'necessary', 'necesary', 'necessery', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Which word means "a person who lives near you"?', 'synonym', 'neighbour', 'neighbour', 'nuisance', 'secretary', 'soldier', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Complete the missing word: The loud noise was a nuis__ce.', 'missing', 'nuisance', 'nuisence', 'nuisance', 'nuissance', 'nuisanse', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Choose the correct spelling.', 'spelling', 'occupy', 'ocupy', 'occupy', 'ocuppy', 'occupie', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Which word means "to happen or take place"?', 'synonym', 'occur', 'occupy', 'occur', 'develop', 'achieve', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Complete the missing word: This is a great opp__tunity to learn.', 'missing', 'opportunity', 'oportunity', 'opportunity', 'oppertunity', 'opportunety', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Choose the correct spelling.', 'spelling', 'parliament', 'parliment', 'parliament', 'parliamant', 'parlement', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Which word means "to convince someone to do or believe something"?', 'synonym', 'persuade', 'persuade', 'criticise', 'interrupt', 'sacrifice', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Complete the missing word: Exercise improves phys__al strength.', 'missing', 'physical', 'phisical', 'physical', 'physicle', 'fysical', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Choose the correct spelling.', 'spelling', 'prejudice', 'predjudice', 'prejudice', 'prejudise', 'prejedice', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Which word means "a special right or advantage"?', 'synonym', 'privilege', 'privilege', 'profession', 'prejudice', 'opportunity', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Complete the missing word: Teaching is a respected prof__sion.', 'missing', 'profession', 'profesion', 'profession', 'proffession', 'professian', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Choose the correct spelling.', 'spelling', 'programme', 'program', 'programme', 'programne', 'programe', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Which word means "the way a word is spoken"?', 'synonym', 'pronunciation', 'pronunciation', 'profession', 'programme', 'punctuation', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Complete the missing word: We had to qu__e outside the theatre.', 'missing', 'queue', 'que', 'queue', 'cueue', 'qeue', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Choose the correct spelling.', 'spelling', 'recognise', 'recoginise', 'recognise', 'reconise', 'recognize', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Which word means "to suggest something as good or useful"?', 'synonym', 'recommend', 'recommend', 'recognise', 'relevant', 'correspond', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Complete the missing word: Only include rel__ant details in your answer.', 'missing', 'relevant', 'relevent', 'relevant', 'relavant', 'relevint', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Choose the correct spelling.', 'spelling', 'restaurant', 'restaraunt', 'restaurant', 'resturant', 'resteraunt', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Which word means "words that have the same ending sound"?', 'synonym', 'rhyme', 'rhythm', 'rhyme', 'symbol', 'system', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Complete the missing word: The drummer kept a steady rh__hm.', 'missing', 'rhythm', 'rythm', 'rhythm', 'rhythym', 'rhythem', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Choose the correct spelling.', 'spelling', 'sacrifice', 'sacrafice', 'sacrifice', 'sacrifise', 'sacrifce', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Which word means "a person who organises letters, appointments, or office work"?', 'synonym', 'secretary', 'secretary', 'soldier', 'committee', 'neighbour', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Complete the missing word: He carried the bag on his sh__lder.', 'missing', 'shoulder', 'sholder', 'shoulder', 'shouldar', 'shouder', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Choose the correct spelling.', 'spelling', 'signature', 'signiture', 'signature', 'signachure', 'signatuer', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Which word means "honest and genuine"?', 'synonym', 'sincere', 'sincere', 'sufficient', 'relevant', 'familiar', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Complete the missing word: The sol__er marched across the field.', 'missing', 'soldier', 'soldier', 'soljer', 'souldier', 'solder', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Choose the correct spelling.', 'spelling', 'stomach', 'stomache', 'stomach', 'stummach', 'stomack', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Which word means "enough for what is needed"?', 'synonym', 'sufficient', 'sincere', 'sufficient', 'necessary', 'available', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Complete the missing word: Can you sugg__t a better title?', 'missing', 'suggest', 'sugest', 'suggest', 'sujjest', 'suggust', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Choose the correct spelling.', 'spelling', 'symbol', 'symbal', 'symbol', 'simbol', 'symbel', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Which word means "an organised set of connected parts"?', 'synonym', 'system', 'symbol', 'system', 'category', 'programme', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Complete the missing word: The temp__ature dropped overnight.', 'missing', 'temperature', 'temprature', 'temperature', 'temperatuer', 'tempereture', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Choose the correct spelling.', 'spelling', 'thorough', 'thourough', 'thorough', 'thurough', 'thorogh', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Which word names the ordinal number after eleventh?', 'synonym', 'twelfth', 'twelth', 'twelfth', 'twelveth', 'twelf', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Complete the missing word: The shop sells a var__ty of fruit.', 'missing', 'variety', 'varity', 'variety', 'varietey', 'variaty', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Choose the correct spelling.', 'spelling', 'vegetable', 'vegtable', 'vegetable', 'vegetabel', 'vedgetable', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Which word means "a machine used for transport"?', 'synonym', 'vehicle', 'vehicle', 'yacht', 'queue', 'programme', 1),
((SELECT id FROM seed_fsce_level5_english_paper3_id), 'Complete the missing word: The ya__t sailed across the harbour.', 'missing', 'yacht', 'yact', 'yacht', 'yatch', 'yachet', 1);

DROP TABLE seed_fsce_level5_english_paper3_id;

COMMIT;
