-- -> Update the stock when insert purchase item
CREATE OR REPLACE FUNCTION update_stock_after_purchase()
RETURNS TRIGGER AS $$
BEGIN
	UPDATE product
	SET	quantity = units_in_stock - New.quantity	
	WHERE product_id = NEW.product_id;

	RAISE NOTICE 'Update stock for product ID %: -%units', NEW.product_id, NEW.quantity;
	
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_stock
AFTER INSERT ON purchase
FOR EACH ROW
EXECUTE FUNCTION update_stock_after_purchase();
