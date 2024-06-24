DROP PROCEDURE IF EXISTS create_ad_logs_table3;

DELIMITER //

CREATE PROCEDURE create_ad_logs_table3()
BEGIN
    -- Declare variables for ENUM values
    DECLARE company_values TEXT;
    DECLARE ad_type_values TEXT;
    DECLARE peak_values TEXT;
    DECLARE brand_values TEXT;
    DECLARE sub_brand_values TEXT;
    DECLARE product_type_values TEXT;
    DECLARE product_values TEXT;
    DECLARE program_type_values TEXT;
    DECLARE break_type_values TEXT;
    DECLARE ad_name_values_1 TEXT;
    DECLARE ad_name_values_2 TEXT;
    DECLARE ad_name_values_3 TEXT;
    DECLARE ad_name_values_4 TEXT;
    DECLARE ad_name_values_5 TEXT;
    DECLARE ad_name_values_6 TEXT;
    DECLARE ad_name_values_7 TEXT;
    DECLARE ad_name_values_8 TEXT;
    DECLARE ad_name_values_9 TEXT;
    DECLARE ad_name_values_10 TEXT;
    
    -- Set a high value for group_concat_max_len
    SET SESSION group_concat_max_len = 1000000;

    -- Get distinct ENUM values for each column
    SELECT GROUP_CONCAT(DISTINCT CONCAT('\'', REPLACE(company, '\'', '\\\''), '\'')) INTO company_values FROM ad_logs;
    SELECT GROUP_CONCAT(DISTINCT CONCAT('\'', REPLACE(ad_type, '\'', '\\\''), '\'')) INTO ad_type_values FROM ad_logs;
    SELECT GROUP_CONCAT(DISTINCT CONCAT('\'', REPLACE(peak, '\'', '\\\''), '\'')) INTO peak_values FROM ad_logs;
    SELECT GROUP_CONCAT(DISTINCT CONCAT('\'', REPLACE(brand, '\'', '\\\''), '\'')) INTO brand_values FROM ad_logs;
    SELECT GROUP_CONCAT(DISTINCT CONCAT('\'', REPLACE(sub_brand, '\'', '\\\''), '\'')) INTO sub_brand_values FROM ad_logs;
    SELECT GROUP_CONCAT(DISTINCT CONCAT('\'', REPLACE(product_type, '\'', '\\\''), '\'')) INTO product_type_values FROM ad_logs;
    SELECT GROUP_CONCAT(DISTINCT CONCAT('\'', REPLACE(product, '\'', '\\\''), '\'')) INTO product_values FROM ad_logs;
    SELECT GROUP_CONCAT(DISTINCT CONCAT('\'', REPLACE(program_type, '\'', '\\\''), '\'')) INTO program_type_values FROM ad_logs;
    SELECT GROUP_CONCAT(DISTINCT CONCAT('\'', REPLACE(break_type, '\'', '\\\''), '\'')) INTO break_type_values FROM ad_logs;

    -- Retrieve distinct ad_name values and split them into ten variables
    SELECT GROUP_CONCAT(CONCAT('\'', REPLACE(ad_name, '\'', '\\\''), '\'')) INTO ad_name_values_1 FROM (SELECT DISTINCT ad_name FROM ad_logs LIMIT 0, 897) AS temp1;
    SELECT GROUP_CONCAT(CONCAT('\'', REPLACE(ad_name, '\'', '\\\''), '\'')) INTO ad_name_values_2 FROM (SELECT DISTINCT ad_name FROM ad_logs LIMIT 897, 897) AS temp2;
    SELECT GROUP_CONCAT(CONCAT('\'', REPLACE(ad_name, '\'', '\\\''), '\'')) INTO ad_name_values_3 FROM (SELECT DISTINCT ad_name FROM ad_logs LIMIT 1794, 897) AS temp3;
    SELECT GROUP_CONCAT(CONCAT('\'', REPLACE(ad_name, '\'', '\\\''), '\'')) INTO ad_name_values_4 FROM (SELECT DISTINCT ad_name FROM ad_logs LIMIT 2691, 897) AS temp4;
    SELECT GROUP_CONCAT(CONCAT('\'', REPLACE(ad_name, '\'', '\\\''), '\'')) INTO ad_name_values_5 FROM (SELECT DISTINCT ad_name FROM ad_logs LIMIT 3588, 897) AS temp5;
    SELECT GROUP_CONCAT(CONCAT('\'', REPLACE(ad_name, '\'', '\\\''), '\'')) INTO ad_name_values_6 FROM (SELECT DISTINCT ad_name FROM ad_logs LIMIT 4485, 897) AS temp6;
    SELECT GROUP_CONCAT(CONCAT('\'', REPLACE(ad_name, '\'', '\\\''), '\'')) INTO ad_name_values_7 FROM (SELECT DISTINCT ad_name FROM ad_logs LIMIT 5382, 897) AS temp7;
    SELECT GROUP_CONCAT(CONCAT('\'', REPLACE(ad_name, '\'', '\\\''), '\'')) INTO ad_name_values_8 FROM (SELECT DISTINCT ad_name FROM ad_logs LIMIT 6279, 897) AS temp8;
    SELECT GROUP_CONCAT(CONCAT('\'', REPLACE(ad_name, '\'', '\\\''), '\'')) INTO ad_name_values_9 FROM (SELECT DISTINCT ad_name FROM ad_logs LIMIT 7176, 897) AS temp9;
    SELECT GROUP_CONCAT(CONCAT('\'', REPLACE(ad_name, '\'', '\\\''), '\'')) INTO ad_name_values_10 FROM (SELECT DISTINCT ad_name FROM ad_logs LIMIT 8073, 899) AS temp10;

    -- Create the CREATE TABLE statement
    SET @sql = CONCAT('CREATE TABLE ad_logs3 (
        id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        ad_date DATE NOT NULL,
        channel_id INT NOT NULL,
        company ENUM(', company_values, ') NOT NULL,
        ad_type ENUM(', ad_type_values, ') NOT NULL,
        peak ENUM(', peak_values, ') NOT NULL,
        telecast_time TIME NOT NULL,
        duration INT NOT NULL,
        start TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        finish TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        ad_name ENUM(', ad_name_values_1, ',', ad_name_values_2, ',', ad_name_values_3, ',', ad_name_values_4, ',', ad_name_values_5, ',', ad_name_values_6, ',', ad_name_values_7, ',', ad_name_values_8, ',', ad_name_values_9, ',', ad_name_values_10, ') NOT NULL,
        brand ENUM(', brand_values, ') NOT NULL,
        sub_brand ENUM(', sub_brand_values, ') NOT NULL,
        product_type ENUM(', product_type_values, ') NOT NULL,
        product ENUM(', product_values, ') NOT NULL,
        program_type ENUM(', program_type_values, ') NOT NULL,
        program_name VARCHAR(200) NOT NULL,
        break_type ENUM(', break_type_values, ') NOT NULL,
        ad_qty INT NOT NULL,
        ad_pos INT NOT NULL,
        campaign VARCHAR(200),
        ad_price INT NOT NULL,
        incomplete_ad VARCHAR(100)
    );');
    
    -- Prepare and execute the CREATE TABLE statement
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //

DELIMITER ;


-- Call the procedure to create the table
CALL create_ad_logs_table3();


















