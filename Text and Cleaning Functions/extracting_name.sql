-- Task: Extracting name from email
-- Description: Extracts and formats customer names written in CamelCase from the email address (before '@') by inserting spaces between name parts.

SELECT 
	SUBSTRING( email, 0, POSITION('@' IN email) ) AS names
FROM customer
SELECT 
	TRIM( 
		REGEXP_REPLACE (
			SUBSTRING( email, 0, POSITION('@' IN email)), '([A-Z])', ' \1', 'g'
		) 
	) AS spaced_name
FROM customer;
