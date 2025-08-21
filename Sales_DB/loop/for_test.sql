CREATE OR REPLACE FUNCTION fn_for_test(max_num INT)
RETURNS int AS
$body$
DECLARE 
	tot_sum INT DEFAULT 0;
BEGIN
	FOR i IN 1 .. max_num BY 2
	LOOP
		tot_sum := tot_sum + i;
	END LOOP;

	RETURN tot_sum;
END;
$body$
LANGUAGE plpgsql;

SELECT fn_for_test(5);

