CREATE OR REPLACE VIEW gold.dim_employee AS
SELECT
	e.employee_id,
	CONCAT(e.first_name, ' ', e.last_name)::VARCHAR(50) AS employee_name,
	DATE_PART('YEAR', AGE(e.birth_date))::INT AS age,
	
	CASE
		WHEN e.reports_to IS NULL THEN 'Manager'::VARCHAR(50)
		ELSE CONCAT(m.first_name, ' ', m.last_name)::VARCHAR(50)
	END AS manager_name,

	CASE
		WHEn y > 0 AND m > 0 THEN CONCAT(y, ' years and ', m, ' months')
		WHEN y > 0 AND m = 0 THEN CONCAT(y, ' years')
		WHEN y = 0 AND m > 0 THEN CONCAT(m, ' months')
		ELSE 'Less than a month'
	END company_time,

	CASE
		WHEN e.fired_date IS NULL THEN 'Active'::VARCHAR(12)
		ELSE 'Terminated'::VARCHAR(12)
	END employment_status
	
FROM (
	SELECT 
	e.*,
	DATE_PART('YEAR', AGE(COALESCE(e.fired_date, CURRENT_DATE), e.hire_date)) AS y,
	DATE_PART('MONTH', AGE(COALESCE(e.fired_date, CURRENT_DATE), e.hire_date)) AS m
	FROM silver.employee e
) e
LEFT JOIN silver.employee m ON e.reports_to = m.employee_id;
