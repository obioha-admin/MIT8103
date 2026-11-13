-- Run 05_reset.sql first. SESSION A locks Alice's wallet row.
BEGIN;
SELECT balance FROM p3_wallets WHERE user_id=(SELECT user_id FROM users WHERE username='p3_alice') FOR UPDATE;
-- Keep transaction open while SESSION B runs its first statement.
-- Observe that B waits for this lock; then execute:
COMMIT;
