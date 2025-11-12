-- ====================================
-- PASSO 1: Criar tabela temporária com dados limpos
-- ====================================
DROP TABLE IF EXISTS temp_stars_cleaned;

CREATE TEMP TABLE temp_stars_cleaned AS
SELECT
	id,
	COALESCE(
		TRIM(
			regexp_replace(
				CASE
					-- Se tem TANTO Directors quanto Stars, pega a segunda parte (após |)
					WHEN director ~* 'Directors?:' AND director ~* 'Stars:' 
						THEN split_part(director, '|', 2)
					-- Se tem APENAS Stars (sem Directors), pega a primeira parte
					WHEN director ~* 'Stars:' AND  director !~* 'Directors?:'
						THEN split_part(director, '|', 1)
					-- Caso contrário, Unknown
					ELSE NULL
				END,
				'Stars:\s*', '', 'i' -- Remove "Stars:" e espaços após
			)
		), 
		'Unknown'
	) AS stars
FROM practice.tb_movies
ORDER BY id ASC;

-- ====================================
-- PASSO 2: Verificar os resultados
-- ====================================
-- Ver exemplos de cada tipo
SELECT
	id,
	director AS original,
	stars AS extraido,
	CASE
		WHEN director ~* 'Directors?:' AND director ~* 'Stars:' THEN 'Director + Stars'
		WHEN director !~* 'Directors?:' AND director ~* 'Stars:' THEN 'Apenas Stars'
		ELSE 'Sem Stars'
	END
FROM practice.tb_movies 
JOIN temp_stars_cleaned USING(id)
ORDER BY id ASC
LIMIT 203;

-- Contagem por tipo
SELECT 
    COUNT(*) AS total,
    COUNT(*) FILTER (WHERE stars = 'Unknown') AS unknown_count,
    COUNT(*) FILTER (WHERE stars != 'Unknown') AS with_stars_count
FROM temp_stars_cleaned;


-- ====================================
-- PASSO 3: Atualizar a tabela original
-- ====================================
-- Criar coluna se não existir
ALTER TABLE practice.tb_movies
ADD COLUMN IF NOT EXISTS stars TEXT;

-- Atualizar com base na tabela temporária
UPDATE practice.tb_movies m
SET stars = t.stars
FROM temp_stars_cleaned t
WHERE m.id = t.id;

-- ====================================
-- PASSO 4: Validar resultado final
-- ====================================
SELECT 
	id,
	director,
	stars,
	CASE
		WHEN director ~* 'Directors?:' AND director ~* 'Stars:' THEN 'Directors + Stars'
		WHEN director ~* 'Stars:' AND director !~* 'Directors?:' THEN 'Apenas Stars'
		ELSE 'Sem Stars'
	END AS tipo
FROM practice.tb_movies
ORDER BY tipo, id




