-- Most expensive product in the store.
-- Using the subquery in WHERE clause.
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
