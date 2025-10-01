TRUNCATE TABLE auditoria.tb_produto_log;
ALTER SEQUENCE auditoria.tb_produto_log_id_produto_log_seq RESTART WITH 1;

TRUNCATE TABLE estoque.tb_movimentacao;
ALTER SEQUENCE estoque.tb_movimentacao_id_movimentacao_seq RESTART WITH 1;

TRUNCATE TABLE venda.tb_venda;
ALTER SEQUENCE venda.tb_venda_id_venda_seq RESTART WITH 1;

TRUNCATE TABLE estoque.tb_estoque_produto CASCADE;
ALTER SEQUENCE estoque.tb_estoque_produto_id_estoque_produto_seq RESTART WITH 1;

TRUNCATE TABLE produto.tb_produto CASCADE;
ALTER SEQUENCE produto.tb_produto_id_produto_seq RESTART WITH 1;

TRUNCATE TABLE produto.tb_categoria CASCADE;
ALTER SEQUENCE produto.tb_categoria_id_categoria_seq RESTART WITH 1;

TRUNCATE TABLE produto.tb_fabricante CASCADE;
ALTER SEQUENCE produto.tb_fabricante_id_fabricante_seq RESTART WITH 1;
