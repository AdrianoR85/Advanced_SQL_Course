-- Task: How many products with Intel or AMD processors are there, and what is the total stock for each processor type?
/* Describing the code:
	- Looks for products that mention "Processador Intel" or "Processador AMD" in their description.
	- Groups them by processor type.
	- Counts how many products there are (processor_total).
	- Sums the stock of these products (total_in_stock).
*/
SELECT
	CASE
		WHEN description ILIKE '%Processador Intel%' THEN 'Processador Intel'
		WHEN description ILIKE '%Processador AMD%' THEN 'Processador AMD'
	ELSE 'Others'
	END AS processor_type,
	COUNT(*) AS processor_total,
	SUM(units_in_stock) AS total_in_stock
FROM product
WHERE  description ILIKE '%Processador Intel%'
	OR description ILIKE '%Processador AMD%'
GROUP BY processor_type;
