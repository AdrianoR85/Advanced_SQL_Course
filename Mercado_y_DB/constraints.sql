-- ALTER TABLE <schema_name><table_name> ADD CONSTRAINT <constraint_name> CHECK(<condition>) 

-- CONSTRAINT CHECK
ALTER TABLE produto.tb_produto ADD CONSTRAINT chk_tb_produto_preco_compra CHECK(preco_compra >=0);
ALTER TABLE produto.tb_produto ADD CONSTRAINT chk_tb_produto_preco_venda CHECK(preco_venda > preco_compra);

-- CONSTRAINT UNIQUE
ALTER TABLE produto.tb_fabricante ADD CONSTRAINT uc_tb_fabricante_email UNIQUE(email);
ALTER TABLE produto.tb_categoria DROP COLUMN email;
