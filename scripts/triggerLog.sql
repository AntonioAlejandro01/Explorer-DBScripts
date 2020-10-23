delimiter //
create trigger Explorer.createLog after insert
on Explorer.Route
for each row
begin
   insert into Explorer.CreationsLog(idRoute,creationDate,description) values(NEW.id,(select current_timestamp()),concat('Route: ',NEW.title ,',Topic: ', NEW.topic,', Image QR: ' , NEW.qrKey));
end//
delimiter ;
