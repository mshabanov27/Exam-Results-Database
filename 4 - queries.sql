SET ROLE center_worker;
SELECT (SELECT name FROM disciplines WHERE id = exams.discipline_id), exam_date_time FROM exams;
SELECT name, state FROM cities WHERE id IN (SELECT city_id FROM testing_centres);
SELECT (SELECT surname FROM students WHERE student_id = students.id),
       (SELECT name FROM students WHERE student_id = students.id),
        exam_grade FROM exam_results
        WHERE variant IN (1, 4, 7, 10, 13, 16, 19, 22, 25, 28);
SELECT name, examined_students FROM schools WHERE city_id IN (SELECT id FROM cities) and examined_students < 50;
SELECT (SELECT name FROM disciplines WHERE id IN
        (SELECT id FROM exams WHERE id = exam_results.exam_id)) AS discipline_name, COUNT(*)
FROM exam_results GROUP BY discipline_name;

SET ROLE instructor;
SELECT surname, name, second_name FROM inspectors WHERE id IN (SELECT inspector_id FROM inspectors_presence) and surname LIKE 'П%';
SELECT name, is_mandatory FROM disciplines WHERE id IN (SELECT discipline_id FROM exams WHERE EXTRACT(year FROM exam_date_time) = 2021);
SELECT (SELECT name FROM cities WHERE id = testing_centres.city_id) AS city, COUNT(*) FROM testing_centres GROUP BY city;
SELECT (SELECT surname FROM inspectors WHERE id = inspectors_presence.inspector_id),
       (SELECT name FROM inspectors WHERE id = inspectors_presence.inspector_id),
       (SELECT second_name FROM inspectors WHERE id = inspectors_presence.inspector_id),
       (SELECT cabinet_number FROM cabinets WHERE id = inspectors_presence.cabinet_id)
FROM inspectors_presence;

SELECT (SELECT surname FROM students WHERE student_id = students.id),
       (SELECT name FROM students WHERE student_id = students.id),
       (SELECT second_name FROM students WHERE student_id = students.id),
        exam_grade FROM exam_results WHERE exam_id = 5 ORDER BY exam_grade desc;

SELECT surname, name, second_name FROM students UNION SELECT surname, name, second_name FROM inspectors ORDER BY surname, name, second_name;
SELECT name, array_to_string(array(SELECT surname FROM students WHERE school_id = schools.id), ', ') AS students_list FROM schools;
SELECT cabinet_number, (SELECT address FROM testing_centres WHERE id = cabinets.testing_centre_id)
FROM cabinets WHERE cabinet_number BETWEEN 50 AND 150;

SELECT (SELECT (SELECT name FROM disciplines WHERE id = exams.discipline_id) FROM exams WHERE id = exam_results.exam_id),
        exam_grade FROM exam_results
        WHERE exam_grade > (SELECT AVG(exam_grade) FROM exam_results);

SELECT (SELECT surname FROM inspectors WHERE id = inspectors_presence.inspector_id) AS inspector_surname,
       (SELECT name FROM inspectors WHERE id = inspectors_presence.inspector_id) AS inspector_name,
       (SELECT second_name FROM inspectors WHERE id = inspectors_presence.inspector_id) AS inspector_second_name,
       (SELECT DATE_TRUNC('minutes', exam_date_time) FROM exams WHERE id = inspectors_presence.exam_id) AS exam_time
FROM inspectors_presence ORDER BY inspector_surname, inspector_name, inspector_second_name;

SELECT (SELECT name FROM disciplines WHERE id = exams.discipline_id), exam_date_time
FROM exams WHERE exam_date_time BETWEEN '2021-05-21 10:00:00' AND '2021-06-25 10:00:00';

SELECT exam_grade, COUNT(*) FROM exam_results GROUP BY exam_grade HAVING COUNT(*) > 5 ORDER BY exam_grade desc;

SELECT name, array_to_string(array(SELECT name FROM schools WHERE city_id = cities.id), ', ') AS schools_list FROM cities;

SELECT surname, name, second_name, exam_grade FROM students JOIN exam_results er on students.id =
er.student_id WHERE exam_grade BETWEEN 150 AND 175 ORDER BY exam_grade;

SELECT (SELECT surname FROM students WHERE student_id = students.id) as student_surname,
       (SELECT name FROM students WHERE student_id = students.id) as student_name,
       (SELECT second_name FROM students WHERE student_id = students.id) as student_second_name,
       (SELECT personal_code FROM students WHERE student_id = students.id),
       (SELECT (SELECT name FROM disciplines WHERE id = exams.discipline_id) FROM exams WHERE id = exam_results.exam_id),
        exam_grade FROM exam_results ORDER BY student_surname, student_name, student_second_name desc;