-- Logical hash sharding demonstration: 4 partitions in one PostgreSQL instance.
-- This is NOT deployment across multiple physical servers.
BEGIN;
CREATE TABLE IF NOT EXISTS p5.posts_sharded (
 post_id BIGINT NOT NULL,
 author_id BIGINT NOT NULL,
 content TEXT NOT NULL,
 created_at TIMESTAMPTZ NOT NULL,
 PRIMARY KEY(post_id, author_id)
) PARTITION BY HASH (author_id);
CREATE TABLE IF NOT EXISTS p5.posts_shard_0 PARTITION OF p5.posts_sharded FOR VALUES WITH (MODULUS 4, REMAINDER 0);
CREATE TABLE IF NOT EXISTS p5.posts_shard_1 PARTITION OF p5.posts_sharded FOR VALUES WITH (MODULUS 4, REMAINDER 1);
CREATE TABLE IF NOT EXISTS p5.posts_shard_2 PARTITION OF p5.posts_sharded FOR VALUES WITH (MODULUS 4, REMAINDER 2);
CREATE TABLE IF NOT EXISTS p5.posts_shard_3 PARTITION OF p5.posts_sharded FOR VALUES WITH (MODULUS 4, REMAINDER 3);
INSERT INTO p5.posts_sharded SELECT * FROM p5.posts_source ON CONFLICT DO NOTHING;
COMMIT;
SELECT tableoid::regclass AS partition_name, count(*) AS rows FROM p5.posts_sharded GROUP BY 1 ORDER BY 1;
SELECT (SELECT count(*) FROM p5.posts_source) AS source_count, (SELECT count(*) FROM p5.posts_sharded) AS partitioned_count;
