delimiter //
create trigger Explorer.checkAuthor before insert
on Explorer.Route
for each row
begin
    if NEW.author is null OR NEW.author = '' OR length(NEW.author) < 4 then
        set NEW.author = 'unknown';
    end if;
 end;
 //   
delimiter ;