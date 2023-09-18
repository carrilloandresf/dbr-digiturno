-- Trigger para actualizar registration_date en la tabla tbUsers
DELIMITER //
CREATE TRIGGER update_tbusers
BEFORE UPDATE ON tbUsers
FOR EACH ROW
BEGIN
    SET NEW.registration_date = NOW();
END;
//
DELIMITER ;

-- Trigger para actualizar registration_date en la tabla tbAccessTokens
DELIMITER //
CREATE TRIGGER update_tbaccesstokens
BEFORE UPDATE ON tbAccessTokens
FOR EACH ROW
BEGIN
    SET NEW.registration_date = NOW();
END;
//
DELIMITER ;

-- Trigger para actualizar registration_date en la tabla tbCustomers
DELIMITER //
CREATE TRIGGER update_tbcustomers
BEFORE UPDATE ON tbCustomers
FOR EACH ROW
BEGIN
    SET NEW.registration_date = NOW();
END;
//
DELIMITER ;

-- Trigger para actualizar registration_date en la tabla tbTransactionTypes
DELIMITER //
CREATE TRIGGER update_tbtransactiontypes
BEFORE UPDATE ON tbTransactionTypes
FOR EACH ROW
BEGIN
    SET NEW.registration_date = NOW();
END;
//
DELIMITER ;

-- Trigger para actualizar registration_date en la tabla tbUsersTransaction
DELIMITER //
CREATE TRIGGER update_tbuserstransaction
BEFORE UPDATE ON tbUsersTransaction
FOR EACH ROW
BEGIN
    SET NEW.registration_date = NOW();
END;
//
DELIMITER ;
