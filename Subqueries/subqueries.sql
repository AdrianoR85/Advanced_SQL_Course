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
