CREATE OR REPLACE FUNCTION fn_get_sum(val1 INT, val2 INT)
RETURNS int AS 
$body$
DECLARE 
	ans INT;
BEGIN
	ans := val1 + val2;
	RETURN ans;
END
$body$
LANGUAGE plpgsql;

SELECT fn_get_sum(2,5);