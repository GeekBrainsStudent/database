/*1. Создайте двух пользователей которые имеют доступ к базе данных shop. 
Первому пользователю shop_read должны быть доступны только запросы на чтение данных, 
второму пользователю shop — любые операции в пределах базы данных shop.*/

mysql> CREATE USER 'shop_read'@'localhost' IDENTIFIED WITH sha256_password BY 'pass';
Query OK, 0 rows affected (0.01 sec)

mysql> GRANT SELECT ON shop.* TO 'shop_read'@'localhost';
Query OK, 0 rows affected (0.01 sec)

mysql> CREATE USER 'shop_all'@'localhost' IDENTIFIED WITH sha256_password BY 'pass';
Query OK, 0 rows affected (0.01 sec)

mysql> GRANT ALL ON shop.* TO 'shop_all'@'localhost';
Query OK, 0 rows affected (0.01 sec)


/* 2. (по желанию) Есть таблица (accounts), включающая в себя три столбца: id, name, password, 
которые содержат первичный ключ, имя пользователя и его пароль. 
Создайте представление username таблицы accounts, предоставляющее доступ к столбцам id и name. Создайте пользователя user_read, 
который бы не имел доступа к таблице accounts, однако мог извлекать записи из представления username. */

mysql> CREATE TABLE accounts2 (id SERIAL PRIMARY KEY, name VARCHAR(50) NOT NULL, password VARCHAR(100) NOT NULL);
Query OK, 0 rows affected (0.08 sec)

mysql> CREATE VIEW acc_view (id, name) AS SELECT id, name FROM accounts2;
Query OK, 0 rows affected (0.01 sec)

mysql> CREATE USER 'user_read'@'localhost' IDENTIFIED WITH sha256_password BY 'pass';
Query OK, 0 rows affected (0.02 sec)

mysql> GRANT SELECT ON shop.acc_view TO 'user_read'@'localhost';
Query OK, 0 rows affected (0.01 sec)