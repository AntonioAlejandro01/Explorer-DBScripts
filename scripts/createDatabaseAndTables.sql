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
