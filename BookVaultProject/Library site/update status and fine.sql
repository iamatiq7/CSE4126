CREATE OR REPLACE PROCEDURE UpdateFine AS
BEGIN
    -- Update the fine by 1 for borrowers whose return date has passed
    UPDATE Borrowers
    SET fine = 60
    WHERE Return_Date < SYSDATE;
	
    COMMIT;
    --DBMS_OUTPUT.PUT_LINE('Fine updates completed.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
        ROLLBACK;
END;
/

CREATE OR REPLACE PROCEDURE UpdateCardStatus AS
BEGIN
    -- Update card status for members in Members1 table
    UPDATE Members1
    SET Card = 'Invalid'
    WHERE end_date_lib < TRUNC(SYSDATE);
    
    -- Update card status for members in Members3 table
    UPDATE Members3@site
    SET Card = 'Invalid'
    WHERE end_date_lib < TRUNC(SYSDATE);
    
    COMMIT;
    --DBMS_OUTPUT.PUT_LINE('Card status updated successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
        ROLLBACK;
END;
/

