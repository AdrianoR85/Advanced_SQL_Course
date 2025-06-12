-- Check is exist product with negative price

DO $$
BEGIN
	IF EXISTS (SELECT 1 FROM product WHERE unit_price < 0.00 ) THEN
 		RAISE NOTICE 'Product with negative price was found';
	ELSE 
		RAISE NOTICE 'Product with negative price was not found';
	END IF;
END
$$;



-- Classify products by their prices. 
WITH price_stats AS (
    SELECT 
        MAX(unit_price) AS max_price,
        PERCENTILE_CONT(0.8) WITHIN GROUP (ORDER BY unit_price) AS p80,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY unit_price) AS median,
        PERCENTILE_CONT(0.2) WITHIN GROUP (ORDER BY unit_price) AS p20
    FROM product
)
SELECT 
    p.product_id,
    p.product_name,
    p.unit_price,
    CASE 
		WHEN unit_price > ps.p80 * 2 THEN 'Super Premium'
        WHEN p.unit_price > ps.p80 THEN 'Premium'
        WHEN p.unit_price > ps.median THEN 'Luxury'
        WHEN p.unit_price > ps.p20 THEN 'Mid-range'
        ELSE 'Economy'
    END AS price_category
FROM product p, price_stats ps;
