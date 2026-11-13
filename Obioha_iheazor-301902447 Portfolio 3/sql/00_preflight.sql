-- Run in a disposable database with Portfolio 1 schema installed.
SELECT current_database() AS database_name, version() AS postgres_version;
SELECT table_name FROM information_schema.tables WHERE table_schema='public' AND table_type='BASE TABLE' ORDER BY table_name;
-- Check that the experiment's reserved usernames do not already exist.
SELECT username FROM users WHERE username IN ('p3_alice','p3_bob');
