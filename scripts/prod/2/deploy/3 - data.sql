-- Crear grupo publicitario por defecto
INSERT INTO tbImageGroup (registration_date, image_group_name, description) 
VALUES (NOW(), 'Default', 'Grupo de imágenes publicitarias por defecto');

-- Crear relación entre el primer usuario y el grupo publicitario por defecto
INSERT INTO tbUserImageGroupRelation (registration_date, user_id, imagegroup_id)
VALUES (NOW(), 1, 1), (NOW(), 2, 1);

-- Insertar imagenes publicitarias por defecto
INSERT INTO tbImages (registration_date, imagegroup_id, image_name, image_url)
VALUES (NOW(), 1, 'Default 1', 'https://api-service.turnodigital.net:54017/src/img/1/1.png'),
       (NOW(), 1, 'Default 2', 'https://api-service.turnodigital.net:54017/src/img/1/2.png'),
       (NOW(), 1, 'Default 3', 'https://api-service.turnodigital.net:54017/src/img/1/3.png');

-- Insertar datos iniciales para la tabla tbaccountbalancesdt
INSERT INTO tbAccountBalancesdt (registration_date, user_id, movement_type, detail, quantity, unit_price, transaction_value) 
VALUES (NOW(), 1, 'credit', 'Saldo Inicial', null, null, 200000.00);

-- Insertar datos iniciales para la tabla tbaccountbalances
INSERT INTO tbAccountBalances (registration_date, user_id, movement_type, transaction_value, balance)
VALUES (NOW(), 1, 'credit', 200000.00, 200000.00);