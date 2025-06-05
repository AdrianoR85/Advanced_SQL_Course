-- This query shows the customers who spent more than the average.
-- It joins the Customer and Purchase tables.
-- For each customer, it calculates the total money they spent (SUM of total_price).
-- It groups the results by customer.
-- Then, it uses a subquery in the HAVING clause.
-- The subquery calculates the average purchase value (AVG of total_price).
-- The HAVING clause checks if the customer's total is greater than that average.
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(p.total_price) AS total_spent
FROM 
    Customer c
JOIN 
    Purchase p ON c.customer_id = p.customer_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name
HAVING 
    SUM(p.total_price) > (
        SELECT AVG(total_price) FROM Purchase
    );
