set verify off
set serveroutput ON

-- Trigger after inserting into Purchases table
CREATE OR REPLACE TRIGGER after_insert_purchases
AFTER INSERT ON Purchases
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('A new record was inserted into Purchases table.');
END;
/

-- Trigger after updating Purchases table
CREATE OR REPLACE TRIGGER after_update_purchases
AFTER UPDATE ON Purchases
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('A record was updated in Purchases table.');
END;
/

-- Trigger after deleting from Purchases table
CREATE OR REPLACE TRIGGER after_delete_purchases
AFTER DELETE ON Purchases
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('A record was deleted from Purchases table.');
END;
/

-- Trigger after inserting into Members1 table
CREATE OR REPLACE TRIGGER after_insert_members2
AFTER INSERT ON Members2
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('A new record was inserted into Members2 table.');
END;
/

-- Trigger after updating Members1 table
CREATE OR REPLACE TRIGGER after_update_members2
AFTER UPDATE ON Members2
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('A record was updated in Members2 table.');
END;
/

-- Trigger after deleting from Members1 table
CREATE OR REPLACE TRIGGER after_delete_members2
AFTER DELETE ON Members2
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('A record was deleted from Members2 table.');
END;
/

-- Trigger after inserting into Members3 table
CREATE OR REPLACE TRIGGER after_insert_members3
AFTER INSERT ON Members3
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('A new record was inserted into Members3 table.');
END;
/

-- Trigger after updating Members3 table
CREATE OR REPLACE TRIGGER after_update_members3
AFTER UPDATE ON Members3
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('A record was updated in Members3 table.');
END;
/

-- Trigger after deleting from Members3 table
CREATE OR REPLACE TRIGGER after_delete_members3
AFTER DELETE ON Members3
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('A record was deleted from Members3 table.');
END;
/

-- Trigger after inserting into Books1 table
CREATE OR REPLACE TRIGGER after_insert_books2
AFTER INSERT ON Books2
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('A new record was inserted into Books2 table.');
END;
/

-- Trigger after updating Books1 table
CREATE OR REPLACE TRIGGER after_update_books2
AFTER UPDATE ON Books2
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('A record was updated in Books2 table.');
END;
/

-- Trigger after deleting from Books1 table
CREATE OR REPLACE TRIGGER after_delete_books2
AFTER DELETE ON Books2
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('A record was deleted from Books2 table.');
END;
/

-- Trigger after inserting into Book_Copies2 table
CREATE OR REPLACE TRIGGER after_insert_book_copies2
AFTER INSERT ON Book_Copies2
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('A new record was inserted into Book_Copies2 table.');
END;
/

-- Trigger after updating Book_Copies2 table
CREATE OR REPLACE TRIGGER after_update_book_copies2
AFTER UPDATE ON Book_Copies2
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('A record was updated in Book_Copies2 table.');
END;
/

-- Trigger after deleting from Book_Copies1 table
CREATE OR REPLACE TRIGGER after_delete_book_copies2
AFTER DELETE ON Book_Copies2
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('A record was deleted from Book_Copies2 table.');
END;
/