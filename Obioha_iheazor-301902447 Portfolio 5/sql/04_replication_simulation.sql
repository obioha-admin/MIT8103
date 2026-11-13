-- A local table-copy demonstration of snapshot replication and lag.
-- NOT PostgreSQL streaming/logical replication and NOT high availability.
BEGIN;
CREATE TABLE IF NOT EXISTS p5.posts_replica_snapshot (LIKE p5.posts_source INCLUDING ALL);
TRUNCATE p5.posts_replica_snapshot;
INSERT INTO p5.posts_replica_snapshot SELECT * FROM p5.posts_source;
COMMIT;
SELECT (SELECT count(*) FROM p5.posts_source) AS source_count, (SELECT count(*) FROM p5.posts_replica_snapshot) AS replica_count;
-- Create a new row on the source only.
INSERT INTO p5.posts_source(post_id,author_id,content) VALUES (10001,42,'New source-only post') ON CONFLICT DO NOTHING;
SELECT (SELECT count(*) FROM p5.posts_source) AS source_count, (SELECT count(*) FROM p5.posts_replica_snapshot) AS replica_count;
-- Manual snapshot refresh.
INSERT INTO p5.posts_replica_snapshot SELECT * FROM p5.posts_source ON CONFLICT DO NOTHING;
SELECT (SELECT count(*) FROM p5.posts_source) AS source_count, (SELECT count(*) FROM p5.posts_replica_snapshot) AS replica_count;
