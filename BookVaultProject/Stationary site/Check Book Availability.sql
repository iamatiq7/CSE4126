set serveroutput on
set verify off
-- Create a PL/SQL procedure to search for a book by title
CREATE OR REPLACE PROCEDURE FindBookIDByTitle(p_book_title in VARCHAR2, p_book_id OUT NUMBER)
IS
BEGIN
  -- Initialize the output parameter to None
  p_book_id := 0;


  -- Search for the book by title in the Books2 table
  SELECT Book_ID INTO p_book_id
  FROM Books2
  WHERE Title = p_book_title;


  -- If the book is not found, set p_book_id to 0
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      p_book_id := 0;
END;
/
-- Create a PL/SQL procedure to search for a book by title
CREATE OR REPLACE PROCEDURE PrintAvailabilityStatus(f_book_id in NUMBER)
IS
	total_available_books NUMBER;
	book_price NUMBER;
BEGIN
	
	IF f_book_id > 0 THEN
		SELECT Availability_Status_Shop INTO total_available_books
		FROM book_copies2
		WHERE Book_ID = f_book_id;
		
		IF total_available_books > 0 THEN
			SELECT price into book_price
			FROM Books2
			WHERE Book_ID = f_book_id;
		
			DBMS_OUTPUT.PUT_LINE('Book available. Book Price: ' || book_price);
		ELSE
			DBMS_OUTPUT.PUT_LINE('Book not available right now.');
		END IF;
	ELSE
		DBMS_OUTPUT.PUT_LINE('Book not available.');
	END If;
END;
/

DECLARE
	v_book_title books2.title%type; 
	v_book_id NUMBER;
BEGIN
	v_book_title := '&book_title';
	FindBookIDByTitle(v_book_title, v_book_id);
	--DBMS_OUTPUT.PUT_LINE(v_book_id);
	PrintAvailabilityStatus(v_book_id);
END;
/


