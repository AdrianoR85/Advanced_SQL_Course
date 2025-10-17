/*
=====================================
       EXTENSÕES (ADD-ONS)
=====================================
*/

-- Listando as extensões disponiveis no patoce contrib.
SELECT * FROM pg_catalog.pg_available_extensions;
-- Visualização detalhada
SELECT * FROM pg_catalog.pg_extension;
SELECT * FROM pg_catalog.pg_namespace WHERE oid = 11;
SELECT * FROM pg_catalog.pg_namespace WHERE oid = 2200;
SELECT * FROM pg_catalog.pg_namespace WHERE oid = 16468;

-- Instalar as extensões
CREATE EXTENSION pgcrypto;
CREATE EXTENSION btree_gin schema produto;

-- Desistanlando as extensões
DROP EXTENSION pgcrypto;
DROP EXTENSION btree_gin;

