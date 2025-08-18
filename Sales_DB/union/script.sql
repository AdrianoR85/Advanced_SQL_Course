SELECT
	first_name, 
	last_name,
	street,
	city,
	zip,
	birth_date
FROM customer
WHERE EXTRACT(MONTH FROM birth_date) = 12
UNION
SELECT
	first_name, 
	last_name,
	street,
	city,
	zip,
	birth_date
FROM sales_person
WHERE EXTRACT(MONTH FROM birth_date) = 12;


