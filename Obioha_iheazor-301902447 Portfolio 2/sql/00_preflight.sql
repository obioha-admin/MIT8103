-- Run on connectsphere_test_db, NOT the original connectsphere_db.
SELECT current_database() AS database_name, version() AS postgres_version;
SELECT table_name FROM information_schema.tables WHERE table_schema='public' AND table_type='BASE TABLE' ORDER BY table_name;
SELECT relname AS table_name, n_live_tup AS estimated_rows FROM pg_stat_user_tables ORDER BY relname;
-- Stop if the database is not connectsphere_test_db or is not empty.
