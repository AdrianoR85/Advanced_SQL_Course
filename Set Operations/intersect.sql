-- Find the employees who have the same name as the customer
SELECT 
	first_name,
	last_name
FROM employee 

INTERSECT

SELECT 
	first_name,
	last_name
FROM customer employee
