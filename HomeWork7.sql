-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders
-- в интернет магазине.

SELECT * FROM orders;
SELECT * FROM users;
SELECT * FROM orders_products;
SELECT * FROM products;

insert into orders (id, user_id, created_at, updated_at)
values (1, 3, '2020-11-10 22:25:23', '2020-11-10 22:25:47');
insert into orders values (2, 4, '2020-12-10 07:25:23', '2020-12-10 07:29:34');

insert into orders_products values (1, 1, 6, 4311, '2020-11-10 22:25:23', '2020-11-10 22:25:47');
insert into orders_products values (2, 2, 2, 12700, '2020-12-10 07:25:23', '2020-12-10 07:29:34');

UPDATE `homework`.`orders_products` SET `order_id` = '2' WHERE (`id` = '2');

select
	u.id,
    u.name,
    o.id as order_id,
    p.name as product,
    p.price,
    op.total,
    op.created_at,
    op.updated_at
from
	orders o
    join users u on o.user_id = u.id
    join orders_products op on o.id = op.order_id
    join products p on p.id = op.product_id
where op.id > 0;



-- Выведите список товаров products и разделов catalogs, который соответствует товару.
select
	p.id,
    p.name,
    p.description,
    p.price,
    c.name as catalog_category
from
	products p
join catalogs c on c.id = p.catalog_id;