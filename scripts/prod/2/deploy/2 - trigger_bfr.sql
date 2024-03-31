DELIMITER //

CREATE TRIGGER trg_insert_user_counter BEFORE INSERT ON tbQueue
FOR EACH ROW
BEGIN
    -- Verificamos si el usuario existe en tbQueueCounter
    DECLARE user_exists INT;
    SELECT COUNT(*) INTO user_exists FROM tbQueueCounter WHERE user_id = NEW.user_id;

    -- Si el usuario no existe, lo insertamos con un contador inicial de 1
    IF user_exists = 0 THEN
        INSERT INTO tbQueueCounter (user_id, counter) VALUES (NEW.user_id, 1);
    END IF;
END;
//
DELIMITER ;
