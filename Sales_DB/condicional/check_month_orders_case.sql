CREATE OR REPLACE FUNCTION fn_check_month_orders(the_month INT)
RETURNS varchar AS
$body$
DECLARE
	total_orders INT;
BEGIN
	SELECT COUNT(purchase_order_number)
	INTO total_orders
	FROM sales_order
	WHERE EXTRACT(MONTH FROM time_order_taken) = the_month;

	CASE 
		WHEN total_orders < 1 THEN
			RETURN CONCAT(total_orders, ' Orders: Terrible');
		WHEN total_orders > 1 AND total_orders < 5 THEN
			RETURN CONCAT(total_orders, ' Orders: On Target');
		ELSE
			RETURN CONCAT(total_orders, ' Orders: Doing Good');
	END CASE;
END;
$body$
LANGUAGE plpgsql;

SELECT fn_check_month_orders(6);