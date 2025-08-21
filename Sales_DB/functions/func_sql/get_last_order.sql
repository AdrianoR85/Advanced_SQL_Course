CREATE OR REPLACE FUNCTION fn_get_last_order()
RETURNS sales_order AS 
$body$
	SELECT *
	FROM sales_order
	ORDER BY time_order_taken DESC
	LIMIT 1;
$body$
LANGUAGE SQL;

SELECT (fn_get_last_order()).*;
