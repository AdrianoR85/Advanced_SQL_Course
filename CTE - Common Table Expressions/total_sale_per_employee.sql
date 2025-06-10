-- Objective: Find the total sales per employee in 2024
-- Steps: 
-- -> First, we use a CTE query to get the total sales per employee ID.
-- -> Then, we use the main query to join the Employee table with the CTE_Total_Sales to generate a table with the employee ID, first name, last name, and total sales for each employee.
 
-- CTE Query
WITH CTE_Total_Sales AS (
	SELECT 
		employee_id,
		SUM(total_price) AS total_sales
	FROM purchase
	WHERE EXTRACT('year' FROM purchase_date) = '2024'
	GROUP BY employee_id
)
-- Main Query
SELECT
	e.employee_id,
	e.first_name,
	e.last_name,
	total_sales
FROM employee e
LEFT JOIN CTE_Total_Sales cts ON e.employee_id = cts.employee_id;
