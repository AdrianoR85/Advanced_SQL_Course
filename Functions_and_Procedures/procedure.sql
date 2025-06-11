-- Creating a procedure that update the quantity in stock of the desired product. 
CREATE OR REPLACE PROCEDURE inventory_quantity_update(
	code INT,
	quantity INT
) AS $$
BEGIN
	UPDATE product
	SET units_in_stock = quantity
	WHERE product_id = code;

	COMMIT;
END
$$ LANGUAGE plpgsql;

-- Calling the procedure
CALL inventory_quantity_update(425,12);

-- Showing the result
SELECT * FROM product where product_id = 425;
