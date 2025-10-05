-- Índices não custerizados (B-Tree)
-- CREATE INDEX <index.name> ON <table_name> USING <index_method>(<column>)
CREATE INDEX idx_cliente_nome ON cliente.tb_cliente USING btree(nome);
CREATE INDEX idx_cliente_email ON cliente.tb_cliente USING btree(email);

-- Restrições
CREATE UNIQUE INDEX idx_cliente_email ON cliente.tb_cliente USING btree(email);

-- Índices Multicolunas
CREATE UNIQUE INDEX idx_cliente_nome_email_idade ON cliente.tb_cliente USING btree(nome,email,idade);

-- Índices parciais
CREATE INDEX idx_cliente_idade ON cliente.tb_cliente USING btree(idade) WHERE idade BETWEEN 15 AND 40;

-- Índices de modo concorrentes;
CREATE INDEX CONCURRENTLY idx_cliente_nome_sobrenome ON cliente.tb_cliente USING btree(nome, sobrenome);

-- Drop - Deletando indexes
DROP INDEX cliente.idx_cliente_email;
