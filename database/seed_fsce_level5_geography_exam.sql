BEGIN TRANSACTION;

INSERT OR IGNORE INTO stages (name, description)
VALUES ('Year 5', 'UK primary Year 5 students.');

INSERT INTO quizzes (title, description, created_by, stage_id, lock_after_attempt, is_archived)
SELECT 'FSCE Exam Geography for Level 5',
       'A 100-question FSCE-style Geography paper for Level 5 covering physical and human geography, map skills, fieldwork, landscapes, environmental change, coordinates, compass directions, and time zones.',
       1,
       (SELECT id FROM stages WHERE name = 'Year 5'),
       1,
       0
WHERE NOT EXISTS (SELECT 1 FROM quizzes WHERE title = 'FSCE Exam Geography for Level 5')
  AND NOT EXISTS (SELECT 1 FROM deleted_seed_quizzes WHERE title = 'FSCE Exam Geography for Level 5');

UPDATE quizzes
SET description = 'A 100-question FSCE-style Geography paper for Level 5 covering physical and human geography, map skills, fieldwork, landscapes, environmental change, coordinates, compass directions, and time zones.',
    stage_id = (SELECT id FROM stages WHERE name = 'Year 5'),
    lock_after_attempt = 1,
    is_archived = 0
WHERE title = 'FSCE Exam Geography for Level 5';

DROP TABLE IF EXISTS seed_fsce_level5_geography_id;
CREATE TEMP TABLE seed_fsce_level5_geography_id(id INTEGER);
INSERT INTO seed_fsce_level5_geography_id
SELECT id FROM quizzes WHERE title = 'FSCE Exam Geography for Level 5' LIMIT 1;

DELETE FROM questions
WHERE quiz_id = (SELECT id FROM seed_fsce_level5_geography_id);

INSERT INTO questions (quiz_id, question_text, question_type, correct_answer, option1, option2, option3, option4, points)
VALUES
((SELECT id FROM seed_fsce_level5_geography_id), 'Which of these is a physical feature?', 'meaning', 'river', 'road', 'bridge', 'river', 'factory', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which of these is a human feature?', 'meaning', 'railway station', 'mountain', 'beach', 'valley', 'railway station', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which pair contains only physical features?', 'meaning', 'cliff and waterfall', 'school and harbour', 'cliff and waterfall', 'road and shop', 'bridge and canal', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which pair contains only human features?', 'meaning', 'airport and motorway', 'river and lake', 'airport and motorway', 'hill and cave', 'forest and beach', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'What is a landscape?', 'meaning', 'the visible features of an area of land', 'the weather on one day', 'the visible features of an area of land', 'a list of countries', 'a type of map symbol', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which physical process can slowly wear away cliffs?', 'meaning', 'erosion', 'building', 'shopping', 'erosion', 'commuting', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'What is deposition?', 'meaning', 'when material is dropped in a new place', 'when rock is broken down by freezing', 'when material is dropped in a new place', 'when people move to cities', 'when rain is measured', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which process can form a river valley over time?', 'meaning', 'flowing water eroding the land', 'cars parking beside a river', 'flowing water eroding the land', 'shops opening in a town', 'people drawing a sketch map', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which human activity can change a landscape?', 'meaning', 'building a new road', 'a river freezing naturally', 'building a new road', 'waves hitting cliffs', 'wind moving sand', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which statement best shows interaction between physical and human geography?', 'meaning', 'A town builds flood defences beside a river.', 'A hill is higher than a valley.', 'A town builds flood defences beside a river.', 'A compass points north.', 'A map uses symbols.', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Why are many towns built near rivers?', 'meaning', 'rivers can provide water, transport routes, and trade links', 'rivers stop all erosion', 'rivers can provide water, transport routes, and trade links', 'rivers make all land flat', 'rivers remove the need for roads', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which human activity is most likely to increase traffic in a village?', 'meaning', 'opening a large shopping centre nearby', 'planting wildflowers', 'opening a large shopping centre nearby', 'measuring rainfall', 'watching birds', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which human factor might affect where a factory is built?', 'meaning', 'access to roads and workers', 'the shape of clouds', 'access to roads and workers', 'the colour of nearby flowers', 'the phases of the Moon', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'What is land use?', 'meaning', 'how people use an area of land', 'how heavy a rock is', 'how people use an area of land', 'how rain is formed', 'how far north a place is', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which change could make a countryside area more urban?', 'meaning', 'building houses, shops, and roads', 'more sheep grazing in fields', 'building houses, shops, and roads', 'a river meandering naturally', 'snow melting on hills', 1),

((SELECT id FROM seed_fsce_level5_geography_id), 'On a map, what does a symbol usually represent?', 'meaning', 'a real feature such as a station or campsite', 'the age of the map reader', 'a real feature such as a station or campsite', 'the weather tomorrow', 'a spoken instruction', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'What does a map key help you understand?', 'meaning', 'what the symbols and colours mean', 'how heavy the map is', 'what the symbols and colours mean', 'who drew every road', 'what time it is', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which direction is opposite north?', 'meaning', 'south', 'east', 'west', 'south', 'north-east', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which direction is halfway between north and east?', 'meaning', 'north-east', 'north-west', 'south-east', 'north-east', 'south-west', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'If a school is west of the park, which direction is the park from the school?', 'meaning', 'east', 'west', 'east', 'north', 'south', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'If you walk north, then turn right, which direction are you facing?', 'meaning', 'east', 'west', 'south', 'east', 'north-west', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'What is a grid reference used for?', 'meaning', 'finding a location on a map', 'measuring temperature', 'finding a location on a map', 'naming a continent', 'recording wind speed', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'When reading a four-figure grid reference, which number do you usually read first?', 'meaning', 'the easting', 'the northing', 'the easting', 'the height', 'the scale', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'In map skills, what does "eastings before northings" mean?', 'meaning', 'read across first, then up', 'read up first, then across', 'read across first, then up', 'ignore the grid lines', 'start from the right-hand side', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'What does map scale show?', 'meaning', 'the relationship between map distance and real distance', 'the height of every building', 'the relationship between map distance and real distance', 'the age of a landscape', 'the number of people in a place', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'If 1 cm on a map equals 1 km in real life, what does 3 cm represent?', 'meaning', '3 km', '1 km', '2 km', '3 km', '30 km', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which map would be best for planning a walking route?', 'meaning', 'a large-scale local map with footpaths', 'a world map only showing continents', 'a large-scale local map with footpaths', 'a blank map with no symbols', 'a map of ocean currents only', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'What do contour lines show on a map?', 'meaning', 'height and shape of the land', 'temperature', 'height and shape of the land', 'traffic speed', 'time zones', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Close contour lines usually show land that is...', 'meaning', 'steep', 'flat', 'steep', 'underwater', 'urban', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which feature would most likely be shown with a blue line on a map?', 'meaning', 'river', 'road', 'school', 'river', 'railway', 1),

((SELECT id FROM seed_fsce_level5_geography_id), 'What is weather?', 'meaning', 'the day-to-day condition of the atmosphere', 'the average conditions over many years', 'the day-to-day condition of the atmosphere', 'the shape of a coastline', 'the number of people in a town', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'What is climate?', 'meaning', 'the average weather conditions of a place over a long time', 'the weather at exactly midday', 'the average weather conditions of a place over a long time', 'a type of map grid', 'a short rain shower', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which instrument measures temperature?', 'meaning', 'thermometer', 'rain gauge', 'thermometer', 'wind vane', 'compass', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which instrument measures rainfall?', 'meaning', 'rain gauge', 'thermometer', 'rain gauge', 'bar magnet', 'compass', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which instrument shows wind direction?', 'meaning', 'wind vane', 'rain gauge', 'wind vane', 'thermometer', 'trundle wheel', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which observation would be useful in simple fieldwork about local weather?', 'meaning', 'recording temperature at the same time each day', 'guessing the weather without measuring', 'recording temperature at the same time each day', 'counting cars once at midnight only', 'drawing a country flag', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Why should fieldwork measurements be taken carefully?', 'meaning', 'so the results are more reliable', 'so the map looks colourful', 'so the results are more reliable', 'so the weather changes faster', 'so north changes direction', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'What is a tally chart useful for?', 'meaning', 'counting repeated observations quickly', 'showing compass directions only', 'counting repeated observations quickly', 'measuring mountain height exactly', 'finding longitude', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which fieldwork question is geographical?', 'meaning', 'How does traffic change during the school day?', 'What is your favourite colour?', 'How does traffic change during the school day?', 'Which sandwich tastes best?', 'Who has the neatest handwriting?', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which method would help compare traffic on two roads?', 'meaning', 'count vehicles on each road for the same length of time', 'count one road for five minutes and the other for one hour', 'count vehicles on each road for the same length of time', 'ask one person to guess', 'ignore buses and cars', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which graph is good for comparing categories such as car, bus, bicycle, and lorry counts?', 'meaning', 'bar chart', 'bar chart', 'story map', 'compass rose', 'weather vane', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which fieldwork tool helps measure distance along the ground?', 'meaning', 'trundle wheel', 'wind vane', 'rain gauge', 'trundle wheel', 'atlas', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Why might a geographer take photographs during fieldwork?', 'meaning', 'to record evidence of what the place looked like', 'to change the weather', 'to record evidence of what the place looked like', 'to replace all maps', 'to find exact longitude only', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'What should a good field sketch include?', 'meaning', 'labels for important features', 'only bright colours with no labels', 'labels for important features', 'made-up features', 'only people names', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which is a fair way to compare two places?', 'meaning', 'use the same categories for both places', 'describe one place carefully and ignore the other', 'use the same categories for both places', 'use different scales for every answer', 'only compare their names', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which categories help compare a city and countryside area?', 'meaning', 'land use, transport, buildings, and green space', 'favourite foods only', 'land use, transport, buildings, and green space', 'shoe sizes and handwriting', 'alphabetical order only', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which evidence would help show a street has changed over time?', 'meaning', 'old and recent photographs of the same street', 'one drawing of a different town', 'old and recent photographs of the same street', 'a list of football scores', 'a recipe book', 1),

((SELECT id FROM seed_fsce_level5_geography_id), 'What is latitude?', 'meaning', 'distance north or south of the Equator measured in degrees', 'distance east or west of Greenwich only', 'distance north or south of the Equator measured in degrees', 'height above sea level only', 'the size of a country', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'What is longitude?', 'meaning', 'distance east or west of the Prime Meridian measured in degrees', 'distance north or south of the Equator only', 'distance east or west of the Prime Meridian measured in degrees', 'the daily weather', 'the number of rivers', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which line of latitude is at 0 degrees?', 'meaning', 'Equator', 'Prime Meridian', 'Equator', 'Tropic of Cancer', 'Arctic Circle', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which line of longitude is at 0 degrees?', 'meaning', 'Prime Meridian', 'Equator', 'Prime Meridian', 'Tropic of Capricorn', 'Arctic Circle', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'What do GPS apps use to help locate places?', 'meaning', 'coordinates such as latitude and longitude', 'only the colour of buildings', 'coordinates such as latitude and longitude', 'only rainfall totals', 'only mountain names', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Why do different places have different time zones?', 'meaning', 'Earth rotates, so places face the Sun at different times', 'all countries choose random times for fun', 'Earth rotates, so places face the Sun at different times', 'rivers flow at different speeds', 'maps are different colours', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'If it is noon in one time zone and another place is two hours ahead, what time is it there?', 'meaning', '2 pm', '10 am', '12 pm', '2 pm', '4 pm', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'If London is 5 hours behind a city and it is 3 pm in London, what time is it in that city?', 'meaning', '8 pm', '10 am', '3 pm', '8 pm', '5 pm', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which is the best reason to check time zones before calling relatives abroad?', 'meaning', 'it may be daytime in one place and night-time in another', 'phones cannot work across borders', 'it may be daytime in one place and night-time in another', 'maps cannot show countries', 'latitude changes every hour', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'What is the Prime Meridian also linked with?', 'meaning', 'Greenwich', 'the North Pole', 'Greenwich', 'the Amazon', 'Mount Everest', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which coordinates would be written using latitude and longitude?', 'meaning', '51 degrees N, 0 degrees W', 'Blue line, red dot', '51 degrees N, 0 degrees W', '3 cm equals 1 km', 'North-east of a tree', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which is closest to the Equator?', 'meaning', '0 degrees latitude', '80 degrees north', '0 degrees latitude', '90 degrees south', '60 degrees north', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which statement about longitude is correct?', 'meaning', 'lines of longitude meet at the poles', 'lines of longitude are all rivers', 'lines of longitude meet at the poles', 'longitude measures rainfall', 'longitude is measured in kilometres only', 1),

((SELECT id FROM seed_fsce_level5_geography_id), 'Which natural process helps form beaches?', 'meaning', 'waves depositing sand and shingle', 'cars driving on roads', 'waves depositing sand and shingle', 'people painting houses', 'trains stopping at stations', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which feature is formed by river erosion?', 'meaning', 'waterfall', 'shopping centre', 'waterfall', 'motorway', 'airport runway', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'What is weathering?', 'meaning', 'the breaking down of rocks where they are', 'the movement of people to cities', 'the breaking down of rocks where they are', 'the building of roads', 'the measuring of population', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which is an example of coastal management?', 'meaning', 'building a sea wall', 'measuring classroom temperature', 'building a sea wall', 'drawing a rainforest animal', 'planting wheat inland', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Why might sea walls be built?', 'meaning', 'to protect land and buildings from coastal erosion or flooding', 'to make the sea disappear', 'to protect land and buildings from coastal erosion or flooding', 'to stop all rain', 'to create mountains', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which human action may increase flood risk?', 'meaning', 'building on a floodplain', 'planting trees beside a river', 'building on a floodplain', 'using a rain gauge', 'drawing a contour map', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'What is a floodplain?', 'meaning', 'flat land beside a river that may flood', 'the top of a mountain', 'flat land beside a river that may flood', 'a dry desert dune', 'a city bus stop', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'How can trees help reduce flooding?', 'meaning', 'they intercept rainfall and help water soak into soil', 'they make rivers vanish', 'they intercept rainfall and help water soak into soil', 'they stop all clouds forming', 'they remove the need for maps', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which is a renewable energy source shaped by physical geography?', 'meaning', 'hydroelectric power from flowing water', 'coal from an old factory', 'hydroelectric power from flowing water', 'plastic from shops', 'petrol from cars', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Why might wind turbines be placed on hills or coasts?', 'meaning', 'these places can be windy', 'these places have no people ever', 'these places can be windy', 'these places are always hot', 'these places have no roads', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which change is most likely to reduce habitats for wildlife?', 'meaning', 'clearing woodland for a new housing estate', 'creating a nature reserve', 'clearing woodland for a new housing estate', 'planting native trees', 'cleaning litter from a beach', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'What does sustainable mean?', 'meaning', 'using resources in a way that can continue into the future', 'using everything as fast as possible', 'using resources in a way that can continue into the future', 'never changing any place', 'only building in cities', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which transport choice is usually better for reducing air pollution?', 'meaning', 'walking or cycling for a short journey', 'driving alone for every short journey', 'walking or cycling for a short journey', 'leaving engines running', 'building more car parks only', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which statement shows a place changing over time?', 'meaning', 'An old dock area becomes flats, offices, and cafes.', 'A compass points north.', 'An old dock area becomes flats, offices, and cafes.', 'Latitude is measured in degrees.', 'A river is shown in blue.', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Why might an old industrial area be redeveloped?', 'meaning', 'to create new homes, jobs, or services', 'to stop Earth rotating', 'to create new homes, jobs, or services', 'to remove all rivers', 'to change north into south', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which change could be caused by more tourists visiting a national park?', 'meaning', 'more footpath erosion and more local income', 'fewer paths and no jobs', 'more footpath erosion and more local income', 'no effect on the area', 'the climate changes instantly', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which is a positive effect of tourism?', 'meaning', 'jobs for local people', 'more litter in every case', 'jobs for local people', 'damage to all habitats', 'no need for transport', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which is a possible negative effect of tourism?', 'meaning', 'crowding and pressure on local environments', 'more income for all shops only', 'crowding and pressure on local environments', 'better map reading', 'more latitude', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Why might a settlement grow near a road junction?', 'meaning', 'transport links make movement and trade easier', 'road junctions stop weather', 'transport links make movement and trade easier', 'rivers cannot exist nearby', 'soil always disappears there', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which sentence best explains dynamic landscapes?', 'meaning', 'Landscapes change because physical processes and human actions interact over time.', 'Landscapes never change.', 'Landscapes change because physical processes and human actions interact over time.', 'Only maps can change landscapes.', 'Only buildings are part of geography.', 1),

((SELECT id FROM seed_fsce_level5_geography_id), 'Which continent is the United Kingdom in?', 'meaning', 'Europe', 'Africa', 'Europe', 'Asia', 'South America', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which ocean lies west of the United Kingdom?', 'meaning', 'Atlantic Ocean', 'Indian Ocean', 'Atlantic Ocean', 'Pacific Ocean', 'Arctic Ocean', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which country is part of the United Kingdom?', 'meaning', 'Wales', 'France', 'Wales', 'Spain', 'Italy', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which city is the capital of Scotland?', 'meaning', 'Edinburgh', 'Cardiff', 'Edinburgh', 'Belfast', 'Manchester', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which city is the capital of Wales?', 'meaning', 'Cardiff', 'London', 'Cardiff', 'Edinburgh', 'Dublin', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which city is the capital of Northern Ireland?', 'meaning', 'Belfast', 'Belfast', 'Cardiff', 'Glasgow', 'Liverpool', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which river runs through London?', 'meaning', 'River Thames', 'River Severn', 'River Thames', 'River Tyne', 'River Mersey', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which is the highest mountain in the UK?', 'meaning', 'Ben Nevis', 'Snowdon', 'Scafell Pike', 'Ben Nevis', 'Kinder Scout', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which area is most likely to have a harbour?', 'meaning', 'coast', 'mountain summit', 'coast', 'inland desert', 'deep forest only', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which type of map would best show countries and borders?', 'meaning', 'political map', 'weather chart only', 'political map', 'street sketch only', 'fieldwork tally', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which type of map would best show hills, rivers, and land height?', 'meaning', 'physical map', 'political map only', 'physical map', 'bus timetable', 'population list', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which word describes the number of people living in an area?', 'meaning', 'population', 'erosion', 'population', 'deposition', 'longitude', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which word means people moving from one place to live in another?', 'meaning', 'migration', 'evaporation', 'migration', 'erosion', 'deposition', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which reason might cause migration to a city?', 'meaning', 'more jobs and services', 'fewer schools and hospitals', 'more jobs and services', 'no transport links', 'no homes anywhere', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which settlement is usually smallest?', 'meaning', 'hamlet', 'city', 'town', 'village', 'hamlet', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which settlement is usually largest?', 'meaning', 'city', 'hamlet', 'village', 'town', 'city', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which service would you expect in many large towns?', 'meaning', 'hospital', 'glacier', 'hospital', 'volcano crater', 'coral reef', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which feature is most linked with farming?', 'meaning', 'fields', 'airport runway', 'fields', 'shopping arcade', 'underground station', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which feature is most linked with industry?', 'meaning', 'factory', 'beach dune', 'factory', 'mountain stream', 'woodland path', 1),
((SELECT id FROM seed_fsce_level5_geography_id), 'Which answer best describes Geography?', 'meaning', 'the study of places, people, environments, and how they interact', 'the study of spelling only', 'the study of places, people, environments, and how they interact', 'the study of numbers only', 'the study of planets only', 1);

DROP TABLE seed_fsce_level5_geography_id;

COMMIT;
