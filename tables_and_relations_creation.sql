CREATE TABLE cities
(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    state TEXT NOT NULL
);

CREATE TABLE testing_centres
(
    id SERIAL PRIMARY KEY,
    city_id INTEGER REFERENCES cities(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    address TEXT NOT NULL
);

CREATE TABLE cabinets
(
    id SERIAL PRIMARY KEY,
    testing_centre_id INTEGER REFERENCES testing_centres(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    cabinet_number INTEGER NOT NULL
);

CREATE TABLE schools
(
    id SERIAL PRIMARY KEY,
    name TEXT NULL,
    city_id INTEGER REFERENCES cities(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    address TEXT NOT NULL,
    examined_students INTEGER NOT NULL
);

CREATE TABLE students
(
    id SERIAL PRIMARY KEY,
    school_id INTEGER REFERENCES schools(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    surname TEXT NOT NULL,
    name TEXT NOT NULL,
    second_name TEXT,
    personal_code VARCHAR(7) UNIQUE NOT NULL,
    passport_number CHAR(9) UNIQUE NOT NULL
);

CREATE TABLE inspectors
(
    id SERIAL PRIMARY KEY,
    surname TEXT NOT NULL,
    name TEXT NOT NULL,
    second_name TEXT,
    passport_number CHAR(9) UNIQUE NOT NULL
);

CREATE TABLE disciplines
(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    is_mandatory BOOLEAN NOT NULL
);

CREATE TABLE exams
(
    id SERIAL PRIMARY KEY,
    discipline_id INTEGER REFERENCES disciplines(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    exam_date_time TIMESTAMP NOT NULL CHECK ('2008-04-21 12:00:00' < exam_date_time),
    on_main_session BOOLEAN NOT NULL
);

CREATE TABLE inspectors_presence
(
    exam_id INTEGER REFERENCES exams(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    inspector_id INTEGER REFERENCES inspectors(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    cabinet_id INTEGER REFERENCES cabinets(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL
);

CREATE TABLE exam_results
(
    id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES students(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    exam_id INTEGER REFERENCES exams(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    cabinet_id INTEGER REFERENCES cabinets(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    variant INTEGER NOT NULL CHECK (1 <= variant and variant <= 30),
    exam_grade INTEGER NOT NULL CHECK (100 <= exam_grade and exam_grade <= 200)
);