-- Successful atomic transfer: Alice -> Bob, 100 units.
BEGIN;
UPDATE p3_wallets SET balance=balance-100
WHERE user_id=(SELECT user_id FROM users WHERE username='p3_alice');
UPDATE p3_wallets SET balance=balance+100
WHERE user_id=(SELECT user_id FROM users WHERE username='p3_bob');
COMMIT;
SELECT u.username,w.balance FROM p3_wallets w JOIN users u USING(user_id) ORDER BY u.username;
-- Expected after one run: Alice 900.00, Bob 600.00; total 1500.00.
