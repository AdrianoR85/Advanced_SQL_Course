CREATE OR REPLACE FUNCTION fn_get_random_number(min_val INT, max_val INT)
RETURNS int AS 
$body$
DECLARE 
	rand INT;
BEGIN
	SELECT random()*(max_val - min_val) + min_val INTO rand;
	RETURN rand;
END
$body$
LANGUAGE plpgsql;

SELECT fn_get_random_number(10,30);