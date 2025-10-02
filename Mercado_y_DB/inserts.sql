/* Insert - Inserindo registros de categorias */
insert into produto.tb_categoria(categoria)values('Mercearia');
insert into produto.tb_categoria(categoria)values('Bebidas');
insert into produto.tb_categoria(categoria)values('Frios e Laticícios');
insert into produto.tb_categoria(categoria)values('Congelados');
insert into produto.tb_categoria(categoria)values('Carnes, Aves e Peixes');
insert into produto.tb_categoria(categoria)values('Limpeza');
insert into produto.tb_categoria(categoria)values('Higiene e Perfumaria');
insert into produto.tb_categoria(categoria)values('Bebê');
insert into produto.tb_categoria(categoria)values('Bomboniere');
insert into produto.tb_categoria(categoria)values('Pães e Bolos');
insert into produto.tb_categoria(categoria)values('Hortifruti');
insert into produto.tb_categoria(categoria)values('Bazar');
insert into produto.tb_categoria(categoria)values('Pet Shop');

/* Insert - Inserindo registros de fabricantes */
insert into produto.tb_fabricante(fabricante, telefone, contato)values('Bauducco', '11 3333-3333', 'Sara');
insert into produto.tb_fabricante(fabricante, telefone, contato)values('Coca-Cola', '11 5555-4444', 'Maria');
insert into produto.tb_fabricante(fabricante, telefone, contato)values('Danone', '11 1111-1111', 'Roberto');
insert into produto.tb_fabricante(fabricante, telefone, contato)values('Seara', '11 2222-2222', 'Suzana');
insert into produto.tb_fabricante(fabricante, telefone, contato)values('Aurora', '11 6666-6666', 'Gustavo');
insert into produto.tb_fabricante(fabricante, telefone, contato)values('Bombril', '11 7777-7744', 'Alana');
insert into produto.tb_fabricante(fabricante, telefone, contato)values('Colgate', '11 2222-4411', 'Mauro');
insert into produto.tb_fabricante(fabricante, telefone, contato)values('Huggies', '11 1111-1144', 'Júlia');
insert into produto.tb_fabricante(fabricante, telefone, contato)values('Nestlé', '11 9999-9999', 'Thiago');
insert into produto.tb_fabricante(fabricante, telefone, contato)values('Pullman', '11 7799-9988', 'Fernanda');
insert into produto.tb_fabricante(fabricante, telefone, contato)values('FLV', '11 9977-7788', 'Roberto');
insert into produto.tb_fabricante(fabricante, telefone, contato)values('Tramontina', '11 8888-7788', 'Michele');
insert into produto.tb_fabricante(fabricante, telefone, contato)values('Pedigree', '11 3333-2121', 'Rubens');

/* Insert - Inserindo registros de produtos */
insert into produto.tb_produto(fk_id_categoria, fk_id_fabricante, produto, unidade_medida, preco_compra, preco_venda)values(1 , 1, 'Pão de Mel Bauducco 30g', 'UN', 0.55, 0.89);
insert into produto.tb_produto(fk_id_categoria, fk_id_fabricante, produto, unidade_medida, preco_compra, preco_venda)values(2 , 2, 'Refrigerante Coca-Cola 2l', 'UN', 3.95, 6.35);
insert into produto.tb_produto(fk_id_categoria, fk_id_fabricante, produto, unidade_medida, preco_compra, preco_venda)values(3, 3, 'Iogurte Sabor Multifrutas Danoninho 320g', 'UN', 4.02, 6.68);
insert into produto.tb_produto(fk_id_categoria, fk_id_fabricante, produto, unidade_medida, preco_compra, preco_venda)values(4, 4, 'Lasanha Presunto e Queijo 600g', 'UN', 6.35, 9.48);
insert into produto.tb_produto(fk_id_categoria, fk_id_fabricante, produto, unidade_medida, preco_compra, preco_venda)values(5, 5, 'Bacon Fatiado 250g', 'UN', 6.77, 9.98);
insert into produto.tb_produto(fk_id_categoria, fk_id_fabricante, produto, unidade_medida, preco_compra, preco_venda)values(6, 6, 'lã de aço', 'UN', 1.00, 1.75);
insert into produto.tb_produto(fk_id_categoria, fk_id_fabricante, produto, unidade_medida, preco_compra, preco_venda)values(7, 7, 'Creme dental 90g', 'UN', 2.05, 2.65);
insert into produto.tb_produto(fk_id_categoria, fk_id_fabricante, produto, unidade_medida, preco_compra, preco_venda)values(8, 8, 'Fralda Supreme Hiper XXG 52un', 'UN', 49.68, 65.80);
insert into produto.tb_produto(fk_id_categoria, fk_id_fabricante, produto, unidade_medida, preco_compra, preco_venda)values(9, 9, 'Chocolate Kit Kat 41,5g', 'UN', 1.12, 1.99);
insert into produto.tb_produto(fk_id_categoria, fk_id_fabricante, produto, unidade_medida, preco_compra, preco_venda)values(10, 10, 'Bisnaguito Pullman 300g', 'UN', 3.72, 4.98);
insert into produto.tb_produto(fk_id_categoria, fk_id_fabricante, produto, unidade_medida, preco_compra, preco_venda)values(11, 11, 'Ovos extra branco 20un', 'UN', 6.35, 7.89);
insert into produto.tb_produto(fk_id_categoria, fk_id_fabricante, produto, unidade_medida, preco_compra, preco_venda)values(12, 12, 'Frigideira Antiaderente', 'UN', 19.50, 25.50);
insert into produto.tb_produto(fk_id_categoria, fk_id_fabricante, produto, unidade_medida, preco_compra, preco_venda)values(13, 13, 'Alimento para cães - Raças pequenas 100g', 'UN', 1.33, 2.09);

/* Update - Atualizando registros de produtos */
update produto.tb_produto set preco_compra = 6.44, preco_venda = 9.77 where id_produto = 5;
update produto.tb_produto set preco_compra = 6.57, preco_venda = 8.00 where id_produto = 11;
update produto.tb_produto set preco_compra = 2.10, preco_venda = 2.75 where id_produto = 7;
update produto.tb_produto set preco_compra = 1.44, preco_venda = 2.19 where id_produto = 13;

/* Insert - Inserindo registros de movimentos de entrada */
insert into estoque.tb_movimentacao(fk_id_produto, fk_id_estoque_produto, qtde_movimento, tipo_movimento)values(1, 1, 200, 'entrada');
insert into estoque.tb_movimentacao(fk_id_produto, fk_id_estoque_produto, qtde_movimento, tipo_movimento)values(1, 1, 200, 'entrada');
insert into estoque.tb_movimentacao(fk_id_produto, fk_id_estoque_produto, qtde_movimento, tipo_movimento)values(1, 1, 200, 'entrada');
insert into estoque.tb_movimentacao(fk_id_produto, fk_id_estoque_produto, qtde_movimento, tipo_movimento)values(1, 1, 200, 'entrada');
insert into estoque.tb_movimentacao(fk_id_produto, fk_id_estoque_produto, qtde_movimento, tipo_movimento)values(1, 1, 200, 'entrada');
insert into estoque.tb_movimentacao(fk_id_produto, fk_id_estoque_produto, qtde_movimento, tipo_movimento)values(1, 1, 200, 'entrada');
insert into estoque.tb_movimentacao(fk_id_produto, fk_id_estoque_produto, qtde_movimento, tipo_movimento)values(1, 1, 200, 'entrada');
insert into estoque.tb_movimentacao(fk_id_produto, fk_id_estoque_produto, qtde_movimento, tipo_movimento)values(1, 1, 200, 'entrada');
insert into estoque.tb_movimentacao(fk_id_produto, fk_id_estoque_produto, qtde_movimento, tipo_movimento)values(1, 1, 200, 'entrada');
insert into estoque.tb_movimentacao(fk_id_produto, fk_id_estoque_produto, qtde_movimento, tipo_movimento)values(9, 9, 100, 'entrada');
insert into estoque.tb_movimentacao(fk_id_produto, fk_id_estoque_produto, qtde_movimento, tipo_movimento)values(2, 2, 450, 'entrada');
insert into estoque.tb_movimentacao(fk_id_produto, fk_id_estoque_produto, qtde_movimento, tipo_movimento)values(7, 7, 600, 'entrada');
insert into estoque.tb_movimentacao(fk_id_produto, fk_id_estoque_produto, qtde_movimento, tipo_movimento)values(4, 4, 57, 'entrada');
insert into estoque.tb_movimentacao(fk_id_produto, fk_id_estoque_produto, qtde_movimento, tipo_movimento)values(5, 5, 180, 'entrada');
insert into estoque.tb_movimentacao(fk_id_produto, fk_id_estoque_produto, qtde_movimento, tipo_movimento)values(6, 6, 220, 'entrada');
insert into estoque.tb_movimentacao(fk_id_produto, fk_id_estoque_produto, qtde_movimento, tipo_movimento)values(3, 3, 275, 'entrada');
insert into estoque.tb_movimentacao(fk_id_produto, fk_id_estoque_produto, qtde_movimento, tipo_movimento)values(13, 13, 200, 'entrada');
insert into estoque.tb_movimentacao(fk_id_produto, fk_id_estoque_produto, qtde_movimento, tipo_movimento)values(8, 8, 310, 'entrada');
insert into estoque.tb_movimentacao(fk_id_produto, fk_id_estoque_produto, qtde_movimento, tipo_movimento)values(10, 10, 120, 'entrada');
insert into estoque.tb_movimentacao(fk_id_produto, fk_id_estoque_produto, qtde_movimento, tipo_movimento)values(11, 11, 200, 'entrada');
insert into estoque.tb_movimentacao(fk_id_produto, fk_id_estoque_produto, qtde_movimento, tipo_movimento)values(12, 12, 170, 'entrada');
insert into estoque.tb_movimentacao(fk_id_produto, fk_id_estoque_produto, qtde_movimento, tipo_movimento)values(1, 1, 55, 'entrada');
insert into estoque.tb_movimentacao(fk_id_produto, fk_id_estoque_produto, qtde_movimento, tipo_movimento)values(7, 7, 10, 'entrada');
insert into estoque.tb_movimentacao(fk_id_produto, fk_id_estoque_produto, qtde_movimento, tipo_movimento)values(3, 3, 100, 'entrada');
insert into estoque.tb_movimentacao(fk_id_produto, fk_id_estoque_produto, qtde_movimento, tipo_movimento)values(9, 9, 25, 'entrada');
insert into estoque.tb_movimentacao(fk_id_produto, fk_id_estoque_produto, qtde_movimento, tipo_movimento)values(2, 2, 72, 'entrada');
insert into estoque.tb_movimentacao(fk_id_produto, fk_id_estoque_produto, qtde_movimento, tipo_movimento)values(6, 6, 111, 'entrada');


/* Insert - Inserindo registros de vendas */
insert into venda.tb_venda(fk_id_produto, fk_id_estoque_produto, qtde_venda)values(1, 1, 12);
insert into venda.tb_venda(fk_id_produto, fk_id_estoque_produto, qtde_venda)values(1, 1, 4);
insert into venda.tb_venda(fk_id_produto, fk_id_estoque_produto, qtde_venda)values(1, 1, 14);
insert into venda.tb_venda(fk_id_produto, fk_id_estoque_produto, qtde_venda)values(1, 1, 25);
insert into venda.tb_venda(fk_id_produto, fk_id_estoque_produto, qtde_venda)values(1, 1, 16);
insert into venda.tb_venda(fk_id_produto, fk_id_estoque_produto, qtde_venda)values(2, 2, 111);
insert into venda.tb_venda(fk_id_produto, fk_id_estoque_produto, qtde_venda)values(2, 2, 13);
insert into venda.tb_venda(fk_id_produto, fk_id_estoque_produto, qtde_venda)values(2, 2, 45);
insert into venda.tb_venda(fk_id_produto, fk_id_estoque_produto, qtde_venda)values(2, 2, 110);
insert into venda.tb_venda(fk_id_produto, fk_id_estoque_produto, qtde_venda)values(3, 3, 50);
insert into venda.tb_venda(fk_id_produto, fk_id_estoque_produto, qtde_venda)values(3, 3, 45);
insert into venda.tb_venda(fk_id_produto, fk_id_estoque_produto, qtde_venda)values(3, 3, 10);
insert into venda.tb_venda(fk_id_produto, fk_id_estoque_produto, qtde_venda)values(3, 3, 11);
insert into venda.tb_venda(fk_id_produto, fk_id_estoque_produto, qtde_venda)values(4, 4, 3);
insert into venda.tb_venda(fk_id_produto, fk_id_estoque_produto, qtde_venda)values(4, 4, 18);
insert into venda.tb_venda(fk_id_produto, fk_id_estoque_produto, qtde_venda)values(4, 4, 10);
insert into venda.tb_venda(fk_id_produto, fk_id_estoque_produto, qtde_venda)values(5, 5, 22);
insert into venda.tb_venda(fk_id_produto, fk_id_estoque_produto, qtde_venda)values(5, 5, 9);
insert into venda.tb_venda(fk_id_produto, fk_id_estoque_produto, qtde_venda)values(5, 5, 27);
insert into venda.tb_venda(fk_id_produto, fk_id_estoque_produto, qtde_venda)values(6, 6, 32);
insert into venda.tb_venda(fk_id_produto, fk_id_estoque_produto, qtde_venda)values(6, 6, 47);
insert into venda.tb_venda(fk_id_produto, fk_id_estoque_produto, qtde_venda)values(6, 6, 11);
insert into venda.tb_venda(fk_id_produto, fk_id_estoque_produto, qtde_venda)values(6, 6, 2);
insert into venda.tb_venda(fk_id_produto, fk_id_estoque_produto, qtde_venda)values(7, 7, 150);
insert into venda.tb_venda(fk_id_produto, fk_id_estoque_produto, qtde_venda)values(7, 7, 122);
insert into venda.tb_venda(fk_id_produto, fk_id_estoque_produto, qtde_venda)values(7, 7, 10);
insert into venda.tb_venda(fk_id_produto, fk_id_estoque_produto, qtde_venda)values(8, 8, 33);
insert into venda.tb_venda(fk_id_produto, fk_id_estoque_produto, qtde_venda)values(8, 8, 49);
insert into venda.tb_venda(fk_id_produto, fk_id_estoque_produto, qtde_venda)values(8, 8, 111);
insert into venda.tb_venda(fk_id_produto, fk_id_estoque_produto, qtde_venda)values(10, 10, 60);
insert into venda.tb_venda(fk_id_produto, fk_id_estoque_produto, qtde_venda)values(13, 13, 10);
insert into venda.tb_venda(fk_id_produto, fk_id_estoque_produto, qtde_venda)values(13, 13, 12);

