-- Trigger para actualizar turno_id en la tabla tbQueue

DELIMITER //

CREATE TRIGGER trg_generate_turno_id AFTER INSERT ON tbQueue
FOR EACH ROW
BEGIN
    DECLARE current_counter INT;
    
    -- Verificamos si el usuario existe en tbQueueCounter
    SELECT counter INTO current_counter FROM tbQueueCounter WHERE user_id = NEW.user_id;
    
    -- Si el usuario no existe, lo insertamos con un contador inicial de 1
    IF current_counter IS NULL THEN
        SET current_counter = 1;
        INSERT INTO tbQueueCounter (user_id, counter) VALUES (NEW.user_id, current_counter);
    ELSE
        -- Si el contador llega a 100, reiniciamos el contador a 1 y actualizamos tbQueueCounter
        IF current_counter = 100 THEN
            SET current_counter = 1;
        ELSE
            -- Incrementamos el contador
            SET current_counter = current_counter + 1;
        END IF;
        
        -- Actualizamos el registro en tbQueueCounter
        UPDATE tbQueueCounter SET counter = current_counter WHERE user_id = NEW.user_id;
    END IF;

    -- Insertamos el valor de current_counter como el turno_id en la tabla tbQueue
    UPDATE tbQueue SET turno_id = current_counter WHERE id = NEW.id;
END;
//
DELIMITER ;
