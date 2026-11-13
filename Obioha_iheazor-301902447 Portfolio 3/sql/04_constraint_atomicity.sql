-- Demonstrate statement error and transaction atomicity.
-- Run as separate statements in one Query Tool connection (not one selected batch),
-- so you can observe the error and then issue ROLLBACK.
BEGIN;
UPDATE p3_wallets SET balance=balance+20 WHERE user_id=(SELECT user_id FROM users WHERE username='p3_bob');
-- This violates CHECK(balance >= 0):
UPDATE p3_wallets SET balance=-1 WHERE user_id=(SELECT user_id FROM users WHERE username='p3_alice');
-- PostgreSQL marks transaction aborted; execute next statement to clear it:
ROLLBACK;
-- Bob's +20 was rolled back as well.
SELECT u.username,w.balance FROM p3_wallets w JOIN users u USING(user_id) ORDER BY u.username;
