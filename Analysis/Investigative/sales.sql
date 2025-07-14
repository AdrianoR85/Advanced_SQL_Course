-- Quais são os clientes que mais compram (em valor e em volume)?
WITH purchases_customer AS (
	SELECT 
		c.customer_name,
		SUM(s.quantity) AS total_quantity,
		SUM(s.quantity * s.unit_price) AS total_price
	FROM gold.dim_customer c
	JOIN gold.fact_sales s ON s.customer_id = c.customer_id
	GROUP BY 1
),
customer_rank AS (
	SELECT 
		ROW_NUMBER() OVER(ORDER BY total_quantity DESC) AS quantity_rank,
		ROW_NUMBER() OVER (ORDER BY total_price DESC) AS value_rank,
		customer_name,
		total_quantity,
		total_price
	FROM purchases_customer
)
SELECT 
	*
FROM customer_rank
WHERE quantity_rank <= 10 and value_rank <= 10

-----------------------------------------------------------------------------------------------------------
-- Qual é o ticket médio de vendas (mês de dezembro de 2024)?
SELECT
	ROUND(AVG(s.total_price_per_item),2) avg_ticket
FROM gold.fact_sales s
WHERE s.purchase_date between '2024-12-01' and '2024-12-31';

-- Ticket médio de vendas de cada mês
SELECT 
	d."year",
	d."month",
	ROUND(AVG(s.total_price_per_item),2) avg_ticket
FROM gold.fact_sales s
JOIN gold.dim_date d ON s.purchase_date = d.date_id
GROUP BY d."year", d."month"
ORDER BY d."year", d."month";

-----------------------------------------------------------------------------------------------------------
