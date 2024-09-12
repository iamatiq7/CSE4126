SET SERVEROUTPUT ON
DECLARE
    -- Declare variables for cursor
    CURSOR c_member_info IS
        SELECT M.Phone_No, M.Name, M.Start_Date_Lib
        FROM Members2 M
        UNION
        SELECT M.Phone_No, M.Name, M.Start_Date_Lib
        FROM Members3 M;
    
    -- Variables to hold cursor data
    v_phone_no Members2.Phone_No%TYPE;
    v_name Members2.Name%TYPE;
    v_start_date_lib Members2.Start_Date_Lib%TYPE;
BEGIN
    -- Open the cursor
    OPEN c_member_info;
    FETCH c_member_info INTO v_phone_no, v_name, v_start_date_lib;
    
    IF c_member_info%FOUND THEN
        DBMS_OUTPUT.PUT_LINE(RPAD('Name', 16) || RPAD('Phone No', 12) || RPAD('Start Date', 15));
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE(RPAD(v_name, 16) || RPAD(v_phone_no, 12) || RPAD(v_start_date_lib, 15));
    END IF;


    -- Fetch and display member information
    LOOP
        FETCH c_member_info INTO v_phone_no, v_name, v_start_date_lib;
        EXIT WHEN c_member_info%NOTFOUND;


        -- Display member info
        DBMS_OUTPUT.PUT_LINE(RPAD(v_name, 16) || RPAD(v_phone_no, 12) || RPAD(v_start_date_lib, 15));
    END LOOP;


    -- Close the cursor
    CLOSE c_member_info;
END;
/




