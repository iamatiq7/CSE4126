SET SERVEROUTPUT ON;

DECLARE
    CURSOR MembersCursor IS
        SELECT Name, Phone_No
        FROM Members1
        UNION ALL
        SELECT Name, Phone_No
        FROM Members2@site
        UNION ALL
        SELECT Name, Phone_No
        FROM Members3@site;
    
    v_member_name Members1.Name%TYPE;
    v_member_phone Members1.Phone_No%TYPE;
BEGIN
	-- Retrieve and display members names and phone numbers
	DBMS_OUTPUT.PUT_LINE('ALl members name with their name and phone no: ');
    OPEN MembersCursor;
    LOOP
        FETCH MembersCursor INTO v_member_name, v_member_phone;
        EXIT WHEN MembersCursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Member Name: ' || v_member_name || ', Phone: ' || v_member_phone);
    END LOOP;
    CLOSE MembersCursor;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/
