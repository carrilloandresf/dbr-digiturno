-- Trigger para actualizar registration_date en la tabla tbUsers
DELIMITER //
CREATE TRIGGER insert_tbusers
BEFORE INSERT ON tbUsers
FOR EACH ROW
BEGIN
    SET NEW.registration_date = NOW();
END;
//
DELIMITER ;

-- Trigger para actualizar registration_date en la tabla tbAccessTokens
DELIMITER //
CREATE TRIGGER insert_tbaccesstokens
BEFORE INSERT ON tbAccessTokens
FOR EACH ROW
BEGIN
    SET NEW.registration_date = NOW();
END;
//
DELIMITER ;

-- Trigger para actualizar registration_date en la tabla tbCustomers
DELIMITER //
CREATE TRIGGER insert_tbcustomers
BEFORE INSERT ON tbCustomers
FOR EACH ROW
BEGIN
    SET NEW.registration_date = NOW();
END;
//
DELIMITER ;

-- Trigger para actualizar registration_date en la tabla tbTransactionTypes
DELIMITER //
CREATE TRIGGER insert_tbtransactiontypes
BEFORE INSERT ON tbTransactionTypes
FOR EACH ROW
BEGIN
    SET NEW.registration_date = NOW();
END;
//
DELIMITER ;

-- Trigger para actualizar registration_date en la tabla tbUsersTransaction
DELIMITER //
CREATE TRIGGER insert_tbuserstransaction
BEFORE INSERT ON tbUsersTransaction
FOR EACH ROW
BEGIN
    SET NEW.registration_date = NOW();
END;
//
DELIMITER ;

-- CREATE TRIGGER para la tabla tbUserCustomerRelation
DELIMITER //
CREATE TRIGGER insert_tbUserCustomerRelation
BEFORE INSERT ON tbUserCustomerRelation
FOR EACH ROW
BEGIN
    SET NEW.registration_date = NOW();
END;
//
DELIMITER ;
