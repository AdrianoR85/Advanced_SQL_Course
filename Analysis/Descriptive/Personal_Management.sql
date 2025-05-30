
-- This query is designed to identify the employee who sold the highest total value in sales during the year 2024.
-- In other words, it calculates the sum of sales made by each employee in 2024 and returns the employee with the highest total sales amount.

-- Detailed explanation of the code:

WITH ranked_employee AS (
    -- Creates a CTE (Common Table Expression) named ranked_employee that groups and ranks employees by their total sales.

    SELECT 
        CONCAT(e.first_name, ' ', e.last_name) AS fullname,  -- Combines the employee's first and last names into a single column "fullname"
        SUM(p.total_price) AS total,                         -- Calculates the total sum of sales made by the employee in the period
        RANK() OVER (ORDER BY SUM(p.total_price) DESC) AS employee_rank -- Applies a ranking function ordering employees from highest to lowest total sales
    FROM employee e
    JOIN purchase p ON e.employee_id = p.employee_id        -- Joins the employee and purchase tables on employee_id
    WHERE EXTRACT(YEAR FROM p.purchase_date) = '2024'       -- Filters purchases only for the year 2024
    GROUP BY fullname                                        -- Groups data by employee full name to calculate the sum of sales
)

SELECT 
    fullname,  -- Selects the full name of the employee with the highest sales
    total      -- Selects the total sales amount for that employee
FROM ranked_employee
WHERE employee_rank = 1     -- Returns only the employee(s) with the highest total sales (rank 1)

