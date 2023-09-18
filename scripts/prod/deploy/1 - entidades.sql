-- Crear la base de datos DIGITURNO si no existe
DROP DATABASE IF EXISTS DIGITURNO;
CREATE DATABASE DIGITURNO;
USE DIGITURNO;

-- Crear la tabla tbUsers
CREATE TABLE tbUsers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    registration_date DATE,
    username VARCHAR(255) UNIQUE,
    password VARCHAR(255),
    full_name VARCHAR(255),
    address VARCHAR(255),
    legal_representative_name VARCHAR(255),
    corporation_name VARCHAR(255),
    account_balance DECIMAL(10, 2),
    INDEX (id),
    INDEX (username)
);

-- Crear la tabla tbAccessTokens
CREATE TABLE tbAccessTokens (
    id INT AUTO_INCREMENT PRIMARY KEY,
    registration_date DATE,
    token VARCHAR(255),
    validity DATE,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES tbUsers(id),
    INDEX (id),
    INDEX (user_id)
);

-- Crear la tabla tbDialingCodes con el campo "country_name"
CREATE TABLE tbDialingCodes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    dialing_code VARCHAR(10),
    country_name VARCHAR(255),  -- Nuevo campo
    INDEX (id),
    INDEX (dialing_code)
);

-- Crear la tabla tbCustomers
CREATE TABLE tbCustomers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    registration_date DATE,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    phone_number VARCHAR(20),
    city VARCHAR(255),
    dialing_code_id INT,
    user_id INT,
    FOREIGN KEY (dialing_code_id) REFERENCES tbDialingCodes(id),
    FOREIGN KEY (user_id) REFERENCES tbUsers(id),
    INDEX (id),
    INDEX (phone_number)
);

-- Crear la tabla tbTransactionTypes
CREATE TABLE tbTransactionTypes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    registration_date DATE,
    transaction_type VARCHAR(255),
    cost DECIMAL(10, 2),
    price DECIMAL(10, 2),
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES tbUsers(id),
    INDEX (id),
    INDEX (user_id)
);

-- Crear la tabla tbUsersTransaction
CREATE TABLE tbUsersTransaction (
    id INT AUTO_INCREMENT PRIMARY KEY,
    registration_date DATE,
    customer_id INT,
    user_id INT,
    transaction_type_id INT,
    message_text VARCHAR(250),
    FOREIGN KEY (customer_id) REFERENCES tbCustomers(id),
    FOREIGN KEY (user_id) REFERENCES tbUsers(id),
    FOREIGN KEY (transaction_type_id) REFERENCES tbTransactionTypes(id),
    INDEX (id),
    INDEX (customer_id),
    INDEX (user_id),
    INDEX (transaction_type_id),
    INDEX (registration_date)
);

-- Crear la tabla tbAccountBalances
CREATE TABLE tbAccountBalances (
    id INT AUTO_INCREMENT PRIMARY KEY,
    registration_date DATE,
    user_id INT,
    movement_type ENUM('debit', 'credit'),
    transaction_value DECIMAL(10, 2),
    FOREIGN KEY (user_id) REFERENCES tbUsers(id),
    INDEX (id),
    INDEX (user_id),
    INDEX (movement_type)
);
