DELIMITER //
create procedure Explorer.registerDowload(_id int)
BEGIN
        declare num int;
        declare strs int;
        select count(id) into num from Explorer.Route where id = _id;
        if num = 1 then
			select stars into strs from Explorer.Route where id =_id;
            update Explorer.Route set stars = strs + 1 where id = _id;
        end if;
END//

DELIMITER ;
