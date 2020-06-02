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
