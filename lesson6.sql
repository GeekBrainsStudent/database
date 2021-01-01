
mysql> USE shop;
Database changed

/* 1. В базе данных shop и sample присутвуют одни и те же таблицы учебной базы данных. 
Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. 
Используйте транзакции. */

mysql> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)

mysql> INSERT INTO sample.users (SELECT * FROM USERS WHERE id = 1);
Query OK, 1 row affected (0.00 sec)
Records: 1  Duplicates: 0  Warnings: 0

mysql> DELETE FROM users WHERE id = 1;
Query OK, 1 row affected (0.00 sec)

mysql> COMMIT;
Query OK, 0 rows affected (0.01 sec)

/* Проверка таблиц */
mysql> SELECT * FROM users;
+----+--------------------+-------------+---------------------+---------------------+
| id | name               | birthday_at | created_at          | updated_at          |
+----+--------------------+-------------+---------------------+---------------------+
|  2 | Игорь              | 1990-04-13  | 2020-12-24 08:39:51 | 2020-12-28 14:21:34 |
|  3 | Лена               | 1984-06-12  | 2020-12-24 08:39:51 | 2020-12-28 14:21:48 |
|  4 | Стёпа              | 2000-05-04  | 2020-12-24 08:39:51 | 2020-12-28 14:22:02 |
|  5 | Лиза               | 1990-03-24  | 2021-01-01 11:38:42 | 2021-01-01 11:38:42 |
|  6 | Вика               | 1988-12-04  | 2020-12-24 08:39:51 | 2020-12-28 14:22:23 |
|  7 | Маргарита          | 1999-03-04  | 2020-12-24 08:39:51 | 2020-12-28 14:22:36 |
+----+--------------------+-------------+---------------------+---------------------+
6 rows in set (0.00 sec)

mysql> SELECT * FROM sample.users;
+----+----------+-------------+---------------------+---------------------+
| id | name     | birthday_at | created_at          | updated_at          |
+----+----------+-------------+---------------------+---------------------+
|  1 | Егор     | 1984-04-21  | 2020-12-24 08:38:40 | 2020-12-28 14:21:21 |
+----+----------+-------------+---------------------+---------------------+
1 row in set (0.00 sec)


/* 2. Создайте представление, 
которое выводит название (name) товарной позиции из таблицы products 
и соответствующее название (name) каталога из таблицы catalogs. */

mysql> CREATE OR REPLACE VIEW prodcat (prodname, catname) AS SELECT p.name, c.name FROM products AS p, catalogs AS c WHERE p.catalog_id = c.id;
Query OK, 0 rows affected (0.01 sec)

/* Проверка таблицы */
mysql> SELECT * FROM prodcat;
+---------------------------------+----------------------+
| prodname                        | catname              |
+---------------------------------+----------------------+
| AMD Athlon X4 840 OEM           | Процессоры           |
| Intel Celeron G5905 OEM         | Процессоры           |
| ASRock H110M-DGS R3.0           | Мат. платы           |
| ASUS A68HM-K                    | Мат. платы           |
| INNO3D GeForce GT 710 Silent LP | Видеокарты           |
| GIGABYTE GeForce GT 710         | Видеокарты           |
+---------------------------------+----------------------+
6 rows in set (0.00 sec)


/* 3. (по желанию) Пусть имеется таблица с календарным полем created_at. 
В ней размещены разряженые календарные записи 
за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. 
Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1, 
если дата присутствует в исходном таблице и 0, если она отсутствует. */

mysql> CREATE TEMPORARY TABLE days (created_at DATE NOT NULL);
Query OK, 0 rows affected (0.00 sec)

mysql> INSERT INTO days (created_at) VALUES
    -> ('2018-08-02'),
    -> ('2018-08-07'),
    -> ('2018-08-12'),
    -> ('2018-08-15'),
    -> ('2018-08-17'),
    -> ('2018-08-20'),
    -> ('2018-08-25'),
    -> ('2018-08-27'),
    -> ('2018-08-29'),
    -> ('2018-08-31');
Query OK, 10 rows affected (0.00 sec)
Records: 10  Duplicates: 0  Warnings: 0

mysql> SELECT day, EXISTS(SELECT 1 FROM days WHERE created_at = day) AS `exists` FROM
    -> (SELECT ADDDATE('2018-08-01', t0 + t1 * 6) AS day FROM
    -> (SELECT 0 AS t0 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) AS t0,
    -> (SELECT 0 AS t1 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) AS t1) AS t
    -> WHERE day BETWEEN '2018-08-01' AND '2018-08-31';
+------------+--------+
| day        | exists |
+------------+--------+
| 2018-08-01 |      0 |
| 2018-08-02 |      1 |
| 2018-08-03 |      0 |
| 2018-08-04 |      0 |
| 2018-08-05 |      0 |
| 2018-08-06 |      0 |
| 2018-08-07 |      1 |
| 2018-08-08 |      0 |
| 2018-08-09 |      0 |
| 2018-08-10 |      0 |
| 2018-08-11 |      0 |
| 2018-08-12 |      1 |
| 2018-08-13 |      0 |
| 2018-08-14 |      0 |
| 2018-08-15 |      1 |
| 2018-08-16 |      0 |
| 2018-08-17 |      1 |
| 2018-08-18 |      0 |
| 2018-08-19 |      0 |
| 2018-08-20 |      1 |
| 2018-08-21 |      0 |
| 2018-08-22 |      0 |
| 2018-08-23 |      0 |
| 2018-08-24 |      0 |
| 2018-08-25 |      1 |
| 2018-08-26 |      0 |
| 2018-08-27 |      1 |
| 2018-08-28 |      0 |
| 2018-08-29 |      1 |
| 2018-08-30 |      0 |
| 2018-08-31 |      1 |
+------------+--------+
31 rows in set (0.00 sec)


/* 4. (по желанию) Пусть имеется любая таблица с календарным полем created_at. 
Создайте запрос, который удаляет устаревшие записи из таблицы, 
оставляя только 5 самых свежих записей. */

/* Временные таблицы нельзя использовать больше одного раза в запросах,
поэтому для этой задачи, создаем реальную таблицу */

mysql> DROP TEMPORARY TABLE IF EXISTS days;
Query OK, 0 rows affected (0.00 sec)

mysql> CREATE TABLE days (created_at DATE NOT NULL);
Query OK, 0 rows affected (0.04 sec)

mysql> INSERT INTO days VALUES
    -> ('2018-08-02'),
    -> ('2018-08-07'),
    -> ('2018-08-12'),
    -> ('2018-08-15'),
    -> ('2018-08-17'),
    -> ('2018-08-20'),
    -> ('2018-08-25'),
    -> ('2018-08-27'),
    -> ('2018-08-29'),
    -> ('2018-08-31');
Query OK, 10 rows affected (0.01 sec)
Records: 10  Duplicates: 0  Warnings: 0

mysql> SET @i := 0;
Query OK, 0 rows affected (0.00 sec)

mysql> DELETE FROM days WHERE created_at IN (
    -> SELECT created_at FROM (
    -> SELECT @i := @i + 1 AS i, created_at FROM days ORDER BY created_at DESC) AS t
    -> WHERE i > 5);
Query OK, 5 rows affected, 1 warning (0.01 sec)

/* Проверка таблицы */
mysql> SELECT * FROM days;
+------------+
| created_at |
+------------+
| 2018-08-20 |
| 2018-08-25 |
| 2018-08-27 |
| 2018-08-29 |
| 2018-08-31 |
+------------+
5 rows in set (0.00 sec)

mysql>