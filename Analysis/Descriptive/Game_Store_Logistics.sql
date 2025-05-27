-- -> What is the average shipping time per month?
SELECT 
	TO_CHAR(purchase_date, 'YYYY-MM') AS sale_date,
	ROUND(AVG(EXTRACT(DAY FROM shipped_date - purchase_date)), 2) AS avg_days
FROM purchase
-- WHERE DATE_PART('year',purchase_date) = 2022
GROUP BY sale_date
ORDER BY sale_date;

--------------------------------------------------------------------------------------

-- -> What is the average annual shipping time by region?
SELECT 
    DATE_PART('year', purchase_date) AS year,
	ship_region,
    ROUND(AVG(EXTRACT(DAY FROM shipped_date - purchase_date)), 2) AS avg_days
FROM purchase
WHERE shipped_date IS NOT NULL AND DATE_PART('year', purchase_date) = 2022
GROUP BY 1, 2
ORDER BY 1, 2;

--------------------------------------------------------------------------------------

-- -> ABC classification
WITH product_sales AS (
    SELECT 
        p.product_id AS code,
        p.product_name AS product,
        SUM(pi.quantity * p.unit_price) AS total_quantity
    FROM product p
    JOIN purchase_item pi ON p.product_id = pi.product_id
    JOIN purchase pu ON pi.purchase_id = pu.purchase_id
    WHERE EXTRACT(YEAR FROM pu.purchase_date) = 2024
    GROUP BY p.product_id, p.product_name
	ORDER BY 3 DESC
),
ranked_product AS (
    SELECT
        code,
        product,
        total_quantity,
        ROUND(total_quantity * 100.0 / SUM(total_quantity) OVER(), 2) AS pct_total,
        ROUND(SUM(total_quantity) OVER(ORDER BY total_quantity DESC) * 100.0 / 
              SUM(total_quantity) OVER(), 2) AS pct_acumulado
    FROM product_sales
)
SELECT 
    code,
    product,
    total_quantity,
    pct_total,
    pct_acumulado,
    CASE 
        WHEN pct_acumulado <= 80 THEN 'A'
        WHEN pct_acumulado <= 95 THEN 'B'
        ELSE 'C'
    END AS class_abc
FROM ranked_product
ORDER BY total_quantity DESC;

--------------------------------------------------------------------------------------

-- What are the 5 products with the most sales?
WITH ranked_sale AS (
	SELECT
		EXTRACT('year' FROM pu.purchase_date) AS year, 
		p.product_name AS product,
		SUM(pi.quantity) AS total,
		ROW_NUMBER() OVER(
			PARTITION BY EXTRACT('year' FROM pu.purchase_date)
			ORDER BY SUM(pi.quantity) DESC
		) AS sale_rank
	FROM product p
	JOIN purchase_item pi ON p.product_id = pi.product_id
	JOIN purchase pu ON pi.purchase_id = pu.purchase_id
	GROUP BY year, p.product_name
)
SELECT 
	year,
	product,
	total,
	sale_rank
FROM ranked_sale
WHERE sale_rank <= 5 and year = '2024'
ORDER BY year, total DESC;

--------------------------------------------------------------------------------------

