WITH annual_sales AS (
    SELECT
        d.year,
        d.month,
        d.month_name,
        CASE WHEN d.is_weekend THEN 'Weekend' ELSE 'Week' END AS day_type,
        SUM(s.quantity * s.unit_price) AS total_spent
    FROM gold.fact_sales s
    JOIN gold.dim_date d ON s.purchase_date = d.date_id
    WHERE d."year" = 2024 
    GROUP BY d.year, d.month, d.month_name, day_type
),
pivoted_monthly_sales AS ( 
    SELECT
        year,
        month,
        month_name,
        MAX(CASE WHEN day_type = 'Weekend' THEN total_spent END) AS weekend_spent,
        MAX(CASE WHEN day_type = 'Week' THEN total_spent END) AS week_spent
    FROM annual_sales
    GROUP BY year, month, month_name
)
SELECT
    year,
    month,
    month_name,
    weekend_spent,
    week_spent,
    CASE
        WHEN weekend_spent > week_spent THEN 'Weekend'
        WHEN weekend_spent < week_spent THEN 'Week'
        ELSE 'Both'
    END AS highest_sales_period
FROM pivoted_monthly_sales;
