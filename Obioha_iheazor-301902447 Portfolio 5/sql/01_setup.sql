-- Run only in a disposable PostgreSQL database, e.g. connectsphere_p5_db.
BEGIN;
CREATE SCHEMA IF NOT EXISTS p5;
CREATE TABLE IF NOT EXISTS p5.posts_source (
 post_id BIGINT PRIMARY KEY,
 author_id BIGINT NOT NULL,
 content TEXT NOT NULL,
 created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
INSERT INTO p5.posts_source(post_id,author_id,content,created_at)
SELECT g, (g % 1000)+1, 'Synthetic post '||g, now() - (g || ' minutes')::interval
FROM generate_series(1,10000) AS g
ON CONFLICT (post_id) DO NOTHING;
COMMIT;
SELECT count(*) AS source_count FROM p5.posts_source;
