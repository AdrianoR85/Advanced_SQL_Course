DO $$
DECLARE
	i INT := 0;
	inserted_count INT := 0;
	
	purchaseNumber INT;
	productCode INT;
	productPrice NUMERIC(10,2);
	productQuantity INT;

	start_time TIMESTAMP := clock_timestamp();
    end_time TIMESTAMP;
	
BEGIN
	-- Loop to create 22.500 purchase item record
	FOR i IN 1..22500 LOOP
		BEGIN
			-- Generator a random purchase id.
			SELECT purchase_id 
			INTO purchaseNumber
			FROM purchase
			ORDER BY random()
			LIMIT 1;
		
			-- Generator a random product and get the price.
			SELECT product_id, unit_price
			INTO productCode, productPrice
			FROM product
			ORDER BY random()
			LIMIT 1;
		
			-- Generator a random quantity
			productQuantity := FLOOR(random() * 4 + 1);

			-- Insert the purchase item into the database. 
			INSERT INTO purchase_item (purchase_id, product_id, quantity, price)
			VALUES (purchaseNumber, productCode, productQuantity, productPrice);
	
			inserted_count := inserted_count + 1;

			RAISE NOTICE 'Inserting...'
			
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
