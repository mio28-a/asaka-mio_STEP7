--設問１
select * from users;

--設問２
SELECT * FROM users
WHERE created_at LIKE '2024%';

--設問３
SELECT * FROM `users` WHERE `age`< 30 AND `gender`='female';

--設問４
SELECT product_name,price 
FROM `products`;

--設問５
SELECT users.name,orders.order_date
FROM `users`
JOIN `orders`
ON users.id = orders.user_id;

--設問６
SELECT 
order_items.quantity,
products.product_name,
products.price,
products.price*order_items.quantity
FROM order_items
JOIN products
ON order_items.product_id = products.id;

--設問７
SELECT users.name,
COUNT(orders.id)
FROM users
JOIN orders
ON users.id = orders.user_id
GROUP BY users.name;

--設問８
SELECT users.name,
       SUM(products.price * order_items.quantity)
FROM users
JOIN orders
    ON users.id = orders.user_id
JOIN order_items
    ON orders.id = order_items.order_id
JOIN products
    ON order_items.product_id = products.id
GROUP BY users.name;

--設問９
SELECT users.name,
    SUM(products.price * order_items.quantity) AS total_price
FROM `users`
JOIN `orders`
    ON users.id = orders.user_id
JOIN `order_items`
    ON orders.id = order_items.order_id
JOIN products
    ON order_items.product_id = products.id
GROUP BY users.id, users.name
ORDER BY total_price DESC
LIMIT 1;

--設問１０
SELECT products.product_name,
    SUM(quantity) AS '合計数量'
FROM `products`
JOIN order_items
ON products.id = order_items.product_id
GROUP BY products.product_name;

--設問１１
SELECT users.name
FROM users
LEFT JOIN orders
    ON users.id = orders.user_id
WHERE orders.user_id IS NULL;

--設問１２
SELECT order_id
FROM order_items
GROUP BY order_id
HAVING COUNT(DISTINCT product_id) >= 2;

--設問１３
SELECT users.name
FROM users
JOIN orders
    ON users.id = orders.user_id
JOIN order_items
    ON orders.id = order_items.order_id
JOIN products
    ON order_items.product_id = products.id
WHERE products.product_name = 'テレビ';


--設問１４
SELECT
    orders.order_date,
    users.name,
    products.product_name,
    order_items.quantity,
    products.price * order_items.quantity AS 合計金額
FROM users
JOIN orders
    ON users.id = orders.user_id
JOIN order_items
    ON orders.id = order_items.order_id
JOIN products
    ON order_items.product_id = products.id;

--設問１５
SELECT products.product_name,
    SUM(order_items.quantity) AS total_quantity
FROM products
JOIN order_items
ON products.id = order_items.product_id
GROUP BY products.product_name
ORDER BY total_quantity DESC
LIMIT 1;

--設問１６
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS 年月,
    COUNT(*) AS 注文件数
FROM orders
GROUP BY 年月;

--設問１７
SELECT products.product_name
FROM products
LEFT JOIN order_items
ON products.id = order_items.product_id
WHERE order_items.id IS NULL;

--設問１８
CREATE INDEX idx_order_items_product_id
ON order_items(product_id);

--設問１９
SELECT user_id,
    AVG(order_total) AS average_order_total
FROM (
    SELECT 
    orders.user_id,
    orders.id,
    SUM(products.price*order_items.quantity) AS order_total
FROM orders
JOIN order_items
ON orders.id = order_items.order_id
JOIN products
ON order_items.product_id = products.id
GROUP BY orders.user_id,orders.id
) AS order_totals
GROUP BY user_id;

--設問２０
SELECT users.name,
    MAX(orders.order_date) AS latest_order_date
FROM users
JOIN orders
ON users.id = orders.user_id
GROUP BY users.name;

    --設問21
INSERT INTO 
    `users`(`id`,`name`,`age`,`gender`,`created_at`)
VALUES
    (6,'中村愛',25,'female','2025-06-01');

    --設問22
INSERT INTO `products`(`id`,`product_name`,`price`)
VALUES
(6,'エアコン',60000);

    --設問23
INSERT INTO `orders`(`id`,`user_id`,`order_date`)
VALUES
(10,1,'2025-06-10');

    --設問24
INSERT INTO `order_items`(`id`,`order_id`,`product_id`,`quantity`)
VALUES
(10,10,6,1);

    --設問25
UPDATE `users`
SET `age` = 24
WHERE `name` = '田中美咲';

    --設問26
UPDATE `products`
SET `price` = price * 1.1;

    --設問27
UPDATE `orders`
SET `order_date` = '2024-05-01'
WHERE `order_date` < '2024-05-01';

    --設問28
DELETE
FROM `users`
WHERE `name`='高橋健一';

    --設問29
DELETE
FROM `order_items`
WHERE `order_id` = 5 ;

    --設問30
DELETE products
FROM products
LEFT JOIN order_items
    ON products.id = order_items.product_id
WHERE order_items.id IS NULL;