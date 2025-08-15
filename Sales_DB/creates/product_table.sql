CREATE TABLE product(
	type_id INTEGER REFERENCES product_type(id),
	name VARCHAR(30) NOT NULL,
	supplier VARCHAR(30) NOT NULL,
	description TEXT NOT NULL,
	id SERIAL PRIMARY KEY
);