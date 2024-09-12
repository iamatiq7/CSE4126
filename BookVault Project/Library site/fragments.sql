-- Droping table before creating
Drop table members1;
Drop table books1;
Drop table Book_Copies1;

-- Create new tables for fragments
-- Library site
-- Members1 (SLstatus = 'reader')
CREATE TABLE Members1 AS
SELECT *
FROM Members
WHERE Membership_Status = 'Reader';

-- Books1 (PJBook_ID, Title, Author)
CREATE TABLE Books1 AS
SELECT Book_ID, Title, Author
FROM Books;

-- Book_Copies1 (PJCopy_ID, Book_ID, Books_at_library, Availibility_status_library)
CREATE TABLE Book_Copies1 AS
SELECT Copy_ID, Book_ID, Books_At_Library, Availability_Status_Library
FROM Book_Copies;
