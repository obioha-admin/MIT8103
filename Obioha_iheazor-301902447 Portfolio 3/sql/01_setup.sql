-- Run once in the disposable database. Dedicated rows avoid touching existing application data.
BEGIN;
INSERT INTO users (username,email,password_hash,full_name)
VALUES ('p3_alice','p3_alice@example.invalid','DEMO_NOT_A_REAL_HASH','Portfolio 3 Alice'),
       ('p3_bob','p3_bob@example.invalid','DEMO_NOT_A_REAL_HASH','Portfolio 3 Bob');
CREATE TABLE IF NOT EXISTS p3_wallets (
 user_id BIGINT PRIMARY KEY REFERENCES users(user_id) ON DELETE CASCADE,
 balance NUMERIC(12,2) NOT NULL CHECK(balance >= 0)
);
INSERT INTO p3_wallets(user_id,balance)
SELECT user_id, CASE username WHEN 'p3_alice' THEN 1000.00 ELSE 500.00 END
FROM users WHERE username IN ('p3_alice','p3_bob');
COMMIT;
SELECT u.username,w.balance FROM p3_wallets w JOIN users u USING(user_id) ORDER BY u.username;
