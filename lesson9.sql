mysql> USE shop;
Database changed

/* 1. Создайте таблицу logs типа Archive. 
Пусть при каждом создании записи в таблицах users, catalogs и products 
в таблицу logs помещается время и дата создания записи, название таблицы, 
идентификатор первичного ключа и содержимое поля name. */

mysql> CREATE TABLE logs(
    -> `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    -> `table_name` VARCHAR(8) NOT NULL,
    -> `id` BIGINT(20) UNSIGNED NOT NULL,
    -> `name` VARCHAR(255) NOT NULL
    -> ) ENGINE = ARCHIVE;
Query OK, 0 rows affected, 1 warning (0.02 sec)

mysql> DELIMITER //
mysql> CREATE TRIGGER write_log_insert_users AFTER INSERT ON users
    -> FOR EACH ROW
    -> BEGIN
    ->  INSERT INTO logs (`table_name`, `id`, `name`) VALUE ('users', NEW.id, NEW.name);
    -> END//
Query OK, 0 rows affected (0.02 sec)

mysql> CREATE TRIGGER write_log_insert_products AFTER INSERT ON products
    -> FOR EACH ROW
    -> BEGIN
    ->  INSERT INTO logs (`table_name`, `id`, `name`) VALUE ('products', NEW.id, NEW.name);
    -> END//
Query OK, 0 rows affected (0.02 sec)

mysql> CREATE TRIGGER write_log_insert_catalogs AFTER INSERT ON catalogs
    -> FOR EACH ROW
    -> BEGIN
    ->  INSERT INTO logs (`table_name`, `id`, `name`) VALUE ('catalogs', NEW.id, NEW.name);
    -> END//
Query OK, 0 rows affected (0.02 sec)



/* 2. (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей. */

/* Удаляю триггер вставки, чтоб не тормозило */
mysql> DROP TRIGGER write_log_insert_users;
Query OK, 0 rows affected (0.02 sec)

/* Процедура вставки. 
Отключаю автокоммит, проверку на уникальность и первичных ключей.
День рождения у всех одникавое. */
mysql> CREATE PROCEDURE insert_users(IN numb INT)
    -> BEGIN
    ->  DECLARE i INT DEFAULT 1;
    ->  SET AUTOCOMMIT = 0;
    ->  SET UNIQUE_CHECKS = 0;
    ->  SET FOREIGN_KEY_CHECKS = 0;
    ->  WHILE numb > 0 DO
    ->          INSERT INTO users (name, birthday_at) VALUES (CONCAT('user', i), '1984-01-01');
    ->          SET i = i + 1;
    ->          SET numb = numb - 1;
    ->  END WHILE;
    ->  SET FOREIGN_KEY_CHECKS = 1;
    ->  SET UNIQUE_CHECKS = 1;
    ->  COMMIT;
    -> END//
Query OK, 0 rows affected (0.01 sec)

mysql> CALL insert_users(1000000)//
Query OK, 0 rows affected (1 min 10.76 sec)

mysql> SELECT id, name, birthday_at FROM users WHERE name = 'user1000000';
+---------+-------------+-------------+
| id      | name        | birthday_at |
+---------+-------------+-------------+
| 1509274 | user1000000 | 1984-01-01  |
+---------+-------------+-------------+
1 row in set (0.54 sec)

mysql>