-- Drop the function if it exists
DROP FUNCTION IF EXISTS create_ad_logs_table5();

-- Create the function
CREATE OR REPLACE FUNCTION create_ad_logs_table5() RETURNS void AS $$
DECLARE
    company_values TEXT;
    ad_type_values TEXT;
    peak_values TEXT;
    brand_values TEXT;
    sub_brand_values TEXT;
    product_type_values TEXT;
    product_values TEXT;
    program_type_values TEXT;
    break_type_values TEXT;
    ad_name_values_1 TEXT;
    ad_name_values_2 TEXT;
    ad_name_values_3 TEXT;
    ad_name_values_4 TEXT;
    ad_name_values_5 TEXT;
    ad_name_values_6 TEXT;
    ad_name_values_7 TEXT;
    ad_name_values_8 TEXT;
    ad_name_values_9 TEXT;
    ad_name_values_10 TEXT;
    sql TEXT;
BEGIN
    -- Set a high value for string_agg max length
    PERFORM set_config('work_mem', '50MB', false);

    -- Get distinct ENUM values for each column
    SELECT string_agg(DISTINCT quote_literal(company), ',') INTO company_values FROM ad_logs;
    SELECT string_agg(DISTINCT quote_literal(ad_type), ',') INTO ad_type_values FROM ad_logs;
    SELECT string_agg(DISTINCT quote_literal(peak), ',') INTO peak_values FROM ad_logs;
    SELECT string_agg(DISTINCT quote_literal(brand), ',') INTO brand_values FROM ad_logs;
    SELECT string_agg(DISTINCT quote_literal(sub_brand), ',') INTO sub_brand_values FROM ad_logs;
    SELECT string_agg(DISTINCT quote_literal(product_type), ',') INTO product_type_values FROM ad_logs;
    SELECT string_agg(DISTINCT quote_literal(product), ',') INTO product_values FROM ad_logs;
    SELECT string_agg(DISTINCT quote_literal(program_type), ',') INTO program_type_values FROM ad_logs;
    SELECT string_agg(DISTINCT quote_literal(break_type), ',') INTO break_type_values FROM ad_logs;

    -- Retrieve distinct ad_name values and split them into ten variables
    SELECT string_agg(quote_literal(ad_name), ',') INTO ad_name_values_1 FROM (SELECT DISTINCT ad_name FROM ad_logs LIMIT 897 OFFSET 0) AS temp1;
    SELECT string_agg(quote_literal(ad_name), ',') INTO ad_name_values_2 FROM (SELECT DISTINCT ad_name FROM ad_logs LIMIT 897 OFFSET 897) AS temp2;
    SELECT string_agg(quote_literal(ad_name), ',') INTO ad_name_values_3 FROM (SELECT DISTINCT ad_name FROM ad_logs LIMIT 897 OFFSET 1794) AS temp3;
    SELECT string_agg(quote_literal(ad_name), ',') INTO ad_name_values_4 FROM (SELECT DISTINCT ad_name FROM ad_logs LIMIT 897 OFFSET 2691) AS temp4;
    SELECT string_agg(quote_literal(ad_name), ',') INTO ad_name_values_5 FROM (SELECT DISTINCT ad_name FROM ad_logs LIMIT 897 OFFSET 3588) AS temp5;
    SELECT string_agg(quote_literal(ad_name), ',') INTO ad_name_values_6 FROM (SELECT DISTINCT ad_name FROM ad_logs LIMIT 897 OFFSET 4485) AS temp6;
    SELECT string_agg(quote_literal(ad_name), ',') INTO ad_name_values_7 FROM (SELECT DISTINCT ad_name FROM ad_logs LIMIT 897 OFFSET 5382) AS temp7;
    SELECT string_agg(quote_literal(ad_name), ',') INTO ad_name_values_8 FROM (SELECT DISTINCT ad_name FROM ad_logs LIMIT 897 OFFSET 6279) AS temp8;
    SELECT string_agg(quote_literal(ad_name), ',') INTO ad_name_values_9 FROM (SELECT DISTINCT ad_name FROM ad_logs LIMIT 897 OFFSET 7176) AS temp9;
    SELECT string_agg(quote_literal(ad_name), ',') INTO ad_name_values_10 FROM (SELECT DISTINCT ad_name FROM ad_logs LIMIT 899 OFFSET 8073) AS temp10;

    -- Create the CREATE TABLE statement
    sql := 'CREATE TABLE ad_logs5 (
        id SERIAL PRIMARY KEY,
        ad_date DATE NOT NULL,
        channel_id INT NOT NULL,
        company TEXT CHECK (company IN (' || company_values || ')) NOT NULL,
        ad_type TEXT CHECK (ad_type IN (' || ad_type_values || ')) NOT NULL,
        peak TEXT CHECK (peak IN (' || peak_values || ')) NOT NULL,
        telecast_time TIME NOT NULL,
        duration INT NOT NULL,
        start TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        finish TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        ad_name TEXT CHECK (ad_name IN (' || ad_name_values_1 || ',' || ad_name_values_2 || ',' || ad_name_values_3 || ',' || ad_name_values_4 || ',' || ad_name_values_5 || ',' || ad_name_values_6 || ',' || ad_name_values_7 || ',' || ad_name_values_8 || ',' || ad_name_values_9 || ',' || ad_name_values_10 || ')) NOT NULL,
        brand TEXT CHECK (brand IN (' || brand_values || ')) NOT NULL,
        sub_brand TEXT CHECK (sub_brand IN (' || sub_brand_values || ')) NOT NULL,
        product_type TEXT CHECK (product_type IN (' || product_type_values || ')) NOT NULL,
        product TEXT CHECK (product IN (' || product_values || ')) NOT NULL,
        program_type TEXT CHECK (program_type IN (' || program_type_values || ')) NOT NULL,
        program_name VARCHAR(200) NOT NULL,
        break_type TEXT CHECK (break_type IN (' || break_type_values || ')) NOT NULL,
        ad_qty INT NOT NULL,
        ad_pos INT NOT NULL,
        campaign VARCHAR(200),
        ad_price INT NOT NULL,
        incomplete_ad VARCHAR(100)
    );';

    -- Execute the CREATE TABLE statement
    EXECUTE sql;
END;
$$ LANGUAGE plpgsql;

-- Call the function to create the table
SELECT create_ad_logs_table5();
