SET VERIFY OFF
SET serveroutput on

CREATE OR REPLACE PROCEDURE InsertLibraryMember AS
	v_phone_number   VARCHAR2(14);
    v_name           VARCHAR2(40);
    v_address        VARCHAR2(40);
	f_name           VARCHAR2(40);
    f_address        VARCHAR2(40);
	v_membership     VARCHAR2(10);
    v_start_date_lib DATE;
    v_end_date_lib   DATE;
	v_start_date members1.start_date_lib%type;
    v_end_date   members1.start_date_lib%type;
	v_member_count NUMBER;
	v_member_count1 NUMBER;
	v_member_count2 NUMBER;
BEGIN
    -- Input values from the user
    v_phone_number := '&phone';
    v_name := '&name';
    v_address := '&address';
	v_membership := 'Customer';
    v_start_date_lib := TRUNC(SYSDATE); -- Today's date
    v_end_date_lib := TRUNC(ADD_MONTHS(SYSDATE, 1)); -- Same day of next month
	
	SELECT COUNT(*) INTO v_member_count2 FROM Members1 WHERE Phone_no = v_phone_number;
	SELECT COUNT(*) INTO v_member_count FROM Members2@site WHERE Phone_no = v_phone_number;
	SELECT COUNT(*) INTO v_member_count1 FROM Members3@site WHERE Phone_no = v_phone_number;
	
	-- If the member exists and is a 'reader', and the new membership is 'customer', update the membership status to 'both'
    IF v_member_count > 0 THEN
		SELECT name, address, start_date_lib
		INTO f_name, f_address, v_start_date 
		from MEMBERS2@site
		where Phone_No = v_phone_number;
		
		DELETE FROM Members2@site
        WHERE Phone_No = v_phone_number;
		
		INSERT INTO Members3@site VALUES 
		(v_phone_number, f_name, f_address, 'Both', v_start_date, v_end_date_lib, 'Valid');
	DBMS_OUTPUT.PUT_LINE('Updated status as Both.');
	
	ELSIF v_member_count1 < 1 AND v_member_count2 < 1 THEN
    -- Insert the values into the Members table
    INSERT INTO Members1 VALUES (
        v_phone_number,
        v_name,
        v_address,
        v_membership,
        v_start_date_lib,
		v_end_date_lib,
		'Valid'
    );
	ELSE
		DBMS_OUTPUT.PUT_LINE('Phone number already registered.');
	END If;
END;
/


DECLARE
BEGIN
    InsertLibraryMember;
	COMMIT;
END;
/
