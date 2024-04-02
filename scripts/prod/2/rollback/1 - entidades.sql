-- Eliminar si existe tabla de colas de mensajes tbQueue
DROP TABLE IF EXISTS tbQueue;

-- Eliminar si existe tabla de imagenes publicitarias almacenadas en bits tbImages
DROP TABLE IF EXISTS tbImages;

-- Eliminar si existe tabla para relacionar muchos a muchos entre usuarios y grupos de imagenes tbUserImageGroupRelation
DROP TABLE IF EXISTS tbUserImageGroupRelation;

-- Eliminar si existe tabla de contadores de turnos tbQueueCounter
DROP TABLE IF EXISTS tbQueueCounter;

-- Eliminar si existe tabla para relacionar tbimagenes con un grupo de imagenes tbImageGroup
DROP TABLE IF EXISTS tbImageGroup;

-- Eliminar si existe vista para obtener las imagenes de un usuario vwUserImages
DROP VIEW IF EXISTS vwUserImages;

-- Eliminar si existe tabla tbAccountBalancesdt
DROP TABLE IF EXISTS tbAccountBalancesdt;

-- Eliminar si existe tabla tbAccountBalances
DROP TABLE IF EXISTS tbAccountBalances;

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