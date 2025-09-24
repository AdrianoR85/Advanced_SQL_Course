/*
===========================================================
 PostgreSQL Table Inheritance (INHERITS)
===========================================================

In PostgreSQL, table inheritance allows a table (CHILD) to 
automatically inherit the structure (columns and constraints) 
from another table (PARENT).

Key points:
- Changes made in the PARENT table (e.g., adding a column) 
  are automatically reflected in the CHILD table.
- Inserts, updates, and deletes in the CHILD table also 
  affect the PARENT table, and vice versa.
- It provides a way to create a hierarchy of tables with 
  shared columns and constraints.

This script demonstrates how inheritance works in practice:
1. Creating a PARENT table (tb_pessoas).
2. Creating a CHILD table (tb_funcionario) using INHERITS.
3. Showing how inserts, updates, and deletes propagate 
   between PARENT and CHILD tables.

===========================================================
*/

CREATE SCHEMA tabelas_avancadas;
-- Parent table
CREATE TABLE tabelas_avancadas.tb_pessoas (
	id_pessoa SERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	idade INT,
	sexo CHAR(1) CONSTRAINT chk_sexo CHECK(sexo in ('M', 'F'))
);

-- Child table.
CREATE TABLE tabelas_avancadas.tb_funcionario (
	id_funcionario SERIAL PRIMARY KEY,
	matricula VARCHAR(20) NOT NULL,
	departamento VARCHAR(50) NOT NULL
) INHERITS (tabelas_avancadas.tb_pessoas);

-- Change made in the PARENT table will be reflected in the CHILD table.
ALTER TABLE tabelas_avancadas.tb_pessoas  ADD COLUMN apelido VARCHAR(15);

-- Inserts made in the CHILD table will also be inserted into the PARENTE table.
INSERT INTO tabelas_avancadas.tb_pessoas (nome, idade, sexo,apelido) 
VALUES ('Maria', 27, 'F', 'Mari');

INSERT INTO tabelas_avancadas.tb_funcionario (nome, idade, sexo,apelido, matricula,departamento) 
VALUES ('João', 35, 'M', 'Joãozinho', 'xyz123', 'Contabilidade');

INSERT INTO tabelas_avancadas.tb_funcionario (nome, idade, sexo,apelido, matricula,departamento) 
VALUES ('Rosana', 20, 'F', 'Ro', '123abc', 'Administrativo');

-- Updates made in CHILD table also affect the PARENT table, and vice versa. 
UPDATE tabelas_avancadas.tb_funcionario SET idade = 45 where id_funcionario = 1;
UPDATE tabelas_avancadas.tb_pessoas SET nome = 'João da Silva' where id_pessoa = 2;

-- Deletes made in CHILD table also affect the PARENT table, and vice versa. 
DELETE FROM tabelas_avancadas.tb_funcionario WHERE id_funcionario = 1;
DELETE FROM tabelas_avancadas.tb_pessoas WHERE id_pessoa = 3;

SELECT * FROM tabelas_avancadas.tb_pessoas;
SELECT * FROM tabelas_avancadas.tb_funcionario;


