set serveroutput on
set verify off
DECLARE
    v_max_price Books2.Price%TYPE;
BEGIN
    -- Get input from the user
    v_max_price := &max_price;

    -- Show books from books2 with price less than user input
    FOR book_rec IN (
        SELECT b2.Title, b1.Author, b1.Publication
        FROM Books2 b2
        JOIN Books1@site b1 ON b2.Book_ID = b1.Book_ID
        WHERE b2.Price < v_max_price
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Title: ' || book_rec.Title || ', Author: ' || book_rec.Author || ', Publisher: ' || book_rec.Publication);
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/
