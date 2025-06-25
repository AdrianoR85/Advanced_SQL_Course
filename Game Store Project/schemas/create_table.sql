CREATE TABLE category (
    category_id SERIAL,
    name VARCHAR(60) NOT NULL,
    description TEXT,
	CONSTRAINT pk_category PRIMARY KEY (category_id)
	
);

CREATE TABLE product (
    product_id SERIAL,
    product_name VARCHAR(40) NOT NULL,
    quantity_per_unit INTEGER,
    unit_price DECIMAL(10,2),
    units_in_stock INTEGER,
    discontinued BOOLEAN DEFAULT FALSE,
	description TEXT, 
    category_id INTEGER NOT NULL,
	CONSTRAINT pk_product PRIMARY KEY (product_id),
    FOREIGN KEY (category_id) REFERENCES category(category_id)
);

CREATE TABLE customer (
    customer_id SERIAL,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(40) NOT NULL,
    email VARCHAR(128),
	gender CHAR(1),
	bith_date DATE,
	cpf CHAR(11),
	phone_number CHAR(13),
	CONSTRAINT pk_customer PRIMARY KEY (customer_id),
);

CREATE TABLE address(
	address_id SERIAL, 
	street VARCHAR(120) NOT NULL,
    city VARCHAR(30) NOT NULL,
    state CHAR(2) NOT NULL,
	region VARCHAR(15) NOT NULL,
	customer_id INTEGER NOT NULL,
	CONSTRAINT pk_address PRIMARY KEY (address_id),
	FOREIGN KEY (customer_id) REFERENCES employee(employee_id)
);


CREATE TABLE employee (
    employee_id SERIAL,
    last_name VARCHAR(40) NOT NULL,
    first_name VARCHAR(20) NOT NULL,
    birth_date DATE,
    hire_date DATE,
	fired_date DATE,
    reports_to INTEGER,
	CONSTRAINT pk_employee PRIMARY KEY (employee_id),
    FOREIGN KEY (reports_to) REFERENCES employee(employee_id)
);

CREATE TABLE purchase (
    purchase_id SERIAL,
    total_price DECIMAL(10,2),
    purchase_date TIMESTAMP,
    shipped_date TIMESTAMP,
    ship_street VARCHAR(100),
    ship_city VARCHAR(50),
    ship_state CHAR(2),
    ship_region VARCHAR(15),
    customer_id INTEGER NOT NULL,
    employee_id INTEGER NOT NULL,
	CONSTRAINT pk_purchase PRIMARY KEY (purchase_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);

CREATE TABLE purchase_item (
	purchase_item_id INTEGER,
    quantity INTEGER NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    purchase_id INTEGER,
    product_id INTEGER,
	CONSTRAINT pk_purchase_item PRIMARY KEY (purchase_item_id),
    FOREIGN KEY (purchase_id) REFERENCES purchase(purchase_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);
