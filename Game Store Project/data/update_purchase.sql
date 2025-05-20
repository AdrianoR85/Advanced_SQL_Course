DO $$
DECLARE 
	total NUMERIC(10,2);
	r RECORD;

BEGIN
	FOR r IN (
		SELECT p.purchase_id
        FROM purchase p
	) LOOP
		SELECT SUM(quantity * price)
		INTO total
		FROM purchase_item
		WHERE purchase_id = r.purchase_id;

		UPDATE purchase SET total_price = total WHERE purchase_id = r.purchase_id;
		
	END LOOP;
	
END $$;


