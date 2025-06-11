-- Find employees whose customers don't have the same name
SELECT 
	first_name,
	last_name
FROM employee 

EXCEPT

SELECT 
	first_name,
	last_name
FROM customer employee
