set serveroutput ON
set verify OFF

CREATE OR REPLACE PROCEDURE InsertMember2(
    p_phone_no IN Members2.Phone_No%TYPE
) AS
    v_name Members2.Name%TYPE;
    v_address Members2.Address%TYPE;
	v_start_date_lib date;
BEGIN
    -- Get user input for name and address
    v_name := '&name';
    v_address := '&address';

    -- Get today's date
    v_start_date_lib := SYSDATE;

    -- Insert values into Members2 table
    INSERT INTO Members2 (Phone_No, Name, Address, Membership_Status, Start_Date_lib)
    VALUES (p_phone_no, v_name, v_address, 'Customer', v_start_date_lib);

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Member inserted successfully.');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Phone number already registered.');
        ROLLBACK;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
        ROLLBACK;
END InsertMember2;
/
