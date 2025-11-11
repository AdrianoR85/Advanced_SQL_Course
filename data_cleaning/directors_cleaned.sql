-- ====================================
-- PASSO 1: Criar tabela temporária com dados limpos
-- ====================================
DROP TABLE IF EXISTS temp_directors_cleaned;

CREATE TEMP TABLE temp_directors_cleaned AS
SELECT 
    id,
    CASE
        -- Se a primeira parte NÃO contém "Stars", limpa o "Director:"
        WHEN split_part(director, '|', 1) NOT LIKE '%Stars%' THEN
            COALESCE(
                TRIM(NULLIF(
                    regexp_replace( split_part(director, '|', 1), 'Directors?:\s*', '', 'i' ), '' )), 'Unknown' ) 
        -- Caso contrário, marca como "Unknown"
        ELSE 'Unknown'
    END AS directors_cleaned
FROM practice.tb_movies
ORDER BY id ASC;

-- ====================================
-- PASSO 2: Verificar os resultados
-- ====================================
-- Ver todos os registros limpos
SELECT * FROM temp_directors_cleaned LIMIT 50;

-- Ver apenas os que serão "Unknown"
SELECT * FROM temp_directors_cleaned WHERE directors = 'Unknown';

-- Ver apenas os que têm diretor
SELECT * FROM temp_directors_cleaned WHERE directors != 'Unknown';

SELECT 
    COUNT(*) AS total,
    COUNT(*) FILTER (WHERE directors = 'Unknown') AS unknown_count,
    COUNT(*) FILTER (WHERE directors != 'Unknown') AS with_director_count
FROM temp_directors_cleaned;

-- ====================================
-- PASSO 3: Atualizar a tabela original (só depois de verificar!)
-- ====================================
-- Primeiro, alterar o tipo da coluna se necessário
ALTER TABLE practice.tb_movies ADD COLUMN director_cleaned TEXT;

-- Atualizar com base na tabela temporária
UPDATE practice.tb_movies m
SET director_cleaned = t.directors
FROM temp_directors_cleaned t
WHERE m.id = t.id;

-- ====================================
-- PASSO 4: Verificar resultado final
-- ====================================
SELECT * FROM practice.tb_movies ORDER BY id ASC LIMIT 50;

-- Limpar tabela temporária (opcional, ela é limpa automaticamente ao fim da sessão)
DROP TABLE temp_directors_cleaned;
