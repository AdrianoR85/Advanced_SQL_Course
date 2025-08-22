CREATE TABLE distributor_audit(
	id SERIAL PRIMARY KEY,
	dist_id INT NOT NULL,
	name VARCHAR(100) NOT NULL,
	edit_date TIMESTAMP NOT NULL
);