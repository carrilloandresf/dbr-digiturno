DELIMITER //

CREATE PROCEDURE sp_generateToken (
    IN userId INT
)
BEGIN
    DECLARE v_token VARCHAR(50);
    DECLARE v_expiryDate DATETIME;

    -- Set the expiry date to 2 days from now at midnight
    SET v_expiryDate = DATE_ADD(CURDATE(), INTERVAL 2 DAY);

    -- Set the expiry time to midnight
    SET v_expiryDate = DATE_ADD(v_expiryDate, INTERVAL 1 SECOND);
    
    -- Generate the token
    SET v_token = UUID();

    -- Insert the token into the database
    INSERT INTO tbAccessTokens (token, validity, user_id)
    VALUES (v_token, v_expiryDate, userId);

    -- Return the token
    SELECT v_token AS token, v_expiryDate AS expiry_date;
END //

DELIMITER ;