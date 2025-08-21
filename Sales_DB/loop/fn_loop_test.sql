CREATE OR REPLACE FUNCTION fn_loop_test(max_num INT)
RETURNS INT AS
$body$
DECLARE 
	j INT DEFAULT 1;
	total_sum INT DEFAULT 0;
BEGIN
	LOOP 
		total_sum := total_sum + j;
		j := j + 1;
		EXIT WHEN j > max_num;
	END LOOP;

	RETURN total_sum;
END;
$body$
LANGUAGE plpgsql;

SELECT fn_loop_test(5);