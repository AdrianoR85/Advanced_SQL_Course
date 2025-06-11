CREATE OR REPLACE FUNCTION get_total_purchase(customer_id INT)
RETURNS INT AS $$
DECLARE 
	total_purchase INT;
BEGIN
	SELECT COUNT(*) INTO total_purchase
	FROM purchase p
	WHERE p.customer_id = get_total_purchase.customer_id;

	RETURN total_purchase;
END
$$ LANGUAGE plpgsql;

select get_customer_purchase(10);