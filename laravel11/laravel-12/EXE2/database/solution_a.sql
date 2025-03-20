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
('user1', 'user1@example.com', 'password123', GETDATE(), GETDATE()),
('user2', 'user2@example.com', 'password456', GETDATE(), GETDATE()),
('user3', 'user3@example.com', 'password789', GETDATE(), GETDATE()),
('user4', 'user4@example.com', 'password101', GETDATE(), GETDATE()),
('user5', 'user5@example.com', 'password202', GETDATE(), GETDATE()),
('user6', 'user6@example.com', 'password789', GETDATE(), GETDATE()),
('user7', 'user7@example.com', 'password101', GETDATE(), GETDATE()),
('user8', 'user8@example.com', 'password202', GETDATE(), GETDATE());

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


-- 1. Lấy ra danh sách người dùng theo thứ tự tên theo Alphabet (A->Z)
SELECT * FROM users ORDER BY user_name ASC;

-- 2. Lấy ra 07 người dùng theo thứ tự tên theo Alphabet (A->Z)
SELECT TOP 7 * FROM users ORDER BY user_name ASC;

-- 3. Lấy ra danh sách người dùng theo thứ tự tên theo Alphabet (A->Z), trong đó tên người dùng có chữ a
SELECT * FROM users WHERE user_name LIKE '%a%' ORDER BY user_name ASC;

-- 4. Lấy ra danh sách người dùng trong đó tên người dùng bắt đầu bằng chữ m
SELECT * FROM users WHERE user_name LIKE 'm%';

-- 5. Lấy ra danh sách người dùng trong đó tên người dùng kết thúc bằng chữ i
SELECT * FROM users WHERE user_name LIKE '%i';

-- 6. Lấy ra danh sách người dùng trong đó email người dùng là Gmail (ví dụ: example@gmail.com)
SELECT * FROM users WHERE user_email LIKE '%@gmail.com';

-- 7. Lấy ra danh sách người dùng trong đó email người dùng là Gmail (ví dụ: example@gmail.com), tên người dùng bắt đầu bằng chữ m
SELECT * FROM users WHERE user_email LIKE '%@gmail.com' AND user_name LIKE 'm%';

-- 8. Lấy ra danh sách người dùng trong đó email người dùng là Gmail (ví dụ: example@gmail.com), tên người dùng có chữ i và tên người dùng có chiều dài lớn hơn 5
SELECT * FROM users WHERE user_email LIKE '%@gmail.com' AND user_name LIKE '%i%' AND LEN(user_name) > 5;

-- 9. Lấy ra danh sách người dùng trong đó tên người dùng có chữ a, chiều dài từ 5 đến 9, email dùng dịch vụ Gmail, trong tên email có chữ I (trong tên, chứ không phải domain exampleitest@yahoo.com)
SELECT * FROM users 
WHERE user_name LIKE '%a%' 
AND LEN(user_name) BETWEEN 5 AND 9 
AND user_email LIKE '%@gmail.com' 
AND user_email LIKE '%i%';

-- 10. Lấy ra danh sách người dùng trong đó tên người dùng có chữ a, chiều dài từ 5 đến 9 hoặc tên người dùng có chữ i, chiều dài nhỏ hơn 9 hoặc email dùng dịch vụ Gmail, trong tên email có chữ i
SELECT * FROM users 
WHERE (user_name LIKE '%a%' AND LEN(user_name) BETWEEN 5 AND 9) 
OR (user_name LIKE '%i%' AND LEN(user_name) < 9) 
OR (user_email LIKE '%@gmail.com' AND user_email LIKE '%i%');




