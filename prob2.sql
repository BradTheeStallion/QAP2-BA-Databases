--Brad Ayers
--QAP2 Problem 2: Online Store Inventory and Orders System
--October 8 - 9, 2024

--Create Tables:
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    stock_quantity INT,
    CONSTRAINT check_stock_quantity CHECK (stock_quantity >= 0)
);

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_price DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

--Insert Data:
--Insert products
INSERT INTO products (product_name, price, stock_quantity) VALUES
('Ghost Shrimp', 3.99, 100),
('Neocaridina Shrimp', 7.99, 200),
('Amano Shrimp', 9.99, 300),
('Bamboo Shrimp', 16.99, 50),
('Caridina Shrimp', 8.99, 250);

--Insert customers
INSERT INTO customers (first_name, last_name, email) VALUES
('Adam', 'Stevenson', 'adam.stevenson@keyin.com'),
('Brandon', 'Shea', 'brandon.shea@keyin.com'),
('Kyle', 'Hollett', 'kyle.hollett@keyin.com'),
('Brian', 'Janes', 'brian.janes@keyin.com');

--Insert orders
INSERT INTO orders (customer_id, order_date, total_price) VALUES
(1, '2024-10-01', 23.97),
(2, '2024-10-01', 24.98),
(3, '2024-10-02', 30.96),
(4, '2024-10-02', 24.97),
(1, '2024-10-03', 26.98);

--Insert order items
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 1),
(1, 3, 2),
(2, 2, 1),
(2, 4, 1),
(3, 5, 3),
(3, 1, 1),
(4, 2, 2),
(4, 5, 1),
(5, 3, 1),
(5, 4, 1);

--Tasks:
--Retrieve all products with their stock quantities
SELECT product_name, stock_quantity
FROM products;

--Retrieve the product names and quantities for one of the orders
SELECT products.product_name, order_items.quantity
FROM order_items
JOIN products ON order_items.product_id = products.id
WHERE order_items.order_id = 1;

--Retrieve all orders placed by a specific customer
--(including the IDs of what was ordered and quantities)
SELECT orders.id AS order_id, order_items.product_id, order_items.quantity
FROM orders
JOIN order_items ON orders.id = order_items.order_id
WHERE orders.customer_id = 1;

--Update Data
--Simulate stock reduction for order_id = 1
UPDATE products
SET stock_quantity = GREATEST(0, stock_quantity - (
    SELECT quantity
    FROM order_items
    WHERE order_items.product_id = products.id AND order_items.order_id = 1
))
WHERE id IN (SELECT product_id FROM order_items WHERE order_id = 1);

--Delete Data:
--Delete order with id = 2
DELETE FROM orders
WHERE id = 2;
