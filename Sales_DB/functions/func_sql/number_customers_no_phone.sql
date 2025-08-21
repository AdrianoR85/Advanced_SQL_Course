CREATE OR REPLACE FUNCTION fn_number_customer_no_phone()
RETURNS int AS
$body$
	SELECT COUNT(*) FROM customer
	WHERE phone IS NULL;
$body$
LANGUAGE SQL;

SELECT fn_number_customer_no_phone();