CREATE OR REPLACE FUNCTION fn_get_supplier_value(the_supplier VARCHAR)
RETURNS VARCHAR AS
$body$
DECLARE
	supplier_name VARCHAR;
	price_sum NUMERIC;
	
BEGIN
	SELECT product.supplier, SUM(item.price)
	INTO supplier_name, price_sum
	FROM product, item
	WHERE product.supplier = the_supplier
	GROUP BY product.supplier;

	RETURN CONCAT(supplier_name, ' Inverntory Value : $', price_sum);
END;

$body$
LANGUAGE plpgsql;

SELECT fn_get_supplier_value('Nike');