
DROP PROCEDURE IF EXISTS create_ad_logs_table;


DELIMITER //

CREATE PROCEDURE create_ad_logs_table()
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
    
    -- Get distinct ENUM values for each column
    
    -- Retrieve ENUM values for the company column
    SELECT GROUP_CONCAT(DISTINCT CONCAT('\'', REPLACE(company, '\'', '\\\''), '\'')) INTO company_values FROM ad_logs;
    
    -- Retrieve ENUM values for the ad_type column
    SELECT GROUP_CONCAT(DISTINCT CONCAT('\'', REPLACE(ad_type, '\'', '\\\''), '\'')) INTO ad_type_values FROM ad_logs;
    
    -- Retrieve ENUM values for the peak column
    SELECT GROUP_CONCAT(DISTINCT CONCAT('\'', REPLACE(peak, '\'', '\\\''), '\'')) INTO peak_values FROM ad_logs;
    
    
    -- Retrieve ENUM values for the brand column
    SELECT GROUP_CONCAT(DISTINCT CONCAT('\'', REPLACE(brand, '\'', '\\\''), '\'')) INTO brand_values FROM ad_logs;
    
    -- Retrieve ENUM values for the sub_brand column
    SELECT GROUP_CONCAT(DISTINCT CONCAT('\'', REPLACE(sub_brand, '\'', '\\\''), '\'')) INTO sub_brand_values FROM ad_logs;
    
    -- Retrieve ENUM values for the product_type column
    SELECT GROUP_CONCAT(DISTINCT CONCAT('\'', REPLACE(product_type, '\'', '\\\''), '\'')) INTO product_type_values FROM ad_logs;
    
    -- Retrieve ENUM values for the product column
    SELECT GROUP_CONCAT(DISTINCT CONCAT('\'', REPLACE(product, '\'', '\\\''), '\'')) INTO product_values FROM ad_logs;
    
    -- Retrieve ENUM values for the program_type column
    SELECT GROUP_CONCAT(DISTINCT CONCAT('\'', REPLACE(program_type, '\'', '\\\''), '\'')) INTO program_type_values FROM ad_logs;
    
    -- Retrieve ENUM values for the break_type column
    SELECT GROUP_CONCAT(DISTINCT CONCAT('\'', REPLACE(break_type, '\'', '\\\''), '\'')) INTO break_type_values FROM ad_logs;
    
    -- Create the CREATE TABLE statement
    SET @sql = CONCAT('CREATE TABLE ad_logs1 (
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
        ad_name varchar(200) NOT NULL,
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




SET SESSION group_concat_max_len = 1000000; -- Set a larger value temporarily
CALL create_ad_logs_table();
