
drop procedure if exists insertBook;
delimiter //
CREATE PROCEDURE insertBook(num int)
BEGIN
	declare prefix char(9) default 'aaa000000';
    declare bookName varchar(8);
    declare isbn char(13);

    set bookName = concat('Book', num);
    set isbn = concat(prefix, lpad(num, 4, 0));
	insert into djangolocallibrary.catalog_book (title, summary, isbn, author_id, language_id)
	values(bookName, concat(bookName, ' summary'), isbn, 2, 1);
END//
delimiter ;

-- Looping procedure to add multiple records
drop procedure if exists insertBooks;
delimiter //
create procedure insertBooks()
begin
	declare idx int default 1;
    while idx < 201 do
		call insertBook(idx);
        
        -- TODO: Add 'catalog_book_genre' records
        -- For now assume book id same as idx
        insert into djangolocallibrary.catalog_book_genre (book_id, genre_id) values(idx, 1);
        
        set idx = idx + 1;
    end while;
end//
delimiter ;
call insertBooks();
