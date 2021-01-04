mysql> USE shop;
Database changed
mysql> DELIMITER //

/*1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, 
в зависимости от текущего времени суток. 
С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".*/

mysql> CREATE FUNCTION hello()
    -> RETURNS VARCHAR(12) NOT DETERMINISTIC
    -> BEGIN
    ->  DECLARE curr_hour INT;
    ->  DECLARE result VARCHAR(12);
    ->  SET curr_hour = HOUR(NOW());
    ->  IF(curr_hour >= 0 AND curr_hour < 6) THEN
    ->          SET result = 'Доброй ночи!';
    ->  ELSEIF(curr_hour >= 6 AND curr_hour < 12) THEN
    ->          SET result = 'Доброе утро!';
    ->  ELSEIF(curr_hour >= 12 AND curr_hour < 18) THEN
    ->          SET result = 'Добрый день!';
    ->  ELSE
    ->          SET result = 'Добрый вечер!';
    ->  END IF;
    ->  RETURN result;
    -> END//
Query OK, 0 rows affected (0.01 sec)

mysql> SELECT hello()//
+------------------------+
| hello()                |
+------------------------+
| Добрый день!           |
+------------------------+
1 row in set (0.00 sec)


/* 2. В таблице products есть два текстовых поля: 
name с названием товара и description с его описанием. 
Допустимо присутствие обоих полей или одно из них. 
Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
При попытке присвоить полям NULL-значение необходимо отменить операцию. */

mysql> CREATE TRIGGER check_insert_to_products BEFORE INSERT ON products
    -> FOR EACH ROW
    -> BEGIN
    ->  IF(new.name IS NULL AND new.description IS NULL) THEN
    ->          SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'insert cancelled';
    ->  END IF;
    -> END//
Query OK, 0 rows affected (0.02 sec)

mysql> CREATE TRIGGER check_update_products BEFORE UPDATE ON products
    -> FOR EACH ROW
    -> BEGIN
    ->  IF(new.name IS NULL AND new.description IS NULL) THEN
    ->          SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'update cancelled';
    ->  END IF;
    -> END//
Query OK, 0 rows affected (0.02 sec)


/* 3. (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. 
Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел. 
Вызов функции FIBONACCI(10) должен возвращать число 55. */

mysql> CREATE FUNCTION fibonacci(numb INT)
    -> RETURNS INT NOT DETERMINISTIC
    -> BEGIN
    ->  DECLARE sum INT DEFAULT 0;
    ->  DECLARE i INT DEFAULT 1;
    ->  DECLARE j INT DEFAULT 0;
    ->  WHILE numb > 0  DO
    ->          SET sum = i + j;
    ->          SET i = j;
    ->          SET j = sum;
    ->          SET numb = numb - 1;
    ->  END WHILE;
    ->  RETURN sum;
    -> END//
Query OK, 0 rows affected (0.01 sec)