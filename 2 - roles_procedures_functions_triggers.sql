CREATE ROLE center_worker WITH PASSWORD 'worker404';
CREATE ROLE instructor;
REVOKE ALL PRIVILEGES ON exam_results, cities, disciplines, exams, inspectors_presence, schools, students FROM center_worker;
GRANT SELECT ON schools, cities, testing_centres TO center_worker;
GRANT INSERT, UPDATE, SELECT ON students, exam_results, disciplines, exams TO center_worker;
REVOKE ALL PRIVILEGES ON exam_results, cities, disciplines, exams, inspectors_presence, schools, students, testing_centres, cabinets, inspectors FROM instructor;
GRANT SELECT ON testing_centres, cabinets, exams, disciplines, inspectors, inspectors_presence, cities TO instructor;


CREATE OR REPLACE PROCEDURE remove_from_exams(value timestamp)
LANGUAGE plpgsql AS
$$
BEGIN
    IF value = ANY(array(SELECT exam_date_time FROM exams)) THEN
        DELETE FROM exams WHERE exam_date_time = value;
    ELSE
        RAISE NOTICE 'Such time does not exist in exams!';
    END IF;
END
$$;


CREATE OR REPLACE FUNCTION disciplines_inserter() RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
     IF NEW.is_mandatory = TRUE THEN
        RAISE NOTICE '% is added to disciplines and is mandatory.', NEW.name;
     ELSE
        RAISE NOTICE '% is added to disciplines and is not mandatory.', NEW.name;
     END IF;
     RETURN NEW;
END;
$$;

CREATE TRIGGER disciplines_inserter_trigger
 AFTER INSERT
 ON "disciplines"
 FOR EACH ROW
EXECUTE PROCEDURE disciplines_inserter();


CREATE OR REPLACE FUNCTION inspector_deleter() RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
 RAISE NOTICE '%s %s %s is fired and is not inspector no longer.', NEW.surname, NEW.name, NEW.second_name;
 RETURN NEW;
END;
$$;

CREATE TRIGGER inspector_delete_trigger
 AFTER DELETE
 ON "inspectors"
 FOR EACH ROW
EXECUTE PROCEDURE inspector_deleter();


CREATE VIEW results AS SELECT (SELECT personal_code FROM students WHERE id = exam_results.student_id), exam_grade FROM exam_results;
CREATE VIEW present_inspectors AS SELECT surname, name, second_name FROM inspectors WHERE id IN (SELECT inspector_id FROM inspectors_presence);