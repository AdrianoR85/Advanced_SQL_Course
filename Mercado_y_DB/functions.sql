-- Function without returns (void), language slq
CREATE FUNCTION produto.func_test_void_sql()
RETURNS void AS
$body$
	INSERT INTO produto.tb_categoria(categoria) VALUES('Mercearia');
$body$
LANGUAGE sql;

SELECT * FROM produto.tb_categoria;
select produto.func_test_void_sql();

-- Function without returns (void), language plpgslq, with parameters
CREATE OR REPLACE FUNCTION produto.func_test_void_plpgsql(p_categoria VARCHAR(30))
RETURNS void AS
$body$
BEGIN
	INSERT INTO produto.tb_categoria(categoria) VALUES(p_categoria);
END
$body$
LANGUAGE plpgsql;

SELECT produto.func_test_void_plpgsql('Limpeza');
SELECT produto.func_test_void_plpgsql('Higiene e Perfumaria');
SELECT * FROM produto.tb_categoria;

-- Function with returns (void), language plpgslq, with parameters
CREATE OR REPLACE FUNCTION produto.func_test_return_plpgsql()
RETURNS int AS
$body$
DECLARE
	v_total INT;
BEGIN
	SELECT COUNT(*) INTO v_total FROM produto.tb_categoria;

	RETURN v_total;
END
$body$
LANGUAGE plpgsql;

SELECT produto.func_test_return_plpgsql();
