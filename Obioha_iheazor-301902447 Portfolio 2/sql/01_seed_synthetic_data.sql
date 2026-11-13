-- ConnectSphere Portfolio 2: deterministic synthetic data; PostgreSQL 18.
-- Run ONLY on a fresh connectsphere_test_db containing the seven Portfolio 1 tables.
-- This script intentionally aborts if any core table already contains rows.
BEGIN;
DO $$ BEGIN
 IF current_database() <> 'connectsphere_test_db' THEN
   RAISE EXCEPTION 'Refusing to seed database %; use connectsphere_test_db', current_database();
 END IF;
 IF EXISTS (SELECT 1 FROM users) OR EXISTS (SELECT 1 FROM posts)
    OR EXISTS (SELECT 1 FROM comments) OR EXISTS (SELECT 1 FROM post_likes)
    OR EXISTS (SELECT 1 FROM comment_likes) OR EXISTS (SELECT 1 FROM follows)
    OR EXISTS (SELECT 1 FROM notifications) THEN
   RAISE EXCEPTION 'Expected empty tables. Do not seed an existing dataset.';
 END IF;
END $$;

INSERT INTO users(username,email,password_hash,full_name)
SELECT 'bench_user_' || lpad(g::text,4,'0'),
       'bench_user_' || lpad(g::text,4,'0') || '@example.invalid',
       'synthetic_not_a_real_hash', 'Benchmark User ' || g
FROM generate_series(1,1000) g;

CREATE TEMP TABLE bench_users AS
SELECT user_id, row_number() OVER (ORDER BY username)::int AS rn
FROM users WHERE username LIKE 'bench_user_%';
CREATE UNIQUE INDEX ON bench_users(rn);

INSERT INTO posts(user_id,content,visibility,created_at)
SELECT u.user_id, 'Benchmark post #' || g || ' — ' || repeat('database performance ',3),
       'public', TIMESTAMPTZ '2026-01-01 00:00:00+00' + g * INTERVAL '1 minute'
FROM generate_series(1,10000) g
JOIN bench_users u ON u.rn = ((g-1)%1000)+1;

CREATE TEMP TABLE bench_posts AS
SELECT post_id, row_number() OVER (ORDER BY created_at,post_id)::int AS rn
FROM posts WHERE content LIKE 'Benchmark post #%';
CREATE UNIQUE INDEX ON bench_posts(rn);

INSERT INTO comments(post_id,user_id,content,created_at)
SELECT p.post_id,u.user_id,'Benchmark comment #' || g,
       TIMESTAMPTZ '2026-02-01 00:00:00+00' + g * INTERVAL '10 seconds'
FROM generate_series(1,50000) g
JOIN bench_posts p ON p.rn = ((g-1)%10000)+1
JOIN bench_users u ON u.rn = ((g*17-1)%1000)+1;

INSERT INTO post_likes(user_id,post_id,created_at)
SELECT u.user_id,p.post_id,
       TIMESTAMPTZ '2026-03-01 00:00:00+00' + g * INTERVAL '1 second'
FROM generate_series(1,100000) g
JOIN bench_posts p ON p.rn = ((g-1)%10000)+1
JOIN bench_users u ON u.rn = (((g-1)/10000)%1000)+1;

-- Each user follows the next 20 users in cyclic order (no self-follows).
INSERT INTO follows(follower_id,following_id)
SELECT a.user_id,b.user_id
FROM bench_users a CROSS JOIN generate_series(1,20) offset_n
JOIN bench_users b ON b.rn = ((a.rn-1+offset_n)%1000)+1;
COMMIT;
ANALYZE;
SELECT 'users' AS entity, count(*) FROM users
UNION ALL SELECT 'posts',count(*) FROM posts
UNION ALL SELECT 'comments',count(*) FROM comments
UNION ALL SELECT 'post_likes',count(*) FROM post_likes
UNION ALL SELECT 'follows',count(*) FROM follows
ORDER BY entity;
