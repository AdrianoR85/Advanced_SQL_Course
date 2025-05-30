-- This query calculates the average shipping time (in days) for each month.
-- It shows how many days on average it takes from purchase to shipment per month.

SELECT 
	TO_CHAR(purchase_date, 'YYYY-MM') AS sale_date,  -- Formats the purchase date as Year-Month for grouping
	ROUND(AVG(EXTRACT(DAY FROM shipped_date - purchase_date)), 2) AS avg_days  -- Calculates average difference in days rounded to 2 decimals
FROM purchase
-- WHERE DATE_PART('year',purchase_date) = 2022 -- (Optional) filter by year 2022
GROUP BY sale_date
ORDER BY sale_date;


--------------------------------------------------------------------------------------

-- This query returns the average shipping time in days per year and shipping region.
-- It calculates the average number of days between purchase and shipment by region for the year 2022.

SELECT 
    DATE_PART('year', purchase_date) AS year,     -- Extracts the year from purchase date
	ship_region,                                  -- Shipping region
    ROUND(AVG(EXTRACT(DAY FROM shipped_date - purchase_date)), 2) AS avg_days  -- Average shipping time in days, rounded
FROM purchase
WHERE shipped_date IS NOT NULL                   -- Only consider purchases that were shipped
  AND DATE_PART('year', purchase_date) = 2022   -- Filter for the year 2022
GROUP BY 1, 2                                    -- Group by year and shipping region
ORDER BY 1, 2;                                  -- Order results by year and region


--------------------------------------------------------------------------------------

-- This query classifies products into ABC categories based on their sales in 2024.
-- It sums total sales value per product, calculates each product’s contribution percentage,
-- then assigns ABC class: 'A' for top ~80%, 'B' for next ~15%, and 'C' for the rest.

WITH product_sales AS (
    SELECT 
        p.product_id AS code,                      -- Product identifier
        p.product_name AS product,                 -- Product name
        SUM(pi.quantity * p.unit_price) AS total_quantity  -- Total sales value per product
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
        ROUND(total_quantity * 100.0 / SUM(total_quantity) OVER(), 2) AS pct_total,  -- Percent of total sales for each product
        ROUND(SUM(total_quantity) OVER(ORDER BY total_quantity DESC) * 100.0 / 
              SUM(total_quantity) OVER(), 2) AS pct_acumulado                        -- Cumulative percent for ranking
    FROM product_sales
)
SELECT 
    code,
    product,
    total_quantity,
    pct_total,
    pct_acumulado,
    CASE 
        WHEN pct_acumulado <= 80 THEN 'A'       -- Classify top ~80% as 'A'
        WHEN pct_acumulado <= 95 THEN 'B'       -- Next ~15% as 'B'
        ELSE 'C'                                -- Remaining as 'C'
    END AS class_abc
FROM ranked_product
ORDER BY total_quantity DESC;

--------------------------------------------------------------------------------------

-- This query identifies the top 5 products with the highest quantity sold in each year.
-- It ranks products by quantity sold per year and selects the top 5 for 2024.

WITH ranked_sale AS (
	SELECT
		EXTRACT('year' FROM pu.purchase_date) AS year,  -- Extract purchase year
		p.product_name AS product,                       -- Product name
		SUM(pi.quantity) AS total,                       -- Total quantity sold
		ROW_NUMBER() OVER(
			PARTITION BY EXTRACT('year' FROM pu.purchase_date)  -- Rank within each year
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
WHERE sale_rank <= 5 AND year = '2024'  -- Filter top 5 for 2024 only
ORDER BY year, total DESC;


--------------------------------------------------------------------------------------
-- -> ABC Classification by product quantity in stock
/*
 What This Does
- product_name: Name of the product.
- units_in_stock: Quantity of that product in stock.
- pct_by_product:	What % of total stock this product represents.
- pct_accumulated: Running cumulative % from top product (by quantity) to bottom.
- total_in_stock: Total units of all products in stock.
- class_abc: 
	A: Top ~80% of value → high impact products.
	B: Next ~10% of value.
	C: Remaining ~10%.
*/

WITH ranked_product_in_stock AS (
	SELECT 
		product_name,
		units_in_stock,
		ROUND(units_in_stock * 100.0 / SUM(units_in_stock) OVER(), 2) AS pct_by_product,
		ROUND(
			SUM(units_in_stock) OVER(
				ORDER BY units_in_stock DESC 
				ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW 
			) * 100.0 /
			SUM(units_in_stock) OVER(), 2) AS pct_accumulated,
		SUM(units_in_stock) OVER() AS total_in_stock
	FROM product
)
SELECT 
	*,
	CASE 
		WHEN pct_accumulated <= 80 THEN 'A'
		WHEN pct_accumulated <= 90 THEN 'B'
		ELSE 'C'
	END AS class_abc
FROM ranked_product_in_stock

--------------------------------------------------------------------------------------
-- -> ABC Classification by product value in stock
/* What This Does
- product_value: Current value of each product in stock.
- pct_by_product: What % of total value that product represents.
- pct_accumulated: Cumulative % for ranking by value.
- class_abc:
	A: Top ~80% of value → high impact products.
	B: Next ~10% of value.
	C: Remaining ~10%.
*/
WITH ranked_product_in_stock AS (
	SELECT 
		product_name,
		(units_in_stock * unit_price) AS product_value,
		
		-- % of each product value over total
		ROUND((units_in_stock * unit_price) * 100.0 / SUM(units_in_stock * unit_price) OVER(), 2) AS pct_by_product,

		-- Cumulative % (correct with ROWS clause)
		ROUND(
			SUM(units_in_stock * unit_price) OVER(
				ORDER BY (units_in_stock * unit_price) DESC
				ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
				) * 100.0 /
			SUM(units_in_stock * unit_price) OVER(), 2) AS pct_accumulated,
			
		SUM(units_in_stock * unit_price) OVER() AS total_in_stock
	FROM product
)
SELECT 
	*,
	CASE 
		WHEN pct_accumulated <= 80 THEN 'A'
		WHEN pct_accumulated <= 90 THEN 'B'
		ELSE 'C'
	END AS class_abc
FROM ranked_product_in_stock;
