-- Distribuição de pedidos por clientes
SELECT orders, COUNT(*) as num_customers
FROM
(
	SELECT
		customer_id,
		COUNT(purchase_id) as orders
	FROM gold.fact_sales
	GROUP BY 1
	ORDER BY 1 ASC
) a
GROUP BY 1;


