SELECT LOWER(email) FROM customer;
SELECT REPLACE(gender, 'F', 'Female') FROM customer;
SELECT REPLACE(gender, 'M', 'Male') FROM customer;

SELECT
	CONCAT(SUBSTRING(cpf, 1, 3), ' *** *** - **') AS masked_cpf
FROM customer;


SELECT UPPER(product_name) FROM product;
SELECT INITCAP(product_name) FROM product;

SELECT UPPER(product_name) FROM product;
SELECT SPLIT_PART(product_name, ' ', 1 ) FROM product; -- Xbox One -> Xbox
SELECT SPLIT_PART(product_name, ' ', 2 ) FROM product; -- Xbox One -> One 


SELECT * FROM product;
SELECT * FROM customer;

---------------------------------------------------------------------------------------------------------------------------------------------- 

-- Function: format_camelcase_name_from_email
-- Description: Extracts and formats customer names written in CamelCase from the email address (before '@') by inserting spaces between name parts.

SELECT 
	SUBSTRING( email, 0, POSITION('@' IN email) ) AS names
FROM customer
SELECT 
	TRIM( 
		REGEXP_REPLACE (
			SUBSTRING( email, 0, POSITION('@' IN email)), '([A-Z])', ' \1', 'g'
		) 
	) AS spaced_name
FROM customer; 
