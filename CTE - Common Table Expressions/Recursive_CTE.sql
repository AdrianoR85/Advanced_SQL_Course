-- Task: Show the employee hierarchy by displaying each employee's leve within the organization.

WITH RECURSIVE CTE_Emp_Hierarchy AS (
	-- Anchor Query
	SELECT 
		employee_id,
		first_name,
		last_name,
		reports_to,
		1 AS Level
	FROM employee
	WHERE reports_to IS NULL

	UNION ALL

	-- Recursion Query
	SELECT 
		e.employee_id,
		e.first_name,
		e.last_name,
		e.reports_to,
		Level + 1
	FROM employee e
	INNER JOIN CTE_Emp_Hierarchy ceh ON e.reports_to = ceh.employee_id
	
)
SELECT * FROM CTE_Emp_Hierarchy
