-- Create Database
CREATE DATABASE IF NOT EXISTS polycoffee CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE polycoffee;

-- 1. Users Table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(255),
    phone VARCHAR(20),
    role TINYINT(1) DEFAULT 0 COMMENT '1: Manager, 0: Staff',
    active TINYINT(1) DEFAULT 1
) ENGINE=InnoDB;

-- 2. Categories Table
CREATE TABLE IF NOT EXISTS categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    active TINYINT(1) DEFAULT 1
) ENGINE=InnoDB;

-- 3. Drinks Table
CREATE TABLE IF NOT EXISTS drinks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    image VARCHAR(255),
    price INT NOT NULL,
    active TINYINT(1) DEFAULT 1,
    CONSTRAINT fk_drink_category FOREIGN KEY (category_id) REFERENCES categories(id)
) ENGINE=InnoDB;

-- 4. Bills Table
CREATE TABLE IF NOT EXISTS bills (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    code VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total INT DEFAULT 0,
    status ENUM('WAITING', 'FINISHED', 'CANCELLED') DEFAULT 'WAITING',
    CONSTRAINT fk_bill_user FOREIGN KEY (user_id) REFERENCES users(id)
) ENGINE=InnoDB;

-- 5. Bill Details Table
CREATE TABLE IF NOT EXISTS bill_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    bill_id INT NOT NULL,
    drink_id INT NOT NULL,
    quantity INT NOT NULL,
    price INT NOT NULL,
    CONSTRAINT fk_detail_bill FOREIGN KEY (bill_id) REFERENCES bills(id) ON DELETE CASCADE,
    CONSTRAINT fk_detail_drink FOREIGN KEY (drink_id) REFERENCES drinks(id)
) ENGINE=InnoDB;

-- Sample Data Initialization
INSERT INTO users (email, password, full_name, phone, role, active) VALUES
('manager@polycoffee.com', 'admin123', 'John Manager', '0987654321', 1, 1),
('staff@polycoffee.com', 'staff123', 'Jane Staff', '0123456789', 0, 1);

INSERT INTO categories (name, active) VALUES
('Coffee', 1),
('Tea', 1),
('Smoothies', 1),
('Snacks', 1);

INSERT INTO drinks (category_id, name, description, price, active) VALUES
(1, 'Espresso', 'Rich and bold dark roast', 35000, 1),
(1, 'Cappuccino', 'Steamed milk and foam', 45000, 1),
(2, 'Peach Tea', 'Sweet and refreshing', 30000, 1),
(3, 'Avocado Smoothie', 'Creamy and fresh', 55000, 1);
