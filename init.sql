SET GLOBAL log_bin_trust_function_creators = 1;
/*Creacion de la base de datos*/
drop database if exists Explorer;
create database Explorer character set = utf8;

use Explorer;

/*Creacion de las tablas*/

CREATE TABLE Explorer.Topic(
	id int auto_increment primary key,
	topicName varchar(50) not null
);

CREATE TABLE Explorer.Route(
	id int auto_increment primary key,
    title varchar(120) not null,
    author varchar(50) default 'unknown',
    topic int not null,
	loca text not null,/*Location*/
    places longtext not null,
    qrKey tinytext not null,
	stars int  default 0,
    foreign key (topic) references Topic(id)
);


/*Tabla para registrar los logs*/

CREATE TABLE Explorer.CreationsLog (
    id INT AUTO_INCREMENT PRIMARY KEY,
    idRoute INT NOT NULL,
    creationDate TIMESTAMP NOT NULL,
    description TEXT NOT NULL,
    FOREIGN KEY (idRoute)
        REFERENCES Route (id)
);

delimiter //
create function Explorer.createTopicIfNotExists (_name varchar(50)) returns int
begin
	declare topicExists boolean;
    declare idTopic int;
	select count(id) into topicExists from Explorer.Topic where lower(_name) in (select topicName from Explorer.Topic);
	if topicExists = 0 then
		insert into Explorer.Topic(topicName) values (LOWER(_name));
	end if;
	select id into idTopic from Explorer.Topic where Topic.topicName = _name limit 1;
    return idTopic;
end //
delimiter ;

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

delimiter //
create trigger Explorer.createLog after insert
on Explorer.Route
for each row
begin
   insert into Explorer.CreationsLog(idRoute,creationDate,description) values(NEW.id,(select current_timestamp()),concat('Route: ',NEW.title ,',Topic: ', NEW.topic,', Image QR: ' , NEW.qrKey));
end//
delimiter ;

