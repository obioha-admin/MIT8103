-- SESSION B: execute after SESSION A's first SELECT.
BEGIN;
UPDATE p3_wallets SET balance=balance+100 WHERE user_id=(SELECT user_id FROM users WHERE username='p3_alice');
COMMIT;
