CREATE TABLE silver.category (
    category_id INTEGER,
    name VARCHAR(60),
    description TEXT,
	created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE silver.product (
    product_id INTEGER,
    product_name VARCHAR(40),
    quantity_per_unit INTEGER,
    unit_price DECIMAL(10,2),
    units_in_stock INTEGER,
    discontinued BOOLEAN DEFAULT FALSE,
	description TEXT, 
    category_id INTEGER,
	created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE silver.customer (
    customer_id INTEGER,
    first_name VARCHAR(30),
    last_name VARCHAR(40),
    email VARCHAR(128),
	gender CHAR(1),
	bith_date DATE,
	cpf CHAR(11),
	phone_number CHAR(13),
	created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE silver.address(
	address_id INTEGER, 
	street VARCHAR(120),
    city VARCHAR(30),
    state CHAR(2),
	region VARCHAR(15),
	customer_id INTEGER,
	created_at TIMESTAMP DEFAULT NOW()
);


CREATE TABLE silver.employee (
    employee_id INTEGER,
    last_name VARCHAR(40),
    first_name VARCHAR(20),
    birth_date DATE,
    hire_date DATE,
	fired_date DATE,
    reports_to INTEGER,
	created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE silver.purchase (
    purchase_id INTEGER,
    total_price DECIMAL(10,2),
    purchase_date TIMESTAMP,
    shipped_date TIMESTAMP,
    ship_street VARCHAR(100),
    ship_city VARCHAR(50),
    ship_state CHAR(2),
    ship_region VARCHAR(15),
    customer_id INTEGER,
    employee_id INTEGER,
	created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE silver.purchase_item (
	purchase_item_id INTEGER,
    quantity INTEGER,
    unit_price DECIMAL(10,2),
    purchase_id INTEGER,
    product_id INTEGER,
	created_at TIMESTAMP DEFAULT NOW()
);
