set verify off
set serveroutput ON

DECLARE
    v_phone_no Borrowers.Phone_No%TYPE;
    v_fine Borrowers.Fine%TYPE;
    v_book_id Borrowers.Book_ID%TYPE;
BEGIN
    -- Get user input
    v_phone_no := '&phone_no';

    -- Search for the phone number in the Borrowers table
    SELECT Fine, Book_ID
    INTO v_fine, v_book_id
    FROM Borrowers
    WHERE Phone_No = v_phone_no;

    -- Display the fine value and book details
        DBMS_OUTPUT.PUT_LINE('Borrowed book returned with ' || v_fine || ' late fee.');
		delete from borrowers where Phone_No = v_phone_no;
		-- Increment Availability_Status_Library by 1 for the book in Book_Copies1
		UPDATE Book_Copies1
		SET Availability_Status_Library = Availability_Status_Library + 1
		WHERE Book_ID = v_book_id;

    -- Optionally, you can retrieve and display more information about the book using v_book_id

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Phone number not found in the Borrowers table.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/
