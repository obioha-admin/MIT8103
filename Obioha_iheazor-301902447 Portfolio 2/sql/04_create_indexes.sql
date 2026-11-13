-- Secondary indexes chosen to support author timeline, post comments and feed.
-- Existing primary/unique constraints already create indexes; don't duplicate those.
CREATE INDEX IF NOT EXISTS idx_posts_user_created
    ON posts(user_id,created_at DESC);
CREATE INDEX IF NOT EXISTS idx_comments_post_created
    ON comments(post_id,created_at DESC);
CREATE INDEX IF NOT EXISTS idx_post_likes_post
    ON post_likes(post_id);
ANALYZE;
SELECT tablename,indexname,indexdef FROM pg_indexes
WHERE schemaname='public' AND tablename IN ('posts','comments','post_likes')
ORDER BY tablename,indexname;
