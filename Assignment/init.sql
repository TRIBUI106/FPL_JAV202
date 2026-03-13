-- ==========================================
-- POLYCOFFEE DATABASE INITIALIZATION
-- Premium Brews & Jakarta EE ProMax
-- ==========================================

-- Create Database
CREATE DATABASE IF NOT EXISTS polycoffee CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE polycoffee;

-- 1. Users Table (Core Personnel)
DROP TABLE IF EXISTS bill_details;
DROP TABLE IF EXISTS bills;
DROP TABLE IF EXISTS drinks;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(255),
    phone VARCHAR(20),
    role TINYINT(1) DEFAULT 0 COMMENT '1: Manager, 0: Staff',
    active TINYINT(1) DEFAULT 1
) ENGINE=InnoDB;

-- 2. Categories Table (Menu Archetypes)
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    active TINYINT(1) DEFAULT 1
) ENGINE=InnoDB;

-- 3. Drinks Table (The Artisan Collection)
CREATE TABLE drinks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    image VARCHAR(255),
    price INT NOT NULL,
    active TINYINT(1) DEFAULT 1,
    CONSTRAINT fk_drink_category FOREIGN KEY (category_id) REFERENCES categories(id)
) ENGINE=InnoDB;

-- 4. Bills Table (Transaction Ledger)
CREATE TABLE bills (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    code VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total INT DEFAULT 0,
    status ENUM('WAITING', 'FINISHED', 'CANCELLED') DEFAULT 'WAITING',
    CONSTRAINT fk_bill_user FOREIGN KEY (user_id) REFERENCES users(id)
) ENGINE=InnoDB;

-- 5. Bill Details Table (Line Items)
CREATE TABLE bill_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    bill_id INT NOT NULL,
    drink_id INT NOT NULL,
    quantity INT NOT NULL,
    price INT NOT NULL,
    CONSTRAINT fk_detail_bill FOREIGN KEY (bill_id) REFERENCES bills(id) ON DELETE CASCADE,
    CONSTRAINT fk_detail_drink FOREIGN KEY (drink_id) REFERENCES drinks(id)
) ENGINE=InnoDB;

-- ==========================================
-- SEED DATA: AUTHENTICATION
-- ==========================================
INSERT INTO users (email, password, full_name, phone, role, active) VALUES
('admin@polycoffee.com', 'admin@2026', 'Executive Manager', '0901234567', 1, 1),
('staff@polycoffee.com', 'staff@2026', 'Senior Barista', '0907654321', 0, 1),
('demo@polycoffee.com', 'password', 'Guest Assistant', '0123456789', 0, 1);

-- ==========================================
-- SEED DATA: CATEGORIES
-- ==========================================
INSERT INTO categories (name, active) VALUES
('Signature Coffee', 1),
('Premium Tea', 1),
('Velvet Smoothies', 1),
('Artisanal Bakery', 1),
('Seasonal Specials', 1);

-- ==========================================
-- SEED DATA: THE DRINK COLLECTION
-- ==========================================

-- Signature Coffee
INSERT INTO drinks (category_id, name, description, price, active, image) VALUES
(1, 'Obsidian Cold Brew', '24-hour slow-steeped signature blend with hints of dark chocolate.', 55000, 1, 'cold-brew.jpg'),
(1, 'Golden Latte', 'Creamy espresso with saffron-infused milk and organic honey.', 65000, 1, 'golden-latte.jpg'),
(1, 'Espresso Romano', 'Double shot of our finest Arabica with a twist of lemon zest.', 40000, 1, 'espresso.jpg'),
(1, 'Nitro Velvet', 'Nitrogen-infused cold brew for a silky, Guinness-like finish.', 60000, 1, 'nitro.jpg');

-- Premium Tea
INSERT INTO drinks (category_id, name, description, price, active, image) VALUES
(2, 'Imperial Oolong', 'Rare high-mountain tea with a floral, long-lasting aroma.', 45000, 1, 'oolong.jpg'),
(2, 'Moroccan Mint', 'Refreshing green tea with fresh mint leaves and honeycomb.', 42000, 1, 'mint-tea.jpg'),
(2, 'Lavender Earl Grey', 'Classic Earl Grey with organic lavender petals and steamed milk.', 48000, 1, 'earl-grey.jpg');

-- Velvet Smoothies
INSERT INTO drinks (category_id, name, description, price, active, image) VALUES
(3, 'Emerald Matcha', 'Ceremonial grade matcha blended with white chocolate and soy.', 75000, 1, 'matcha-smoothie.jpg'),
(3, 'Berry Symphony', 'Assorted wild berries with Greek yogurt and basil infusion.', 68000, 1, 'berry-smoothie.jpg');

-- Artisanal Bakery
INSERT INTO drinks (category_id, name, description, price, active, image) VALUES
(4, 'Truffle Croissant', 'Buttery pastry with black truffle oil and sea salt flakes.', 85000, 1, 'croissant.jpg'),
(4, 'Dark Forest Scone', 'Cacao-infused scone with dried cherries and whipped cream.', 52000, 1, 'scone.jpg');

-- Seasonal Specials
INSERT INTO drinks (category_id, name, description, price, active, image) VALUES
(5, 'Sakura Blossom Latte', 'Cherry blossom syrup with white coffee and rose petals.', 70000, 1, 'sakura.jpg'),
(5, 'Autumn Spice Brew', 'Pumpkin spice cold foam on top of a cinnamon-infused dark roast.', 72000, 1, 'autumn-spice.jpg');

-- ==========================================
-- END OF INITIALIZATION
-- ==========================================
