WITH annualy_sales AS (
	SELECT 
	    d.year,
	    d.month,
		d.month_name,
		CASE WHEN d.is_weekend THEN 'Weekend' ELSE 'Week' END AS day_type, 
	    SUM(s.quantity * s.unit_price) AS total_spent
	FROM gold.fact_sales s
	JOIN gold.dim_date d ON s.purchase_date = d.date_id
	WHERE d."year" = '2024'
	GROUP BY d.year, month, month_name, day_type
)
SELECT
	year,
	month,
	month_name,
	MAX(CASE WHEN day_type = 'Weekend' THEN total_spent END) AS weekend_spent,
	MAX(CASE WHEN day_type = 'Week' THEN total_spent END) AS weekend_spent,
	CASE
		WHEN MAX(CASE WHEN day_type = 'Weekend' THEN total_spent END) >
			 MAX(CASE WHEN day_type = 'Week' THEN total_spent END)
			THEN 'Weekend'
		WHEN MAX(CASE WHEN day_type = 'Weekend' THEN total_spent END) <
			 MAX(CASE WHEN day_type = 'Week' THEN total_spent END)
			THEN 'Week'
		ELSE 'Both'
	END AS highest_sales_period
FROM annualy_sales
GROUP BY year, month, month_name
