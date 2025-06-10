-- Step 1: find the last purchase date for each employee
WITH CTE_Total_Sales AS (
	SELECT 
		employee_id,
		SUM(total_price) AS total_sales
	FROM purchase
	GROUP BY employee_id
), 
-- Step 2: -- Step 2: find the last purchase date for each employee
CTE_Last_Purchase AS (
	SELECT 
		employee_id,
		MAX(DATE(purchase_date)) AS last_purchase
	FROM purchase
	GROUP BY employee_id
)
-- Main Query
SELECT
	e.first_name,
	e.last_name,
	clp.last_purchase,
	total_sales
FROM employee e
LEFT JOIN CTE_Total_Sales cts ON e.employee_id = cts.employee_id
LEFT JOIN CTE_Last_Purchase clp ON e.employee_id = clp.employee_id
WHERE e.reports_to IS NOT NULL;
