-- Tabela de Categorias
CREATE TABLE category (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(60) NOT NULL,
    description TEXT,
    parent_category_id INTEGER,
    FOREIGN KEY (parent_category_id) REFERENCES category(category_id)
);

-- Tabela de Produtos
CREATE TABLE product (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(40) NOT NULL,
    category_id INTEGER NOT NULL,
    quantity_per_unit INTEGER,
    unit_price DECIMAL(10,2),
    units_in_stock INTEGER,
    discontinued BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (category_id) REFERENCES category(category_id)
);

-- Tabela de Clientes
CREATE TABLE customer (
    customer_id SERIAL PRIMARY KEY,
    contact_name VARCHAR(30) NOT NULL,
    company_name VARCHAR(40) NOT NULL,
    contact_email VARCHAR(128),
    address VARCHAR(120) NOT NULL,
    city VARCHAR(30) NOT NULL,
    country VARCHAR(30) NOT NULL
);

-- Tabela de Funcionários
CREATE TABLE employee (
    employee_id SERIAL PRIMARY KEY,
    last_name VARCHAR(40) NOT NULL,
    first_name VARCHAR(20) NOT NULL,
    birth_date DATE,
    hire_date DATE,
    address VARCHAR(128),
    city VARCHAR(30),
    country VARCHAR(30),
    reports_to INTEGER,
    FOREIGN KEY (reports_to) REFERENCES employee(employee_id)
);

-- Tabela de Compras
CREATE TABLE purchase (
    purchase_id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    employee_id INTEGER NOT NULL,
    total_price DECIMAL(10,2),
    purchase_date TIMESTAMP,
    shipped_date TIMESTAMP,
    ship_address VARCHAR(60),
    ship_city VARCHAR(15),
    ship_country VARCHAR(15),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);

-- Tabela de Itens de Compra
CREATE TABLE purchase_item (
    purchase_id INTEGER,
    product_id INTEGER,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INTEGER NOT NULL,
    PRIMARY KEY (purchase_id, product_id),
    FOREIGN KEY (purchase_id) REFERENCES purchase(purchase_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);
