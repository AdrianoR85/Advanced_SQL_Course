CREATE OR REPLACE FUNCTION fn_max_product_price()
RETURNS INT AS
$body$
	SELECT MAX(item.price) FROM item 
$body$
LANGUAGE sql;

SELECT fn_max_product_price();

