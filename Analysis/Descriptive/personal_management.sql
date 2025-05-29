
-- -> Which employee sold the most in terms of value in 2024?
WITH ranked_employee AS (
	SELECT 
		CONCAT(e.first_name, ' ',e.last_name) AS fullname,
		SUM(p.total_price) AS total,
		RANK() OVER(ORDER BY SUM(p.total_price) DESC) AS employee_rank
	FROM employee e
	JOIN purchase p ON e.employee_id = p.employee_id
	WHERE EXTRACT(YEAR FROM p.purchase_date) = '2024'
	GROUP BY fullname
)
SELECT 
	fullname,
	total
FROM ranked_employee
WHERE employee_rank = 1
