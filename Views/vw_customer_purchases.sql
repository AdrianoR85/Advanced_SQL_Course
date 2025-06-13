-- Creating a view 
CREATE OR REPLACE VIEW vw_customer_purchases AS 
WITH cte_products AS (
	SELECT
		p.product_id,
		p.product_name,
		c.name AS category_name
	FROM product p
	JOIN category c ON p.category_id = c.category_id 
),
cte_customer_purchases AS (
	SELECT
		pu.customer_id,
		pu.purchase_date,
		pi.product_id,
		cp.product_name,
		cp.category_name,
		pi.quantity,
		pi.price
	FROM purchase pu
	JOIN purchase_item pi ON pu.purchase_id = pi.purchase_id
	JOIN cte_products cp ON pi.product_id = cp.product_id
)
SELECT
	c.customer_id,
	CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
	CASE
		WHEN c.gender = 'F' THEN 'Female'
		WHEN c.gender = 'M' THEN 'Male'
	END AS gender,
	purchase.purchase_date,
	purchase.product_id,
	purchase.product_name,
	purchase.category_name,
	purchase.quantity,
	purchase.price
FROM customer c
JOIN cte_customer_purchases purchase ON c.customer_id = purchase.customer_id

-- Using the view
-- Sum the total number of customer purchases over a period of one year.
SELECT 
	customer_name,
	count(customer_id) as total_purchase
FROM vw_customer_purchases -- view 
WHERE purchase_date >= CURRENT_DATE - INTERVAL '1 year'
GROUP BY customer_name
ORDER BY total_purchase DESC
