SELECT time_order_taken, cust_id
FROM sales_order
WHERE time_order_taken > '2018-12-01' AND time_order_taken <= '2018-12-31';

SELECT *
FROM sales_item
WHERE discount > .15
ORDER BY discount DESC
LIMIT 5;

SELECT 
	CONCAT(first_name, ' ', last_name) AS Name,
	phone,
	state
FROM customer
WHERE state = 'TX';

SELECT 
	product_id,
	SUM(price)
FROM item
WHERE product_id = 1
GROUP BY product_id;

SELECT DISTINCT state
FROM customer
WHERE state != 'CA'
ORDER BY state;

