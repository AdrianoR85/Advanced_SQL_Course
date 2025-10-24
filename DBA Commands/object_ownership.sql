/*
=====================================================
		SECURITY - Object Ownership (Owner)
=====================================================

Everthing in PostgreSQL database is an object, and 
each object has a role that is owns it.

Each object is owned by a specific role (user), which
determines who has full control over it. The owner of an
object can modify its structure, grant privileges to other
roles, or transfer ownership when needed.

Understanding object ownership is essential for managing
permissions and maintaining proper security within the
database.
*/

-----------------------------------------------------------------------------------

/*  How to identify an object owner 
Listing owner: database, schemas, tables. 
*/
-- database owner
SELECT datname, pg_get_userbyid(datdba) AS "owner" FROM pg_catalog.pg_database;
-- schema owner
SELECT schema_name, schema_owner FROM information_schema.schemata;
-- table owner
SELECT tablename, tableowner FROM pg_catalog.pg_tables;
-- trigger owner
SELECT 
	t.tgname AS "trigger_name",
	c.relname AS "table_name",
	pg_get_userbyid(c.relowner) AS "table_owner"
FROM pg_trigger t
JOIN pg_class c ON t.tgrelid = c.oid
JOIN pg_namespace n ON c.relnamespace = n.oid
WHERE NOT t.tgisinternal
ORDER BY table_owner, table_name, trigger_name;

----------------------------------------------------------
SELECT * FROM pg_roles;
CREATE database bd_teste_1 owner bianca;

/* Changing the owner of an object */
ALTER DATABASE bd_teste_1 OWNER TO pedro;
ALTER SCHEMA schema_teste OWNER TO pedro;
ALTER TABLE schema_teste.tb_teste1 OWNER TO pedro

/* Transferring ownership of objects */
GRANT pedro TO adriano;
REASSIGN OWNED BY pedro TO adriano; 
