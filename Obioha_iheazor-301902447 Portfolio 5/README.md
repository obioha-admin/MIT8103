# Portfolio 5 — Distributed and Cloud Databases

**Case study:** ConnectSphere (social media system)  
**Environment:** PostgreSQL 18, pgAdmin 4, Windows  
**Scope:** local simulations of distribution concepts; no actual multi-node cluster or cloud deployment is claimed.

## Objectives

Explore horizontal partitioning, replica lag, consistency and availability using reproducible SQL. Explain what a production distributed deployment would require.

## Safety and setup

Create a NEW disposable database named `connectsphere_p5_db`. The scripts use their own `p5` schema and do not require previous portfolio tables. Do not run on `connectsphere_db`. In pgAdmin, connect the Query Tool to `connectsphere_p5_db` and run scripts **in order**, individually. Scripts are designed for a first run; repeated runs may change the lag demonstration results.

## Execution order and evidence

1. `sql/01_setup.sql` — 10,000 synthetic source posts. Save screenshot `evidence/01_source_count.png`.
2. `sql/02_sharding.sql` — four local hash partitions of `author_id`; verify total row counts. Save `evidence/02_partition_counts.png`.
3. `sql/03_partition_pruning.sql` — capture both `EXPLAIN (ANALYZE, BUFFERS)` outputs, noting whether only one partition is scanned for `author_id=42`. Save plans as text or screenshots (`evidence/03_partition_plans.txt`).
4. `sql/04_replication_simulation.sql` — observe replica snapshot match, lag after a source-only write, and catch-up after manual refresh. Save `evidence/04_replica_lag.png`.
5. `sql/05_verification.sql` — capture final counts (`evidence/05_verification.png`). Note source and snapshot may have 10,001 posts while the partitioned table has 10,000 until re-synced.

**Important:** The partitioning demonstration uses one PostgreSQL instance, not networked shards. The snapshot copy uses ordinary SQL, not PostgreSQL replication. Neither demonstrates failover or proves high availability.

## Architecture and discussion

A production ConnectSphere deployment might use a primary PostgreSQL database accepting writes, read replicas serving eligible read traffic, a failover manager, load balancers, backups, monitoring and a disaster recovery plan. Replication may be asynchronous (replica can lag) or synchronous (stronger durability guarantees with latency and availability trade-offs). Replicas should not be assumed to provide read-after-write consistency. A sharded system routes requests by a shard key, e.g. `author_id`, but cross-shard queries, joins, resharding, global uniqueness and hotspot prevention require additional design.

**Cloud deployment:** Managed PostgreSQL services can offer automated backups, replica creation, monitoring and availability-zone deployment, but these features must be configured and tested. No cloud deployment is included in this exercise.

## Evaluation and limitations

Document actual partition-pruning plan nodes and observed snapshot row counts. Describe the distinction between table partitioning and independent-node sharding; between manual copying and native replication; and between availability design and measured failover. The scripts provide a local conceptual demonstration only.

## Individual technical reflection

[In your own words: What surprised you about partition pruning or stale replica reads? What limitations would you address before production? What trade-offs matter for a social feed?]

## AI use declaration

ChatGPT helped draft the SQL examples, documentation and testing workflow. The student executed, inspected and verified results and is responsible for accuracy and final submission.

## References

- https://www.postgresql.org/docs/18/ddl-partitioning.html
- https://www.postgresql.org/docs/18/high-availability.html
- https://www.postgresql.org/docs/18/warm-standby.html
- https://www.postgresql.org/docs/18/using-explain.html
