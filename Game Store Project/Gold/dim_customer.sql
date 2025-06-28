CREATE OR REPLACE VIEW gold.dim_customer AS
SELECT c.customer_id,
	concat(c.first_name, ' ', c.last_name) AS customer_name,
	gender,
    EXTRACT(YEAR FROM age(CURRENT_DATE, c.birth_date)) AS age,
    a.city,
    a.state,
    a.region
FROM silver.customer c
JOIN silver.address a ON c.customer_id = a.customer_id;
