-- Representative workload. Run SELECT statements independently in pgAdmin.
-- Q1: posts by one author, newest first.
SELECT post_id,content,created_at FROM posts
WHERE user_id=(SELECT user_id FROM users WHERE username='bench_user_0001')
ORDER BY created_at DESC LIMIT 20;

-- Q2: comments for one benchmark post, newest first.
SELECT comment_id,user_id,content,created_at FROM comments
WHERE post_id=(SELECT post_id FROM posts WHERE content LIKE 'Benchmark post #5000 — %' LIMIT 1)
ORDER BY created_at DESC LIMIT 20;

-- Q3: feed from followed accounts, newest first.
SELECT p.post_id,p.user_id,p.content,p.created_at
FROM follows f JOIN posts p ON p.user_id=f.following_id
WHERE f.follower_id=(SELECT user_id FROM users WHERE username='bench_user_0001')
  AND p.visibility='public'
ORDER BY p.created_at DESC LIMIT 20;

-- Q4: engagement leaderboard (aggregate across likes).
SELECT p.post_id,p.content,count(pl.user_id) AS like_count
FROM posts p JOIN post_likes pl ON pl.post_id=p.post_id
GROUP BY p.post_id,p.content
ORDER BY like_count DESC,p.post_id LIMIT 20;
