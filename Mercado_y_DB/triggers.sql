
CREATE OR REPLACE FUNCTION produto.func_log_produto()
RETURNS TRIGGER AS
$body$
BEGIN
	INSERT INTO auditoria.tb_produto_log(
		id_produto,
		id_categoria_new, id_categoria_old, 
		id_fabricante_new, id_fabricante_old, 
		produto_new, produto_old, 
		preco_compra_new, preco_compra_old, 
		preco_venda_new, preco_venda_old, 
		evento
	) VALUES (
		NEW.id_produto, 
		NEW.fk_id_categoria, NULL, 
		NEW.fk_id_fabricante, NULL, 
		NEW.produto, NULL, 
		NEW.preco_compra, NULL, 
		NEW.preco_venda, NULL, 
		'insert'
	);
	
	RETURN NEW;
END
$body$
LANGUAGE plpgsql;

CREATE TRIGGER tr_after_insert_produto
AFTER INSERT ON produto.tb_produto
FOR EACH ROW
EXECUTE PROCEDURE produto.func_log_produto()

---

CREATE OR REPLACE FUNCTION produto.fun_log_produto_update()
RETURNS TRIGGER AS
$$
BEGIN
	INSERT INTO auditoria.tb_produto_log(
		id_produto,
		id_categoria_new, id_categoria_old, 
		id_fabricante_new, id_fabricante_old, 
		produto_new, produto_old, 
		preco_compra_new, preco_compra_old, 
		preco_venda_new, preco_venda_old, 
		evento)
	VALUES(
		OLD.id_produto,
		NEW.fk_id_categoria, OLD.fk_id_categoria, 
		NEW.fk_id_fabricante, OLD.fk_id_fabricante, 
		NEW.produto, OLD.produto, 
		NEW.preco_compra, OLD.preco_compra, 
		NEW.preco_venda, OLD.preco_venda, 
		'update'
	);

	RETURN NEW;

END
$$
LANGUAGE plpgsql;

CREATE TRIGGER tr_before_update_produto
BEFORE UPDATE ON  produto.tb_produto
FOR EACH ROW
EXECUTE PROCEDURE produto.fun_log_produto_update();
