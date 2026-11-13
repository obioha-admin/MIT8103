-- Open TWO separate Query Tool tabs/connections. Run 05_reset.sql first.
-- SESSION A: execute BEGIN and first SELECT, then pause.
BEGIN ISOLATION LEVEL READ COMMITTED;
SELECT balance FROM p3_wallets WHERE user_id=(SELECT user_id FROM users WHERE username='p3_alice');
-- Ask SESSION B to execute its UPDATE and COMMIT.
-- Then run this SELECT in SESSION A: value should change from 1000 to 1100.
SELECT balance FROM p3_wallets WHERE user_id=(SELECT user_id FROM users WHERE username='p3_alice');
COMMIT;
