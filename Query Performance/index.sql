-------------------------(Postgres)---------------------------

-------------------  How to create a INDEX ------------------- 
CREATE INDEX idx_custumer_name
ON customer( first_name, last_name );

------------------- How to view the INDEX ------------------- 
-- View the indexes of a specific table
SELECT indexname, indexdef
FROM pg_indexes
WHERE tablename = 'nome_da_tabela'; -- -> Replace 'table_name' with the name of your table.

-- View all indexes of a database (with table names)
SELECT
  tab.relname AS tabela,
  idx.relname AS indice,
  am.amname AS tipo,
  i.indisunique AS unico,
  i.indisprimary AS primario
FROM
  pg_class tab,
  pg_class idx,
  pg_index i,
  pg_am am
WHERE
  tab.oid = i.indrelid
  AND idx.oid = i.indexrelid
  AND idx.relam = am.oid
  AND tab.relkind = 'r'
ORDER BY tab.relname, idx.relname;

-- View indexes with detailed columns
SELECT
  t.relname AS tabela,
  i.relname AS indice,
  a.attname AS coluna
FROM
  pg_class t,
  pg_class i,
  pg_index ix,
  pg_attribute a
WHERE
  t.oid = ix.indrelid
  AND i.oid = ix.indexrelid
  AND a.attrelid = t.oid
  AND a.attnum = ANY(ix.indkey)
  AND t.relname = 'nome_da_tabela'; -- -> Replace 'table_name' with the name of your table.
