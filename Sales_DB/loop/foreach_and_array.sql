DO
$body$
	DECLARE 
		arr1 INT[] := array[1,2,3];
		i INT;
	BEGIN
		FOREACH i IN ARRAY arr1 
		LOOP
			RAISE NOTICE '%', i;
		END LOOP;
	END;
$body$
LANGUAGE plpgsql;