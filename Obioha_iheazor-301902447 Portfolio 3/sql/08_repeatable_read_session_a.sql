-- Run 05_reset.sql first, and ensure previous transactions are closed.
-- SESSION A: execute BEGIN and first SELECT, then pause.
BEGIN ISOLATION LEVEL REPEATABLE READ;
SELECT balance FROM p3_wallets WHERE user_id=(SELECT user_id FROM users WHERE username='p3_alice');
-- Ask SESSION B to execute UPDATE + COMMIT.
-- SESSION A sees the SAME snapshot value (1000), even after B commits.
SELECT balance FROM p3_wallets WHERE user_id=(SELECT user_id FROM users WHERE username='p3_alice');
COMMIT;
-- New transaction sees 1100:
SELECT balance FROM p3_wallets WHERE user_id=(SELECT user_id FROM users WHERE username='p3_alice');
