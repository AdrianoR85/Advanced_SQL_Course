DO
$body$
	DECLARE 
		rec record;
	BEGIN
		FOR rec IN
			SELECT first_name, last_name
			FROM sales_person
			LIMIT 5
		LOOP
			RAISE NOTICE '% %', rec.first_name, rec.last_name;
		END LOOP;
	END;
$body$
LANGUAGE plpgsql;
