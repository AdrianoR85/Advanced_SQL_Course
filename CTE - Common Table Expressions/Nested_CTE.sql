-- Objective: Rank Employee based on total sales per employee

-- Step 1: Finde the total sales per employee
WITH CTE_Total_Sales AS (
	SELECT 
		employee_id,
		SUM(total_price) AS total_sales
	FROM purchase
	GROUP BY employee_id
), 
-- Step 2: find the last purchase date for each employee 
CTE_Last_Purchase AS (
	SELECT 
		employee_id,
		MAX(DATE(purchase_date)) AS last_purchase
	FROM purchase
	GROUP BY employee_id
), 
-- Step 3: Rank Employee based on total sales per employee
CTE_Employee_Rank AS (
	SELECT
		employee_id,
		total_sales,
		RANK() OVER(ORDER BY total_sales DESC) AS employee_rank
	FROM CTE_Total_Sales
),
-- Step 4: Segment employees based on their total sales.
CTE_Employee_Segments AS (
	SELECT
		employee_id,
		CASE WHEN total_sales > 3000000 THEN 'Hight'
			 WHEN total_sales > 2200000 THEN 'Medium'
			 ELSE 'Low'
		END employee_segments
	FROM CTE_Total_Sales
)
-- Main Query
SELECT
	e.first_name,
	e.last_name,
	clp.last_purchase,
	cts.total_sales,
	cer.employee_rank,
	ces.employee_segments
FROM employee e
LEFT JOIN CTE_Total_Sales cts ON e.employee_id = cts.employee_id
LEFT JOIN CTE_Last_Purchase clp ON e.employee_id = clp.employee_id
LEFT JOIN CTE_Employee_Rank cer ON e.employee_id = cer.employee_id
LEFT JOIN CTE_Employee_Segments ces ON e.employee_id = ces.employee_id
WHERE e.reports_to IS NOT NULL
ORDER BY cer.employee_rank ASC;
