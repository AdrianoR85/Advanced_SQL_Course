SELECT 
    c.customer_name,
    d.year,
    d.month,
    SUM(s.quantity * s.unit_price) AS total_spent
FROM gold.fact_sales s
JOIN gold.dim_customer c ON s.customer_id = c.customer_id
JOIN gold.dim_date d ON s.purchase_date = d.date_id
WHERE d."year" = '2024'
GROUP BY c.customer_name, d.year, d.month
ORDER BY c.customer_name, d.year, d.month;
Here is the translation in B1 English:

/*
📊 2. What to do with this data?

- Option 1: Visualize
Use line charts for each client to see the changes. If there is a repeating pattern month after month, this suggests seasonality.

- Option 2: Calculate standard deviation and coefficient of variation
Clients with high variation over the months might be seasonal.

- Option 3: Statistical analysis (advanced, optional)
Use autocorrelation or time series decomposition (for example, in Python with statsmodels or Prophet).
*/
