COPY cities(name, state) FROM 'C:\coursework\cities.csv' DELIMITER ',' CSV HEADER;
COPY testing_centres(city_id, address) FROM 'C:\coursework\testing_centres.csv' DELIMITER ',' CSV HEADER;
COPY cabinets(testing_centre_id, cabinet_number)  FROM 'C:\coursework\cabinets.csv' DELIMITER ',' CSV HEADER;
COPY schools(name, city_id, address, examined_students) FROM 'C:\coursework\schools.csv' DELIMITER ',' CSV HEADER;
COPY students(school_id, surname, name, second_name, personal_code, passport_number) FROM 'C:\coursework\students.csv' DELIMITER ',' CSV HEADER;
COPY inspectors(surname, name, second_name, passport_number) FROM 'C:\coursework\inspectors.csv' DELIMITER ',' CSV HEADER;
COPY disciplines(name, is_mandatory)  FROM 'C:\coursework\disciplines.csv' DELIMITER ',' CSV HEADER;
COPY exams(discipline_id, exam_date_time, on_main_session) FROM 'C:\coursework\exams.csv' DELIMITER ',' CSV HEADER;
INSERT INTO inspectors_presence VALUES (generate_series(1, 150) * 0.15 + 1, trunc(random()*149) + 1, trunc(random()*399) + 1);
INSERT INTO exam_results VALUES (generate_series(1, 300), trunc(random()*171) + 1, trunc(random()*25) + 1, trunc(random()*399) + 1, trunc(random()*30) + 1, trunc(random()*100) + 100);
