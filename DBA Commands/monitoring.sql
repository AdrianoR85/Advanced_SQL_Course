/* MONITORAMENTO DE USUÁRIOS */

-- Listando os processos ativos.
SELECT * FROM pg_catalog.pg_stat_activity;
-- Concelando a execução de uma query.
SELECT pg_cancel_backend(20339);
SELECT pg_cancel_backend(pid) FROM pg_catalog.pg_stat_activity WHERE usaname = 'site' -- cancela tudo daquele usuário
-- Finalizar a sessão
SELECT pg_terminate_backend(20339);
