-- → What is the annual revenue?
SELECT 
	date_part('year', purchase_date) AS sale_year,
	SUM(total_price)
FROM purchase
GROUP BY sale_year;
-----------------------------------------------------------------------------------------------------
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
-----------------------------------------------------------------------------------------------------
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

-----------------------------------------------------------------------------------------------------
-- →  What is the average number of sales per month?
SELECT
	sales.sale_year,
	sales.total_sales,
	ROUND(sales.total_sales::NUMERIC / monthly.months_with_sales,2) AS avg_monthly_sales
FROM (	
	SELECT 
		DATE_PART('year', purchase_date) AS sale_year,
		COUNT(purchase_id) AS total_sales
	FROM purchase
	GROUP BY sale_year
) AS sales
JOIN (
	-- Count the number of days with sales in each year 
	SELECT 
		DATE_PART('year', purchase_date) AS sale_year,
		COUNT(DISTINCT DATE_PART('month', purchase_date)) AS months_with_sales
	FROM purchase
	GROUP BY sale_year
) AS monthly
ON sales.sale_year = monthly.sale_year
ORDER BY sales.sale_year;
