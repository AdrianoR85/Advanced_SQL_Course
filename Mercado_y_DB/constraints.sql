-- ALTER TABLE <schema_name><table_name> ADD CONSTRAINT <constraint_name> CHECK(<condition>) 

-- CONSTRAINT CHECK
ALTER TABLE produto.tb_produto ADD CONSTRAINT chk_tb_produto_preco_compra CHECK(preco_compra >=0);
ALTER TABLE produto.tb_produto ADD CONSTRAINT chk_tb_produto_preco_venda CHECK(preco_venda > preco_compra);

-- CONSTRAINT UNIQUE
ALTER TABLE produto.tb_fabricante ADD CONSTRAINT uc_tb_fabricante_email UNIQUE(email);
ALTER TABLE produto.tb_categoria DROP COLUMN email;

-- CONSTRAINT PRIMARY KEY
ALTER TABLE produto.tb_produto ADD CONSTRAINT pk_id_produto PRIMARY KEY (id_produto);
ALTER TABLE produto.tb_fabricante ADD CONSTRAINT pk_id_fabricante PRIMARY KEY (id_fabricante);
ALTER TABLE produto.tb_categoria ADD CONSTRAINT pk_id_categoria PRIMARY KEY (id_categoria);

-- CONSTRAINT FOREIGN KEY
ALTER TABLE produto.tb_produto ADD CONSTRAINT fk_id_fabricante 
FOREIGN KEY (fk_id_fabricante) REFERENCES produto.tb_fabricante (id_fabricante);

ALTER TABLE produto.tb_produto ADD CONSTRAINT fk_id_categoria 
FOREIGN KEY (fk_id_categoria) REFERENCES produto.tb_categoria(id_categoria);
