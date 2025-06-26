-- Customer Table - Transform and Clean
SELECT
	customer_id,
	COALESCE(INITCAP(TRIM(first_name)), 'N/A') AS first_name,
  	COALESCE(INITCAP(TRIM(last_name)), 'N/A') AS last_name,
  	COALESCE(LOWER(TRIM(email)), 'N/A') AS email,
	CASE 
		WHEN gender = 'F' THEN 'Female'
		WHEN gender = 'M' THEN 'Male'
		ELSE 'Other'
	END gender,
	birth_date,
	CASE
		WHEN LENGTH(REGEXP_REPLACE(cpf, '[^0-9]', '', 'g')) <> 11 THEN 'N/A'
		ELSE REGEXP_REPLACE(cpf, '[^0-9]', '', 'g')
	END cpf,
	CASE
		WHEN LENGTH(REGEXP_REPLACE(phone_number, '[^0-9]', '', 'g')) <> 11 THEN 'N/A'
		ELSE REGEXP_REPLACE(phone_number, '[^0-9]', '', 'g')
	END phone_number
FROM customer;

-- Address Table - Transform and Clean
SELECT
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
FROM address;

-- Category Table - Transform and Clean

SELECT DISTINCT
	category_id,
	COALESCE(INITCAP(TRIM(name)), 'N/A') AS name,
	CASE
		WHEN description = '' OR description IS NULL THEN 'N/A'
		ELSE description
	END description
FROM category;

-- Product Table - Transform and Clean

SELECT
	product_id,
	COALESCE(INITCAP(TRIM(product_name)), 'N/A') AS product_name,
	category_id,
	CASE
		WHEN quantity_per_unit < 1 OR quantity_per_unit IS NULL THEN 1
		ELSE quantity_per_unit
	END quantity_per_unit,
	CASE
		WHEN unit_price < 1 OR unit_price IS NULL THEN 0.00
		ELSE unit_price
	END unit_price,
	CASE
		WHEN units_in_stock < 1 OR units_in_stock IS NULL THEN 0
		ELSE units_in_stock
	END unit_price,
	CASE
		WHEN discontinued = 'false' THEN 'No'
		WHEN discontinued = 'true' THEN 'Yes'
		ELSE 'N/A'
	END unit_price,
	COALESCE(INITCAP(TRIM(description)), 'N/A') As description
FROM product
ORDER BY product_id ASC;
