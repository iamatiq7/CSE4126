drop table book1;

create table book1 (bookID number primary key, authorID number, title varchar2(60));


insert into book1 values(216, 109, 'Misir Ali series');

insert into book1 values(217, 110, 'Meher Ali Series');

commit;