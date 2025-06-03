-- This query shows how to use ranking window functions in SQL.
-- Ranking functions add a number to each row, based on the order of a column.
-- They help to find positions, ranks, or groupings in the data.
-- In this example, we rank purchases by total_price (highest to lowest) for each purchase date.

SELECT
  purchase_id,          -- ID of the purchase
  purchase_date,        -- Date of the purchase
  total_price,          -- Total value of the purchase
  -- Give a unique row number, even if the prices are the same
  ROW_NUMBER() OVER (PARTITION BY purchase_date ORDER BY total_price DESC) AS row_num,
  -- Give a rank, but if two prices are the same, they get the same rank (with gaps)
  RANK() OVER (PARTITION BY purchase_date ORDER BY total_price DESC) AS rank_value,
  -- Like RANK(), but without gaps when prices are the same
  DENSE_RANK() OVER (PARTITION BY purchase_date ORDER BY total_price DESC) AS dense_rank,
  -- Divide the rows into 4 groups (quartiles), based on total_price
  NTILE(4) OVER (PARTITION BY purchase_date ORDER BY total_price DESC) AS quartile,
  -- Show how many rows are below or equal to this one, as a percentage (includes current row)
  CUME_DIST() OVER (PARTITION BY purchase_date ORDER BY total_price DESC) AS cume_dist,
  -- Show the rank of the row as a percentage (does not count the current row)
  PERCENT_RANK() OVER (PARTITION BY purchase_date ORDER BY total_price DESC) AS percent_rank
FROM purchase
-- Only show purchases from 2024 and after
WHERE purchase_date >= '2024-01-01'
-- Order by date and by total price descending
ORDER BY purchase_date, total_price DESC
-- Limit result for testing
LIMIT 1000;

