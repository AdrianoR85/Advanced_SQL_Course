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

-- MERCADO Y CONSTRAINT
ALTER TABLE produto.tb_produto ADD CONSTRAINT fk_produto_categoria
	FOREIGN KEY (fk_id_categoria)
	REFERENCES produto.tb_categoria (id_categoria);

ALTER TABLE produto.tb_produto ADD CONSTRAINT fk_produto_fabricante
	FOREIGN KEY (fk_id_fabricante)
	REFERENCES produto.tb_fabricante (id_fabricante);
	
ALTER TABLE estoque.tb_estoque_produto ADD CONSTRAINT fk_estoque_produto_produto
	FOREIGN KEY (fk_id_produto)
	REFERENCES produto.tb_produto (id_produto);
	
ALTER TABLE venda.tb_venda ADD CONSTRAINT fk_venda_estoque_produto
	FOREIGN KEY (fk_id_estoque_produto)
	REFERENCES estoque.tb_estoque_produto (id_estoque_produto);
	
ALTER TABLE venda.tb_venda ADD CONSTRAINT fk_venda_produto
	FOREIGN KEY (fk_id_produto)
	REFERENCES produto.tb_produto (id_produto);
	
ALTER TABLE estoque.tb_movimentacao ADD CONSTRAINT fk_tb_movimentacao_2
	FOREIGN KEY (id_movimentacao)
	REFERENCES estoque.tb_estoque_produto (id_estoque_produto);
	
ALTER TABLE estoque.tb_movimentacao ADD CONSTRAINT fk_movimentacao_produto
	FOREIGN KEY (fk_id_produto)
	REFERENCES produto.tb_produto (id_produto);
	
ALTER TABLE estoque.tb_movimentacao ADD CONSTRAINT fk_movimentacao_estoque_produto
	FOREIGN KEY(fk_id_estoque_produto)
	REFERENCES estoque.tb_estoque_produto (id_estoque_produto);
