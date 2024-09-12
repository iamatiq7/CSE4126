SET VERIFY OFF
SET serveroutput on

CREATE OR REPLACE PACKAGE BorrowFromLibraryPackage AS
	FUNCTION BorrowBook(
        p_PhoneNo  VARCHAR2,
        p_BorrowBookName   books1.title%type,
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
        p_BorrowBookName   books1.title%type,
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
		
		-- Update the Availability_Status_Library for the borrowed book copy
        UPDATE Book_Copies1 SET Availability_Status_Library = (Availability_Status_Library-1)
        WHERE Book_ID = v_borrow_BookID AND Availability_Status_Library > 0;
		
        INSERT INTO Borrowers  VALUES (
		v_total_borrowed, p_PhoneNo, v_borrow_BookID, p_LoanDate, p_ReturnDate, 0);
		
        RETURN TRUE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Book not available.');
            ROLLBACK;
            RETURN FALSE;
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
            ROLLBACK;
            RETURN FALSE;
    END BorrowBook;
	
END BorrowFromLibraryPackage;
/
CREATE OR REPLACE FUNCTION ProcessMembership(p_PhoneNo IN VARCHAR2)
    RETURN NUMBER
IS
    v_membership_status Members.Membership_Status%TYPE;
    v_name Members1.Name%TYPE;
    v_address Members1.Address%TYPE;
    v_start_date_lib Members1.Start_Date_Lib%TYPE;
    v_end_date_lib DATE;
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
		SELECT Name, Address, Start_Date_Lib
		INTO v_name, v_address, v_start_date_lib
		FROM Members2@site
		WHERE Phone_No = p_PhoneNo;
        DELETE FROM Members2@site WHERE Phone_No = p_PhoneNo;

        v_end_date_lib := ADD_MONTHS(TRUNC(SYSDATE), 1);
		
        INSERT INTO Members3@site (Phone_No, Name, Address, Membership_Status, Card, Start_Date_Lib, End_Date_Lib)
        VALUES (p_PhoneNo, v_name, v_address, 'Both', 'Valid', v_start_date_lib, v_end_date_lib);
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

DECLARE
	--for borrow book
    v_PhoneNo    VARCHAR2(11);
    v_BorrowBookName   books1.title%type;
    v_LoanDate   DATE;
    v_ReturnDate DATE;
	v_card_status VARCHAR2(7);
    v_Borrowed   BOOLEAN;
	v_days number;
	v_already_Borrowed number;
	v_member number;
	late_fee number;
BEGIN
	-- Get user input
    v_PhoneNo := '&Borrower_PhoneNo';
    v_BorrowBookName := '&Book_to_Borrow';
	v_days := &days;
    v_LoanDate := TRUNC(SYSDATE);
    v_ReturnDate := TRUNC(SYSDATE + v_days);
	UpdateFine;
	UpdateCardStatus;
	
	select count(*) into v_already_Borrowed from Borrowers where phone_no = v_PhoneNo;
	
	if v_already_Borrowed < 1 THEN
	
		SELECT Card INTO v_card_status FROM ( SELECT Card FROM Members1 WHERE Phone_No = v_PhoneNo 
		UNION ALL SELECT Card FROM Members3@site WHERE Phone_No = v_PhoneNo );
		
		if v_card_status = 'Valid' THEN
			v_member := ProcessMembership(v_PhoneNo);

			-- Call the BorrowBook function with user input
			if v_member = 1 OR v_member = 2  then
				v_Borrowed := BorrowFromLibraryPackage.BorrowBook(v_PhoneNo, v_BorrowBookName, v_LoanDate, v_ReturnDate);
			end if;
		
			IF v_Borrowed THEN
				DBMS_OUTPUT.PUT_LINE('Book borrowed successfully.');
			ELSE
				DBMS_OUTPUT.PUT_LINE('Not a member.');
			END IF;
		ELSE
			DBMS_OUTPUT.PUT_LINE('Not a valid member.');
			
		end if;
	ELSE
		select fine into late_fee from borrowers where phone_no = v_PhoneNo;
		DBMS_OUTPUT.PUT_LINE('Already borrowed a book or membership card expired. Late fee: ' || late_fee);
	end if;
	
	commit;
	EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
        ROLLBACK;
END;
/


