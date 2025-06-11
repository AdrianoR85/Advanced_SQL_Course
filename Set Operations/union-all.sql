-- Combine the data from employees and customers into one table, including duplicates.
SELECT 
	first_name
	last_name
FROM customer 

UNION ALL

SELECT 
	first_name
	last_name
FROM employee
