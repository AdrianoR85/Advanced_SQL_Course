-- Union customer names and employee names
SELECT 
	first_name,
	last_name
FROM customer 

UNION

SELECT 
	first_name,
	last_name
FROM employee;
