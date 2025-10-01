-- Insert Categorias
INSERT INTO produto.tb_categoria(categoria) VALUES ('Bebidas');
INSERT INTO produto.tb_categoria(categoria) VALUES ('Mercearia');
INSERT INTO produto.tb_categoria(categoria) VALUES ('Limpeza');
INSERT INTO produto.tb_categoria(categoria) VALUES ('Higiene e Perfumaria');

-- Insert Produtos
INSERT INTO produto.tb_produto(
	fk_id_categoria, fk_id_fabricante, produto, 
	unidade_medida, preco_compra, preco_venda)
VALUES (1, 1, 'Refrigerante Coca-Cola 2L', 'UN', 3.35, 6.25);

INSERT INTO produto.tb_produto(
	fk_id_categoria, fk_id_fabricante, produto,
	unidade_medida, preco_compra, preco_venda )
VALUES (2,2, 'Café tradicional 500g', 'UN', 5.12, 7.48);

INSERT INTO produto.tb_produto(
	fk_id_categoria, fk_id_fabricante, produto,
	unidade_medida, preco_compra, preco_venda )
VALUES (3,3, 'Lã de aço', 'UN', 1.00, 1.75);

INSERT INTO produto.tb_produto(
	fk_id_categoria, fk_id_fabricante, produto,
	unidade_medida, preco_compra, preco_venda )
VALUES (4, 4, 'Creme dental 90g', 'UN', 2.05, 2.65);


-- Insert Fabricantes
INSERT INTO produto.tb_fabricante(fabricante, telefone, contato)
VALUES('Coca-cola', '11 5555-55555', 'Maria');

INSERT INTO produto.tb_fabricante(fabricante, telefone, contato)
VALUES('3 Corações', '11 4444-4444', 'João');

INSERT INTO produto.tb_fabricante(fabricante, telefone, contato)
VALUES('Bombril', '11 7777-7744', 'Alana');

INSERT INTO produto.tb_fabricante(fabricante, telefone, contato)
VALUES('Colgate', '11 2222-4411', 'Mauro');


-- Insert Movimentações
INSERT INTO estoque.tb_movimentacao (
	fk_id_produto, fk_id_estoque_produto, qtde_movimento, tipo_movimento
) VALUES (
	3,
	(SELECT id_estoque_produto FROM estoque.tb_estoque_produto WHERE fk_id_produto = 3),
	25,
	'entrada'
);

-- Insert Vendas
INSERT INTO venda.tb_venda (
	fk_id_produto, fk_id_estoque_produto, qtde_venda
) VALUES (
	3,
	(SELECT id_estoque_produto FROM estoque.tb_estoque_produto WHERE fk_id_produto = 3),
	5
);


