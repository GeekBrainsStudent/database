use shop;

/* Задание №1 */
/* при добавлении пустых строк, возникает ошибка из-за уникального индекса столбца name */
insert into catalogs values (null,''), (null,''), (null,'');  	

/* добавлеяем строки, со значением null */
insert into catalogs values (null, null), (null, null), (null, null);  	

/*попытка заменить их значением empty, завершена с ошибкой из-за уникальности */ 
update catalogs set name = 'empty' where name is null;   


/* Задание №2 */
create database media;
use media;

create table photos (
	id serial primary key,
    path_ varchar(255),
    name varchar(255),
    description varchar(255),
    owner varchar(255)
);

create table audios (
	id serial primary key,
    path_ varchar(255),
    name varchar(255),
    description varchar(255),
    owner varchar(255)
);  

create table videos (
	id serial primary key,
    path_ varchar(255),
    name varchar(255),
    description varchar(255),
    owner varchar(255)
);   


/* Задание №3 */
create database sample;
use sample;

create table cat (
	id serial primary key,
    name varchar(255)
);

insert into cat values
	(null, 'Хлеб'),
    (null, 'молоко');
    
 select * from cat;   

/* sql запрос копирующий значения из shop.catalogs в sample.cat */
insert into cat select * from shop.catalogs on duplicate key update cat.name = shop.catalogs.name;