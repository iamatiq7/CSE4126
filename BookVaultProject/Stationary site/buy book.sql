set serveroutput ON
set verify OFF

DECLARE
    v_phone_no Members3.Phone_no%TYPE;
    v_book_title Books2.Title%TYPE;
    v_book_id Books2.Book_ID%TYPE;
    book_price NUMBER;
    total_available_books NUMBER;
    discount_amount NUMBER := 0.2; -- 20% discount
    pay_amount NUMBER;
    v_count NUMBER;
	v_count1 NUMBER;
	v_count2 NUMBER;
    v_date DATE;
BEGIN
    -- Get input from user
    v_phone_no := '&phone_no';
    v_book_title := '&book_title';

    -- Search for the book_id in Books2 table
    SELECT Book_ID INTO v_book_id
    FROM Books2
    WHERE Title = v_book_title;

    SELECT Availability_Status_Shop INTO total_available_books
    FROM Book_Copies2
    WHERE Book_ID = v_book_id;

    IF total_available_books > 0 THEN
        SELECT Price INTO book_price
        FROM Books2
        WHERE Book_ID = v_book_id;

        -- Check if the phone_no exists in Members3 table
        SELECT COUNT(*) INTO v_count
        FROM Members3
        WHERE Phone_no = v_phone_no;

        IF v_count > 0 THEN
            pay_amount := book_price - (book_price * discount_amount);
			DBMS_OUTPUT.PUT_LINE('-');
            DBMS_OUTPUT.PUT_LINE('This book is available. Pay Amount after discount: ' || pay_amount);
        ELSE
            pay_amount := book_price;
			DBMS_OUTPUT.PUT_LINE('-');
            DBMS_OUTPUT.PUT_LINE('This book is available. Pay Amount: ' || pay_amount);
			
			-- Check if the phone_no exists in Members1 table
			SELECT COUNT(*) INTO v_count1
			FROM Members1@site
			WHERE Phone_no = v_phone_no;
			
			-- Check if the phone_no exists in Members2 table
			SELECT COUNT(*) INTO v_count2
			FROM Members2
			WHERE Phone_no = v_phone_no;
			
			IF v_count1 < 1 AND v_count2 < 1 THEN
				InsertMember2(v_phone_no);
			ELSIF v_count1 > 0  THEN
				InsertMember3(v_phone_no);
			END IF;
        END IF;

        -- Update availability_status_shop in Book_Copies2 table
        UPDATE Book_Copies2
        SET Availability_Status_Shop = Availability_Status_Shop - 1
        WHERE Book_ID = v_book_id;
		
		

        -- Insert purchase details into Purchases table
        v_date := SYSDATE; -- Current date and time
        INSERT INTO Purchases VALUES (Purchases_seq.nextval, v_phone_no, v_book_id, v_date);
	
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Book bought successfully.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Book not available right now.');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Book not found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
        ROLLBACK;
END;
/
