-- Using the subquery in WHERE clause.
-- Most expensive product in the store.
SELECT 
    product_id,
    product_name,
    unit_price
FROM 
    Product
WHERE 
    unit_price = (
        SELECT MAX(unit_price) FROM Product
 );

-------------------------------------------------------------------------------------
-- Using the subquery in FROM clause.
-- Show customers and how much each spent, along with the overall average spend
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    cust_total.total_spent,
    avg_total.avg_spent
FROM 
    Customer c
JOIN 
    (
        -- Subquery that calculates the total spent per customer
        SELECT 
            p.customer_id,
            SUM(p.total_price) AS total_spent
        FROM 
            Purchase p
        GROUP BY 
            p.customer_id
    ) AS cust_total ON c.customer_id = cust_total.customer_id
CROSS JOIN (
    -- Subquery that calculates the overall average spending
    SELECT 
        AVG(total_price) AS avg_spent
    FROM 
        Purchase
) AS avg_total;
