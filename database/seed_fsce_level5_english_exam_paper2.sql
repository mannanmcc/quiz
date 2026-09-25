BEGIN TRANSACTION;

INSERT OR IGNORE INTO stages (name, description)
VALUES ('Year 5', 'UK primary Year 5 students.');

INSERT INTO quizzes (title, description, created_by, stage_id, lock_after_attempt, is_archived)
SELECT 'FSCE Exam English for Level 5 Paper 2',
       'A second 100-question FSCE-style English paper for Level 5 covering vocabulary, grammar, punctuation, cohesion, clauses, word families, and comprehension of sentence meaning.',
       1,
       (SELECT id FROM stages WHERE name = 'Year 5'),
       1,
       0
WHERE NOT EXISTS (SELECT 1 FROM quizzes WHERE title = 'FSCE Exam English for Level 5 Paper 2')
  AND NOT EXISTS (SELECT 1 FROM deleted_seed_quizzes WHERE title = 'FSCE Exam English for Level 5 Paper 2');

UPDATE quizzes
SET description = 'A second 100-question FSCE-style English paper for Level 5 covering vocabulary, grammar, punctuation, cohesion, clauses, word families, and comprehension of sentence meaning.',
    stage_id = (SELECT id FROM stages WHERE name = 'Year 5'),
    lock_after_attempt = 1,
    is_archived = 0
WHERE title = 'FSCE Exam English for Level 5 Paper 2';

DROP TABLE IF EXISTS seed_fsce_level5_english_paper2_id;
CREATE TEMP TABLE seed_fsce_level5_english_paper2_id(id INTEGER);
INSERT INTO seed_fsce_level5_english_paper2_id
SELECT id FROM quizzes WHERE title = 'FSCE Exam English for Level 5 Paper 2' LIMIT 1;

DELETE FROM questions
WHERE quiz_id = (SELECT id FROM seed_fsce_level5_english_paper2_id);

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
VALUES
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Choose the sentence written in the past tense.', 'meaning', 'The explorer discovered a hidden cave.', 'The explorer discovers a hidden cave.', 'The explorer discovered a hidden cave.', 'The explorer is discovering a hidden cave.', 'The explorer will discover a hidden cave.', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Choose the sentence written in the present tense.', 'meaning', 'The river flows through the valley.', 'The river flowed through the valley.', 'The river flows through the valley.', 'The river was flowing through the valley.', 'The river will flow through the valley.', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which sentence keeps the tense consistent?', 'meaning', 'Aisha packed her bag and caught the bus.', 'Aisha packs her bag and caught the bus.', 'Aisha packed her bag and catches the bus.', 'Aisha packed her bag and caught the bus.', 'Aisha packing her bag and caught the bus.', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which sentence changes tense incorrectly?', 'meaning', 'Ben opened the window and looks outside.', 'Ben opened the window and looked outside.', 'Ben opens the window and looks outside.', 'Ben was opening the window.', 'Ben opened the window and looks outside.', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Choose the best verb form: Yesterday, the choir ___ beautifully.', 'meaning', 'sang', 'sing', 'sang', 'sings', 'singing', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Choose the best verb form: Every evening, Noor ___ her reading book.', 'meaning', 'opens', 'opened', 'opens', 'opening', 'was open', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which sentence shows a future action?', 'meaning', 'The class will visit the science museum tomorrow.', 'The class visited the science museum yesterday.', 'The class visits the science museum weekly.', 'The class will visit the science museum tomorrow.', 'The class was visiting the science museum.', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which sentence uses a clear past-time phrase?', 'meaning', 'Last night, the wind rattled the windows.', 'Last night, the wind rattles the windows.', 'Tomorrow, the wind rattled the windows.', 'Last night, the wind rattled the windows.', 'Every night, the wind rattled the windows.', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Choose the correct verb: The children ___ quietly when the visitor entered.', 'meaning', 'were working', 'work', 'were working', 'works', 'working', 1),

((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which sentence uses the present progressive?', 'meaning', 'The baker is kneading the dough.', 'The baker kneads the dough.', 'The baker kneaded the dough.', 'The baker is kneading the dough.', 'The baker will knead the dough.', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which sentence uses the past progressive?', 'meaning', 'The fox was creeping through the grass.', 'The fox creeps through the grass.', 'The fox was creeping through the grass.', 'The fox crept through the grass.', 'The fox will creep through the grass.', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'What does the progressive form show in "The candle was flickering"?', 'meaning', 'The action continued for a time.', 'The action never happened.', 'The action continued for a time.', 'The action will happen later.', 'The action is a command.', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Choose the progressive form: The pupils ___ notes during the lesson.', 'meaning', 'were taking', 'took', 'were taking', 'take', 'taken', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which sentence shows an action happening now?', 'meaning', 'The mechanic is repairing the bicycle.', 'The mechanic repaired the bicycle.', 'The mechanic repairs bicycles.', 'The mechanic is repairing the bicycle.', 'The mechanic has repaired the bicycle.', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which sentence is not progressive?', 'meaning', 'The kite soared above the beach.', 'The kite was soaring above the beach.', 'The kite is soaring above the beach.', 'The kite soared above the beach.', 'The kite had been soaring above the beach.', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Choose the correct form: We ___ dinner when the phone rang.', 'meaning', 'were eating', 'eat', 'were eating', 'are eat', 'eated', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which sentence uses the past progressive correctly?', 'meaning', 'I was searching for my glasses.', 'I were searching for my glasses.', 'I was searching for my glasses.', 'I am searched for my glasses.', 'I searching for my glasses.', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which sentence contrasts a longer action with a sudden event?', 'meaning', 'They were painting when the rain began.', 'They painted when the rain was beginning.', 'They were painting when the rain began.', 'They paint when the rain began.', 'They had paint when the rain began.', 1),

((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which word is closest in meaning to "perplexed"?', 'synonym', 'confused', 'confused', 'certain', 'angry', 'careless', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which word is closest in meaning to "tranquil"?', 'synonym', 'peaceful', 'noisy', 'peaceful', 'rapid', 'ordinary', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which word is closest in meaning to "fortunate"?', 'synonym', 'lucky', 'lucky', 'lonely', 'nervous', 'tired', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which word is closest in meaning to "vivid"?', 'synonym', 'bright and clear', 'dull and faint', 'bright and clear', 'very old', 'hard to hear', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which word is closest in meaning to "fragile"?', 'synonym', 'easily broken', 'very strong', 'easily broken', 'very brave', 'very loud', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which word is opposite in meaning to "generous"?', 'antonym', 'selfish', 'kind', 'selfish', 'helpful', 'thoughtful', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which word is opposite in meaning to "expand"?', 'antonym', 'shrink', 'grow', 'widen', 'shrink', 'increase', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which word is opposite in meaning to "gloomy"?', 'antonym', 'cheerful', 'dark', 'sad', 'cheerful', 'dull', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which word is opposite in meaning to "scarce"?', 'antonym', 'plentiful', 'rare', 'limited', 'plentiful', 'missing', 1),

((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Choose the sentence with correctly punctuated direct speech.', 'meaning', 'Lily asked, "Where is my notebook?"', 'Lily asked "Where is my notebook"?', 'Lily asked, "Where is my notebook?"', '"Lily asked, Where is my notebook?"', 'Lily asked, Where is my notebook?', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Where should the comma go? After the storm the streets were flooded.', 'meaning', 'After the storm, the streets were flooded.', 'After, the storm the streets were flooded.', 'After the storm, the streets were flooded.', 'After the, storm the streets were flooded.', 'After the storm the, streets were flooded.', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Choose the correctly punctuated sentence.', 'meaning', '"Please wait," said the librarian.', '"Please wait" said the librarian.', '"Please wait," said the librarian.', '"Please wait, said the librarian."', 'Please wait," said the librarian.', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which sentence uses a comma after a fronted adverbial?', 'meaning', 'Without warning, the alarm began to ring.', 'Without warning the alarm began to ring.', 'Without, warning the alarm began to ring.', 'Without warning, the alarm began to ring.', 'The alarm, began to ring without warning.', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Choose the sentence with correctly punctuated speech.', 'meaning', '"I have lost my ticket," muttered Sam.', '"I have lost my ticket" muttered Sam.', '"I have lost my ticket," muttered Sam.', '"I have lost my ticket, muttered Sam."', 'I have lost my ticket," muttered Sam.', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which sentence uses an exclamation mark appropriately?', 'meaning', '"Stop!" yelled the coach.', '"Stop." yelled the coach.', '"Stop!" yelled the coach.', '"Stop", yelled the coach!', 'Stop!" yelled the coach.', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which sentence needs a comma after the introductory phrase?', 'meaning', 'At the edge of the forest, a path disappeared.', 'At the edge of the forest a path disappeared.', 'At the edge of the forest, a path disappeared.', 'At, the edge of the forest a path disappeared.', 'A path, disappeared at the edge of the forest.', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which punctuation marks direct speech?', 'meaning', 'inverted commas', 'commas', 'apostrophes', 'inverted commas', 'colons', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Choose the sentence with the comma in the correct place.', 'meaning', 'During the performance, the audience remained silent.', 'During, the performance the audience remained silent.', 'During the performance, the audience remained silent.', 'During the, performance the audience remained silent.', 'The audience, remained silent during the performance.', 1),

((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Choose the correct possessive form: the bag belonging to one boy.', 'meaning', 'the boy''s bag', 'the boys bag', 'the boy''s bag', 'the boys'' bag', 'the boy bag''s', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Choose the correct possessive form: the classroom used by several teachers.', 'meaning', 'the teachers'' classroom', 'the teacher''s classroom', 'the teachers'' classroom', 'the teachers classroom''', 'the teacher classroom', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which sentence uses an apostrophe for contraction?', 'meaning', 'They''ll arrive before lunch.', 'The bird''s nest fell.', 'They''ll arrive before lunch.', 'The boys'' shoes were muddy.', 'The captain''s hat blew away.', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which sentence uses an apostrophe for possession?', 'meaning', 'The sailor''s compass was broken.', 'We''re leaving early.', 'The sailor''s compass was broken.', 'I''m ready now.', 'They''ve gone home.', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Choose the correct sentence.', 'meaning', 'The women''s coats were hanging by the door.', 'The womens coats were hanging by the door.', 'The women''s coats were hanging by the door.', 'The womens'' coats were hanging by the door.', 'The women coats'' were hanging by the door.', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which sentence is incorrect?', 'meaning', 'The carrot''s were chopped finely.', 'The carrots were chopped finely.', 'The rabbit''s ears twitched.', 'The carrot''s were chopped finely.', 'The players'' boots were wet.', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'What does "the pilots'' lounge" mean?', 'meaning', 'a lounge for more than one pilot', 'one pilot owns the lounge', 'a lounge for more than one pilot', 'the lounge owns the pilots', 'there is one pilot only', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Choose the correct plural without an apostrophe.', 'meaning', 'The lamps flickered in the hall.', 'The lamp''s flickered in the hall.', 'The lamps flickered in the hall.', 'The lamps'' flickered in the hall.', 'The lampes'' flickered in the hall.', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Choose the correct possessive phrase for one woman.', 'meaning', 'the woman''s scarf', 'the womans scarf', 'the woman''s scarf', 'the womans'' scarf', 'the women''s scarf', 1),

((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which word best links these events? We checked the map. ___, we followed the path.', 'meaning', 'Next', 'Although', 'Next', 'Because', 'However', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which sentence uses a pronoun to avoid repetition?', 'meaning', 'Omar found the coin and placed it on the table.', 'Omar found the coin and placed the coin on Omar''s table.', 'Omar found the coin and placed it on the table.', 'The coin found Omar and placed it on the table.', 'Omar found Omar and placed the table on it.', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which pronoun best completes the sentence? Priya missed the train, so ___ waited for the next one.', 'meaning', 'she', 'he', 'they', 'she', 'it', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which connective shows cause?', 'meaning', 'since', 'next', 'nearby', 'since', 'finally', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which sentence is most cohesive?', 'meaning', 'The bridge was unsafe. Therefore, the walkers used another route.', 'The bridge was unsafe. The apple was green.', 'The bridge was unsafe. Therefore, the walkers used another route.', 'The bridge was unsafe. Pencils are sharp.', 'The bridge was unsafe. Tomorrow sang loudly.', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which adverbial links ideas by time?', 'meaning', 'Afterwards', 'Beneath', 'Afterwards', 'Because', 'Secondly', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which adverbial links ideas by place?', 'meaning', 'Nearby', 'Finally', 'Nearby', 'Therefore', 'Firstly', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'When should a new paragraph usually begin?', 'meaning', 'when the time, place, speaker, or main idea changes', 'after every comma', 'when the time, place, speaker, or main idea changes', 'after every adjective', 'only at the end of a story', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Choose the best linking phrase: ___, the team celebrated their success.', 'meaning', 'After the final whistle', 'Under the quiet pencil', 'After the final whistle', 'Because of yesterdayly', 'With the purple idea', 1),

((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which is the expanded noun phrase?', 'meaning', 'the dusty leather suitcase beneath the bed', 'suitcase', 'the suitcase', 'the dusty leather suitcase beneath the bed', 'beneath the bed', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which sentence contains an expanded noun phrase?', 'meaning', 'The silver watch with a cracked face lay on the desk.', 'The watch ticked.', 'The silver watch with a cracked face lay on the desk.', 'The watch was useful.', 'It ticked loudly.', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'What is the head noun in "the tall stone tower on the hill"?', 'meaning', 'tower', 'tall', 'stone', 'tower', 'hill', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which option best expands "the boat"?', 'meaning', 'the narrow fishing boat beside the jetty', 'the boat', 'the narrow fishing boat beside the jetty', 'boat narrow beside', 'the beside boat narrow', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which phrase includes a prepositional phrase?', 'meaning', 'the mirror behind the curtain', 'the shining mirror', 'the mirror behind the curtain', 'the mirror gleamed', 'the delicate mirror', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'What is the purpose of an expanded noun phrase?', 'meaning', 'to add detail and precision about a noun', 'to replace the main verb', 'to add detail and precision about a noun', 'to join two paragraphs', 'to create direct speech', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which sentence gives the clearest image?', 'meaning', 'The narrow path wound between the frosted hedges.', 'The path was there.', 'The narrow path wound between the frosted hedges.', 'A thing went outside.', 'Hedges happened near it.', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which word is an adjective in "the golden crown inside the chest"?', 'meaning', 'golden', 'crown', 'inside', 'chest', 'golden', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which words expand the noun in "the restless sea beyond the harbour"?', 'meaning', 'restless and beyond the harbour', 'the and sea', 'restless and beyond the harbour', 'sea and harbour', 'beyond and the', 1),

((SELECT id FROM seed_fsce_level5_english_paper2_id), 'What does the prefix "de-" often mean in "defrost"?', 'meaning', 'remove or reverse', 'again', 'remove or reverse', 'before', 'too much', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'What does the prefix "auto-" mean in "autobiography"?', 'meaning', 'self', 'against', 'self', 'not', 'below', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'What does the prefix "super-" mean in "superhuman"?', 'meaning', 'above or beyond', 'wrongly', 'very small', 'after', 'above or beyond', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'What does the prefix "re-" mean in "rebuild"?', 'meaning', 'again', 'again', 'not', 'too much', 'under', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'What does the prefix "mis-" mean in "misplace"?', 'meaning', 'wrongly', 'before', 'wrongly', 'against', 'self', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which word means to make something pure?', 'meaning', 'purify', 'pureful', 'purify', 'pureless', 'purement', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which word means to make something legal?', 'meaning', 'legalise', 'legalise', 'legalful', 'legalless', 'legalment', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which word means to make something equal?', 'meaning', 'equalise', 'equalment', 'equalise', 'equalless', 'equalhood', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which word has a prefix?', 'meaning', 'antifreeze', 'kindness', 'running', 'antifreeze', 'careful', 1),

((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Identify the relative clause: The painting that hung in the hall was famous.', 'meaning', 'that hung in the hall', 'The painting', 'that hung in the hall', 'was famous', 'hung in the hall was', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which sentence contains a relative clause?', 'meaning', 'The athlete, who trained daily, won the race.', 'The athlete won the race.', 'The athlete, who trained daily, won the race.', 'The athlete trained daily.', 'The daily athlete won.', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Choose the correct relative pronoun: The jacket ___ I bought yesterday is too small.', 'meaning', 'that', 'who', 'where', 'that', 'when', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Choose the correct relative pronoun: This is the day ___ we met our new teacher.', 'meaning', 'when', 'who', 'where', 'whose', 'when', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which relative clause adds detail about a person?', 'meaning', 'who rescued the dog', 'which rescued the dog', 'who rescued the dog', 'where rescued the dog', 'when rescued the dog', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Choose the sentence that correctly uses "whose".', 'meaning', 'The author whose novel won the prize thanked her family.', 'The author whose novel won the prize thanked her family.', 'The author which novel won the prize thanked her family.', 'The author where novel won the prize thanked her family.', 'The author when novel won the prize thanked her family.', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'What is the purpose of a relative clause?', 'meaning', 'to give extra information about a noun', 'to remove all verbs', 'to give extra information about a noun', 'to make every noun plural', 'to show only tense', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which sentence uses a relative clause beginning with "which"?', 'meaning', 'The clock, which had stopped, needed new batteries.', 'The clock needed batteries.', 'Which clock needed batteries?', 'The clock, which had stopped, needed new batteries.', 'The clock had stopped and needed batteries.', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Choose the correct completion: The library, ___ we study on Thursdays, is quiet.', 'meaning', 'where', 'who', 'where', 'whose', 'when', 1),

((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which modal verb shows possibility?', 'meaning', 'may', 'must', 'may', 'will', 'shall', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which modal verb shows obligation?', 'meaning', 'must', 'could', 'might', 'must', 'may', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Choose the sentence showing uncertainty.', 'meaning', 'The concert may finish late.', 'The concert must finish late.', 'The concert may finish late.', 'The concert finished late.', 'The concert finishes late.', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Choose the sentence showing certainty.', 'meaning', 'The sun will rise tomorrow.', 'The sun might rise tomorrow.', 'The sun could rise tomorrow.', 'The sun will rise tomorrow.', 'The sun may rise tomorrow.', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which adverb shows uncertainty?', 'meaning', 'perhaps', 'silently', 'perhaps', 'nearby', 'yesterday', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Choose the best modal verb: You ___ return library books on time.', 'meaning', 'should', 'might', 'should', 'could', 'may', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which sentence uses an adverb to show probability?', 'meaning', 'The team will probably win.', 'The team ran quickly.', 'The team will probably win.', 'The team trained outside.', 'The team won yesterday.', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'What does "might" suggest in "The shop might close early"?', 'meaning', 'a possibility', 'a command', 'a possibility', 'a completed action', 'a definite fact', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Which sentence shows advice?', 'meaning', 'You ought to revise your spellings.', 'You will revise your spellings.', 'You revised your spellings.', 'You ought to revise your spellings.', 'You are revising your spellings.', 1),

((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Choose the correct homophone: The books are over ___.', 'meaning', 'there', 'their', 'there', 'they''re', 'theirs', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Choose the correct homophone: ___ planning a surprise party.', 'meaning', 'They''re', 'There', 'Their', 'They''re', 'Theirs', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Choose the correct homophone: The twins carried ___ bags upstairs.', 'meaning', 'their', 'there', 'their', 'they''re', 'theirs', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Choose the correct word: The choir will ___ a new song.', 'meaning', 'sing', 'sing', 'sink', 'single', 'seen', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Choose the correct word: The ship began to ___ in the storm.', 'meaning', 'sink', 'sing', 'sink', 'single', 'seen', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Choose the correct word: The hare ran across the ___.', 'meaning', 'field', 'feeld', 'field', 'filled', 'feeled', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Choose the correct word: The knight raised his ___.', 'meaning', 'sword', 'sored', 'sword', 'soared', 'sawed', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Choose the correct word: The bird spread ___ wings.', 'meaning', 'its', 'it''s', 'its', 'its''', 'it', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Choose the correct word: ___ been a long journey.', 'meaning', 'It''s', 'Its', 'It''s', 'Its''', 'It', 1),
((SELECT id FROM seed_fsce_level5_english_paper2_id), 'Choose the correct sentence.', 'meaning', 'They''re leaving their coats over there.', 'Their leaving there coats over they''re.', 'There leaving their coats over they''re.', 'They''re leaving their coats over there.', 'Theyre leaving there coats over their.', 1);

DROP TABLE seed_fsce_level5_english_paper2_id;

COMMIT;
