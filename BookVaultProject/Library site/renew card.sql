CREATE OR REPLACE PROCEDURE RenewCardStatus(p_PhoneNo IN VARCHAR2) AS
    v_next_month DATE;
	v_card_status varchar2(7);
BEGIN
	SELECT Card INTO v_card_status FROM ( SELECT Card FROM Members1 WHERE Phone_No = p_PhoneNo 
	UNION ALL SELECT Card FROM Members3@site WHERE Phone_No = p_PhoneNo );
	
    -- Calculate the same date of the next month
    v_next_month := ADD_MONTHS(TRUNC(SYSDATE), 1);
    -- Update card status and end_date_lib for Members1
    UPDATE Members1
    SET Card = 'Valid',
        End_Date_Lib = v_next_month
    WHERE Phone_No = p_PhoneNo;
    
    -- Update card status and end_date_lib for Members3
    UPDATE Members3@site
    SET Card = 'Valid',
        End_Date_Lib = v_next_month
    WHERE Phone_No = p_PhoneNo;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Card status renewed and End_Date_Lib updated.');
EXCEPTION
	WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Member not registered.');
        ROLLBACK;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
        ROLLBACK;
END;
/
DECLARE
	phone_no varchar2(11);
BEGIN
	phone_no := '&phone';
	RenewCardStatus(phone_no);
END;
/
	