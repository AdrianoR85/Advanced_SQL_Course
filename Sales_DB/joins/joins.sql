SELECT 
	item_id,
	price
FROM item
INNER JOIN sales_item  ON item.id = sales_item.id 
ORDER BY item_id;