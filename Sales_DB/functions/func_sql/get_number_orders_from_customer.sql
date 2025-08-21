CREATE OR REPLACE FUNCTION fn_get_number_orders_from_customer(
	cus_fname VARCHAR,
	cus_Lname VARCHAR
	) 
RETURNS int AS
$body$
	SELECT COUNT(*) FROM sales_order
	NATURAL JOIN customer
	WHERE customer.first_name = cus_fname AND customer.last_name = cus_lname;
$body$
LANGUAGE SQL;

SELECT fn_get_number_orders_from_customer('Christopher', 'Robinson');