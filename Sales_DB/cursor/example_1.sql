DO
$body$
DECLARE 
	msg TEXT DEFAULT '';
	rec_customer RECORD;
	cur_customers CURSOR
	FOR 
		SELECT * FROM customer;
	BEGIN
		OPEN cur_customers;
		LOOP
			FETCH cur_customers INTO rec_customer;
			EXIT WHEN NOT FOUND;
			msg := msg || rec_customer.first_name || ' ' || rec_customer.last_name || ', ';
		END LOOP;
		RAISE NOTICE 'Customers : %', msg;
	END;
$body$