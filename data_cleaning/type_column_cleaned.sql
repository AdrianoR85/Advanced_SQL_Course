-- ===========================================
-- Classificando por filmes ou séries
-- Baseando no end_year
-- ===========================================

-- Criando a coluna type
-- ===========================================
ALTER TABLE practice.tb_movies 
ADD COLUMN type VARCHAR(10);

-- Atualizando a coluna com o tipo do conteúdo
-- ===========================================
UPDATE practice.tb_movies 
SET type =
	CASE
		WHEN end_year ~* '[0-9]' OR end_year = 'Currently' THEN 'Series'
		WHEN end_year = 'N/A' THEN 'Movies'
		ELSE 'Unkown'
	END;


-- Verificando o resultando
-- ===========================================
SELECT title, start_year, end_year, type
FROM practice.tb_movies;

-- Verificando quantidade por type de conteúdo
-- ===========================================
SELECT 
    SUM(CASE WHEN type = 'Movies' THEN 1 ELSE 0 END) AS movie_count,
    SUM(CASE WHEN type = 'Series' THEN 1 ELSE 0 END) AS series_count,
    SUM(CASE WHEN type = 'Unknown' THEN 1 ELSE 0 END) AS unknown_count,
    COUNT(*) AS total
FROM practice.tb_movies;
