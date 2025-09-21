-- List databases
SELECT datname FROM pg_database;

-- List schema/namespaces
SELECT * FROM information_schema.schemata;
SELECT * FROM information_schema.schemata WHERE catalog_name = 'mercado_y';

-- List Tables
SELECT * FROM information_schema.tables;
SELECT table_name FROM information_schema.tables
WHERE table_catalog = 'mercado_y' AND table_schema = 'produto';

-- Create table (ddl)
CREATE TABLE produto.tb_categoria (
	id_categoria INT,
	categoria VARCHAR(30)
);

CREATE TABLE produto.tb_produto(
	id_produto INT,
	fk_id_categoria INT,
	fk_id_fabricante INT,
	produto VARCHAR(50), 
	unidade_medida CHAR(3) NOT NULL,
	preco_compra NUMERIC(10,2) NOT NULL,
	prco_venda NUMERIC(10,2) NOT NULL
);

CREATE TABLE produto.tb_fabricante(
	id_fabricante INT,
	fabricante VARCHAR(100) NOT NULL,
	telefone VARCHAR(17),
	contato VARCHAR(30) 
);
