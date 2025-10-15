/*
===================================================================
						GRANT AND REVOKE
===================================================================
> Listar todos os usuários por cmd: \du ou \du+

> GRANT: 
 - são os privilégios(permissões) que um role(usuario) irá 
 receber possuir em um objeto(tabela, schema, etc).
 - Sintaxe para concender permissões:
 GRANT <privilegio(s)> ON <object) TO <role> WITH GRANT OPTION;
> REVOKE:
 - Remove permissões
 - Sintaxe:
 REVOKE <privilegio(s)> ON <objeto(s)> FROM <role>
 
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
-- Concendendo privilégio DML e DQL para todas as tabelas dentro de um schema específico.
GRANT insert, update, delete, select ON all tables in schema produto TO gerald;
GRANT all privileges ON all tables in schema produto TO gerald;
-- Conceder permissões
GRANT all privileges ON all tables in schema produto TO gerald WITH GRANT OPTION;

/* ENTENDENDO TODOS OS SCHEMAS INFORMATIONS */

-- Listar todas as tabelas do schema_informations
SELECT * FROM information_schema.tables
WHERE 
	table_schema = 'information_schema' AND 
	(table_name LIKE '%privileges%' OR table_name LIKE '%grant%');
-- role_column_grants
-- column_privileges

-- table_privileges
-- role_table_grants

-- prefixo role - não existe privilegios herdados do beneficiario public
SELECT * FROM information_schema.column_privileges WHERE grantee = 'gerald';
SELECT * FROM information_schema.table_privileges WHERE grantee = 'gerald';


/* REVOKE */

-- Revogando priviglégios DML e DQL para uma tabela e schema especifico.
REVOKE insert, update, delete, select ON produto.tb_fabricante FROM gerald;
-- Revongando priviglégios DML e DQL para todas as tabales dentro de um schema especifico.
REVOKE insert, update, delete, select ON all tables in schema produto FROM gerald;
-- Revogando todos os privilégios dentro de um schema.
REVOKE all privileges ON schema produto FROM gerald;
-- Revogando o privilégio de uso de um schema especifico.
REVOKE usage ON schema produto FROM gerald;
-- Revogar todos os privilégios de um role.
REVOKE all privileges ON database mercado_y FROM gerald;
REVOKE all privileges ON database postgres FROM gerald;
REVOKE all privileges ON database db_ciri FROM gerald;
-- Revogando todos os privilégios de conexão de um banco de dados específico.
REVOKE connect ON database mercado_y FROM gerald; 
REVOKE connect ON database postgres FROM gerald; 
REVOKE connect ON database db_ciri FROM gerald; 

-- Revoke all default privileges from a user
REVOKE ALL ON DATABASE postgres FROM PUBLIC;
REVOKE ALL ON DATABASE mercado_y FROM PUBLIC;
REVOKE ALL ON DATABASE db_ciri FROM PUBLIC;

-- Schemas
REVOKE ALL ON SCHEMA public FROM PUBLIC;

/* ======================================================================================== */


/* Grupo*/
CREATE ROLE aplicacao;
CREATE ROLE dba createdb createrole;
/*Usuarios*/
CREATE ROLE site LOGIN PASSWORD '123456';
CREATE ROLE app LOGIN PASSWORD '123456';

-- Privilégio de conexão ao bando de dados;
GRANT connect ON database mercado_y TO aplicacao;
-- Privilégio de uso dos schemas
GRANT usage ON schema produto TO aplicacao;
GRANT usage ON schema estoque TO aplicacao;
GRANT usage ON schema venda TO aplicacao;
GRANT usage ON schema auditoria TO aplicacao;
GRANT usage ON schema cliente TO aplicacao;
-- Privilégios DML e DQL para tabelas 
GRANT insert, update, delete, select ON produto.tb_fabricante TO aplicacao;
GRANT insert, select ON auditoria.tb_produto_log TO aplicacao;

/* Inclusão de role (login) em role (grupo) */
GRANT aplicacao TO site;
GRANT aplicacao TO app;
