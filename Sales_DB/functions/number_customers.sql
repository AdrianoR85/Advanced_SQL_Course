CREATE OR REPLACE FUNCTION fn_number_customers()
RETURNS int AS
$body$
	SELECT COUNT(*) FROM customer;
$body$
LANGUAGE sql;

SELECT fn_number_customers();