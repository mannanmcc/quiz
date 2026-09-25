BEGIN TRANSACTION;

INSERT OR IGNORE INTO stages (name, description)
VALUES ('Year 5', 'UK primary Year 5 students.');

INSERT INTO quizzes (title, description, created_by, stage_id, lock_after_attempt, is_archived)
SELECT 'FSCE Exam History for Level 5',
       'A 100-question FSCE-style History paper for Year 5 covering chronology, sources, cause and consequence, similarity and difference, significance, and historical enquiry.',
       1,
       (SELECT id FROM stages WHERE name = 'Year 5'),
       1,
       0
WHERE NOT EXISTS (SELECT 1 FROM quizzes WHERE title = 'FSCE Exam History for Level 5')
  AND NOT EXISTS (SELECT 1 FROM deleted_seed_quizzes WHERE title = 'FSCE Exam History for Level 5');

UPDATE quizzes
SET description = 'A 100-question FSCE-style History paper for Year 5 covering chronology, sources, cause and consequence, similarity and difference, significance, and historical enquiry.',
    stage_id = (SELECT id FROM stages WHERE name = 'Year 5'),
    lock_after_attempt = 1,
    is_archived = 0
WHERE title = 'FSCE Exam History for Level 5';

DROP TABLE IF EXISTS seed_fsce_level5_history_id;
CREATE TEMP TABLE seed_fsce_level5_history_id(id INTEGER);
INSERT INTO seed_fsce_level5_history_id
SELECT id FROM quizzes WHERE title = 'FSCE Exam History for Level 5' LIMIT 1;

DELETE FROM questions
WHERE quiz_id = (SELECT id FROM seed_fsce_level5_history_id);

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
VALUES
((SELECT id FROM seed_fsce_level5_history_id), 'Which word means putting events in the order they happened?', 'meaning', 'timeline', 'map', 'timeline', 'recipe', 'painting', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which source would most help us understand what a person felt at the time?', 'meaning', 'a diary', 'a textbook', 'a diary', 'a map', 'a statue', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which source was written after the event by someone who was not there?', 'meaning', 'a history book', 'a newspaper from the time', 'a history book', 'a diary entry', 'a photograph', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'What is the main purpose of a museum?', 'meaning', 'to preserve and display historical evidence', 'to teach maths', 'to preserve and display historical evidence', 'to sell clothes', 'to arrange football matches', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which is a primary source?', 'meaning', 'an original letter from the time', 'a modern summary', 'an original letter from the time', 'a film made today', 'a poster from 2025', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which is a secondary source?', 'meaning', 'a school history textbook', 'a coin from Roman times', 'a school history textbook', 'a diary from 1940', 'a stone tool', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'If a source is biased, what does that mean?', 'meaning', 'it gives a one-sided view', 'it is always true', 'it gives a one-sided view', 'it is from the future', 'it has no details', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'What is a cause?', 'meaning', 'something that makes an event happen', 'the result of an event', 'something that makes an event happen', 'a map symbol', 'a family tradition', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'What is a consequence?', 'meaning', 'the result of an event', 'the date of an event', 'the result of an event', 'the place where it happened', 'the style of a building', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'What does significance mean in history?', 'meaning', 'importance', 'speed', 'importance', 'length', 'colour', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which order is correct from earliest to latest?', 'meaning', '1066, 1215, 1485, 1901', '1485, 1066, 1901, 1215', '1066, 1215, 1485, 1901', '1901, 1485, 1215, 1066', '1215, 1901, 1066, 1485', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which came first?', 'meaning', 'Stone Age', 'Victorian times', 'Stone Age', 'Second World War', 'Industrial Revolution', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which event happened after the Romans left Britain?', 'meaning', 'Anglo-Saxon settlement', 'Roman invasion', 'Anglo-Saxon settlement', 'Battle of Hastings', 'Great Fire of London', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'The Norman Conquest changed Britain mainly by changing...', 'meaning', 'the ruling class and language', 'the weather', 'the ruling class and language', 'the shape of the seas', 'the number of planets', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'What is an empire?', 'meaning', 'a group of lands ruled by one country', 'a large ocean', 'a group of lands ruled by one country', 'a small village', 'a school rule', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which word describes a society with its own rules, beliefs, and way of life?', 'meaning', 'civilisation', 'calendar', 'civilisation', 'transport', 'trade', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'What is a kingdom?', 'meaning', 'an area ruled by a king or queen', 'a building made of stone', 'an area ruled by a king or queen', 'a city bus route', 'a farming tool', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'What do BC and AD tell us?', 'meaning', 'the date before or after the birth of Jesus', 'the names of kings', 'the date before or after the birth of Jesus', 'the weather in each season', 'the number of villages', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Why do historians use evidence?', 'meaning', 'to test claims and build conclusions', 'to make up stories', 'to test claims and build conclusions', 'to hide the truth', 'to write poems', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which source would be best for seeing how an evacuee felt during war?', 'meaning', 'a diary', 'a map of the railway', 'a diary', 'a thermometer', 'a census', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Why might two historians disagree about the same event?', 'meaning', 'they may have different evidence or opinions', 'they are always wrong', 'they may have different evidence or opinions', 'they never read history books', 'they do not know the date', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Who built the roads across Roman Britain?', 'meaning', 'the Romans', 'the Vikings', 'the Romans', 'the Anglo-Saxons', 'the Tudors', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Why were Roman roads important?', 'meaning', 'they helped soldiers, traders, and messages travel', 'they kept people indoors', 'they helped soldiers, traders, and messages travel', 'they prevented all wars', 'they built houses for everyone', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'What was a Roman villa?', 'meaning', 'a large country house', 'a fort in the city', 'a large country house', 'a temple for worship', 'a classroom', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'What was the main purpose of Hadrian’s Wall?', 'meaning', 'to defend the Roman frontier', 'to welcome visitors', 'to defend the Roman frontier', 'to store grain', 'to grow crops', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which word means a person who writes about events as they happen?', 'meaning', 'chronicler', 'leader', 'chronicler', 'engineer', 'farmer', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which group came to Britain after the Romans?', 'meaning', 'the Anglo-Saxons', 'the Romans again', 'the Anglo-Saxons', 'the Normans', 'the Victorians', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'What is a kingdom in Anglo-Saxon Britain?', 'meaning', 'an area ruled by a king', 'a type of stone wall', 'an area ruled by a king', 'a castle tower', 'a church window', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Why do historians study Anglo-Saxon villages?', 'meaning', 'they help us understand early settlement and farming', 'they were all built in the desert', 'they help us understand early settlement and farming', 'they tell us about moon landings', 'they are all in the future', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Who were the Vikings?', 'meaning', 'people from Scandinavia who raided and traded', 'the rulers of Ancient Egypt', 'people from Scandinavia who raided and traded', 'the builders of the Great Wall', 'the emperors of Rome', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Why did the Vikings travel far from home?', 'meaning', 'to trade, raid, and explore', 'to cook food only', 'to trade, raid, and explore', 'to stay in one place forever', 'to build pyramids', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'What is a longhouse?', 'meaning', 'a long house used by some early settlers', 'a school building', 'a long house used by some early settlers', 'a Roman road', 'a medieval cathedral', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which object might show that people traded with others?', 'meaning', 'a coin or imported artefact', 'a toy train', 'a coin or imported artefact', 'a poem about flowers', 'a school timetable', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'What happened at the Battle of Hastings in 1066?', 'meaning', 'William, Duke of Normandy, defeated Harold', 'The Romans surrendered to the Vikings', 'William, Duke of Normandy, defeated Harold', 'The Great Fire began in the city', 'The Magna Carta was signed', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Who was William the Conqueror?', 'meaning', 'the Duke of Normandy who became king of England', 'the king of Scotland', 'the Duke of Normandy who became king of England', 'the queen of the Vikings', 'the leader of the Roman army', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'After the Norman Conquest, what new system was introduced?', 'meaning', 'the feudal system', 'the railway system', 'the feudal system', 'the printing system', 'the electric system', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'What was a castle?', 'meaning', 'a fortified building used for defence', 'a public garden', 'a fortified building used for defence', 'a market stall', 'a school', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which of these was part of medieval society?', 'meaning', 'a knight', 'a steam engine', 'a knight', 'a rocket', 'a telephone', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'What was a guild?', 'meaning', 'a group of workers or craftsmen with shared rules', 'a type of castle', 'a group of workers or craftsmen with shared rules', 'a battle plan', 'a form of monarchy', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Why is the Magna Carta important?', 'meaning', 'it limited the king’s power', 'it caused the Great Fire', 'it limited the king’s power', 'it ended the Roman Empire', 'it created the railway', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Who was executed in 1649?', 'meaning', 'King Charles I', 'King Henry VIII', 'King Charles I', 'Queen Elizabeth I', 'King James I', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'What was the Great Fire of London?', 'meaning', 'a huge fire that destroyed much of the city in 1666', 'a festival for kings', 'a huge fire that destroyed much of the city in 1666', 'a storm at sea', 'a theatre performance', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Why did the Great Fire spread so quickly?', 'meaning', 'many buildings were made of wood and close together', 'there were no people in the city', 'many buildings were made of wood and close together', 'the river was too wide', 'the sky was full of rain', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which building was rebuilt after the fire?', 'meaning', 'St Paul’s Cathedral', 'The Tower of London', 'St Paul’s Cathedral', 'Windsor Castle', 'Buckingham Palace', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Why was the Great Fire important in history?', 'meaning', 'it changed how London was rebuilt', 'it ended the Roman period', 'it changed how London was rebuilt', 'it gave Britain a new king', 'it created the telephone', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which invention helped make factories more productive during the Industrial Revolution?', 'meaning', 'the steam engine', 'the pencil', 'the steam engine', 'the telescope', 'the compass', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'What changed most during the Industrial Revolution?', 'meaning', 'factories, transport, and city life', 'the hours in a day', 'factories, transport, and city life', 'the shape of the Earth', 'the names of countries', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Why were children sometimes employed in factories?', 'meaning', 'they were cheap labour and could work long hours', 'they were very tall', 'they were cheap labour and could work long hours', 'they were better at reading', 'they preferred factories to schools', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which invention helped messages travel quickly over long distances?', 'meaning', 'the telegraph', 'the bicycle', 'the telegraph', 'the pottery wheel', 'the plough', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which transport link is strongly associated with Victorian Britain?', 'meaning', 'steam railway', 'sailing boat', 'steam railway', 'camel caravan', 'Roman chariot', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which word describes an event or change that had a very strong effect on people’s lives?', 'meaning', 'significant', 'temporary', 'significant', 'modern', 'colourful', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Why were railways built in the 1800s?', 'meaning', 'to move people and goods more quickly', 'to stop all storms', 'to move people and goods more quickly', 'to catch fish', 'to replace farms', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Why did cities grow during the Industrial Revolution?', 'meaning', 'more factories and jobs attracted workers', 'the sea moved inland', 'more factories and jobs attracted workers', 'rain stopped falling', 'people stopped travelling', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which source would best show everyday life in Victorian Britain?', 'meaning', 'a photograph', 'a modern cartoon', 'a photograph', 'a weather forecast', 'a maths textbook', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'What was the Black Death?', 'meaning', 'a deadly plague that spread across Europe', 'a new kind of train', 'a deadly plague that spread across Europe', 'a period of peace', 'a war in Asia', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which disease spread across Britain in the 1340s and 1350s?', 'meaning', 'plague', 'influenza', 'plague', 'measles', 'smallpox', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Why do historians compare different sources?', 'meaning', 'to check accuracy and look for different viewpoints', 'to make the library bigger', 'to check accuracy and look for different viewpoints', 'to choose the prettiest picture', 'to make the past seem easier', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'What does continuity mean in history?', 'meaning', 'things stay similar over time', 'things change every day', 'things stay similar over time', 'things are always new', 'things happen in a random order', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'What does change mean in history?', 'meaning', 'things become different over time', 'things never move', 'things become different over time', 'things always stay the same', 'things are only in one place', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which statement shows continuity?', 'meaning', 'People still trade and travel along roads today.', 'People stopped using roads after the Romans.', 'People still trade and travel along roads today.', 'Children no longer go to school.', 'All cities were built in one year.', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which statement shows change?', 'meaning', 'Houses are now often built with brick and windows instead of timber and thatch.', 'People still use the same tools as in 1000.', 'Houses are now often built with brick and windows instead of timber and thatch.', 'Roads are never repaired.', 'All people live in castles.', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Why might a historical source be less reliable?', 'meaning', 'it may be personal, inaccurate, or one-sided', 'it has a date on it', 'it may be personal, inaccurate, or one-sided', 'it is printed in a book', 'it contains a map', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'What is a revolution?', 'meaning', 'a sudden and major change in society or government', 'a normal school assembly', 'a sudden and major change in society or government', 'a holiday celebration', 'a family gathering', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which event is linked with a revolution?', 'meaning', 'the French Revolution', 'the first day of spring', 'the French Revolution', 'a school trip', 'a birthday party', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which invention changed people’s lives most in the long term?', 'meaning', 'the printing press', 'the school desk', 'the printing press', 'the lunchbox', 'the bicycle bell', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which question would make a historically valid enquiry?', 'meaning', 'What caused the Romans to leave Britain?', 'What is your favourite colour?', 'What caused the Romans to leave Britain?', 'Who won the football match yesterday?', 'How many books are on the shelf?', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which words help you structure a historical answer?', 'meaning', 'cause, event, consequence', 'red, blue, green', 'cause, event, consequence', 'first, then, finally', 'fact, guess, opinion', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'What does chronological mean?', 'meaning', 'in time order', 'in random order', 'in time order', 'in alphabetical order', 'in map order', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'What is an interpretation in history?', 'meaning', 'a different explanation of past events', 'a list of dates', 'a different explanation of past events', 'a set of rules', 'a type of map', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'What is a census?', 'meaning', 'a count of the population', 'a battle formation', 'a count of the population', 'a church service', 'a castle wall', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Why are maps useful to historians?', 'meaning', 'they show places, boundaries, and movement', 'they record songs', 'they show places, boundaries, and movement', 'they can only show the weather', 'they never change', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'What is archaeology?', 'meaning', 'the study of ancient objects and remains', 'the study of the stars', 'the study of ancient objects and remains', 'the study of animals', 'the study of language', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'What might archaeologists dig up?', 'meaning', 'pottery, tools, and building remains', 'tomatoes and apples', 'pottery, tools, and building remains', 'only coins from the future', 'newspaper headlines', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which feature is most associated with ancient Egypt?', 'meaning', 'pyramids', 'castles', 'pyramids', 'railways', 'skyscrapers', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which civilisation built aqueducts?', 'meaning', 'the Romans', 'the Vikings', 'the Romans', 'the Normans', 'the Tudors', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Why was the first moon landing significant?', 'meaning', 'it showed humans could travel beyond Earth', 'it ended the Roman Empire', 'it showed humans could travel beyond Earth', 'it invented the steam engine', 'it built the first castle', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'How can studying history help people?', 'meaning', 'it helps them understand change, identity, and the world today', 'it only teaches dates', 'it helps them understand change, identity, and the world today', 'it makes everyone the same', 'it stops all arguments', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which country was ruled by the Romans for many years?', 'meaning', 'Britain', 'Japan', 'Britain', 'Brazil', 'Australia', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which building was a centre of learning in ancient times?', 'meaning', 'a library', 'a field', 'a library', 'a factory', 'a railway station', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which event is a major turning point in British history?', 'meaning', 'the Norman Conquest', 'the first day of school', 'the Norman Conquest', 'a classroom test', 'a family holiday', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which statement about local and national history is correct?', 'meaning', 'local history connects to the wider story of the nation', 'local history is always unrelated to national history', 'local history connects to the wider story of the nation', 'national history is only about royalty', 'local history never changes', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Why do we study the history of the wider world?', 'meaning', 'to see how societies connect and how ideas spread', 'because it is easier than studying Britain', 'to see how societies connect and how ideas spread', 'because the world is never changing', 'because maps are no longer used', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which empire was ruled from London?', 'meaning', 'the British Empire', 'the Roman Empire', 'the British Empire', 'the Viking Empire', 'the Ottoman Empire', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Who was the first woman to become Prime Minister of the United Kingdom?', 'meaning', 'Margaret Thatcher', 'Queen Victoria', 'Margaret Thatcher', 'Elizabeth I', 'Anne Boleyn', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which event happened during the Second World War?', 'meaning', 'evacuation of children from cities', 'the Norman Conquest', 'evacuation of children from cities', 'the building of Hadrian’s Wall', 'the signing of the Magna Carta', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Why were children evacuated during the Second World War?', 'meaning', 'to keep them safe from bombing', 'to start a new school year', 'to keep them safe from bombing', 'to move them to the seaside for fun', 'to become soldiers', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'What is a propaganda poster?', 'meaning', 'a poster designed to influence people’s opinions', 'a map of the world', 'a poster designed to influence people’s opinions', 'a family photo album', 'a recipe card', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Why were records kept in the past?', 'meaning', 'to preserve information about people, places, and events', 'to make the furniture heavier', 'to preserve information about people, places, and events', 'to hide stories from future generations', 'to replace newspapers', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'What was a consequence of the invention of the steam engine?', 'meaning', 'transport and factories improved and changed daily life', 'everyone stopped using roads', 'transport and factories improved and changed daily life', 'people became kings', 'the Roman Empire returned', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'What was a consequence of the printing press?', 'meaning', 'books became cheaper and more people could read', 'all people stopped writing', 'books became cheaper and more people could read', 'only kings used books', 'schools closed everywhere', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Why did many settlements grow near rivers?', 'meaning', 'rivers provided water, food, and transport', 'rivers were always too cold', 'rivers provided water, food, and transport', 'rivers prevented all storms', 'rivers caused no travel', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Why do historians consider context?', 'meaning', 'because events happened in a particular time and place', 'because it makes everything colourful', 'because events happened in a particular time and place', 'because all sources are identical', 'because people never change', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'What does evaluate evidence mean?', 'meaning', 'weigh how useful and reliable it is', 'copy it exactly', 'weigh how useful and reliable it is', 'ignore it completely', 'repeat it without thinking', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which comparison is most historically accurate?', 'meaning', 'Victorian factories produced goods faster than hand labour.', 'Victorian factories made no difference to daily life.', 'Victorian factories produced goods faster than hand labour.', 'Victorian factories only made clothes by hand.', 'Victorian factories used no machines.', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which source would be best evidence for how a building was constructed?', 'meaning', 'archaeological remains', 'a sports score sheet', 'archaeological remains', 'a modern cartoon', 'a weather report', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which object would be a primary source from Roman times?', 'meaning', 'a coin or soldier’s letter', 'a modern map of Britain', 'a coin or soldier’s letter', 'a 21st-century history book', 'a drawing from today', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which statement is supported by historical evidence?', 'meaning', 'The Romans influenced roads, towns, and culture in Britain.', 'The Romans never visited Britain.', 'The Romans influenced roads, towns, and culture in Britain.', 'The Vikings never sailed to Europe.', 'The Great Fire happened before the Romans arrived.', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which statement best explains why historians ask questions about the past?', 'meaning', 'They want to understand causes, changes, and people’s lives over time.', 'They already know everything.', 'They want to understand causes, changes, and people’s lives over time.', 'They only want dates.', 'They only want names of kings.', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which example shows a child thinking about significance in history?', 'meaning', 'Choosing the invention that changed most people’s lives and explaining why.', 'Choosing a random colour.', 'Choosing the invention that changed most people’s lives and explaining why.', 'Ignoring all evidence.', 'Saying all events are equally important.', 1),
((SELECT id FROM seed_fsce_level5_history_id), 'Which event best fits a short-term change with long-term effects?', 'meaning', 'The Industrial Revolution changed work, cities, and travel for decades.', 'A child writing a shopping list.', 'The Industrial Revolution changed work, cities, and travel for decades.', 'A school trip to the museum.', 'A single rainy day.', 1);

DROP TABLE seed_fsce_level5_history_id;

COMMIT;
