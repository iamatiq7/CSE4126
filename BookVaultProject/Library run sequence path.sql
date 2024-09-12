set serveroutput on
@"D:\Shihabul-Shuvo Github\DDS-Lab-Project\Library site\fragments.sql"
@"D:\Shihabul-Shuvo Github\DDS-Lab-Project\Library site\trigger.sql"
BEGIN
	dbms_output.put_line('Running...... show all members.sql');
end;
/
@"D:\Shihabul-Shuvo Github\DDS-Lab-Project\Library site\show all members.sql"
BEGIN
	dbms_output.put_line('Running...... Register User.sql');
end;
/
@"D:\Shihabul-Shuvo Github\DDS-Lab-Project\Library site\Register User.sql"
BEGIN
	dbms_output.put_line('Running...... show all readers.sql');
end;
/
@"D:\Shihabul-Shuvo Github\DDS-Lab-Project\Library site\show all readers.sql"
BEGIN
	dbms_output.put_line('Running...... check membership.sql');
end;
/
@"D:\Shihabul-Shuvo Github\DDS-Lab-Project\Library site\check membership.sql"
BEGIN
	dbms_output.put_line('Running...... renew card.sql');
end;
/
@"D:\Shihabul-Shuvo Github\DDS-Lab-Project\Library site\renew card.sql"
@"D:\Shihabul-Shuvo Github\DDS-Lab-Project\Library site\show book availability.sql"
BEGIN
	dbms_output.put_line('Running...... update status and fine.sql');
end;
/
@"D:\Shihabul-Shuvo Github\DDS-Lab-Project\Library site\update status and fine.sql"
BEGIN
	dbms_output.put_line('Running...... Borrow_book.sql');
end;
/
@"D:\Shihabul-Shuvo Github\DDS-Lab-Project\Library site\Borrow_book.sql"
BEGIN
	dbms_output.put_line('Running...... show all borrowers.sql');
end;
/
@"D:\Shihabul-Shuvo Github\DDS-Lab-Project\Library site\show all borrowers.sql"
BEGIN
	dbms_output.put_line('Running...... update library book status.sql');
end;
/
@"D:\Shihabul-Shuvo Github\DDS-Lab-Project\Library site\update library book status.sql"
BEGIN
	dbms_output.put_line('Running...... return book.sql');
end;
/
@"D:\Shihabul-Shuvo Github\DDS-Lab-Project\Library site\return book.sql"
