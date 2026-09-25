BEGIN TRANSACTION;

INSERT OR IGNORE INTO stages (name, description)
VALUES ('Year 5', 'UK primary Year 5 students.');

INSERT INTO quizzes (title, description, created_by, stage_id, lock_after_attempt, is_archived)
SELECT 'FSCE Exam English for Level 5',
       'A 100-question FSCE-style English paper for Level 5 covering vocabulary, grammar, punctuation, cohesion, clauses, word families, and comprehension of sentence meaning.',
       1,
       (SELECT id FROM stages WHERE name = 'Year 5'),
       1,
       0
WHERE NOT EXISTS (SELECT 1 FROM quizzes WHERE title = 'FSCE Exam English for Level 5')
  AND NOT EXISTS (SELECT 1 FROM deleted_seed_quizzes WHERE title = 'FSCE Exam English for Level 5');

UPDATE quizzes
SET description = 'A 100-question FSCE-style English paper for Level 5 covering vocabulary, grammar, punctuation, cohesion, clauses, word families, and comprehension of sentence meaning.',
    stage_id = (SELECT id FROM stages WHERE name = 'Year 5'),
    lock_after_attempt = 1,
    is_archived = 0
WHERE title = 'FSCE Exam English for Level 5';

DROP TABLE IF EXISTS seed_fsce_level5_english_quiz_id;
CREATE TEMP TABLE seed_fsce_level5_english_quiz_id(id INTEGER);
INSERT INTO seed_fsce_level5_english_quiz_id
SELECT id FROM quizzes WHERE title = 'FSCE Exam English for Level 5' LIMIT 1;

DELETE FROM questions
WHERE quiz_id = (SELECT id FROM seed_fsce_level5_english_quiz_id);

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
VALUES
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Choose the sentence that uses the past tense correctly.', 'meaning', 'Yesterday, Maya carried the heavy box upstairs.', 'Yesterday, Maya carries the heavy box upstairs.', 'Yesterday, Maya carried the heavy box upstairs.', 'Yesterday, Maya carry the heavy box upstairs.', 'Yesterday, Maya is carrying the heavy box upstairs.', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Choose the sentence that uses the present tense correctly.', 'meaning', 'Every morning, the gardener waters the roses.', 'Every morning, the gardener watered the roses.', 'Every morning, the gardener waters the roses.', 'Every morning, the gardener watering the roses.', 'Every morning, the gardener water the roses.', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which sentence keeps the tense consistent?', 'meaning', 'Lena opened the gate and walked into the garden.', 'Lena opens the gate and walked into the garden.', 'Lena opened the gate and walks into the garden.', 'Lena opened the gate and walked into the garden.', 'Lena opening the gate and walked into the garden.', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which sentence changes tense incorrectly?', 'meaning', 'Tom ran to the shop and buys some milk.', 'Tom ran to the shop and bought some milk.', 'Tom runs to the shop and buys some milk.', 'Tom was running to the shop when it rained.', 'Tom ran to the shop and buys some milk.', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Choose the best verb form: Last week, the pupils ___ a letter to the author.', 'meaning', 'wrote', 'write', 'wrote', 'writes', 'writing', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Choose the best verb form: Each Friday, the class ___ a chapter from the novel.', 'meaning', 'reads', 'readed', 'reads', 'reading', 'were read', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which sentence shows a completed action in the past?', 'meaning', 'The boat reached the harbour before sunset.', 'The boat reaches the harbour before sunset.', 'The boat is reaching the harbour before sunset.', 'The boat reached the harbour before sunset.', 'The boat will reach the harbour before sunset.', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which sentence shows a regular present action?', 'meaning', 'The train arrives at eight oclock every day.', 'The train arrived at eight oclock yesterday.', 'The train was arriving at eight oclock.', 'The train arrives at eight oclock every day.', 'The train will arrive at eight oclock tomorrow.', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Choose the sentence with a clear time reference.', 'meaning', 'Yesterday, the team practised carefully.', 'Yesterday, the team practise carefully.', 'Tomorrow, the team practised carefully.', 'Yesterday, the team practised carefully.', 'Every day, the team practised carefully.', 1),

((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which sentence uses the past progressive form?', 'meaning', 'She was reading when the bell rang.', 'She reads when the bell rang.', 'She was reading when the bell rang.', 'She read when the bell rings.', 'She has read when the bell rang.', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which sentence uses the present progressive form?', 'meaning', 'The children are building a model castle.', 'The children build a model castle.', 'The children built a model castle.', 'The children are building a model castle.', 'The children have built a model castle.', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Choose the progressive form: At noon, the horses ___ across the field.', 'meaning', 'were galloping', 'galloped', 'were galloping', 'gallop', 'will gallop', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'What does the progressive form show in this sentence? The rain was falling heavily.', 'meaning', 'An action was continuing over time.', 'The action never happened.', 'An action was continuing over time.', 'The action will happen later.', 'The action happened instantly.', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which sentence suggests the action is happening now?', 'meaning', 'The chef is stirring the soup.', 'The chef stirred the soup.', 'The chef stirs the soup every day.', 'The chef is stirring the soup.', 'The chef had stirred the soup.', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Choose the sentence that emphasises duration.', 'meaning', 'The runner was climbing the steep hill.', 'The runner climbed the steep hill.', 'The runner climbs the steep hill.', 'The runner was climbing the steep hill.', 'The runner will climb the steep hill.', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which sentence is not progressive?', 'meaning', 'The birds flew over the lake.', 'The birds were flying over the lake.', 'The birds are flying over the lake.', 'The birds flew over the lake.', 'The birds had been flying over the lake.', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Choose the correct form: I ___ my homework when Dad called me.', 'meaning', 'was finishing', 'finish', 'was finishing', 'am finish', 'finisheding', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which sentence uses the past progressive correctly?', 'meaning', 'They were waiting outside the museum.', 'They was waiting outside the museum.', 'They were waiting outside the museum.', 'They are waited outside the museum.', 'They waiting outside the museum.', 1),

((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which word is closest in meaning to "cautious"?', 'synonym', 'careful', 'careless', 'careful', 'furious', 'swift', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which word is closest in meaning to "ancient"?', 'synonym', 'very old', 'very old', 'modern', 'fragile', 'ordinary', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which word is closest in meaning to "reluctant"?', 'synonym', 'unwilling', 'eager', 'unwilling', 'certain', 'cheerful', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which word is closest in meaning to "enormous"?', 'synonym', 'huge', 'tiny', 'simple', 'huge', 'quiet', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which word is closest in meaning to "scarce"?', 'synonym', 'rare', 'common', 'rare', 'bright', 'wide', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which word is opposite in meaning to "timid"?', 'antonym', 'confident', 'nervous', 'shy', 'confident', 'silent', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which word is opposite in meaning to "rapid"?', 'antonym', 'slow', 'quick', 'sudden', 'slow', 'brief', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which word is opposite in meaning to "furious"?', 'antonym', 'calm', 'angry', 'calm', 'fierce', 'annoyed', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which word is opposite in meaning to "precious"?', 'antonym', 'worthless', 'valuable', 'rare', 'worthless', 'special', 1),

((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Choose the sentence with correctly punctuated direct speech.', 'meaning', 'Amir said, "I have finished the puzzle."', 'Amir said "I have finished the puzzle".', 'Amir said, "I have finished the puzzle."', '"Amir said, I have finished the puzzle."', 'Amir said, I have finished the puzzle."', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Where should the comma go? After the game we walked home.', 'meaning', 'After the game, we walked home.', 'After, the game we walked home.', 'After the game, we walked home.', 'After the, game we walked home.', 'After the game we, walked home.', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Choose the correctly punctuated sentence.', 'meaning', '"Be careful," warned Mum.', '"Be careful" warned Mum.', '"Be careful," warned Mum.', '"Be careful, warned Mum."', 'Be careful," warned Mum.', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which sentence uses a comma after a fronted adverbial?', 'meaning', 'Before sunrise, the fishermen prepared their nets.', 'Before sunrise the fishermen prepared their nets.', 'Before, sunrise the fishermen prepared their nets.', 'Before sunrise, the fishermen prepared their nets.', 'The fishermen, prepared their nets before sunrise.', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Choose the sentence with the question mark in the correct place.', 'meaning', '"Are you coming?" asked Nisha.', '"Are you coming"? asked Nisha.', '"Are you coming?" asked Nisha.', '"Are you coming", asked Nisha?', 'Are you coming?" asked Nisha.', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Choose the sentence that uses an exclamation mark appropriately.', 'meaning', '"Watch out!" shouted the lifeguard.', '"Watch out." shouted the lifeguard.', '"Watch out!" shouted the lifeguard.', '"Watch out", shouted the lifeguard!', 'Watch out!" shouted the lifeguard.', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which sentence needs a comma after the introductory phrase?', 'meaning', 'In the distance, a church bell rang.', 'In the distance a church bell rang.', 'In the distance, a church bell rang.', 'In, the distance a church bell rang.', 'A church bell, rang in the distance.', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Choose the correctly punctuated speech sentence.', 'meaning', '"I cannot find my torch," whispered Ella.', '"I cannot find my torch" whispered Ella.', '"I cannot find my torch," whispered Ella.', '"I cannot find my torch, whispered Ella."', 'I cannot find my torch," whispered Ella.', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which punctuation shows the exact words spoken?', 'meaning', 'inverted commas', 'apostrophes', 'inverted commas', 'brackets', 'hyphens', 1),

((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Choose the correct possessive form: The book belonging to one girl is ___.', 'meaning', 'the girl''s book', 'the girls book', 'the girl''s book', 'the girls'' book', 'the girl book''s', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Choose the correct possessive form: The coats belonging to several boys are ___.', 'meaning', 'the boys'' coats', 'the boy''s coats', 'the boys'' coats', 'the boys coats''', 'the boy coats', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which sentence uses an apostrophe for contraction?', 'meaning', 'I can''t open the window.', 'The cat''s bowl is empty.', 'I can''t open the window.', 'The girls'' team won.', 'The teacher''s desk is tidy.', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which sentence uses an apostrophe for possession?', 'meaning', 'The dragon''s scales glittered.', 'It''s raining heavily.', 'The dragon''s scales glittered.', 'They''re arriving soon.', 'We''ll leave early.', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Choose the correct sentence.', 'meaning', 'The children''s playground was busy.', 'The childrens playground was busy.', 'The children''s playground was busy.', 'The childrens'' playground was busy.', 'The children playground''s was busy.', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which sentence is incorrect?', 'meaning', 'The apple''s were fresh.', 'The apples were fresh.', 'The apple''s skin was red.', 'The apple''s were fresh.', 'The girls'' bags were heavy.', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'What does "the teacher''s pen" mean?', 'meaning', 'one teacher owns the pen', 'several teachers own the pen', 'one teacher owns the pen', 'the pen owns the teacher', 'there is more than one pen', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'What does "the teachers'' room" mean?', 'meaning', 'a room for more than one teacher', 'a room for more than one teacher', 'one teacher owns a room', 'the room owns the teachers', 'there is only one teacher', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Choose the correct plural without an apostrophe.', 'meaning', 'The dogs chased the ball.', 'The dog''s chased the ball.', 'The dogs chased the ball.', 'The dogs'' chased the ball.', 'The doges'' chased the ball.', 1),

((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which sentence is linked with an adverbial of time?', 'meaning', 'Later, we explored the castle ruins.', 'Beside the river, we ate lunch.', 'Later, we explored the castle ruins.', 'Because of the rain, we stayed inside.', 'With great care, we opened the box.', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which word best links these events? We packed our bags. ___, we boarded the coach.', 'meaning', 'Then', 'However', 'Then', 'Although', 'Because', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which sentence uses a pronoun to avoid repetition?', 'meaning', 'Sofia picked up the shell and placed it in her pocket.', 'Sofia picked up the shell and placed the shell in Sofia''s pocket.', 'Sofia picked up the shell and placed it in her pocket.', 'The shell picked up Sofia and placed it in her pocket.', 'Sofia picked up Sofia and placed the shell in the shell.', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which pronoun best completes the sentence? Marcus forgot his lunch, so ___ borrowed a sandwich.', 'meaning', 'he', 'she', 'they', 'he', 'it', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which sentence is most cohesive?', 'meaning', 'The storm grew stronger. Therefore, the sailors returned to harbour.', 'The storm grew stronger. Blue pencils are useful.', 'The storm grew stronger. Therefore, the sailors returned to harbour.', 'The storm grew stronger. Apples were sweet.', 'The storm grew stronger. Yesterday sings loudly.', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which connective shows cause?', 'meaning', 'because', 'next', 'nearby', 'because', 'finally', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Choose the best linking phrase: ___, the explorers reached the summit.', 'meaning', 'After a long climb', 'Under the blue table', 'After a long climb', 'With a loud pencil', 'Because of tomorrow', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which sentence should begin a new paragraph?', 'meaning', 'A sentence that introduces a new place, time, speaker, or idea.', 'A sentence that repeats the same detail.', 'A sentence that introduces a new place, time, speaker, or idea.', 'A sentence with the shortest word.', 'Any sentence after a comma.', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which adverbial links ideas by number?', 'meaning', 'Secondly', 'Nearby', 'Suddenly', 'Secondly', 'Because', 1),

((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which is the expanded noun phrase?', 'meaning', 'the narrow wooden bridge over the stream', 'bridge', 'the bridge', 'the narrow wooden bridge over the stream', 'over the stream', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which sentence contains an expanded noun phrase?', 'meaning', 'The tiny silver key on the hook opened the chest.', 'The key opened it.', 'The tiny silver key on the hook opened the chest.', 'The key was there.', 'It opened quickly.', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which words expand the noun in this phrase: the cracked vase beside the fireplace?', 'meaning', 'cracked and beside the fireplace', 'the and vase', 'cracked and beside the fireplace', 'vase and fireplace', 'beside and the', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Choose the most detailed noun phrase.', 'meaning', 'the enormous oak tree with twisted branches', 'tree', 'the tree', 'the enormous oak tree with twisted branches', 'the enormous', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'What is the head noun in "the small, fluffy puppy with a red collar"?', 'meaning', 'puppy', 'small', 'fluffy', 'puppy', 'collar', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which phrase includes a prepositional phrase?', 'meaning', 'the painting above the fireplace', 'the colourful painting', 'the painting above the fireplace', 'the painting glowed', 'the beautiful painting', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'What is the purpose of an expanded noun phrase?', 'meaning', 'to add precise detail about a noun', 'to replace every verb', 'to add precise detail about a noun', 'to end a paragraph', 'to make a sentence a question', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which option best expands "the cave"?', 'meaning', 'the dark cave beneath the cliffs', 'the cave', 'the dark cave beneath the cliffs', 'cave dark beneath', 'the beneath cave dark', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which sentence gives the clearest image?', 'meaning', 'A fierce wind rattled the broken windows of the empty house.', 'A wind moved things.', 'A fierce wind rattled the broken windows of the empty house.', 'The house was there.', 'Windows happened loudly.', 1),

((SELECT id FROM seed_fsce_level5_english_quiz_id), 'What does the prefix "dis-" usually mean in "disagree"?', 'meaning', 'not or opposite of', 'again', 'not or opposite of', 'before', 'too much', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'What does the prefix "re-" mean in "rewrite"?', 'meaning', 'again', 'against', 'again', 'not', 'below', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'What does the prefix "mis-" mean in "misunderstand"?', 'meaning', 'wrongly', 'wrongly', 'very', 'after', 'together', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'What does the prefix "over-" mean in "overcook"?', 'meaning', 'too much', 'again', 'not', 'too much', 'under', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'What does the prefix "anti-" mean in "antibacterial"?', 'meaning', 'against', 'before', 'against', 'again', 'self', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which word means to make something modern?', 'meaning', 'modernise', 'modernise', 'modernful', 'modernless', 'modernment', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which word means to make something simple?', 'meaning', 'simplify', 'simplement', 'simplify', 'simpleless', 'simplehood', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which word means to make something active?', 'meaning', 'activate', 'activeful', 'activate', 'activeless', 'activement', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which word has a prefix?', 'meaning', 'superhuman', 'running', 'kindness', 'superhuman', 'careful', 1),

((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Identify the relative clause: The girl who won the race smiled proudly.', 'meaning', 'who won the race', 'The girl', 'who won the race', 'smiled proudly', 'won the race smiled', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which sentence contains a relative clause?', 'meaning', 'The museum, which opened last year, is popular.', 'The museum is popular.', 'The museum, which opened last year, is popular.', 'The museum opened.', 'The popular museum opened.', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Choose the correct relative pronoun: The author ___ wrote this book lives nearby.', 'meaning', 'who', 'which', 'where', 'who', 'when', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Choose the correct relative pronoun: This is the village ___ my grandmother was born.', 'meaning', 'where', 'who', 'where', 'whose', 'which', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which relative clause adds detail about a thing?', 'meaning', 'which had a golden handle', 'who had a golden handle', 'which had a golden handle', 'where had a golden handle', 'when had a golden handle', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Choose the sentence that correctly uses "whose".', 'meaning', 'The boy whose bike was stolen called the police.', 'The boy whose bike was stolen called the police.', 'The boy which bike was stolen called the police.', 'The boy where bike was stolen called the police.', 'The boy when bike was stolen called the police.', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'What is the purpose of a relative clause?', 'meaning', 'to add extra information about a noun', 'to replace all punctuation', 'to add extra information about a noun', 'to make every verb past tense', 'to show only possession', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which sentence uses a relative clause beginning with "that"?', 'meaning', 'The cake that won first prize tasted delicious.', 'The cake tasted delicious.', 'That cake tasted delicious.', 'The cake that won first prize tasted delicious.', 'The cake won first prize and tasted delicious.', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Choose the correct completion: The park, ___ we played yesterday, is closed today.', 'meaning', 'where', 'who', 'where', 'whose', 'when', 1),

((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which modal verb shows possibility?', 'meaning', 'might', 'must', 'might', 'will', 'shall', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which modal verb shows obligation?', 'meaning', 'must', 'might', 'could', 'must', 'may', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Choose the sentence showing uncertainty.', 'meaning', 'The parcel might arrive today.', 'The parcel must arrive today.', 'The parcel might arrive today.', 'The parcel arrived today.', 'The parcel arrives daily.', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Choose the sentence showing certainty.', 'meaning', 'She will finish the race.', 'She might finish the race.', 'She could finish the race.', 'She will finish the race.', 'She may finish the race.', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which adverb shows probability?', 'meaning', 'probably', 'silently', 'probably', 'nearby', 'yesterday', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Choose the best modal verb: You ___ wear a helmet when cycling.', 'meaning', 'must', 'might', 'must', 'could', 'may', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which sentence uses an adverb to show possibility?', 'meaning', 'Perhaps the match will be cancelled.', 'Quickly, the match began.', 'Perhaps the match will be cancelled.', 'Outside, the match began.', 'Yesterday, the match ended.', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'What does "could" suggest in "We could visit the library after school"?', 'meaning', 'a possibility', 'a command', 'a possibility', 'a completed action', 'a definite fact', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Which sentence shows advice rather than certainty?', 'meaning', 'You should check your answers.', 'You will check your answers.', 'You checked your answers.', 'You should check your answers.', 'You are checking your answers.', 1),

((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Choose the correct homophone: Please put your coat over ___.', 'meaning', 'there', 'their', 'there', 'they''re', 'theirs', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Choose the correct homophone: ___ going to the theatre tonight.', 'meaning', 'They''re', 'There', 'Their', 'They''re', 'Theirs', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Choose the correct homophone: The children packed ___ lunches.', 'meaning', 'their', 'there', 'their', 'they''re', 'theirs', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Choose the correct word: I can ___ the music from here.', 'meaning', 'hear', 'here', 'hear', 'hair', 'hare', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Choose the correct word: We waited ___ for the bus.', 'meaning', 'here', 'hear', 'here', 'hair', 'hare', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Choose the correct word: The knight rode through the forest at ___.', 'meaning', 'night', 'knight', 'night', 'nigh', 'light', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Choose the correct word: The ___ wore shining armour.', 'meaning', 'knight', 'night', 'knight', 'nigh', 'light', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Choose the correct word: The dog wagged ___ tail.', 'meaning', 'its', 'it''s', 'its', 'its''', 'it', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Choose the correct word: ___ time to leave.', 'meaning', 'It''s', 'Its', 'It''s', 'Its''', 'It', 1),
((SELECT id FROM seed_fsce_level5_english_quiz_id), 'Choose the correct sentence.', 'meaning', 'They''re putting their bags over there.', 'Their putting there bags over they''re.', 'There putting their bags over they''re.', 'They''re putting their bags over there.', 'Theyre putting there bags over their.', 1);

DROP TABLE seed_fsce_level5_english_quiz_id;

COMMIT;
