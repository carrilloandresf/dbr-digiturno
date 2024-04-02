-- Crear la tabla de colas de mensajes
CREATE TABLE tbQueue (
    id INT AUTO_INCREMENT PRIMARY KEY,
    registration_date DATETIME,
    user_id INT,
    turno_id VARCHAR(3),
    transaction_type_id INT,
    phone_number VARCHAR(20),
    sent_transaction BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES tbUsers(id),
    FOREIGN KEY (transaction_type_id) REFERENCES tbTransactionTypes(id),
    INDEX (id),
    INDEX (user_id),
    INDEX (transaction_type_id)
);

-- Crear la tabla de contadores de turnos
CREATE TABLE tbQueueCounter (
    user_id INT PRIMARY KEY,
    counter INT DEFAULT 1,
    FOREIGN KEY (user_id) REFERENCES tbUsers(id),
    INDEX (user_id)
);

-- Crear la tabla para relacionar tbimagenes con un grupo de imagenes
CREATE TABLE tbImageGroup (
    id INT AUTO_INCREMENT PRIMARY KEY,
    registration_date DATETIME,
    image_group_name VARCHAR(255),
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    INDEX (id)
);

-- Crear la tabla tbImages para almacenar imagenes publicitarias por url
CREATE TABLE tbImages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    registration_date DATETIME,
    imagegroup_id INT,
    image_name VARCHAR(255),
    image_url VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (imagegroup_id) REFERENCES tbImageGroup(id),
    INDEX (id)
);

-- Tabla para relacionar muchos a muchos entre usuarios y grupos de imagenes
CREATE TABLE tbUserImageGroupRelation (
    id INT AUTO_INCREMENT PRIMARY KEY,
    registration_date DATETIME,
    user_id INT,
    imagegroup_id INT,
    FOREIGN KEY (user_id) REFERENCES tbUsers(id),
    FOREIGN KEY (imagegroup_id) REFERENCES tbImageGroup(id),
    INDEX (id),
    INDEX (user_id),
    INDEX (imagegroup_id)
);

-- Eliminar si existe tabla tbAccountBalances
DROP TABLE IF EXISTS tbAccountBalances;

-- Crear la tabla tbAccountBalances
CREATE TABLE tbAccountBalances (
    id INT AUTO_INCREMENT PRIMARY KEY,
    registration_date DATETIME,
    user_id INT,
    movement_type ENUM('debit', 'credit'),
    transaction_value DECIMAL(10, 2),
    balance DECIMAL(10, 2),
    FOREIGN KEY (user_id) REFERENCES tbUsers(id),
    INDEX (id),
    INDEX (user_id),
    INDEX (movement_type)
);

-- Crear la tabla tbAccountBalancesdt

CREATE TABLE tbAccountBalancesdt (
    id INT AUTO_INCREMENT PRIMARY KEY,
    registration_date DATETIME,
    user_id INT,
    movement_type ENUM('debit', 'credit'),
    detail VARCHAR(255),
    quantity INT,
    unit_price DECIMAL(10, 2),
    transaction_value DECIMAL(10, 2),
    FOREIGN KEY (user_id) REFERENCES tbUsers(id),
    INDEX (id),
    INDEX (user_id),
    INDEX (movement_type)
);

-- Crear tabla de logs para store procedures
CREATE TABLE tbLogs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    registration_date DATETIME,
    log_type ENUM('info', 'warning', 'error'),
    log_message TEXT,
    INDEX (id),
    INDEX (log_type)
);

-- Vista para obtener las imagenes de un usuario
CREATE VIEW vwUserImages AS
SELECT
    tbUsers.id AS user_id,
    tbUsers.username,
    tbImages.id AS image_id,
    tbImages.image_name,
    tbImages.imagegroup_id,
    tbImages.image_url
FROM
    tbUsers
    JOIN tbUserImageGroupRelation 
        ON tbUsers.id = tbUserImageGroupRelation.user_id
    JOIN tbImageGroup 
        ON tbUserImageGroupRelation.imagegroup_id = tbImageGroup.id
    JOIN tbImages 
        ON tbImageGroup.id = tbImages.imagegroup_id
WHERE
    tbImages.is_active = TRUE
    AND tbImageGroup.is_active = TRUE;