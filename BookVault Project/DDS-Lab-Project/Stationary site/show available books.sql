SET SERVEROUTPUT ON;

DECLARE
    CURSOR AvailableBooksCursor IS
        SELECT B1.Title, B1.Author, B2.Price
        FROM Books1@site B1
        JOIN Book_Copies2 BC2 ON B1.Book_ID = BC2.Book_ID
        JOIN Books2 B2 ON BC2.Book_ID = B2.Book_ID
        WHERE BC2.Availability_Status_Shop > 0;
    
    v_title VARCHAR2(25);
    v_author VARCHAR2(25);
    v_price Books2.Price%TYPE;
BEGIN
    OPEN AvailableBooksCursor;
    LOOP
        FETCH AvailableBooksCursor INTO v_title, v_author, v_price;
        EXIT WHEN AvailableBooksCursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Title: ' || v_title || ', Author: ' || v_author || ', Price: ' || v_price);
    END LOOP;
    CLOSE AvailableBooksCursor;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/
