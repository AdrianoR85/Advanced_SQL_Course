-- → What is the annual revenue?
SELECT 
	date_part('year', purchase_date) AS sale_year,
	SUM(total_price)
FROM purchase
GROUP BY sale_year;

-- → Which products are the best-selling in quantity annually?
SELECT 
	date_part('year', p.purchase_date) AS sale_year,
	pr.product_name AS product,
	SUM(pi.quantity) AS quantity_total
FROM purchase p
JOIN purchase_item pi ON pi.purchase_id = p.purchase_id
JOIN product pr ON pi.product_id = pr.product_id
GROUP BY sale_year, product
ORDER BY sale_year, quantity_total DESC;

-- → Which products generate the highest revenue annually?
WITH ranked_product AS (
	SELECT 
	date_part('year', p.purchase_date) AS sale_year,
	pr.product_name AS product,
	SUM(pi.price) AS revenue_anually,
	ROW_NUMBER() OVER (PARTITION BY date_part('year', p.purchase_date) ORDER BY SUM(pi.price) DESC) AS rank 
	FROM purchase p
	JOIN purchase_item pi ON pi.purchase_id = p.purchase_id
	JOIN product pr ON pi.product_id = pr.product_id
	GROUP BY sale_year, product
)
SELECT 
	sale_year,
	product,
	revenue_anually
FROM ranked_product
WHERE rank = 1
ORDER BY sale_year;
