CREATE database SanPham;


CREATE TABLE users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,   
    user_name VARCHAR(25) NOT NULL,
    user_email VARCHAR(55) NOT NULL,
    user_pass VARCHAR(255) NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,   
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP    
);

CREATE TABLE products (
    product_id INT IDENTITY(1,1) PRIMARY KEY,   
    product_name VARCHAR(255) NOT NULL,
    product_price FLOAT NOT NULL,   
    product_description TEXT NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,   
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP   
);

CREATE TABLE orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,  
    user_id INT NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,   
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,    
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE order_details (
    order_detail_id INT IDENTITY(1,1) PRIMARY KEY,   
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,   
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,    
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


INSERT INTO users (user_name, user_email, user_pass, created_at, updated_at)
VALUES 
('abc', 'abc@gmail.com', 'password123', GETDATE(), GETDATE()),
('rtf', 'rtf@gmail.com', 'password456', GETDATE(), GETDATE()),
('fff', 'fff@gmail.com', 'password789', GETDATE(), GETDATE()),
('eee', 'eee@gmail.com', 'password101', GETDATE(), GETDATE()),
('sdc', 'sdc@hotmail.com', 'password202', GETDATE(), GETDATE()),
('ttt', 'ttt@gmail.com', 'password789', GETDATE(), GETDATE()),
('www', 'www@gmail.com', 'password101', GETDATE(), GETDATE()),
('qqq', 'qqq@gmail.com', 'password202', GETDATE(), GETDATE()),
('mmm', 'mmm@gmail.com', 'password101', GETDATE(), GETDATE()),
('mam', 'mam@gmail.com', 'password101', GETDATE(), GETDATE()),
('iii', 'qqq@gmail.com', 'password202', GETDATE(), GETDATE());

INSERT INTO products (product_name, product_price, product_description, created_at, updated_at)
VALUES 
('Product 1', 100.50, 'This is a description for product 1.', GETDATE(), GETDATE()),
('Product 2', 250.75, 'This is a description for product 2.', GETDATE(), GETDATE()),
('Product 3', 75.20, 'This is a description for product 3.', GETDATE(), GETDATE()),
('Product 4', 150.00, 'This is a description for product 4.', GETDATE(), GETDATE()),
('Product 5', 50.99, 'This is a description for product 5.', GETDATE(), GETDATE());


INSERT INTO orders (user_id, created_at, updated_at)
VALUES 
(1, GETDATE(), GETDATE()),
(2, GETDATE(), GETDATE()),
(3, GETDATE(), GETDATE()),
(4, GETDATE(), GETDATE()),
(5, GETDATE(), GETDATE());


INSERT INTO order_details (order_id, product_id, created_at, updated_at)
VALUES 
(1, 1, GETDATE(), GETDATE()), 
(1, 2, GETDATE(), GETDATE()),
(2, 2, GETDATE(), GETDATE()),
(2, 3, GETDATE(), GETDATE()),
(3, 4, GETDATE(), GETDATE()),
(4, 1, GETDATE(), GETDATE()),
(4, 5, GETDATE(), GETDATE()),
(5, 3, GETDATE(), GETDATE()),
(5, 4, GETDATE(), GETDATE());



-- 1. Liệt kê các hóa đơn của khách hàng, thông tin hiển thị gồm: mã user, tên user, mã hóa đơn
SELECT u.user_id, u.user_name, o.order_id 
FROM users u 
JOIN orders o ON u.user_id = o.user_id;

-- 2. Liệt kê số lượng các hóa đơn của khách hàng: mã user, tên user, số đơn hàng
SELECT u.user_id, u.user_name, COUNT(o.order_id) AS order_count 
FROM users u 
LEFT JOIN orders o ON u.user_id = o.user_id 
GROUP BY u.user_id, u.user_name;

-- 3. Liệt kê thông tin hóa đơn: mã đơn hàng, số sản phẩm
SELECT o.order_id, COUNT(od.product_id) AS product_count 
FROM orders o 
JOIN order_details od ON o.order_id = od.order_id 
GROUP BY o.order_id;

-- 4. Liệt kê thông tin mua hàng của người dùng: mã user, tên user, mã đơn hàng, tên sản phẩm
SELECT u.user_id, u.user_name, o.order_id, p.product_name 
FROM users u 
JOIN orders o ON u.user_id = o.user_id 
JOIN order_details od ON o.order_id = od.order_id 
JOIN products p ON od.product_id = p.product_id 
ORDER BY o.order_id;

-- 5. Liệt kê 7 người dùng có số lượng đơn hàng nhiều nhất
SELECT TOP 7 u.user_id, u.user_name, COUNT(o.order_id) AS order_count 
FROM users u 
JOIN orders o ON u.user_id = o.user_id 
GROUP BY u.user_id, u.user_name 
ORDER BY order_count DESC;

-- 6. Liệt kê 7 người dùng mua sản phẩm có tên: Samsung hoặc Apple trong tên sản phẩm
SELECT TOP 7 DISTINCT u.user_id, u.user_name, o.order_id, p.product_name 
FROM users u 
JOIN orders o ON u.user_id = o.user_id 
JOIN order_details od ON o.order_id = od.order_id 
JOIN products p ON od.product_id = p.product_id 
WHERE p.product_name LIKE '%Samsung%' OR p.product_name LIKE '%Apple%';

-- 7. Liệt kê danh sách mua hàng của user bao gồm giá tiền của mỗi đơn hàng
SELECT u.user_id, u.user_name, o.order_id, SUM(p.product_price) AS total_amount 
FROM users u 
JOIN orders o ON u.user_id = o.user_id 
JOIN order_details od ON o.order_id = od.order_id 
JOIN products p ON od.product_id = p.product_id 
GROUP BY u.user_id, u.user_name, o.order_id;

-- 8. Liệt kê danh sách mua hàng của user bao gồm giá tiền của mỗi đơn hàng, thông tin hiển thị gồm: mã user, tên user, mã đơn hàng, tổng tiền. Mỗi user chỉ chọn ra 1 đơn hàng có giá tiền lớn nhất
WITH RankedOrders AS (
    SELECT u.user_id, u.user_name, o.order_id, SUM(p.product_price) AS total_amount,
           ROW_NUMBER() OVER (PARTITION BY u.user_id ORDER BY SUM(p.product_price) DESC) AS row_num
    FROM users u 
    JOIN orders o ON u.user_id = o.user_id 
    JOIN order_details od ON o.order_id = od.order_id 
    JOIN products p ON od.product_id = p.product_id 
    GROUP BY u.user_id, u.user_name, o.order_id
)
SELECT user_id, user_name, order_id, total_amount
FROM RankedOrders
WHERE row_num = 1;

-- 9. Liệt kê danh sách mua hàng của user bao gồm giá tiền của mỗi đơn hàng, thông tin hiển thị gồm: mã user, tên user, mã đơn hàng, tổng tiền, số sản phẩm. Mỗi user chỉ chọn ra 1 đơn hàng có giá tiền nhỏ nhất
WITH RankedOrders AS (
    SELECT u.user_id, u.user_name, o.order_id, SUM(p.product_price) AS total_amount,
           COUNT(od.product_id) AS product_count,
           ROW_NUMBER() OVER (PARTITION BY u.user_id ORDER BY SUM(p.product_price) ASC) AS row_num
    FROM users u 
    JOIN orders o ON u.user_id = o.user_id 
    JOIN order_details od ON o.order_id = od.order_id 
    JOIN products p ON od.product_id = p.product_id 
    GROUP BY u.user_id, u.user_name, o.order_id
)
SELECT user_id, user_name, order_id, total_amount, product_count
FROM RankedOrders
WHERE row_num = 1;

-- 10. Liệt kê danh sách mua hàng của user bao gồm giá tiền của mỗi đơn hàng, thông tin hiển thị gồm: mã user, tên user, mã đơn hàng, tổng tiền, số sản phẩm. Mỗi user chỉ chọn ra 1 đơn hàng có số sản phẩm là nhiều nhất
WITH RankedOrders AS (
    SELECT u.user_id, u.user_name, o.order_id, SUM(p.product_price) AS total_amount,
           COUNT(od.product_id) AS product_count,
           ROW_NUMBER() OVER (PARTITION BY u.user_id ORDER BY COUNT(od.product_id) DESC) AS row_num
    FROM users u 
    JOIN orders o ON u.user_id = o.user_id 
    JOIN order_details od ON o.order_id = od.order_id 
    JOIN products p ON od.product_id = p.product_id 
    GROUP BY u.user_id, u.user_name, o.order_id
)
SELECT user_id, user_name, order_id, total_amount, product_count
FROM RankedOrders
WHERE row_num = 1;
