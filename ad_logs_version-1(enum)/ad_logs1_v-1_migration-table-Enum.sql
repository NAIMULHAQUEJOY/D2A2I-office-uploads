-- Step 1: Determine ENUM values for each column
SET @company_values := (SELECT SUBSTRING(COLUMN_TYPE, 6, LENGTH(COLUMN_TYPE) - 6) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'ad_logs1' AND COLUMN_NAME = 'company');
SET @ad_type_values := (SELECT SUBSTRING(COLUMN_TYPE, 6, LENGTH(COLUMN_TYPE) - 6) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'ad_logs1' AND COLUMN_NAME = 'ad_type');
SET @peak_values := (SELECT SUBSTRING(COLUMN_TYPE, 6, LENGTH(COLUMN_TYPE) - 6) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'ad_logs1' AND COLUMN_NAME = 'peak');
SET @brand_values := (SELECT SUBSTRING(COLUMN_TYPE, 6, LENGTH(COLUMN_TYPE) - 6) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'ad_logs1' AND COLUMN_NAME = 'brand');
SET @sub_brand_values := (SELECT SUBSTRING(COLUMN_TYPE, 6, LENGTH(COLUMN_TYPE) - 6) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'ad_logs1' AND COLUMN_NAME = 'sub_brand');
SET @product_type_values := (SELECT SUBSTRING(COLUMN_TYPE, 6, LENGTH(COLUMN_TYPE) - 6) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'ad_logs1' AND COLUMN_NAME = 'product_type');
SET @product_values := (SELECT SUBSTRING(COLUMN_TYPE, 6, LENGTH(COLUMN_TYPE) - 6) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'ad_logs1' AND COLUMN_NAME = 'product');
SET @program_type_values := (SELECT SUBSTRING(COLUMN_TYPE, 6, LENGTH(COLUMN_TYPE) - 6) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'ad_logs1' AND COLUMN_NAME = 'program_type');
SET @break_type_values := (SELECT SUBSTRING(COLUMN_TYPE, 6, LENGTH(COLUMN_TYPE) - 6) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'ad_logs1' AND COLUMN_NAME = 'break_type');

-- Step 2: Prepare the dynamic SQL query
SET @sql := CONCAT('
INSERT INTO ad_logs1 (
    id, ad_date, channel_id, company, ad_type, peak, telecast_time, 
    duration, start, finish, ad_name, brand, sub_brand, product_type, 
    product, program_type, program_name, break_type, ad_qty, ad_pos, 
    campaign, ad_price, incomplete_ad
)
SELECT 
    id, ad_date, channel_id,
    CASE 
        WHEN company IN (', @company_values, ') THEN company
        ELSE ''''  -- Default to empty string if not in the ENUM list
    END,
    CASE 
        WHEN ad_type IN (', @ad_type_values, ') THEN ad_type
        ELSE ''Announcement Branding''  -- Default value if not in the ENUM list
    END,
    CASE 
        WHEN peak IN (', @peak_values, ') THEN peak
        ELSE ''Off-Peak''  -- Default to ''Off-Peak'' if not in the list
    END,
    telecast_time, duration, start, finish,
    ad_name,
    CASE 
        WHEN brand IN (', @brand_values, ') THEN brand
        ELSE ''''  -- Default to empty string if not in the ENUM list
    END,
    CASE 
        WHEN sub_brand IN (', @sub_brand_values, ') THEN sub_brand
        ELSE ''''  -- Default to empty string if not in the ENUM list
    END,
    CASE 
        WHEN product_type IN (', @product_type_values, ') THEN product_type
        ELSE ''Agriculture''  -- Default value if not in the ENUM list
    END,
    CASE 
        WHEN product IN (', @product_values, ') THEN product
        ELSE ''''  -- Default to empty string if not in the ENUM list
    END,
    CASE 
        WHEN program_type IN (', @program_type_values, ') THEN program_type
        ELSE ''Agriculture''  -- Default value if not in the ENUM list
    END,
    program_name,
    CASE 
        WHEN break_type IN (', @break_type_values, ') THEN break_type
        ELSE ''100MBP''  -- Default value if not in the ENUM list
    END,
    ad_qty, ad_pos, campaign, ad_price, incomplete_ad
FROM 
    ad_logs;
');

-- Step 3: Execute the dynamic SQL query
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;