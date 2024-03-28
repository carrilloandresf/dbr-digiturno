-- Crear grupo publicitario por defecto
INSERT INTO tbImageGroup (registration_date, image_group_name, description) 
VALUES (NOW(), 'Default', 'Grupo de imágenes publicitarias por defecto');

-- Crear relación entre el primer usuario y el grupo publicitario por defecto
INSERT INTO tbUserImageGroupRelation (registration_date, user_id, imagegroup_id)
VALUES (NOW(), 1, 1);

-- Cargar imagenes publicitarias por defecto
INSERT INTO tbImages (registration_date, imagegroup_id, image_name, image)
VALUES (NOW(), 1, 'default1.png', LOAD_FILE('scripts/dev/2/src/img/1.png')),
(NOW(), 1, 'default2.png', LOAD_FILE('scripts/dev/2/src/img/1.png')),
(NOW(), 1, 'default3.png', LOAD_FILE('scripts/dev/2/src/img/1.png'));