-- Reset only the dedicated test wallet balances, preserving users and schema.
BEGIN;
UPDATE p3_wallets w SET balance=CASE u.username WHEN 'p3_alice' THEN 1000.00 WHEN 'p3_bob' THEN 500.00 END
FROM users u WHERE u.user_id=w.user_id AND u.username IN ('p3_alice','p3_bob');
COMMIT;
SELECT u.username,w.balance FROM p3_wallets w JOIN users u USING(user_id) ORDER BY u.username;
