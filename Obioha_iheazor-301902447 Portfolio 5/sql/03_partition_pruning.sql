ANALYZE p5.posts_sharded;
-- Compare plans: filter on partition key vs. non-partition key.
EXPLAIN (ANALYZE, BUFFERS) SELECT count(*) FROM p5.posts_sharded WHERE author_id = 42;
EXPLAIN (ANALYZE, BUFFERS) SELECT count(*) FROM p5.posts_sharded WHERE content LIKE '%Synthetic%';
