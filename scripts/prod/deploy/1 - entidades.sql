-- Crear la base de datos DIGITURNO si no existe
DROP DATABASE IF EXISTS DIGITURNO;
CREATE DATABASE DIGITURNO;
USE DIGITURNO;

-- Crear la tabla tbUsers
CREATE TABLE tbUsers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    registration_date DATETIME,
    username VARCHAR(50) UNIQUE,
    password VARCHAR(70),
    first_name VARCHAR(250),
    last_name varchar(250),
    address VARCHAR(255),
    city VARCHAR(200),
    phone_number VARCHAR(20),
    country VARCHAR(200),
    email VARCHAR(255),
    legal_representative_name VARCHAR(255),
    corporation_name VARCHAR(255),
    account_balance DECIMAL(10, 2),
    INDEX (id),
    INDEX (username)
);

-- Crear la tabla tbAccessTokens
CREATE TABLE tbAccessTokens (
    id INT AUTO_INCREMENT PRIMARY KEY,
    registration_date DATETIME,
    token VARCHAR(255),
    validity DATETIME,
    user_id INT,
    is_valid BOOLEAN DEFAULT TRUE,
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
    registration_date DATETIME,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    phone_number VARCHAR(20),
    city VARCHAR(255),
    dialing_code_id INT DEFAULT 57,
    FOREIGN KEY (dialing_code_id) REFERENCES tbDialingCodes(id),
    INDEX (id),
    INDEX (phone_number)
);

-- Crear la tabla tbTransactionTypes
CREATE TABLE tbTransactionTypes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    registration_date DATETIME,
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
    registration_date DATETIME,
    customer_id INT,
    user_id INT,
    transaction_type_id INT,
    message_text VARCHAR(250),
    api_code VARCHAR(20),
    api_response VARCHAR(250),
    api_accepted BOOLEAN DEFAULT FALSE,
    api_id VARCHAR(100),
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
    registration_date DATETIME,
    user_id INT,
    movement_type ENUM('debit', 'credit'),
    transaction_value DECIMAL(10, 2),
    FOREIGN KEY (user_id) REFERENCES tbUsers(id),
    INDEX (id),
    INDEX (user_id),
    INDEX (movement_type)
);

-- tbUserCustomerRelation (Tabla de relación muchos a muchos)
CREATE TABLE tbUserCustomerRelation (
    id INT AUTO_INCREMENT PRIMARY KEY,
    registration_date DATETIME,
    user_id INT,
    customer_id INT,
    FOREIGN KEY (user_id) REFERENCES tbUsers(id),
    FOREIGN KEY (customer_id) REFERENCES tbCustomers(id),
    INDEX (id),
    INDEX (user_id),
    INDEX (customer_id),
    INDEX (registration_date)
);

CREATE VIEW vwLastTransactions AS (
    SELECT * FROM tbUsersTransaction WHERE api_accepted =  1 ORDER BY registration_date DESC LIMIT 7
);