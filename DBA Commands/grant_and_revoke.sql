/*
===================================================================
						GRANT AND REVOKE
===================================================================
> Listar todos os usuários por cmd: \du ou \du+

> GRANT: 
 - são os privilégios(permissões) que um role(usuario) irá 
 receber possuir em um objeto(tabela, schema, etc).
 - Sintaxe para concender permissões:
 SELECT <privilegio(s)> ON <object) TO <role> WITH GRANT OPTION;
	---------------------------------
	| Privilegios  | Objects        |
	---------------------------------
	| select       | table          | 
	| insert       | view           |
	| update       | sequence       |
	| delete       | function       |
	| truncate     | schema         |
	| references   | database	    |
	| tirgger      | column         |
	| create       |                |
	| connect      |                |
	| execute      |                |
	| all          |                |
	| usage        |                |  
	---------------------------------

*/

-- Listando todos os bancos de dados
SELECT datname FROM pg_database;
-- Listando todos os usuarios
SELECT * FROM pg_catalog.pg_roles WHERE rolcanlogin = true;
SELECT * FROM pg_catalog.pg_user;
-- Onde os privilégios das roles estão armazenadas
-- Where the roles privileges are records
SELECT DISTINCT(grantor) FROM information_schema.table_privileges;
SELECT DISTINCT(grantee) FROM information_schema.table_privileges;


/* GRANT */
-- Concendento privilégios de conexão(connect) para um bando de dados específico.
GRANT connect ON database mercado_y TO gerald;
-- Concendendo privilégio de uso de um schema específico.
GRANT usage ON schema produto TO gerald;
-- Concendendo privilégios de execusão de instruções DML a uma tabela específica.
GRANT insert, update, delete ON produto.tb_fabricante TO gerald;
-- Concendendo privilégio de execusão de instrução DQL a uma tabela específica.
GRANT select ON produto.tb_fabricante TO gerald;


/* REVOKE */
-- Revoke all default privileges from a user
REVOKE ALL ON DATABASE postgres FROM PUBLIC;
REVOKE ALL ON DATABASE mercado_y FROM PUBLIC;
REVOKE ALL ON DATABASE db_ciri FROM PUBLIC;

-- Schemas
REVOKE ALL ON SCHEMA public FROM PUBLIC;

