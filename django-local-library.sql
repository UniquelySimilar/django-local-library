-- Delete catalog_book records since truncate doesn't work due to foreign key in catalog_book_instance
-- delete from djangolocallibrary.catalog_book where id > 0 and id < 1001;


drop procedure if exists insertBook;
delimiter //
CREATE PROCEDURE insertBook(num int, authorId int)
BEGIN
	declare prefix char(9) default 'aaa000000';
    declare bookName varchar(8);
    declare isbn char(13);

    set bookName = concat('Book', num);
    set isbn = concat(prefix, lpad(num, 4, 0));
	insert into djangolocallibrary.catalog_book (title, summary, isbn, author_id, language_id)
	values(bookName, concat(bookName, ' summary'), isbn, authorId, 1);
    
END//
delimiter ;

-- Looping procedure to add multiple records
drop procedure if exists insertBooks;
delimiter //
create procedure insertBooks()
begin
	declare idx int default 1;
    declare genreId int default 1;
    declare authorId int default 1;

    while idx < 201 do
		call insertBook(idx, authorId);
		set authorId = authorId + 1;
		if authorId = 4 then
			set authorId = 1;
		end if;
        
        -- Add 'catalog_book_genre' records
        -- For now assume book id same as idx
        insert into djangolocallibrary.catalog_book_genre (book_id, genre_id) values(idx, genreId);
        set genreId = genreId + 1;
        if genreId = 6 then
			set genreId = 1;
		end if;
        
        set idx = idx + 1;
    end while;
end//
delimiter ;
call insertBooks();
