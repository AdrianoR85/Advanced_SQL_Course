-- This query shows how to use window functions with aggregation.
-- Aggregation means combining many rows to get summary information, like total, average, or count.
-- Normally, aggregation removes details, but with window functions we keep each row.
-- This query calculates, for each purchase, the total number of sales, the sum, min, max, and average
-- of all purchases that happened on the same date (per day).

SELECT
  purchase_id,               -- The ID of the purchase
  purchase_date,             -- The date when the purchase happened

  -- Count how many purchases were made on the same date
  COUNT(purchase_id) OVER(PARTITION BY purchase_date) AS total_sale_per_month,

  -- Sum of all total_price values for the same purchase date
  SUM(total_price) OVER(PARTITION BY purchase_date) AS total,

  -- The smallest total_price for the same purchase date
  MIN(total_price) OVER(PARTITION BY purchase_date) AS min_value,

  -- The largest total_price for the same purchase date
  MAX(total_price) OVER(PARTITION BY purchase_date) AS max_value,

  -- The average total_price for the same purchase date
  AVG(total_price) OVER(PARTITION BY purchase_date) AS avg_value

-- From the 'purchase' table
FROM purchase

-- Only include purchases from January 1st, 2024 or later
WHERE purchase_date >= '2024-01-01'

-- Order the result by date and then by purchase ID
ORDER BY purchase_date, purchase_id

-- Show only the first 1000 rows
LIMIT 1000;
from Sales.Orders
