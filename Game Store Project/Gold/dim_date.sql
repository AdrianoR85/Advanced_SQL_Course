CREATE OR REPLACE VIEW gold.dim_date AS
SELECT
	d::DATE AS date_id,
	EXTRACT(DAY FROM d)::INT AS day,
	EXTRACT(MONTH FROM d)::INT AS month,
	TO_CHAR(d, 'Month') AS month_name,
	EXTRACT(QUARTER FROM d)::INT AS quarter,
	EXTRACT(YEAR FROM d)::INT AS year,
	TO_CHAR(d, 'YYYY-MM') AS year_month,
	EXTRACT(WEEK FROM d)::INT AS week,
	EXTRACT(DOW FROM d)::INT AS weekday,
	TO_CHAR(d, 'Day') AS week_name,
	CASE 
		WHEN EXTRACT(DOW FROM d) IN (0,6) THEN TRUE 
		ELSE FALSE 
	END AS is_weekend
FROM generate_series('2022-01-01'::DATE,'2030-12-31'::DATE, '1 day') as d;
