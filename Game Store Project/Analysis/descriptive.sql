-- Fase 1 — SQL Descritivo (Exploratórios)
-- Use SELECT, GROUP BY, ORDER BY, JOIN

-- 1. Produtos mais vendidos
SELECT
	p.product_name,
	SUM(pi.quantity) AS quantity_sale,
	RANK() OVER(ORDER BY SUM(pi.quantity) DESC) AS rank_quantity,
	SUM(pi.price) AS revenue_sale,
	RANK() OVER(ORDER BY SUM(pi.price) DESC) AS rank_revenue
FROM product p
JOIN purchase_item pi
ON p.product_id = pi.product_id
GROUP BY p.product_name
ORDER BY quantity_sale DESC
LIMIT 10;

-- 2. Receita total por mês
SELECT
	date_part('year',purchase_date) AS yearly_revenue,
	date_part('month',purchase_date)AS monthly_revenue,
	SUM(total_price) AS total_sale_by_month
FROM purchase
GROUP BY 
	yearly_revenue,
	monthly_revenue
ORDER BY 
	monthly_revenue,
	yearly_revenue;

-- 3. Média de vendas por região
SELECT
	ship_region,
	ROUND(AVG(total_price),2) AS average_total_sale
FROM purchase
GROUP BY ship_region;

-- 4. Total vendido por categoria
SELECT 
	c.name,
	SUM(pi.quantity) AS quantity_sale,
	SUM(pi.price) AS revenue_sale,
	ROUND(SUM(pi.price) * 100.0 / SUM(SUM(pi.price)) OVER(),1) AS percent_revenue
FROM category c
JOIN product p ON c.category_id = p.category_id
JOIN purchase_item pi ON p.product_id = pi.product_id
GROUP BY c.name
ORDER BY quantity_sale DESC;
