-- =========================================================
-- SCRIPT: Verificando Anamalias nos dados da coluna "Year"
-- =========================================================

SELECT * FROM practice.tb_movies

/* Verificando se há valores nulos ou vazio */
SELECT DISTINCT year, count(*)
FROM practice.tb_movies
WHERE year IS NULL OR TRIM(year) = ''
GROUP BY year;
-- Resultdos: 644 valores nulo


/* Verificando se não há números */
SELECT year, COUNT(year)
FROM practice.tb_movies
WHERE year !~ '[0-9]'
GROUP BY year;
-- Resultado: 17 valores


/* Verificando de há anos menor que 1888 ou maior que 2025 */ 
SELECT 
	regexp_replace(year, '.*\(([0-9]{4})[-–]?.*', '\1') as new_year
FROM practice.tb_movies
WHERE (year ~ '[0-9]' AND regexp_replace(year, '.*\(([0-9]{4})[-–]?.*', '\1')::int < 1888)
		OR 
	  (year ~ '[0-9]' AND regexp_replace(year, '.*\(([0-9]{4})[-–]?.*', '\1')::int > 2025);
-- Resultado: Nenhum


/* Verificando se há caracteres especiais */
SELECT COUNT(year)
FROM practice.tb_movies
WHERE year ~ '[^A-Za-z0-9]';
-- Resultado: 9355 valores


/* Verificando se há filmes repetidos */
SELECT title, count(title) as total
FROM practice.tb_movies
WHERE year ~ '\([IVXLCDM]+\) \([0-9]{4}\)'
GROUP BY title
HAVING count(title)> 1;
-- Resultado: Há titles repetidos, porém são filmes diferentes.


-- =========================================
-- SCRIPT: Extrair start_year e end_year
-- =========================================

-- PASSO 1: Adicionar as novas colunas
-- =========================================
ALTER TABLE practice.tb_movies 
ADD COLUMN IF NOT EXISTS start_year VARCHAR(20),
ADD COLUMN IF NOT EXISTS end_year VARCHAR(20);

-- PASSO 2: Atualizar start_year e end_year
-- =========================================
UPDATE practice.tb_movies
SET
	start_year = COALESCE (
		CASE
			WHEN year !~* '[0-9]' THEN 'Unknown'
			ELSE REGEXP_REPLACE(year,'.*\(([0-9]{4})[-–]?.*', '\1')
		END, 'Unknown'
	),
	end_year = COALESCE(
		CASE 
	        WHEN year ~ '\([0-9]{4}[-–][[:space:]]*\)' THEN 'Currently'         -- casos tipo (2016– )
	        WHEN year ~ '\([0-9]{4}[-–][0-9]{4}\)' THEN REGEXP_REPLACE(year, '.*[-–]([0-9]{4})\).*', '\1')  -- (2016–2021)
	        WHEN year ~ '\([IVXLCDM]+\) \([0-9]{4}\)' THEN 'N/A'
	        WHEN year ~ '\([0-9]{4}\)' THEN 'N/A'               -- (2021)
	        ELSE 'Unknown'
	    END, 'Unknown'
	);


-- PASSO 3: Verificar os resultados
-- =========================================
SELECT title, year, start_year, end_year
FROM practice.tb_movies
WHERE year IS NOT NULL
ORDER BY 
    CASE WHEN end_year = 'Currently' THEN 0 ELSE 1 END,
    start_year DESC
LIMIT 50;



-- PASSO 4: Verificar casos específicos
-- =========================================
-- Em andamento (Currently)
SELECT title, year, start_year, end_year
FROM practice.tb_movies
WHERE end_year = 'N/A'
LIMIT 100;

-- Com intervalo de anos
SELECT title, year, start_year, end_year
FROM practice.tb_movies
WHERE start_year = end_year;

-- PASSO 5: Contar por tipo
-- =========================================
SELECT
	CASE
		WHEN end_year = 'Currently' THEN 'Em Andamento'
		WHEN end_year = 'N/A' THEN 'Mesmo ano (Filme)'
		ELSE 'Sem data'
	END AS tipo,
	COUNT(*) AS quantidade
FROM practice.tb_movies
GROUP BY tipo
ORDER BY quantidade DESC;

SELECT * FROM practice.tb_movies;
ALTER TABLE practice.tb_movies DROP COLUMN year;




