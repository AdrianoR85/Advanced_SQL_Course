/* To Create a View
	CREATE VIEW <schema>.<view_name> AS
  Select <cols> FROM <schema><table_name>
*/

/* To Drop a View
	DROP VIEW <schema>.<view_name>
*/

/* To Rename a View
	ALTER VIEW <schema>.<view_name> RENAME TO <new_view_name>
*/

-- Stock Position
CREATE VIEW estoque.vw_posicao_estoque AS
SELECT 
	prod.id_produto,
	prod.produto,
	cat.categoria,
	fab.fabricante,
	prod.unidade_medida,
	prod.preco_compra,
	prod.preco_venda,
	estp.qtde_estoque
FROM estoque.tb_estoque_produto AS estp
LEFT JOIN produto.tb_produto prod ON estp.fk_id_produto = prod.id_produto
LEFT JOIN produto.tb_categoria cat ON prod.fk_id_categoria = cat.id_categoria
LEFT JOIN produto.tb_fabricante fab ON prod.fk_id_fabricante = fab.id_fabricante;

-- MATERIALIZED VIEW
/*
	CREATE MATERIALIZED VIEW <schema><view_name> AS ...
	ALTER MATERIALIZED VIEW <schema><view_name> RENAME TO <new_view_name>;
	DROP MATERIALIZED VIEW <schema><view_name>;
*/
CREATE MATERIALIZED VIEW produto.vwm_produto AS
SELECT 
	prod.produto,
	cat.categoria,
	fab.fabricante
FROM produto.tb_produto AS prod 
LEFT JOIN produto.tb_categoria cat ON prod.fk_id_categoria = cat.id_categoria
LEFT JOIN produto.tb_fabricante fab ON prod.fk_id_fabricante = fab.id_fabricante
WITH NO DATA;

REFRESH MATERIALIZED VIEW produto.vwm_produto;
