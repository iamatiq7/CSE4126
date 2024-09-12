SET VERIFY OFF
SET SERVEROUTPUT ON;
DECLARE
    need NUMBER;
    faculty_count NUMBER;
	total_student NUMBER;
	needs NUMBER;
BEGIN

    -- Get how many student needs one faculty
    need := &input;

    -- Query to count rows in the STUDENT and FACULTY table
    SELECT COUNT(*) INTO total_student FROM STUDENT;
    SELECT COUNT(*) INTO faculty_count FROM FACULTY;
	
	-- Calculate total required facultie
	needs := total_student/need;

    -- Compare the row count with user input
    IF faculty_count >= needs THEN
        DBMS_OUTPUT.PUT_LINE('There are enough faculties for all students.');
    ELSIF faculty_count < needs THEN
        DBMS_OUTPUT.PUT_LINE('More faculties needs to be appointed.');
    END IF;
END;
/