-- Crear grupo publicitario por defecto
INSERT INTO tbImageGroup (registration_date, image_group_name, description) 
VALUES (NOW(), 'Default', 'Grupo de imágenes publicitarias por defecto');

-- Crear relación entre el primer usuario y el grupo publicitario por defecto
INSERT INTO tbUserImageGroupRelation (registration_date, user_id, imagegroup_id)
VALUES (NOW(), 1, 1);
