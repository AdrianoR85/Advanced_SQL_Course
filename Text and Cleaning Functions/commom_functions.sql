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
 

 
