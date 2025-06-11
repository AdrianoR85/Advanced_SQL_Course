-- Combine the data from employees and customers into one table
SELECT 
	first_name,
	last_name
FROM customer 

UNION

SELECT 
	first_name,
	last_name
FROM employee;
