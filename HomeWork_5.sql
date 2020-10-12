-- Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.

CREATE TABLE users_homework (
	id SERIAL PRIMARY KEY,
    name varchar(255) COMMENT 'Имя клиента',
    birthday_at DATE COMMENT 'Дата рождения',
    created_at DATETIME,
    updated_at DATETIME
    ) COMMENT = 'Пользователи'

INSERT INTO
	users_homework (name, birthday_at, created_at, updated_at)
VALUES
	('Геннадий', '1990-10-05', NULL, NULL),
    ('Наталья', '1984-11-12', NULL, NULL),
    ('Александр', '1985-05-20', NULL, NULL),
    ('Сергей', '1988-02-14', NULL, NULL),
    ('Иван', '1998-01-12', NULL, NULL),
    ('Мария', '2006-08-29', NULL, NULL);
    
SELECT * FROM users_homework;

UPDATE users_homework SET created_at = NOW(), updated_at = NOW();

SELECT * FROM users_homework;

-- Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR
-- и в них долгое время помещались значения в формате 20.10.2017 8:10. Необходимо преобразовать поля к типу DATETIME,
-- сохранив введённые ранее значения.

DROP TABLE IF EXISTS users_homework;

CREATE TABLE users_homework (
	id SERIAL PRIMARY KEY,
    name varchar(255) COMMENT 'Имя клиента',
    birthday_at DATE COMMENT 'Дата рождения',
    created_at VARCHAR(255),
    updated_at VARCHAR(255)
    ) COMMENT = 'Пользователи'

INSERT INTO
	users_homework (name, birthday_at, created_at, updated_at)
VALUES
	('Геннадий', '1990-10-05', '07.01.2016 12:05', '07.01.2016 12:05'),
    ('Наталья', '1984-11-12', '20.05.2016 16:32', '20.05.2016 16:32'),
    ('Александр', '1985-05-20', '14.08.2016 20:10', '14.08.2016 20:10'),
    ('Сергей', '1988-02-14', '21.10.2016 9:14', '21.10.2016 9:14'),
    ('Иван', '1998-01-12', '15.12.2016 12:45', '15.12.2016 12:45'),
    ('Мария', '2006-08-29', '12.01.2017 8:56', '12.01.2017 8:56');

UPDATE
	users_homework
SET
created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i'),
updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i');

SELECT * FROM users_homework;

describe users_homework;

alter table
	users_homework
    change
    created_at created_at DATETIME DEFAULT current_timestamp;

alter table
	users_homework
    change
    updated_at updated_at DATETIME DEFAULT current_timestamp;

describe users_homework;

-- В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры:
-- 0, если товар закончился и выше нуля, если на складе имеются запасы.
-- Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value.
-- Однако нулевые запасы должны выводиться в конце, после всех записей.

create table storehouse_products (
id serial primary key,
storehouse_id int unsigned,
product_id int unsigned,
value int unsigned comment 'Запас товарной позиции на складе',
created_at datetime default current_timestamp,
updated_at datetime default current_timestamp on update current_timestamp
) comment = 'Запасы на складе';

insert into
	storehouse_products (storehouse_id, product_id, value)
values
	(1, 543, 0),
    (1, 789, 2500),
    (1, 3432, 0),
    (1, 826, 30),
    (1, 719, 500),
    (1, 638, 1);

select * from storehouse_products order by value;

select id, value, if(value > 0, 0, 1) AS sort FROM storehouse_products order by value;

select * from storehouse_products order by if(value > 0, 0, 1), value;

-- Подсчитайте средний возраст пользователей в таблице users.

select
	timestampdiff(YEAR, birthday, now()) as age
from
	users;

select
	AVG(timestampdiff(YEAR, birthday, now())) as age
from
	users;
-- 33.3725

-- Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.

select name, birthday from users;

select month(birthday), day(birthday) from users;

select year(now()), month(birthday), day(birthday) from users;

select concat_ws('-', year(now()), month(birthday), day(birthday)) as day_b from users;

select date(concat_ws('-', year(now()), month(birthday), day(birthday))) as day_b from users;

select
	date_format(date(concat_ws('-', year(now()), month(birthday), day(birthday))), '%W') as day_b,
	count(*) as total
from
	users
group by
	day_b;

-- Sunday	13
-- Wednesday	21
-- Friday	18
-- Monday	14
-- Tuesday	9
-- Saturday	11
-- Thursday	16

select
	date_format(date(concat_ws('-', year(now()), month(birthday), day(birthday))), '%W') as day_b,
	count(*) as total
from
	users
group by
	day_b
order by
	total DESC;