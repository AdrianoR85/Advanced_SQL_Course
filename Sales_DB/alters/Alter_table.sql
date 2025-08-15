-- Add a new column
ALTER TABLE sales_item ADD day_of_week VARCHAR(8);

-- Alter the set of a column 
ALTER TABLE sales_item ALTER COLUMN day_of_week SET NOT NULL;

-- Rename a column
ALTER TABLE sales_item RENAME COLUMN day_of_week TO weekday;

-- Drop a column
ALTER TABLE sales_item DROP COLUMN weekday;

-- Rename a table name
ALTER TABLE transaction RENAME TO transaction_type;

ALTER TABLE sales_person ALTER COLUMN zip TYPE INTEGER; 
ALTER TABLE customer ALTER COLUMN zip TYPE INTEGER; 

ALTER TABLE sales_order ALTER COLUMN purchase_order_number TYPE BIGINT; 