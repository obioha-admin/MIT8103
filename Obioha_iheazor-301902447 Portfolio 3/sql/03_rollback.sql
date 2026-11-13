-- Demonstrate explicit rollback. Do not rerun COMMIT example unless you reset first.
BEGIN;
UPDATE p3_wallets SET balance=balance-75
WHERE user_id=(SELECT user_id FROM users WHERE username='p3_alice');
SELECT u.username,w.balance FROM p3_wallets w JOIN users u USING(user_id) ORDER BY u.username;
ROLLBACK;
SELECT u.username,w.balance FROM p3_wallets w JOIN users u USING(user_id) ORDER BY u.username;
-- After rollback, balances must match values from before this script.
