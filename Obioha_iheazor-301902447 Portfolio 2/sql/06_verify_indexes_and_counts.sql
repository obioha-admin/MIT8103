SELECT relname AS table_name,n_live_tup AS estimated_rows
FROM pg_stat_user_tables ORDER BY relname;
SELECT tablename,indexname,indexdef FROM pg_indexes
WHERE schemaname='public' ORDER BY tablename,indexname;
SELECT 'users' AS entity,count(*) AS actual_rows FROM users
UNION ALL SELECT 'posts',count(*) FROM posts
UNION ALL SELECT 'comments',count(*) FROM comments
UNION ALL SELECT 'post_likes',count(*) FROM post_likes
UNION ALL SELECT 'follows',count(*) FROM follows ORDER BY entity;
