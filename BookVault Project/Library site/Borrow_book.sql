SET VERIFY OFF
SET serveroutput on

CREATE OR REPLACE PACKAGE BorrowFromLibraryPackage AS
	FUNCTION BorrowBook(
        p_PhoneNo  VARCHAR2,
        p_BorrowBookName   books.title%type,
        p_LoanDate DATE,
        p_ReturnDate DATE
    ) RETURN BOOLEAN;
END BorrowFromLibraryPackage;
/

--Package Body
CREATE OR REPLACE PACKAGE BODY BorrowFromLibraryPackage AS
	--Function to implement feature Borrow a Book 
	FUNCTION BorrowBook(
        p_PhoneNo  VARCHAR2,
        p_BorrowBookName   books.title%type,
        p_LoanDate DATE,
        p_ReturnDate DATE
    ) RETURN BOOLEAN IS
	v_total_borrowed number;
	v_borrow_BookID number;
    BEGIN
		--to get next Borow_ID
		SELECT COUNT(*)
        INTO v_total_borrowed
        FROM Borrowers;
		v_total_borrowed := v_total_borrowed + 1 ;
		
		--Get Book_Id from Books table
		SELECT Book_ID
        INTO v_borrow_BookID
        FROM Books1
        WHERE Title = p_BorrowBookName;
		
        INSERT INTO Borrowers (Borrow_ID, Phone_No, Book_ID, Loan_Date, Return_Date, Fine)
        VALUES (v_total_borrowed, p_PhoneNo, v_borrow_BookID, p_LoanDate, p_ReturnDate, 0);
        COMMIT;

        -- Update the Availability_Status_Library for the borrowed book copy
        UPDATE Book_Copies1
        SET Availability_Status_Library = (Availability_Status_Library-1)
        WHERE Book_ID = v_borrow_BookID AND Availability_Status_Library > 0;
		commit;
		
        RETURN TRUE;
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Borrower ID already exists.');
            ROLLBACK;
            RETURN FALSE;
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Book not available for borrowing.');
            ROLLBACK;
            RETURN FALSE;
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
            ROLLBACK;
            RETURN FALSE;
    END BorrowBook;
	
END BorrowFromLibraryPackage;
/
DECLARE
	--for borrow book
    v_PhoneNo    VARCHAR2(11);
    v_BorrowBookName   books.title%type;
    v_LoanDate   DATE;
    v_ReturnDate DATE;
    v_Borrowed   BOOLEAN;
BEGIN
	-- Get user input
    v_PhoneNo := '&Borrower_PhoneNo';
    v_BorrowBookName := '&Book_to_Borrow';
    v_LoanDate := TO_DATE('&Enter_LoanDate', 'YYYY-MM-DD');
    v_ReturnDate := TO_DATE('&Enter_ReturnDate', 'YYYY-MM-DD');

    -- Call the BorrowBook function with user input
    v_Borrowed := BorrowFromLibraryPackage.BorrowBook(v_PhoneNo, v_BorrowBookName, v_LoanDate, v_ReturnDate);

    -- Display the result
    IF v_Borrowed THEN
        DBMS_OUTPUT.PUT_LINE('Book borrowed successfully.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Book borrowing failed.');
    END IF;
END;
/


