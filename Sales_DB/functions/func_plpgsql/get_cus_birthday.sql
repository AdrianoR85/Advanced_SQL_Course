CREATE OR REPLACE FUNCTION fn_get_cus_birthday(
	IN the_month INT, 
	OUT bd_month INT, 
	OUT bd_day INT,
	OUT f_name VARCHAR,
	OUT l_name VARCHAR
) AS
$body$ 
BEGIN
	SELECT 
		EXTRACT(MONTH FROM birth_date), 
		EXTRACT(DAY FROM birth_date),
		first_name,
		last_name
	INTO bd_month, bd_day, f_name, l_name
	FROM customer
	WHERE EXTRACT(MONTH FROM birth_date) = the_month;
END
$body$
LANGUAGE plpgsql;

SELECT (fn_get_cus_birthday(6)).*;