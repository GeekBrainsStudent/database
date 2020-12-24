
/* 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем. */

UPDATE users SET created_at = now(), updated_at = now() 
	WHERE created_at <=> null OR updated_at <=> null; 
	
/* 2.Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения. */ 
	 
ALTER TABLE users 
	MODIFY COLUMN created_at DATETIME DEFAULT CURRENT_TIMESTAMP, 
	MODIFY COLUMN updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;	 
	
/* 3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. Нулевые запасы должны выводиться в конце, после всех записей. */

SELECT * FROM storehouses_products ORDER BY value DESK;

/* 4. (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий ('may', 'august') */

SELECT id, name, monthname(birthday_at) AS 'Month of birth', created_at, updated_at
	FROM users WHERE month(birthday_at) = 5 or month(birthday_at) = 8; 
	
/* 5. (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN. */

SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY field(id, 5, 1, 2);	 
