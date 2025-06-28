WITH product_values AS (
  SELECT
    p.product_id,
    p.product_name,
    c.name AS category,
    p.unit_price,
    p.units_in_stock,
    (p.unit_price * p.units_in_stock) AS total_item_value
  FROM silver.product p
  JOIN silver.category c ON p.category_id = c.category_id
),
sum_products AS (
  SELECT 
	*,
  	SUM(total_item_value) OVER() AS total_inventory_value,
	SUM(total_item_value) OVER(ORDER BY total_item_value DESC 
		ROWS UNBOUNDED PRECEDING) AS cumulative_value,
	ROW_NUMBER() OVER(ORDER BY total_item_value DESC) AS item_value_rank
  FROM product_values
),
ranked_products AS (
	SELECT
		*,
		ROUND((total_item_value / total_inventory_value * 100), 2) AS item_value_percent,
		ROUND(SUM(total_item_value / total_inventory_value * 100) 
			OVER(ORDER BY total_item_value DESC 
				ROWS UNBOUNDED PRECEDING ), 2) AS cumulative_value_percent
	FROM sum_products
)
SELECT 
	product_id,
	product_name,
	category,
	unit_price,
	units_in_stock,
	total_item_value,
	cumulative_value,
	item_value_percent,
	cumulative_value_percent,

	CASE
	  WHEN unit_price < 500 THEN 'Low'
	  WHEN unit_price BETWEEN 500 AND 5500 THEN 'Medium'
	  ELSE 'High'
	END AS unit_value_class,
	
	CASE 
		WHEN cumulative_value_percent <= 80 THEN 'A'
		WHEN cumulative_value_percent <= 90 THEN 'B'
		ELSE 'C'
	END abc_class,

	item_value_rank
FROM ranked_products 
