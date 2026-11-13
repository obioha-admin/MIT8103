-- OPTIONAL: only on connectsphere_test_db; never run unless resetting baseline.
DO $$ BEGIN IF current_database()<>'connectsphere_test_db' THEN
 RAISE EXCEPTION 'Wrong database'; END IF; END $$;
DROP INDEX IF EXISTS idx_posts_user_created;
DROP INDEX IF EXISTS idx_comments_post_created;
DROP INDEX IF EXISTS idx_post_likes_post;
ANALYZE;
