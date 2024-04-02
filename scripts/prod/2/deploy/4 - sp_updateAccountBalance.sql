DELIMITER //

CREATE PROCEDURE sp_updateAccountBalance (
    IN interval_days INT
)
BEGIN
    -- Definir variables para mantener el recuento de registros insertados en cada tabla
    DECLARE insert_count_dt INT DEFAULT 0;
    DECLARE insert_count_balances INT DEFAULT 0;

    -- Definir manejador de errores para SQLEXCEPTION
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        INSERT INTO tbLogs (registration_date, log_type, log_message) VALUES (NOW(), 'error', CONCAT('Error: ', SUBSTRING_INDEX(MESSAGE_TEXT, ' ', 1)));
    END;

    -- Definir manejador de errores para SQLWARNING
    DECLARE EXIT HANDLER FOR SQLWARNING
    BEGIN
        ROLLBACK;
        INSERT INTO tbLogs (registration_date, log_type, log_message) VALUES (NOW(), 'warning', CONCAT('Warning: ', SUBSTRING_INDEX(MESSAGE_TEXT, ' ', 1)));
    END;

    -- Iniciar transacción
    START TRANSACTION;

    -- Si no se proporciona un valor para interval_days, se asigna el valor por defecto de 1
    IF interval_days IS NULL THEN
        SET interval_days = 1;
    END IF;

    -- Insertar movimientos del día en tbaccountbalancesdt
    INSERT INTO tbaccountbalancesdt (user_id, movement_type, detail, quantity, unit_price, transaction_value)
    SELECT tbuserstransaction.user_id
            , 'debit' as movement_type
            , CONCAT(tbuserstransaction.transaction_type_id, ' - ',tbtransactiontypes.transaction_type) AS detail
            , COUNT(1) as quantity
            , MAX(tbtransactiontypes.price) as unitPrice
            , SUM(tbtransactiontypes.price) as transaction_value
    FROM tbuserstransaction
    INNER JOIN tbtransactiontypes
        ON tbtransactiontypes.id = tbuserstransaction.transaction_type_id
    WHERE DATE(tbuserstransaction.registration_date) = CURDATE() - INTERVAL @interval_days DAY and 
        api_accepted = 1
    GROUP BY tbuserstransaction.user_id, tbuserstransaction.transaction_type_id;

    -- Obtener el número de registros insertados en tbaccountbalancesdt
    SET insert_count_dt = ROW_COUNT();

    -- Insertar resumen de inserción en tbLogs
    INSERT INTO tbLogs (registration_date, log_type, log_message) VALUES (NOW(), 'info', CONCAT('Se insertaron ', insert_count_dt, ' registros en la tabla tbaccountbalancesdt'));

    -- Insertar movimientos agrupados de cuentas en tbaccountbalances
    INSERT INTO tbaccountbalances (user_id, movement_type, transaction_value, balance)
    WITH LAST_BALANCE AS (
        SELECT tbusers.id
            , IFNULL(balance, 0) AS actualBalance
            , ROW_NUMBER() OVER (PARTITION BY tbaccountbalances.user_id ORDER BY tbaccountbalances.id DESC) as rn
        FROM tbusers
            LEFT OUTER JOIN tbaccountbalances
                ON tbusers.id = tbaccountbalances.user_id
    )
    , DEBIT AS (
        SELECT tbuserstransaction.user_id
            , 'debit' as movement_type
            , SUM(tbtransactiontypes.price) as transaction_value
        FROM tbuserstransaction
            INNER JOIN tbtransactiontypes
                ON tbtransactiontypes.id = tbuserstransaction.transaction_type_id
        WHERE DATE(tbuserstransaction.registration_date) = CURDATE() - INTERVAL @interval_days DAY AND 
            api_accepted = 1
        GROUP BY tbuserstransaction.user_id
    )
    SELECT user_id
        ,movement_type
        ,transaction_value
        ,actualBalance - transaction_value as balance
    FROM DEBIT
    INNER JOIN LAST_BALANCE
        ON DEBIT.user_id = LAST_BALANCE.id
    WHERE rn = 1;    

    -- Obtener el número de registros insertados en tbaccountbalances
    SET insert_count_balances = ROW_COUNT();

    -- Actualizar el saldo de la cuenta en tbusers basado en el último registro de la tabla tbaccountbalances
    UPDATE tbusers
    INNER JOIN tbaccountbalances
        ON tbusers.id = tbaccountbalances.user_id
    SET tbusers.account_balance = tbaccountbalances.balance
    WHERE tbaccountbalances.id = (SELECT MAX(id) FROM tbaccountbalances WHERE user_id = tbusers.id);

    -- Insertar resumen de inserción en tbLogs
    INSERT INTO tbLogs (registration_date, log_type, log_message) VALUES (NOW(), 'info', CONCAT('Se insertaron ', insert_count_balances, ' registros en la tabla tbaccountbalances'));

    -- Confirmar transacción
    COMMIT;
END //
DELIMITER ;
