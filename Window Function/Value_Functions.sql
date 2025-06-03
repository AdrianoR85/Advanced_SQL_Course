-- This query shows how to use value window functions in SQL.
-- These functions return values from a specific row in a group.
-- You can get the first, last, or nth value, or compare with the next or previous row.
-- In this example, we analyze purchases by date and compare their prices.

SELECT
  purchase_id,           -- ID of the purchase
  purchase_date,         -- Date of the purchase
  total_price,           -- Total value of the purchase

  -- Get the first (highest) total_price for the date
  FIRST_VALUE(total_price) OVER (
    PARTITION BY purchase_date 
    ORDER BY total_price DESC
  ) AS first_value,

  -- Get the last (lowest) total_price for the date
  LAST_VALUE(total_price) OVER (
    PARTITION BY purchase_date 
    ORDER BY total_price DESC
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
  ) AS last_value,
 
  -- Get the total_price of the previous row (by price order)
  LAG(total_price) OVER (
    PARTITION BY purchase_date 
    ORDER BY total_price DESC
  ) AS previous_price,
 
  -- Get the total_price of the next row (by price order)
  LEAD(total_price) OVER (
    PARTITION BY purchase_date 
    ORDER BY total_price DESC
  ) AS next_price
 
FROM purchase
-- Only show purchases from 2024 and after
WHERE purchase_date >= '2024-01-01'
-- Order by date and total_price descending
ORDER BY purchase_date, total_price DESC
-- Limit the result for testing
LIMIT 1000;
