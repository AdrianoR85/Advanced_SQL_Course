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

-----------------------------------------------------------------------------------------------------
-- → Which region purchases the most monthly? And what is its percentage of the total?
SELECT 
    DATE_PART('year', purchase_date) AS sale_year,
    DATE_PART('month', purchase_date) AS sale_month,
    ship_region AS region,
    COUNT(*) AS total_by_region_month,
	ROUND(
		COUNT(*) * 100.0 / SUM(COUNT(*)) 
		OVER (
        	PARTITION BY DATE_PART('year', purchase_date), DATE_PART('month', purchase_date)
    	),2) AS pct_by_region,
    SUM(COUNT(*)) OVER (
        PARTITION BY DATE_PART('year', purchase_date), DATE_PART('month', purchase_date)
    ) AS total_by_month
FROM purchase
WHERE DATE_PART('year', purchase_date) = 2022
GROUP BY 1,2,3
ORDER BY 1,2,5 DESC;

-----------------------------------------------------------------------------------------------------

-- -> Region with the most purchases per month.
WITH region_monthly AS (
	SELECT
		DATE_PART('year', purchase_date) AS sale_year,
		DATE_PART('month', purchase_date) AS sale_month,
		ship_region,
		COUNT(*) AS total_by_region,
		RANK() OVER (
			PARTITION BY DATE_PART('year', purchase_date), DATE_PART('month', purchase_date)
			ORDER BY COUNT(*) DESC
		) AS region_rank
	FROM purchase
	GROUP BY 1, 2, 3
)
SELECT
	rm.sale_year,
	rm.sale_month,
	rm.ship_region,
	rm.total_by_region
FROM region_monthly rm
WHERE rm.region_rank = 1
