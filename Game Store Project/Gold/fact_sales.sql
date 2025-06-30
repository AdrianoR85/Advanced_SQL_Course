CREATE OR REPLACE VIEW gold.fact_sales AS
SELECT 
	p.purchase_id,
	p.customer_id,
	p.employee_id,
	purchase_date::DATE,
	pi.product_id,
	pi.quantity,
	pi.unit_price,
	p.shipped_date::DATE,
	EXTRACT(DAY FROM p.shipped_date - p.purchase_date) AS days_to_ship,
	CASE
		WHEN EXTRACT(DAY FROM p.shipped_date - p.purchase_date) > 2 THEN 'Delayed'
		ELSE 'On Time'
	END ship_status,
	p.ship_city,
	p.ship_state,
	ship_region
FROM silver.purchase p
JOIN silver.purchase_item pi ON p.purchase_id = pi.purchase_id;
