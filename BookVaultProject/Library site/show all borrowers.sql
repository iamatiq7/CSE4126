set serveroutput on
DECLARE
    -- Declare variables for cursor
    CURSOR c_borrower_info IS
        SELECT B.Phone_No, M.Name, M.Address, B.Loan_Date, B.Return_Date, B.fine
        FROM Borrowers B
        INNER JOIN (
            SELECT Phone_No, Name, Address
            FROM Members1
            UNION
            SELECT Phone_No, Name, Address
            FROM Members3@site
        ) M ON B.Phone_No = M.Phone_No;
    
    -- Variables to hold cursor data
    v_phone_no Members1.Phone_No%TYPE;
    v_name Members1.Name%TYPE;
    v_address Members1.Address%TYPE;
    v_loan_date Borrowers.Loan_Date%TYPE;
    v_return_date Borrowers.Return_Date%TYPE;
    v_fine Borrowers.fine%TYPE;
BEGIN
	UpdateFine;
	UpdateCardStatus;
    -- Open the cursor
    OPEN c_borrower_info;
	FETCH c_borrower_info INTO v_phone_no, v_name, v_address, v_loan_date, v_return_date, v_fine;
	if c_borrower_info%FOUND then
		DBMS_OUTPUT.PUT_LINE(RPAD('Name', 16) || RPAD('Address', 20) || RPAD('Phone No', 12) || RPAD('Loan Date', 10) || RPAD('Return Date', 11) || ' Fine');
		DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------------');
		DBMS_OUTPUT.PUT_LINE(RPAD(v_name, 16) || RPAD(v_address, 20) || RPAD(v_phone_no, 12) || RPAD(v_loan_date, 10) || RPAD(v_return_date, 11) ||' '|| v_fine);
	end if;
    -- Fetch and display borrower information
    LOOP
        FETCH c_borrower_info INTO v_phone_no, v_name, v_address, v_loan_date, v_return_date, v_fine;
        EXIT WHEN c_borrower_info%NOTFOUND;
        
        -- Display borrower info
        DBMS_OUTPUT.PUT_LINE(RPAD(v_name, 16) || RPAD(v_address, 20) || RPAD(v_phone_no, 12) || RPAD(v_loan_date, 10) || RPAD(v_return_date, 11) ||' '|| v_fine);
    END LOOP;

    -- Close the cursor
    CLOSE c_borrower_info;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/
