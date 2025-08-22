CREATE OR REPLACE PROCEDURE pr_debt_paid(
	past_due_id INT,
	payment NUMERIC,
	INOUT msg VARCHAR
) AS
$body$
BEGIN
	UPDATE past_due
	SET balance = balance - payment
	WHERE id = past_due_id;

	COMMIT;
END;
$body$
LANGUAGE plpgsql;

CALL pr_debt_paid(1, 10.00);

SELECT * FROM past_due;