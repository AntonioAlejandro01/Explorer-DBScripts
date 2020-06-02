DELIMITER //
create procedure Explorer.registerRoute(_title varchar(120), _author varchar(50), _topic varchar(50),_loca varchar(100), _places longtext, _qrKey tinytext)
BEGIN
        if (_qrKey is null OR _title is null OR _topic is null OR _places is null)then
            select 'false' as response;
		else
            if _author is null OR _author = '' then
                insert into Explorer.Route(title,topic,loca,places,qrKey) values(_title,createTopicIfNotExists(_topic),LOWER(_loca),_places,_qrKey);
            else
                insert into Explorer.Route(title,author,topic,loca,places,qrKey) values(_title,_author,createTopicIfNotExists(_topic),LOWER(_loca),_places,_qrKey);
            end if;
            select 'true' as response;
        end if;

END//

DELIMITER ;
