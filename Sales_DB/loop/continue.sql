DO
$body$
	DECLARE
		i INT DEFAULT 1;
	BEGIN
		LOOP
			i := i+1;
			EXIT WHEN i > 10;
			CONTINUE WHEN MOD(i,2) = 0;
			RAISE NOTICE 'Num : %', i;
		END LOOP;
	END;
$body$
LANGUAGE plpgsql;