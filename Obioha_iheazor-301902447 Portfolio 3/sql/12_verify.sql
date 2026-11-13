SELECT u.username,w.balance FROM p3_wallets w JOIN users u USING(user_id) ORDER BY u.username;
SELECT SUM(balance) AS total_balance FROM p3_wallets;
SELECT conname, contype FROM pg_constraint WHERE conrelid='p3_wallets'::regclass ORDER BY conname;
