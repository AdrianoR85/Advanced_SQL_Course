CREATE OR REPLACE FUNCTION fn_block_weekend_changes()
	RETURNS TRIGGER
	LANGUAGE plpgsql
AS
$body$
BEGIN
	RAISE NOTICE 'No database changes allowed on the weekend';
	RETURN null;
END;
$body$

CREATE TRIGGER tr_block_weekend_changes
	BEFORE UPDATE OR INSERT OR DELETE OR TRUNCATE
	ON distributor
	FOR EACH STATEMENT
	WHEN (
		EXTRACT('DOW' FROM CURRENT_TIMESTAMP) = 2
	)
	EXECUTE PROCEDURE fn_block_weekend_changes();

UPDATE distributor
SET name = 'Western Clothing'
WHERE id = 2;

-- Delete a trigger
DROP TRIGGER tr_block_weekend_changes ON distributor;
