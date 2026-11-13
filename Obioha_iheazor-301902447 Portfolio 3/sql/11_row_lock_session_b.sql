-- SESSION B: execute BEGIN then UPDATE while SESSION A holds FOR UPDATE lock.
BEGIN;
UPDATE p3_wallets SET balance=balance+50 WHERE user_id=(SELECT user_id FROM users WHERE username='p3_alice');
-- UPDATE should wait until SESSION A COMMIT; then finish.
COMMIT;
SELECT balance FROM p3_wallets WHERE user_id=(SELECT user_id FROM users WHERE username='p3_alice');
-- Expected 1050 after one run.
