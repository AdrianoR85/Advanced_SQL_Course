insert into produto.tb_categoria(categoria)values('Bebiddas');
select * from produto.tb_categoria;

insert into produto.tb_fabricante(fabricante, telefone, contato)
values('Coca-Cola', '11 5555-4444', 'Maria');
select * from produto.tb_fabricante;

insert into produto.tb_produto
	(fk_id_categoria, fk_id_fabricante, produto, unidade_medida,
	preco_compra, preco_venda)
	values
	(3, 3, 'Refrigerante Coca-Cola 2,5L', 'UN',
	 4.10, 6.85);
select * from produto.tb_produto;
