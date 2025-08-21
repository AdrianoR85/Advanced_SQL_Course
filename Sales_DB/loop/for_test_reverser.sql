CREATE OR REPLACE FUNCTION fn_for_test_reverser(max_num INT)
RETURNS int AS
$body$
DECLARE 
	tot_sum INT DEFAULT 0;
BEGIN
	FOR i IN REVERSE max_num .. 1 BY 2
	LOOP
		tot_sum := tot_sum + i;
	END LOOP;

	RETURN tot_sum;
END;
$body$
LANGUAGE plpgsql;

SELECT fn_for_test_reverser(5);