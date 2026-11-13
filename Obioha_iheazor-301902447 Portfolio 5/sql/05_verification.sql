SELECT count(*) AS source_posts FROM p5.posts_source;
SELECT count(*) AS partitioned_posts FROM p5.posts_sharded;
SELECT count(*) AS replica_snapshot_posts FROM p5.posts_replica_snapshot;
SELECT tableoid::regclass AS partition_name, count(*) AS row_count FROM p5.posts_sharded GROUP BY 1 ORDER BY 1;
SELECT post_id,author_id,content FROM p5.posts_source WHERE post_id=10001;
-- A new source-only row is not automatically inserted into posts_sharded.
-- Re-run 02_sharding.sql to resync the partitioned demonstration if desired.
