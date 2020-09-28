-- CRUD (данные)
-- create INSERT
-- read SELECT
-- update UPDATE
-- delete DELETE, TRUNCATE

-- dev.mysql/com/doc/refman/8.0/en/insert.html - документация по insert
-- INSERT... VALUES

INSERT INTO users (id, name,surname,email,phone,gender,birthday,hometown,photo_id,pass,created_at) VALUES (102, 'Сергей', 'Сергеев','qwe@asdf.qw',123123123,'m','1983-03-21','Саратов',NULL,'asjghdasjgd23hbd','2020-09-25 22:09:27.0');

-- INSERT ... SET

INSERT INTO users
set
name='Вадим',surname='Рожков',email='sdhfs@wkjnc,ru';

-- INSERT ... SELECT
insert communities -- вставка в таблицу
select * from bazadannyh.tablename order by id; -- выбранных значений из база.таблица с сортировкой по id
select * from communities order by id;

-- SELECT
select * from communities;
select * from communities order by id; -- select * from communities order by id ASC -- (по умолчанию) -- DESC (по убыванию)
select surname, name, phone from users;
select * from users limit 10;
select * from users limit 3 offset 8;
select * from users limit 8,3; -- то же, что команда выше
select concat(surname,' ',name) as persons from users; -- выберем фамилию и имя из users, сцепим их и сцепленное значение (столбец) назовём persons. as можно не писать
select concat(surname,' ',substring(name,1,1)) as FIO from users; -- то же, только обрежем имя
select distinct hometown from users; -- выберем только уникальные города
select * from users where hometown = 'Саратов'; -- выберем только юзеров, у которых город Саратов
select name, surname, birthday
	from users where birthday >= '1985-01-01'
    order by birthday;

select name, surname, birthday
	from users where birthday >= '1985-01-01' and birthday <= '1990-01-01';
    
select name, surname, birthday
	from users where birthday between '1985-01-01' and '1990-01-01'; -- то же, что выше 
    
select name, surname
	from users where gender != 'm'; -- выберем всех, кто не мужчина
    
select name, surname
	from users where gender <> 'm'; -- выберем всех, кто не мужчина
    
select name, surname
	from users where name in ('Mil','Sonja','Susanna'); -- выберем всех с именами Mil, Sonja, Susanna

select name, surname
	from users where name not in ('Mil','Sonja','Susanna'); -- выберем всех с именами не Mil, Sonja, Susanna

select name, surname
	from users where surname like 'N%'; -- найдём всех с фамилией, начинающейся на N, а далее 0 или более символов

select name, surname from users where surname like '%t'; -- заканчиваются на t
    
select name, surname from users where surname like 'Nug_nt'; -- все, начинаются на Nug, одна любая буква и заканчивается на nt

select name, surname from users
	where name = 'Mil'
	or name = 'Sonja'
	or name = 'Susanna'; -- как пример со скобками
    
select name,surname,hometown, gender from users
	where (hometown = 'Москва' or hometown = 'Саратов') and gender = 'm';

select count(*) from users; -- посчитай всех юзеров
select min(birthday) from users; -- найди пользователя с самой маленькой датой рождения 

select hometown, count(*) from users group by hometown; -- выведи все города и посчитай в них пользователей 

select hometown, count(*) from users group by hometown having count(*) >=10; -- выведи города, в которых пользователей больше 10 (сначала считает всех пользователей во всех городах, потом выводит только нужные)


-- UPDATE
update friend_requests
	set status = 'approved'
    where initiator_user_id = 1 and target_user_id = 81;

-- TRUNCATE --удаляет таблицу, создаёт её заново без значенией, подходящих под условие
set foreign_key_checks = 0; -- отключает проверку внешних ключей
truncate table communities; -- удалить таблицу коммьюнитиз
set foreign_key_checks = 1; -- включает проверку внешниз ключей

-- DELETE --удаляет записи, подходящие под условие (не проводит операций с таблицей)
delete from communities where name = 'adipiscing';
delete from communities where id between 1 and 10; 

show create table users_communities;

CREATE TABLE 'users_communities' (
	'user_id' bigint insigned NOT NULL,
    'community_id' bigint unsigned NOT NULL,
    'is_admin' tinyint(1) DEFAULT '0',
    PRIMARY KEY ('user_id','community_id'),
    KEY ('communit_id'

