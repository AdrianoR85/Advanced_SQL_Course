CREATE OR REPLACE FUNCTION fn_get_random_salasperson()
RETURNS varchar AS 
$body$
DECLARE 
	rand INT;
	emp RECORD;
BEGIN
	SELECT random() * (5-1) + 1 INTO rand;
	
	SELECT * FROM sales_person 
	INTO emp
	WHERE id = rand;

	RETURN CONCAT(emp.first_name, ' ', emp.last_name);
END
$body$
LANGUAGE plpgsql;

SELECT fn_get_random_salasperson();