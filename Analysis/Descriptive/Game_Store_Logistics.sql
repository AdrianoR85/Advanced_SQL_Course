-- -> What is the average shipping time per month?
SELECT 
	TO_CHAR(purchase_date, 'YYYY-MM') AS sale_date,
	ROUND(AVG(EXTRACT(DAY FROM shipped_date - purchase_date)), 2) AS avg_days
FROM purchase
-- WHERE DATE_PART('year',purchase_date) = 2022
GROUP BY sale_date
ORDER BY sale_date;

-- -> What is the average annual shipping time by region?
SELECT 
    DATE_PART('year', purchase_date) AS year,
	ship_region,
    ROUND(AVG(EXTRACT(DAY FROM shipped_date - purchase_date)), 2) AS avg_days
FROM purchase
WHERE shipped_date IS NOT NULL AND DATE_PART('year', purchase_date) = 2022
GROUP BY 1, 2
ORDER BY 1, 2;
