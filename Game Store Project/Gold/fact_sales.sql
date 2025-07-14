-- View: gold.fact_sales

-- DROP VIEW gold.fact_sales;

CREATE OR REPLACE VIEW gold.fact_sales
 AS
 SELECT p.purchase_id,
    p.customer_id,
    p.employee_id,
    p.purchase_date::date AS purchase_date,
    pi.product_id,
    pi.quantity,
    pi.unit_price,
	pi.quantity * pi.unit_price AS total_price_per_item,
    p.shipped_date::date AS shipped_date,
    EXTRACT(day FROM p.shipped_date - p.purchase_date) AS days_to_ship,
        CASE
            WHEN EXTRACT(day FROM p.shipped_date - p.purchase_date) > 2::numeric THEN 'Delayed'::text
            ELSE 'On Time'::text
        END AS ship_status,
    p.ship_city,
    p.ship_state,
    p.ship_region
   FROM silver.purchase p
     JOIN silver.purchase_item pi ON p.purchase_id = pi.purchase_id;

ALTER TABLE gold.fact_sales
    OWNER TO postgres;

GRANT SELECT ON TABLE gold.fact_sales TO lara;
GRANT ALL ON TABLE gold.fact_sales TO postgres;

