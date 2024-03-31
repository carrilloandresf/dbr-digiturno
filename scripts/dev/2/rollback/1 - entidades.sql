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