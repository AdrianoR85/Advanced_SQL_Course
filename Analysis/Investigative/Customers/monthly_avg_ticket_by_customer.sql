SELECT 
	c.customer_name,
	d.year,
  d.month,
	ROUND(SUM(s.total_price_per_item) / COUNT(DISTINCT s.purchase_id), 2) AS avg_ticket
FROM gold.dim_customer c
JOIN gold.fact_sales s ON c.customer_id = s.customer_id
JOIN gold.dim_date d ON s.purchase_date = d.date_id 
GROUP BY 
    c.customer_name,
    d.year,
    d.month
ORDER BY 
    c.customer_name,
    d.year ASC,
    d.month ASC;
