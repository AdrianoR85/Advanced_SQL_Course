DO
$body$
	DECLARE 
		j INT DEFAULT 1;
		tot_sum INT DEFAULT 0;
	BEGIN
		WHILE j <= 10
		LOOP
			tot_sum := tot_sum + j;
			j := j+1;
			RAISE NOTICE '%', tot_sum;
		END LOOP;
			RAISE NOTICE '%', tot_sum;
	END;
$body$
LANGUAGE plpgsql;