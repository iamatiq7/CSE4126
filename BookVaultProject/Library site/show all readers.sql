SET SERVEROUTPUT ON
DECLARE
    -- Declare variables for cursor
    CURSOR c_member_info IS
        SELECT M.Phone_No, M.Name, M.Start_Date_Lib, M.End_Date_Lib, M.Card
        FROM Members1 M
        UNION
        SELECT M.Phone_No, M.Name, M.Start_Date_Lib, M.End_Date_Lib, M.Card
        FROM Members3@site M;
    
    -- Variables to hold cursor data
    v_phone_no Members1.Phone_No%TYPE;
    v_name Members1.Name%TYPE;
    v_start_date_lib Members1.Start_Date_Lib%TYPE;
    v_end_date_lib Members1.End_Date_Lib%TYPE;
    v_card Members1.Card%TYPE;
BEGIN
    -- Open the cursor
    OPEN c_member_info;
    FETCH c_member_info INTO v_phone_no, v_name, v_start_date_lib, v_end_date_lib, v_card;
    
    IF c_member_info%FOUND THEN
        DBMS_OUTPUT.PUT_LINE(RPAD('Name', 16) || RPAD('Phone No', 12) || RPAD('Start Date', 15) || RPAD('End Date', 15) || ' Card');
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE(RPAD(v_name, 16) || RPAD(v_phone_no, 12) || RPAD(v_start_date_lib, 15) || RPAD(v_end_date_lib, 15) || ' ' || v_card);
    END IF;

    -- Fetch and display member information
    LOOP
        FETCH c_member_info INTO v_phone_no, v_name, v_start_date_lib, v_end_date_lib, v_card;
        EXIT WHEN c_member_info%NOTFOUND;

        -- Display member info
        DBMS_OUTPUT.PUT_LINE(RPAD(v_name, 16) || RPAD(v_phone_no, 12) || RPAD(v_start_date_lib, 15) || RPAD(v_end_date_lib, 15) || ' ' || v_card);
    END LOOP;

    -- Close the cursor
    CLOSE c_member_info;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/
