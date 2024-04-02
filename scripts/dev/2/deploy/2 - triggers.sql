-- Trigger para actualizar registration_date en la tabla tbAccountBalances
DELIMITER //
CREATE TRIGGER insert_tbaccountbalances
BEFORE INSERT ON tbaccountbalances
FOR EACH ROW
BEGIN
    SET NEW.registration_date = NOW();
END;
//
DELIMITER ;

-- Trigger para actualizar registration_date en la tabla tbaccountbalancesdt
DELIMITER //
CREATE TRIGGER insert_tbaccountbalancesdt
BEFORE INSERT ON tbaccountbalancesdt
FOR EACH ROW
BEGIN
    SET NEW.registration_date = NOW();
END;
//
DELIMITER ;

-- Trigger para actualizar registration_date en la tabla tbimagegroup
DELIMITER //
CREATE TRIGGER insert_tbimagegroup
BEFORE INSERT ON tbimagegroup
FOR EACH ROW
BEGIN
    SET NEW.registration_date = NOW();
END;
//
DELIMITER ;

-- Trigger para actualizar registration_date en la tabla tbimages
DELIMITER //
CREATE TRIGGER insert_tbimages
BEFORE INSERT ON tbimages
FOR EACH ROW
BEGIN
    SET NEW.registration_date = NOW();
END;
//
DELIMITER ;

-- Trigger para actualizar registration_date en la tabla tbqueue
DELIMITER //
CREATE TRIGGER insert_tbqueue
BEFORE INSERT ON tbqueue
FOR EACH ROW
BEGIN
    SET NEW.registration_date = NOW();
END;
//
DELIMITER ;

-- Trigger para actualizar registration_date en la tabla tbuserimagegrouprelation
DELIMITER //
CREATE TRIGGER insert_tbuserimagegrouprelation
BEFORE INSERT ON tbuserimagegrouprelation
FOR EACH ROW
BEGIN
    SET NEW.registration_date = NOW();
END;
//
DELIMITER ;

-- Trigger para actualizar registration_date en la tabla tbLogs
DELIMITER //
CREATE TRIGGER insert_tbLogs
BEFORE INSERT ON tbLogs
FOR EACH ROW
BEGIN
    SET NEW.registration_date = NOW();
END;
//
DELIMITER ;