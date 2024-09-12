CREATE OR REPLACE FUNCTION ProcessMembership(p_PhoneNo IN VARCHAR2)
    RETURN NUMBER
IS
	v_count number;
BEGIN
	v_count := 0;
    -- Check if the phone number is in Members1 table
    SELECT COUNT(*) INTO v_count
    FROM (SELECT Phone_No from Members1 UNION SELECT Phone_No from Members3@site)
    WHERE Phone_No = p_PhoneNo;

    IF v_count > 0THEN
        RETURN 1;
    END IF;

    -- Check if the phone number is in Members2 table
	SELECT COUNT(*) INTO v_count
    FROM Members2@site
    WHERE Phone_No = p_PhoneNo;
	
    IF v_count > 0 THEN
        RETURN 2;
    END IF;

    RETURN 0;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        RETURN 0;
END;
/
-- call the function in an assignment statement
DECLARE
	phone varchar2(11);
    v_result NUMBER;
BEGIN
	phone := '&phone_no';
	v_result := ProcessMembership(phone);
	--DBMS_OUTPUT.PUT_LINE(v_result);
	if v_result = 1 then
		DBMS_OUTPUT.PUT_LINE('Already a reader.');
	elsif v_result = 2 then
		DBMS_OUTPUT.PUT_LINE('Registered as customer.');
	else 
		DBMS_OUTPUT.PUT_LINE('Not a member.');
	end if;
END;
/