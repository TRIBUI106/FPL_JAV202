CREATE DATABASE PolyCoffee;
GO

USE PolyCoffee;
GO

-- =========================
-- 1. categories
-- =========================
CREATE TABLE categories (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    active BIT NOT NULL DEFAULT 1
);
GO

-- =========================
-- 2. drinks
-- =========================
CREATE TABLE drinks (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    category_id INT NOT NULL,
    active BIT NOT NULL DEFAULT 1,
    CONSTRAINT FK_drinks_categories
        FOREIGN KEY (category_id) REFERENCES categories(id)
);
GO

-- =========================
-- 3. users
-- =========================
CREATE TABLE users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(50) NOT NULL UNIQUE,
    password NVARCHAR(100) NOT NULL,
    fullname NVARCHAR(100) NOT NULL,
    role NVARCHAR(20) NOT NULL,
    active BIT NOT NULL DEFAULT 1
);
GO

-- =========================
-- 4. bills
-- =========================
CREATE TABLE bills (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    created_date DATETIME NOT NULL DEFAULT GETDATE(),
    status NVARCHAR(30) NOT NULL,
    CONSTRAINT FK_bills_users
        FOREIGN KEY (user_id) REFERENCES users(id)
);
GO

-- =========================
-- 5. bill_details
-- =========================
CREATE TABLE bill_details (
    id INT IDENTITY(1,1) PRIMARY KEY,
    bill_id INT NOT NULL,
    drink_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_bill_details_bills
        FOREIGN KEY (bill_id) REFERENCES bills(id),
    CONSTRAINT FK_bill_details_drinks
        FOREIGN KEY (drink_id) REFERENCES drinks(id)
);
GO
INSERT INTO categories(name, active)
VALUES 
(N'Coffee',1),
(N'Tea',1),
(N'Juice',1);

-- Drinks
INSERT INTO drinks(name, price, category_id, active)
VALUES
(N'Black Coffee', 2.5, 1, 1),
(N'Milk Coffee', 3.0, 1, 1),
(N'Milk Tea', 3.5, 2, 1),
(N'Orange Juice', 4.0, 3, 1);

-- Users
INSERT INTO users(username,password,fullname,role,active)
VALUES
('admin','123','Administrator','ADMIN',1),
('staff','123','Staff Member','STAFF',1);

-- Bills
INSERT INTO bills(user_id,status)
VALUES
(1,'PAID'),
(2,'PAID');

-- Bill Details
INSERT INTO bill_details(bill_id,drink_id,quantity,price)
VALUES
(1,1,2,2.5),
(1,3,1,3.5),
(2,2,1,3.0);