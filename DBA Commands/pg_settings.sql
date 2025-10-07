SELECT * FROM pg_setting; -- Show all envorinment Variables.
SELECT * FROM pg_settings WHERE name IN ('config_file');
SELECT DISTINCT(context) FROM pg_settings; -- Show all contexts.

SELECT * FROM pg_settings WHERE name IN ('port', 'max_connections', 'shared_buffers');
