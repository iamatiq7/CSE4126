DECLARE
    v_book_title Books2.Title%TYPE;
    v_books_to_add NUMBER;
    v_book_id Books2.Book_ID%TYPE;
BEGIN
    -- Get input from user
    v_book_title := '&book_title';
    v_books_to_add := &books_to_add;

    -- Search for the book_id in Books2 table
    SELECT Book_ID INTO v_book_id
    FROM Books2
    WHERE Title = v_book_title;

    -- Update availability_status_shop in Book_Copies2 table
    UPDATE Book_Copies2
    SET Availability_Status_Shop = Availability_Status_Shop + v_books_to_add
    WHERE Book_ID = v_book_id;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Availability status updated successfully.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Book not found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
        ROLLBACK;
END;
/
