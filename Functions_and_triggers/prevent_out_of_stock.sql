-- Prevent purchase of out-of-stock product
CREATE OR REPLACE FUNCTION prevent_out_of_stock()
RETURNS TRIGGER AS $$
BEGIN
	IF(SELECT units_in_stock FROM product WHERE product_id = NEW.product_id) < NEW.quantity THEN
		RAISE EXCEPTION 'Not enough stock for product ID %', NEW.product_id;
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_prevent_out_of_stock
BEFORE INSERT ON purchase_item
FOR EACH ROW
EXECUTE FUNCTION prevent_out_of_stock();
