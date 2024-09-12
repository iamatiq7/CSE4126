set verify off
set serveroutput ON

-- Trigger after inserting into Borrowers table
CREATE OR REPLACE TRIGGER after_insert_borrowers
AFTER INSERT ON Borrowers
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('A new record was inserted into Borrowers table.');
END;
/

-- Trigger after updating Borrowers table
CREATE OR REPLACE TRIGGER after_update_borrowers
AFTER UPDATE ON Borrowers
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('A record was updated in Borrowers table.');
END;
/

-- Trigger after deleting from Borrowers table
CREATE OR REPLACE TRIGGER after_delete_borrowers
AFTER DELETE ON Borrowers
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('A record was deleted from Borrowers table.');
END;
/

-- Trigger after inserting into Members1 table
CREATE OR REPLACE TRIGGER after_insert_members1
AFTER INSERT ON Members1
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('A new record was inserted into Members1 table.');
END;
/

-- Trigger after updating Members1 table
CREATE OR REPLACE TRIGGER after_update_members1
AFTER UPDATE ON Members1
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('A record was updated in Members1 table.');
END;
/

-- Trigger after deleting from Members1 table
CREATE OR REPLACE TRIGGER after_delete_members1
AFTER DELETE ON Members1
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('A record was deleted from Members1 table.');
END;
/

-- Trigger after inserting into Books1 table
CREATE OR REPLACE TRIGGER after_insert_books1
AFTER INSERT ON Books1
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('A new record was inserted into Books1 table.');
END;
/

-- Trigger after updating Books1 table
CREATE OR REPLACE TRIGGER after_update_books1
AFTER UPDATE ON Books1
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('A record was updated in Books1 table.');
END;
/

-- Trigger after deleting from Books1 table
CREATE OR REPLACE TRIGGER after_delete_books1
AFTER DELETE ON Books1
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('A record was deleted from Books1 table.');
END;
/

-- Trigger after inserting into Book_Copies1 table
CREATE OR REPLACE TRIGGER after_insert_book_copies1
AFTER INSERT ON Book_Copies1
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('A new record was inserted into Book_Copies1 table.');
END;
/

-- Trigger after updating Book_Copies1 table
CREATE OR REPLACE TRIGGER after_update_book_copies1
AFTER UPDATE ON Book_Copies1
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('A record was updated in Book_Copies1 table.');
END;
/

-- Trigger after deleting from Book_Copies1 table
CREATE OR REPLACE TRIGGER after_delete_book_copies1
AFTER DELETE ON Book_Copies1
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('A record was deleted from Book_Copies1 table.');
END;
/
