REATE TABLE produto.tb_produto (
	id_produto serial PRIMARY KEY,
	fk_id_categoria serial,
	fk_id_fabricante serial,
	produto varchar(50) not null,
	unidade_medida char(3) not null,
	preco_compra numeric(10,2) not null,
	preco_venda numeric(10,2) not null
);

CREATE TABLE produto.tb_fabricante (
	id_fabricante serial PRIMARY KEY,
	fabricante varchar(100) not null,
	telefone varchar(17),
	contato varchar(30)
);

CREATE TABLE produto.tb_categoria (
	id_categoria serial PRIMARY KEY,
	categoria varchar(30) not null
);

CREATE TABLE auditoria.tb_produto_log (
	id_produto_log serial PRIMARY KEY,
	id_produto int,
	id_categoria_new int,
	id_categoria_old int,
	id_fabricante_new int,
	id_fabricante_old int,
	produto_new varchar(50),
	produto_old varchar(50),
	preco_compra_new numeric(10,2),
	preco_compra_old numeric(10,2),
	preco_venda_new numeric(10,2),
	preco_venda_old numeric(10,2),
	data_evento timestamp default current_timestamp not null,
	evento varchar(6) constraint chk_evento check(evento in ('insert', 'update'))
	
);

CREATE TABLE estoque.tb_estoque_produto (
	id_estoque_produto serial PRIMARY KEY,
	fk_id_produto serial,
	qtde_estoque int not null default 0
);

CREATE TABLE estoque.tb_movimentacao (
	id_movimentacao serial PRIMARY KEY,
	fk_id_produto serial,
	fk_id_estoque_produto serial,
	qtde_movimento int,
	tipo_movimento varchar(7)
);	

CREATE TABLE venda.tb_venda (
	id_venda serial PRIMARY KEY,
	fk_id_produto serial,
	fk_id_estoque_produto serial,
	qtde_venda int not null
);
