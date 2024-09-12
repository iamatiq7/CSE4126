SET VERIFY OFF
SET serveroutput on

CREATE OR REPLACE PROCEDURE InsertLibraryMember AS
	v_phone_number   VARCHAR2(14);
    v_name           VARCHAR2(40);
    v_address        VARCHAR2(40);
	v_membership     VARCHAR2(10);
    v_start_date_lib DATE;
    v_end_date_lib   DATE;
	v_existing_membership VARCHAR2(10);
	v_member_count NUMBER;
BEGIN
    -- Input values from the user
    v_phone_number := '&phone';
    v_name := '&name';
    v_address := '&address';
	v_membership := 'reader';
    v_start_date_lib := TRUNC(SYSDATE); -- Today's date
    v_end_date_lib := TRUNC(ADD_MONTHS(SYSDATE, 1)); -- Same day of next month
	v_existing_membership := 'none';
	
	SELECT COUNT(*)
    INTO v_member_count
    FROM Members
    WHERE Phone_no = v_phone_number;
	
	IF v_member_count > 0 THEN
	SELECT Membership_status
    INTO v_existing_membership
    FROM Members
    WHERE Phone_No = v_phone_number;
	END IF;
	
	-- If the member exists and is a 'reader', and the new membership is 'customer', update the membership status to 'both'
   	
	IF v_existing_membership = 'Customer' THEN
        UPDATE Members
        SET Membership_status = 'Both'
        WHERE Phone_No = v_phone_number;
    COMMIT;
	DBMS_OUTPUT.PUT_LINE('Updated status as both.');
	
	ELSE
    -- Insert the values into the Members table
    INSERT INTO Members VALUES (
        v_phone_number,
        v_name,
        v_address,
        v_membership,
        v_start_date_lib,
        v_end_date_lib
    );
	
    COMMIT;
	
	END If;
	
EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Phone number already registered.');
		ROLLBACK;
		
	WHEN no_data_found THEN
		DBMS_OUTPUT.PUT_LINE('No data exist.');
		ROLLBACK;
		
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred.');
        ROLLBACK;
END;
/


DECLARE
BEGIN
    InsertLibraryMember;
END;
/
