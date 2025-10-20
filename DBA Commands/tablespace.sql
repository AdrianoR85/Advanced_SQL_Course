/* 

========================================================
					Tablespaces
========================================================
A tablespace is a storage location on the file system 
where the database stores data files 
(such as tables, indexes, and materialized views).

## Why Tablespaces Exist
By default, all database files are stored in PostgreSQL’s 
main data directory (usually something like /var/lib/postgresql/data).
However, with tablespaces, you can:
	> Store data on different disks or partitions — for performance or capacity reasons.
	> Separate frequently accessed (hot) data from rarely accessed (cold) data.
    > Use different types of storage media (e.g., SSD for indexes, HDD for archives).

## Sumarize:
|-------------------------------------------------------------------------------------|
|      Concept	     |                    Description                                 |
| ------------------ | ---------------------------------------------------------------|
| Definition         | A location on disk for storing database objects                |
| Purpose	         | Manae data placement for performance, storage, or organization | 
| Created With       | CREATE TABLESPACE                                              | 
| Used By	         | Databases, tables, and indexes                                 | 
| Default Tablespace | pg_default (inside the main data directory)                    |
|-------------------------------------------------------------------------------------|
*/

-- Show the directory
SELECT * FROM pg_catalog.pg_settings WHERE name = 'data_directory';

-- Listing the tablespaces
SELECT * FROM pg_catalog.pg_tablespace;

-- Listing a database relationship and their respective tablespace
SELECT 
	d.datname,
	t.spcname
FROM pg_catalog.pg_database AS d
LEFT JOIN pg_catalog.pg_tablespace AS t ON d.dattablespace = t.oid;

-- Listing the tables and their namespaces
SELECT schemaname, tablename, tablespace FROM pg_catalog.pg_tables;

/* CREATE */ 

-- A new tablespace
CREATE TABLESPACE repositorio1 LOCATION '/var/lib/postgresql/tablespaces/repositorio1';
-- create a database associated with specific tablespace
CREATE DATABASE db_1 TABLESPACE repositorio1;
-- create tables associated whith specific tablespace
CREATE TABLE tb_nome_tabela (
	id SERIAL PRIMARY KEY,
	teste VARCHAR(40)
) TABLESPACE repositorio1;

/* REMOVER */
DROP TABLESPACE repositorio1;
