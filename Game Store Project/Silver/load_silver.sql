-- //////////////////////////////////////    CUSTOMER   ///////////////////////////////////////////////
CREATE OR REPLACE PROCEDURE silver.load_silver() 
LANGUAGE plpgsql
AS $$
DECLARE 
	start_time TIMESTAMP;
	end_time TIMESTAMP;
	batch_start_time TIMESTAMP;
	batch_end_time TIMESTAMP;
BEGIN

	batch_start_time := NOW();
	RAISE NOTICE '===============================================';
	RAISE NOTICE '🚀 Silver layer load started at %', TO_CHAR(batch_start_time, 'YYYY-MM-DD HH24:MI:SS');
	RAISE NOTICE '===============================================';

	-- CUSTOMER
	BEGIN
		start_time := NOW();
		RAISE NOTICE '>> Truncate Table: silver.customer';
		TRUNCATE TABLE silver.customer;
		RAISE NOTICE '>> Inserting Data Into: silver.customer';
		INSERT INTO silver.customer (
			customer_id,
		    first_name,
		    last_name,
		    email,
			gender,
			birth_date,
			cpf,
			phone_number
		)
		SELECT
			customer_id,
			COALESCE(INITCAP(TRIM(first_name)), 'N/A') AS first_name,
		  	COALESCE(INITCAP(TRIM(last_name)), 'N/A') AS last_name,
		  	COALESCE(LOWER(TRIM(email)), 'N/A') AS email,
			CASE 
				WHEN gender = 'F' THEN 'Female'
				WHEN gender = 'M' THEN 'Male'
				ELSE 'Other'
			END AS gender,
			CASE
		        WHEN birth_date IS NULL OR birth_date > CURRENT_DATE THEN NULL
		        ELSE birth_date
		    END AS birth_date,
			CASE
				WHEN LENGTH(REGEXP_REPLACE(cpf, '[^0-9]', '', 'g')) <> 11 THEN 'N/A'
				ELSE REGEXP_REPLACE(cpf, '[^0-9]', '', 'g')
			END AS cpf,
			CASE
				WHEN LENGTH(REGEXP_REPLACE(phone_number, '[^0-9]', '', 'g')) <> 11 THEN 'N/A'
				ELSE REGEXP_REPLACE(phone_number, '[^0-9]', '', 'g')
			END AS phone_number
		FROM customer
		ORDER BY customer_id ASC;
		end_time := NOW();
		RAISE NOTICE '>> ✅ Data loaded into silver.customer';
		RAISE NOTICE '>> Load Duration: %', TO_CHAR(end_time, 'YYYY-MM-DD HH24:MI:SS');
		RAISE NOTICE '>> --------------------------------------------';
	EXCEPTION
		WHEN OTHERS THEN
			RAISE WARNING '⚠️ Error loading silver.customer: %', SQLERRM;
	END;

	
	-- ADDRESS
	BEGIN
		start_time := NOW();
		RAISE NOTICE '>> Truncate Table: silver.address';
		TRUNCATE TABLE silver.address;
		RAISE NOTICE '>> Inserting Data Into: silver.address';
		INSERT INTO silver.address (
			address_id, 
			street,
		    city,
		    state,
			region,
			customer_id
		)
		SELECT
			address_id,
		    COALESCE(INITCAP(TRIM(street)), 'N/A') AS street,
		    COALESCE(INITCAP(TRIM(city)), 'N/A') AS city,
		    CASE 
		      WHEN state !~* '^[A-Za-z]{2}$' THEN 'N/A' 
		      ELSE UPPER(TRIM(state)) 
		    END AS state,
		    CASE
		      WHEN TRIM(region) IS NULL OR TRIM(region) = '' THEN 'N/A'
		      ELSE INITCAP(TRIM(region))
		    END AS region,
		    customer_id
		FROM address
		ORDER BY address_id ASC;
		end_time := NOW();
		RAISE NOTICE '>> ✅ Data loaded into silver.address';
		RAISE NOTICE '>> Load Duration: %', TO_CHAR(end_time, 'YYYY-MM-DD HH24:MI:SS');
		RAISE NOTICE '>> --------------------------------------------';
	EXCEPTION
		WHEN OTHERS THEN
			RAISE WARNING '>> ⚠️ Error loading silver.address: %', SQLERRM;
	END;


	-- CATEGORY
	BEGIN
		start_time := NOW();
		RAISE NOTICE '>> Truncate Table: silver.category';
		TRUNCATE TABLE silver.category;
		RAISE NOTICE '>> Inserting Data Into: silver.category';
		INSERT INTO silver.category (
			category_id,
		    name,
		    description
		)
		SELECT DISTINCT
			category_id,
			COALESCE(INITCAP(TRIM(name)), 'N/A') AS name,
			CASE
				WHEN description = '' OR description IS NULL THEN 'N/A'
				ELSE description
			END AS description
		FROM category
		ORDER BY category_id DESC;
		end_time := NOW();
		RAISE NOTICE '>> ✅ Data loaded into silver.category.';
		RAISE NOTICE '>> Load Duration: %', TO_CHAR(end_time, 'YYYY-MM-DD HH24:MI:SS');
		RAISE NOTICE '>> --------------------------------------------';
	EXCEPTION
		WHEN OTHERS THEN
		RAISE WARNING '>> ⚠️ Error loading silver.category: %', SQLERRM;
	END;


	-- PRODUCT
	BEGIN
		start_time := NOW();
		RAISE NOTICE '>> Truncate Table: silver.product';
		TRUNCATE TABLE silver.product;
		RAISE NOTICE '>> Inserting Data Into: silver.product';
		INSERT INTO silver.product (
			product_id,
		    product_name,
		    quantity_per_unit,
		    unit_price,
		    units_in_stock,
		    category_id,
		    discontinued,
			description 
		)
		SELECT
			product_id,
			COALESCE(INITCAP(TRIM(product_name)), 'N/A') AS product_name,
			CASE
				WHEN quantity_per_unit < 1 OR quantity_per_unit IS NULL THEN 1
				ELSE quantity_per_unit
			END AS quantity_per_unit,
			CASE
				WHEN unit_price < 1 OR unit_price IS NULL THEN 0.00
				ELSE unit_price
			END AS unit_price,
			CASE
				WHEN units_in_stock < 1 OR units_in_stock IS NULL THEN 0
				ELSE units_in_stock
			END AS units_in_stock,
			category_id,
			CASE
				WHEN discontinued = 'false' THEN 'No'
				WHEN discontinued = 'true' THEN 'Yes'
				ELSE 'N/A'
			END AS discontinued,
			COALESCE(INITCAP(TRIM(description)), 'N/A') AS description
		FROM product
		ORDER BY product_id ASC;
		end_time := NOW();
		RAISE NOTICE '>> ✅ Data loaded into silver.product';
		RAISE NOTICE '>> Load Duration: %', TO_CHAR(end_time, 'YYYY-MM-DD HH24:MI:SS');
		RAISE NOTICE '>> --------------------------------------------';
	EXCEPTION
		WHEN OTHERS THEN
		RAISE WARNING '>> ⚠️ Error loading silver.product: %', SQLERRM;
	END;

	
	-- EMPLOYEE
	BEGIN
		start_time := NOW();
		RAISE NOTICE '>> Truncate Table: silver.employee';
		TRUNCATE TABLE silver.employee;
		RAISE NOTICE '>> Inserting Data Into: silver.employee';
		INSERT INTO silver.employee (
			employee_id,
		    last_name,
		    first_name,
		    birth_date,
		    hire_date,
			fired_date,
		    reports_to
		)
		SELECT 
			employee_id,
			COALESCE(INITCAP(TRIM(last_name)), 'N/A') AS last_name, 
			COALESCE(INITCAP(TRIM(first_name)), 'N/A') AS first_name,
			CASE
		        WHEN birth_date IS NULL OR birth_date > CURRENT_DATE THEN NULL
		        ELSE birth_date
		    END AS birth_date,
			CASE
		        WHEN hire_date IS NULL OR hire_date < '2022-02-02' OR hire_date > CURRENT_DATE THEN NULL
		        ELSE hire_date
		    END AS hire_date,
			CASE
		        WHEN fired_date < '2022-02-02' 
					OR fired_date > CURRENT_DATE 
					OR fired_date <= hire_date
					THEN NULL
		        ELSE fired_date
		    END AS fired_date,
			reports_to
		FROM employee
		ORDER BY employee_id DESC;
		end_time := NOW();
		RAISE NOTICE '>> ✅ Data loaded into silver.employee';
		RAISE NOTICE '>> Load Duration: %', TO_CHAR(end_time, 'YYYY-MM-DD HH24:MI:SS');
		RAISE NOTICE '>> --------------------------------------------';
	EXCEPTION
		WHEN OTHERS THEN
			RAISE WARNING '>> ⚠️ Error loading silver.employee: %', SQLERRM;
	END;
	

	-- PURCHASE
	BEGIN
		start_time := NOW();
		RAISE NOTICE '>> Truncate Table: silver.purchase';
		TRUNCATE TABLE silver.purchase;
		RAISE NOTICE '>> Inserting Data Into: silver.purchase';
		INSERT INTO silver.purchase (
			purchase_id,
		    employee_id,
		    customer_id,
		    total_price,
		    purchase_date,
		    shipped_date,
		    ship_street,
		    ship_city,
		    ship_state,
		    ship_region
		)
		WITH adjusted_dates AS (
		    SELECT 
		        purchase_id,
		        CASE 
		            WHEN EXTRACT(YEAR FROM purchase_date) = 2022 
		            THEN purchase_date + INTERVAL '1 MONTH'
		            ELSE purchase_date
		        END AS adjusted_purchase_date,
		        CASE 
		            WHEN EXTRACT(YEAR FROM shipped_date) = 2022 
		            THEN shipped_date + INTERVAL '1 MONTH'
		            ELSE shipped_date
		        END AS adjusted_shipped_date
		    FROM purchase
		),
		adjusted_days AS (
		    SELECT 
		        purchase_id,
		        CASE 
		            WHEN EXTRACT(YEAR FROM adjusted_purchase_date) = 2022 
		                 AND EXTRACT(DAY FROM adjusted_purchase_date) <= 2
		            THEN DATE(adjusted_purchase_date + INTERVAL '2 DAYS')
		            ELSE DATE(adjusted_purchase_date)
		        END AS final_purchase_date,
		        CASE 
		            WHEN EXTRACT(YEAR FROM adjusted_shipped_date) = 2022 
		                 AND EXTRACT(DAY FROM adjusted_shipped_date) <= 2
		            THEN DATE(adjusted_shipped_date + INTERVAL '2 DAYS')
		            ELSE DATE(adjusted_shipped_date)
		        END AS final_shipped_date
		    FROM adjusted_dates
		)
		SELECT 
			p.purchase_id,
			p.employee_id,
			p.customer_id,
			CASE
				WHEN total_price < 0.00 OR total_price IS NULL THEN 0.00
				ELSE total_price
			END AS total_price,
		    d.final_purchase_date,
		    d.final_shipped_date,
			COALESCE(INITCAP(TRIM(ship_street)), 'N/A') AS ship_street,
		  	COALESCE(INITCAP(TRIM(ship_city)), 'N/A') AS ship_city,
			CASE 
				WHEN ship_state !~* '^[A-Za-z]{2}$' THEN 'N/A' 
				ELSE UPPER(TRIM(ship_state)) 
			END AS ship_state,
			CASE
				WHEN TRIM(ship_region) IS NULL OR TRIM(ship_region) = '' THEN 'N/A'
				ELSE INITCAP(TRIM(ship_region))
			END AS ship_region
		FROM purchase p
		JOIN adjusted_days d ON p.purchase_id = d.purchase_id
		ORDER BY p.purchase_id DESC;
		end_time := NOW();
		RAISE NOTICE '>> ✅ Data loaded into silver.purchase.';
		RAISE NOTICE '>> Load Duration: %', TO_CHAR(end_time, 'YYYY-MM-DD HH24:MI:SS');
		RAISE NOTICE '>> --------------------------------------------';
	EXCEPTION
        WHEN OTHERS THEN
            RAISE WARNING '>> ⚠️ Error loading silver.purchase: %', SQLERRM;
    END;

	-- PURCHASE ITEM
	BEGIN
		start_time := NOW();
		RAISE NOTICE '>> Truncate Table: silver.purchase_item';
		TRUNCATE TABLE silver.purchase_item;
		RAISE NOTICE '>> Inserting Data Into: silver.purchase_item';
		INSERT INTO silver.purchase_item (
			purchase_item_id,
			quantity,
			unit_price,
			purchase_id,
			product_id
		)
		WITH sum_quantity AS (
			SELECT 
				purchase_id,
				product_id,
				SUM(quantity) AS quantity
			FROM purchase_item
			GROUP BY purchase_id, product_id
		),
		ranked_items AS (
			SELECT 
				pi.purchase_item_id,
				sq.purchase_id,
				sq.product_id,
				CASE
					WHEN sq.quantity < 0 OR sq.quantity IS NULL THEN 0
					ELSE sq.quantity
				END AS quantity,
				CASE
					WHEN pi.price < 0.00 OR pi.price IS NULL THEN 0.00
					ELSE pi.price
				END AS unit_price,
				ROW_NUMBER() OVER (PARTITION BY sq.purchase_id, sq.product_id ORDER BY pi.purchase_item_id) AS rn
			FROM purchase_item pi
			JOIN sum_quantity sq ON pi.purchase_id = sq.purchase_id AND pi.product_id = sq.product_id
		)
		SELECT
			purchase_item_id,
			quantity,
			unit_price,
			purchase_id,
			product_id
		FROM ranked_items 
		WHERE rn = 1
		ORDER BY purchase_item_id DESC;
		end_time := NOW();
		RAISE NOTICE '>> ✅ Data loaded into silver.purchase_item';
		RAISE NOTICE '>> Load Duration: %', TO_CHAR(end_time, 'YYYY-MM-DD HH24:MI:SS');
		RAISE NOTICE '>> --------------------------------------------';
	EXCEPTION
        WHEN OTHERS THEN
            RAISE WARNING '>> ⚠️ Error loading silver.purchase_item: %', SQLERRM;
    END;
	
	batch_end_time := NOW();
	RAISE NOTICE '===============================================';
	RAISE NOTICE '🚀 Loading Silver is Completed                 ';
	RAISE NOTICE ' - Total Load Duration: % seconds              ', (batch_end_time - batch_start_time);
	RAISE NOTICE '===============================================';

END;
$$;



