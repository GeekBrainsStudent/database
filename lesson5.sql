Enter password: ********
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



/* Task 1 */

mysql> SELECT name FROM users WHERE EXISTS (SELECT 1 FROM orders WHERE user_id = users.id);
+------------+
| name       |
+------------+
| Игорь      |
| Жека       |
| Вика       |
+------------+
3 rows in set (0.00 sec)



/* Task 2 */

mysql> SELECT p.id, p.name, p.price, c.name AS catalog FROM products AS p JOIN catalogs AS c ON p.catalog_id = c.id;
+----+---------------------------------+---------+----------------------+
| id | name                            | price   | catalog              |
+----+---------------------------------+---------+----------------------+
|  1 | AMD Athlon X4 840 OEM           | 1650.00 | Процессоры           |
|  2 | Intel Celeron G5905 OEM         | 3250.00 | Процессоры           |
|  3 | ASRock H110M-DGS R3.0           | 3799.00 | Мат. платы           |
|  4 | ASUS A68HM-K                    | 3999.00 | Мат. платы           |
|  5 | INNO3D GeForce GT 710 Silent LP | 3099.00 | Видеокарты           |
|  6 | GIGABYTE GeForce GT 710         | 3399.00 | Видеокарты           |
+----+---------------------------------+---------+----------------------+
6 rows in set (0.00 sec)



/* Task 3 */

mysql> CREATE TABLE flights(id SERIAL PRIMARY KEY, `from` VARCHAR(50) NOT NULL, `to` VARCHAR(50) NOT NULL);
Query OK, 0 rows affected (0.07 sec)

mysql> INSERT INTO flights (`from`, `to`) VALUES
    -> ('New-York', 'Moscow'),
    -> ('Paris', 'Los-Angeles'),
    -> ('Tokio', 'Berlin');
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> CREATE TABLE cities (label VARCHAR(50) NOT NULL, name VARCHAR(50) NOT NULL);
Query OK, 0 rows affected (0.04 sec)

mysql> INSERT INTO cities (label, name) values
    -> ('New-York', 'Нью-Йорк'),
    -> ('Moscow', 'Москва'),
    -> ('Paris', 'Париж'),
    -> ('Los-Angeles', 'Лос-Анджелес'),
    -> ('Tokio', 'Токио'),
    -> ('Berlin', 'Берлин');
Query OK, 6 rows affected (0.01 sec)
Records: 6  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM flights;
+----+----------+-------------+
| id | from     | to          |
+----+----------+-------------+
|  1 | New-York | Moscow      |
|  2 | Paris    | Los-Angeles |
|  3 | Tokio    | Berlin      |
+----+----------+-------------+
3 rows in set (0.00 sec)

mysql> SELECT f.id, c1.name AS `from`, c2.name AS `to` FROM flights AS f JOIN cities AS c1 JOIN cities AS c2 ON f.from = c1.label AND f.to = c2.label;
+----+-----------------+-------------------------+
| id | from            | to                      |
+----+-----------------+-------------------------+
|  1 | Нью-Йорк        | Москва                  |
|  2 | Париж           | Лос-Анджелес            |
|  3 | Токио           | Берлин                  |
+----+-----------------+-------------------------+
3 rows in set (0.00 sec)

mysql>