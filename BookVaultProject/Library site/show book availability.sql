DECLARE
    CURSOR c_latest_return_date IS
        SELECT 
            BC2.Book_ID,B.Title,B.Author,B.Publication,
            MIN(Return_Date) AS Latest_Return_Date,
            SUM(CASE WHEN Availability_Status_Shop > 0 THEN 1 ELSE 0 END) AS Availability_Status
			FROM Book_Copies2@site BC2
			JOIN Books1 B ON BC2.Book_ID = B.Book_ID
			LEFT JOIN Borrowers BR ON BC2.Book_ID = BR.Book_ID
			GROUP BY BC2.Book_ID, B.Title, B.Author, B.Publication;

    v_book_id Books1.Book_ID%TYPE;
    v_title Books1.Title%TYPE;
    v_author Books1.Author%TYPE;
    v_publication Books1.Publication%TYPE;
    v_latest_return_date Borrowers.Return_Date%TYPE;
    v_availability_status NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Title                    Author              Publication         Availability');

    FOR book_rec IN c_latest_return_date LOOP
        v_book_id := book_rec.Book_ID;
        v_title := book_rec.Title;
        v_author := book_rec.Author;
        v_publication := book_rec.Publication;
        v_latest_return_date := book_rec.Latest_Return_Date;
        v_availability_status := book_rec.Availability_Status;
	
        -- Display book information with padding
        DBMS_OUTPUT.PUT_LINE( 
            RPAD(v_title, 25) || 
            RPAD(v_author, 20) || 
            RPAD(v_publication, 20) || 
            v_latest_return_date ||
            v_availability_status
        );
    END LOOP;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/
