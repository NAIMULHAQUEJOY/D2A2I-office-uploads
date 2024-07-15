DO $$
DECLARE
    sql TEXT;
    rows_affected INT;
BEGIN
    -- Create the ad_logs5 table
    EXECUTE '
    CREATE TABLE IF NOT EXISTS ad_logs5 (
        id SERIAL PRIMARY KEY,
        ad_date DATE NOT NULL,
        channel_id INT NOT NULL,
        company TEXT NOT NULL,
        ad_type TEXT NOT NULL,
        peak TEXT NOT NULL,
        telecast_time TIME NOT NULL,
        duration INT NOT NULL,
        start TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        finish TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        ad_name TEXT NOT NULL,
        brand TEXT NOT NULL,
        sub_brand TEXT NOT NULL,
        product_type TEXT NOT NULL,
        product TEXT NOT NULL,
        program_type TEXT NOT NULL,
        program_name VARCHAR(200) NOT NULL,
        break_type TEXT NOT NULL,
        ad_qty INT NOT NULL,
        ad_pos INT NOT NULL,
        campaign VARCHAR(200),
        ad_price INT NOT NULL,
        incomplete_ad VARCHAR(100)
    )';

    -- Prepare the SQL query to insert data
    sql := '
    INSERT INTO ad_logs5 (
        ad_date, channel_id, company, ad_type, peak, telecast_time, 
        duration, start, finish, ad_name, brand, sub_brand, product_type, 
        product, program_type, program_name, break_type, ad_qty, ad_pos, 
        campaign, ad_price, incomplete_ad
    )
    SELECT 
        ad_date, channel_id, company, ad_type, peak, telecast_time, 
        duration, start, finish, ad_name, brand, sub_brand, product_type, 
        product, program_type, program_name, break_type, ad_qty, ad_pos, 
        campaign, ad_price, incomplete_ad
    FROM 
        ad_logs
    ON CONFLICT DO NOTHING;
    ';

    -- Debugging: Print SQL statement
    RAISE NOTICE 'Generated SQL statement: %', sql;

    -- Execute the SQL query
    EXECUTE sql;

    -- Check if any rows were affected
    GET DIAGNOSTICS rows_affected = ROW_COUNT;

    -- Debugging: Print number of rows affected
    RAISE NOTICE 'Number of rows affected: %', rows_affected;
END $$;