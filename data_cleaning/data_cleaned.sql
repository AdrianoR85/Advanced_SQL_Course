CREATE OR REPLACE VIEW silver.vw_movies_clean AS
SELECT
    id,
    INITCAP(TRIM(REGEXP_REPLACE(title, '^''|''$', '', 'g'))) AS title,

    COALESCE(REGEXP_REPLACE(year,'.*\(([0-9]{4})[-–]?.*', '\1'), 'Unknown') AS release_year,

    CASE 
        WHEN year ~ '\([0-9]{4}[-–][[:space:]]*\)' THEN 'Currently'
        WHEN year ~ '\([0-9]{4}[-–][0-9]{4}\)' THEN REGEXP_REPLACE(year, '.*[-–]([0-9]{4})\).*', '\1')
        ELSE 'N/A'
    END AS end_year,

    CASE WHEN year LIKE '%-%' THEN 'Series' ELSE 'Movie' END AS type,

    NULLIF(rating, '')::NUMERIC AS rating,

    TRIM(CASE WHEN descriptio ILIKE '%plot%' OR descriptio = 'NA.' THEN 'Unknown' ELSE descriptio END) AS description,

    CASE
        -- Se a primeira parte NÃO contém "Stars", limpa o "Director:"
        WHEN split_part(director, '|', 1) NOT LIKE '%Stars%' THEN
            COALESCE(
                TRIM(NULLIF(
                    regexp_replace( split_part(director, '|', 1), 'Directors?:\s*', '', 'i' ), '' )), 'Unknown' ) 
        -- Caso contrário, marca como "Unknown"
        ELSE 'Unknown'
    END AS directors,

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
		'Unknown') AS stars,

	COALESCE (REGEXP_REPLACE(REGEXP_REPLACE(gross, ',', '.'), ',', ''), NULL)::NUMERIC AS gross,

    NULLIF(duration, '')::NUMERIC AS duration,

    CASE 
        WHEN extra ~ '^\$[0-9.]+M$' THEN ROUND((REGEXP_REPLACE(extra, '[^\d.]', '', 'g')::NUMERIC) * 1e6, 2)
        ELSE NULL
    END AS extra

FROM bronze.tb_movies;
