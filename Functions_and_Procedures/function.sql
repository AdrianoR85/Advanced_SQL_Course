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


-------------------------------------------------------------------------------------
-- Get all puchase of customer 
CREATE OR REPLACE FUNCTION get_customer_purchase(customer_id INT)
RETURNS TABLE (
    purchase_date TIMESTAMP,
    total_price NUMERIC(10,2),
    ship_city VARCHAR,
    ship_state CHAR(2)
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.purchase_date,
        p.total_price,
        p.ship_city,
        p.ship_state
    FROM purchase p
    WHERE p.customer_id = get_customer_purchase.customer_id;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM get_customer_purchase(123);
