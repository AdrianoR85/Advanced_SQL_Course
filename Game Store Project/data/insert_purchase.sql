DO $$
DECLARE
	i INT := 0;
	inserted_count INT := 0;
	
	p_year INT; 
    p_month INT;
    p_day INT;
    p_date DATE;
	ship_date DATE;
	
	employeeID INT;
	customerID INT;
	c_street VARCHAR;
	c_city VARCHAR;
	c_state CHAR(2);
	c_region VARCHAR(20);

	start_time TIMESTAMP := clock_timestamp();
    end_time TIMESTAMP;
	
BEGIN

	-- Loop to create 10.000 purchase record
	FOR i IN 1..10000 LOOP 
		BEGIN
			-- Select a random customer.
			SELECT customer_id INTO customerID FROM customer ORDER BY random() LIMIT 1;
		
			-- Select a random employee (not a manager).
			employeeID := (SELECT employee_id FROM employee WHERE reports_to IS NOT NULL ORDER BY random() LIMIT 1);
			
			-- Get the shipping address based on the customer.
			SELECT a.street, a.city, a.state, a.region
			INTO c_street, c_city, c_state, c_region
			FROM customer c
			JOIN address a ON a.customer_id = customerID;

			-- Generate a random purchase date
			p_year := FLOOR(random() * 3 + 2022)::INT; -- 2022 a 2024
    	p_month := FLOOR(random() * 12 + 1)::INT; -- 1 a 12
			
			-- Generate a random purchase date.
			IF p_month = 2 THEN
				p_day := FLOOR(random() * 28 + 1)::INT;
			ELSEIF p_month IN (4, 6, 9, 11) THEN
				p_day := FLOOR(random() * 30 + 1)::INT;
			ELSE 
				p_day := FLOOR(random() * 31 + 1)::INT;
			END IF;
		
			p_date := MAKE_DATE(p_year, p_month, p_day);
		
			-- Generate a shipped date with a small delay (1 to 7 days).
			ship_date := p_date + (FLOOR(random() * 7 + 1) || ' days')::INTERVAL;

			-- Insert the purchase into the database.
			INSERT INTO purchase (customer_id, employee_id, purchase_date, shipped_date, ship_street, ship_city, ship_state, ship_region)
            VALUES (customerID, employeeID, p_date, ship_date, c_street, c_city, c_state, c_region);

			-- Increment successful insert count
            inserted_count := inserted_count + 1;

		EXCEPTION WHEN OTHERS THEN
			-- If an error occurs, skip this record and continue
			RAISE NOTICE 'Error on record %, skipping...', i;
		END;
	END LOOP;

	-- Measure time and show result
    end_time := clock_timestamp();
    RAISE NOTICE 'Inserted rows: %', inserted_count;
    RAISE NOTICE 'Elapsed time: % seconds', EXTRACT(SECOND FROM end_time - start_time) + EXTRACT(MINUTE FROM end_time - start_time) * 60;
END $$ 