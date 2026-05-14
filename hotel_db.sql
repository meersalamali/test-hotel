-- ============================================================
-- Hotel Management System — MySQL Database Schema
-- Run this in phpMyAdmin or: mysql -u root -p < hotel_db.sql
-- Then run setup.php once to create the admin user.
-- ============================================================

CREATE DATABASE IF NOT EXISTS `hotel_management`
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;

USE `hotel_management`;

-- ── USERS ────────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS `users` (
  `id`         INT AUTO_INCREMENT PRIMARY KEY,
  `username`   VARCHAR(50)  NOT NULL UNIQUE,
  `password`   VARCHAR(255) NOT NULL,
  `role`       VARCHAR(30)  DEFAULT 'admin',
  `created_at` TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ── ROOMS ────────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS `rooms` (
  `id`          INT AUTO_INCREMENT PRIMARY KEY,
  `number`      VARCHAR(20)   NOT NULL,
  `type`        VARCHAR(50),
  `floor`       INT           DEFAULT 1,
  `capacity`    INT           DEFAULT 2,
  `price`       DECIMAL(10,2) DEFAULT 0.00,
  `status`      ENUM('available','occupied','maintenance') DEFAULT 'available',
  `amenities`   TEXT,
  `description` TEXT
) ENGINE=InnoDB;

-- ── EMPLOYEES ────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS `employees` (
  `id`         INT AUTO_INCREMENT PRIMARY KEY,
  `name`       VARCHAR(100),
  `role`       VARCHAR(100),
  `department` VARCHAR(100),
  `phone`      VARCHAR(50),
  `email`      VARCHAR(150),
  `salary`     DECIMAL(10,2) DEFAULT 0.00,
  `hire_date`  DATE,
  `status`     ENUM('active','inactive') DEFAULT 'active'
) ENGINE=InnoDB;

-- ── BOOKINGS ─────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS `bookings` (
  `id`              INT AUTO_INCREMENT PRIMARY KEY,
  `guest_name`      VARCHAR(150),
  `room_id`         INT,
  `check_in`        DATE,
  `check_out`       DATE,
  `adults`          INT           DEFAULT 1,
  `price_per_night` DECIMAL(10,2) DEFAULT 0.00,
  `total`           DECIMAL(10,2) DEFAULT 0.00,
  `status`          ENUM('active','pending','cancelled','completed') DEFAULT 'active',
  `notes`           TEXT,
  FOREIGN KEY (`room_id`) REFERENCES `rooms`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB;
-- For existing databases run:
-- ALTER TABLE `bookings` ADD COLUMN IF NOT EXISTS `price_per_night` DECIMAL(10,2) DEFAULT 0.00 AFTER `adults`;
-- ALTER TABLE `bookings` MODIFY `status` ENUM('active','pending','cancelled','completed') DEFAULT 'active';

-- ── INCOME ───────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS `income` (
  `id`       INT AUTO_INCREMENT PRIMARY KEY,
  `source`   VARCHAR(150),
  `amount`   DECIMAL(10,2) DEFAULT 0.00,
  `date`     DATE,
  `category` VARCHAR(50),
  `notes`    TEXT
) ENGINE=InnoDB;

-- ── SALARY PAYMENTS ──────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS `salary_payments` (
  `id`          INT AUTO_INCREMENT PRIMARY KEY,
  `employee_id` INT,
  `amount`      DECIMAL(10,2) DEFAULT 0.00,
  `date`        DATE,
  `month`       VARCHAR(50),
  `type`        ENUM('salary','advance') DEFAULT 'salary',
  `receipt_no`  VARCHAR(100),
  `notes`       TEXT,
  FOREIGN KEY (`employee_id`) REFERENCES `employees`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB;
-- For existing databases run:
-- ALTER TABLE `salary_payments` ADD COLUMN IF NOT EXISTS `type` ENUM('salary','advance') DEFAULT 'salary' AFTER `month`;
-- ALTER TABLE `salary_payments` ADD COLUMN IF NOT EXISTS `receipt_no` VARCHAR(100) AFTER `type`;

ALTER TABLE `salary_payments` ADD COLUMN IF NOT EXISTS `type` ENUM('salary','advance') DEFAULT 'salary' AFTER `month`;
ALTER TABLE `salary_payments` ADD COLUMN IF NOT EXISTS `receipt_no` VARCHAR(100) AFTER `type`;

CREATE TABLE IF NOT EXISTS `expenditures` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `subject` VARCHAR(200), `amount` DECIMAL(10,2) DEFAULT 0.00,
  `receipt_no` VARCHAR(100), `date` DATE, `notes` TEXT
) ENGINE=InnoDB;

-- ── EXPENDITURES ─────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS `expenditures` (
  `id`         INT AUTO_INCREMENT PRIMARY KEY,
  `subject`    VARCHAR(200),
  `amount`     DECIMAL(10,2) DEFAULT 0.00,
  `receipt_no` VARCHAR(100),
  `date`       DATE,
  `notes`      TEXT
) ENGINE=InnoDB;

-- ── SEED DATA ────────────────────────────────────────────────────────────────
-- NOTE: The admin user must be inserted via setup.php (requires PHP password_hash).

INSERT INTO `rooms` (`number`,`type`,`floor`,`capacity`,`price`,`status`,`amenities`,`description`) VALUES
('101','Standard',1,2,89.00,'available','WiFi, TV, AC','Cozy standard room with garden view'),
('102','Standard',1,2,89.00,'occupied','WiFi, TV, AC','Cozy standard room with garden view'),
('103','Standard',1,2,89.00,'occupied','WiFi, TV, AC','Standard room'),
('201','Deluxe',2,2,149.00,'available','WiFi, TV, AC, Mini Bar','Spacious deluxe room with city view'),
('202','Deluxe',2,3,169.00,'occupied','WiFi, TV, AC, Mini Bar','Spacious deluxe room with pool view'),
('301','Suite',3,4,299.00,'available','WiFi, TV, AC, Mini Bar, Jacuzzi','Luxury suite with panoramic view'),
('302','Suite',3,2,279.00,'maintenance','WiFi, TV, AC, Jacuzzi','Suite under renovation'),
('401','Presidential',4,6,599.00,'available','All Amenities, Butler','Presidential suite with terrace');

INSERT INTO `employees` (`name`,`role`,`department`,`phone`,`email`,`salary`,`hire_date`,`status`) VALUES
('Ahmad Karim','General Manager','Management','+964 750 111 2222','ahmad@hotel.com',3500.00,'2020-01-15','active'),
('Sara Hassan','Front Desk','Reception','+964 750 333 4444','sara@hotel.com',1200.00,'2021-03-10','active'),
('Omar Saleh','Chef','Kitchen','+964 750 555 6666','omar@hotel.com',1800.00,'2019-06-20','active'),
('Layla Nouri','Housekeeper','Housekeeping','+964 750 777 8888','layla@hotel.com',900.00,'2022-01-05','active'),
('Karwan Aziz','Security','Security','+964 750 999 0000','karwan@hotel.com',1100.00,'2021-08-15','active'),
('Naz Omer','Accountant','Finance','+964 750 123 4567','naz@hotel.com',1600.00,'2020-11-01','active');

-- ── SETTINGS ─────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS `settings` (
  `id`         INT AUTO_INCREMENT PRIMARY KEY,
  `skey`       VARCHAR(100) NOT NULL UNIQUE,
  `svalue`     TEXT,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

INSERT INTO `settings` (`skey`, `svalue`) VALUES
('hotel_name',   'Grand Luxe Hotel'),
('logo',         '🏨'),
('accent_color', '#c9a84c'),
('dark_mode',    '0'),
('language',     'en'),
('expire_days',  '30'),
('saved_at',     NULL)
ON DUPLICATE KEY UPDATE skey=skey;
