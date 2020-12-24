Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 13
Server version: 8.0.18 MySQL Community Server - GPL

Copyright (c) 2000, 2019, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> use shop;

Database changed

mysql> SELECT * FROM users;
+----+-----------+-------------+---------------------+---------------------+
| id | name      | birthday_at | created_at          | updated_at          |
+----+-----------+-------------+---------------------+---------------------+
|  1 | Egor      | 1984-04-21  | 2020-12-24 08:38:40 | 2020-12-24 08:38:40 |
|  2 | Igor      | 1990-04-13  | 2020-12-24 08:39:51 | 2020-12-24 08:39:51 |
|  3 | Lena      | 1984-06-12  | 2020-12-24 08:39:51 | 2020-12-24 08:39:51 |
|  4 | Stepa     | 2000-05-04  | 2020-12-24 08:39:51 | 2020-12-24 08:39:51 |
|  5 | Jeka      | 2010-04-02  | 2020-12-24 08:39:51 | 2020-12-24 08:39:51 |
|  6 | Vika      | 1988-12-04  | 2020-12-24 08:39:51 | 2020-12-24 08:39:51 |
|  7 | Margarita | 1999-03-04  | 2020-12-24 08:39:51 | 2020-12-24 08:39:51 |
+----+-----------+-------------+---------------------+---------------------+
7 rows in set (0.00 sec)

/*1. Подсчитайте средний возраст пользователей в таблице users. */

mysql> SELECT ROUND(AVG(YEAR(CURRENT_DATE())-YEAR(birthday_at))-(RIGHT(CURRENT_DATE(), 5) < (RIGHT(birthday_at, 5))), 1)as avg_age from users;
+---------+
| avg_age |
+---------+
|    26.4 |
+---------+
1 row in set (0.00 sec)


/*2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
Следует учесть, что необходимы дни недели текущего года, а не года рождения.*/

mysql> SELECT DAYNAME(MAKEDATE(YEAR(CURDATE()), DAYOFYEAR(birthday_at))) as birthday, count(*) as count from users group by birthday order by birthday;
+-----------+-------+
| birthday  | count |
+-----------+-------+
| Friday    |     2 |
| Monday    |     1 |
| Sunday    |     1 |
| Tuesday   |     2 |
| Wednesday |     1 |
+-----------+-------+
5 rows in set (0.00 sec)


/*3. (по желанию) Подсчитайте произведение чисел в столбце таблицы.*/

mysql> CREATE TABLE IF NOT EXISTS tbl (id SERIAL PRIMARY KEY, value INT);
Query OK, 0 rows affected (0.08 sec)

mysql> INSERT INTO tbl (value) VALUES (3), (5), (2);
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM tbl;
+----+-------+
| id | value |
+----+-------+
|  1 |     3 |
|  2 |     5 |
|  3 |     2 |
+----+-------+
3 rows in set (0.00 sec)

mysql> SELECT EXP(SUM(LOG(value))) FROM tbl;
+----------------------+
| EXP(SUM(LOG(value))) |
+----------------------+
|   30.000000000000004 |
+----------------------+
1 row in set (0.00 sec)
