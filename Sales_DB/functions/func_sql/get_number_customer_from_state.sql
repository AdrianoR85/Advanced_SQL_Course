CREATE OR REPLACE FUNCTION fn_get_number_customer_from_state(state_name CHAR(2))
RETURNS int AS
$body$
	SELECT COUNT(*) FROM customer
	WHERE state = state_name
$body$
LANGUAGE SQL;

SELECT fn_get_number_customer_from_state('TX');