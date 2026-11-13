# Portfolio 2 — Query Processing and Optimisation

**Course:** MIT 8103 — Advanced Database Systems  
**Case Study:** ConnectSphere — Social Media / Comment System  
**Database:** PostgreSQL 18

## 1. Objective

This portfolio investigates how PostgreSQL executes queries on a relational social media database and evaluates the effects of additional database indexes on query performance.

## 2. Experimental Dataset

A synthetic dataset was generated to simulate social media activity.

| Table | Records |
|---|---:|
| users | 1,000 |
| posts | 10,000 |
| comments | 50,000 |
| post_likes | 100,000 |
| follows | 20,000 |
| **Total** | **181,000** |

The dataset was generated for testing and does not contain real user information.

## 3. Methodology

Four representative queries were evaluated using PostgreSQL's `EXPLAIN (ANALYZE, BUFFERS)`.

The experiment involved recording baseline execution plans, creating additional indexes, refreshing table statistics, and repeating the queries.

Execution times were obtained from PostgreSQL's reported execution results.

## 4. Performance Results

| Query | Before (ms) | After (ms) | Change |
|---|---:|---:|---:|
| Q1 | 3.007 | 0.222 | 92.6% faster |
| Q2 | 1.202 | 1.237 | 2.9% slower |
| Q3 | 2.907 | 2.912 | 0.2% slower |
| Q4 | 55.615 | 46.598 | 16.2% faster |

## 5. Execution Plan Analysis

### Q1 — Indexed Post Retrieval

The optimised execution plan uses `idx_posts_user_created` through a Bitmap Index Scan. The recorded execution time decreased from 3.007 ms to 0.222 ms.

This suggests that the additional index benefits the query's filtering and retrieval operations.

### Q2 — Comment Retrieval

The query uses `idx_comments_post_created`, but its execution time changed from 1.202 ms to 1.237 ms.

The small difference does not establish a meaningful performance regression. Other query operations and execution variability may contribute to the measured time.

### Q3 — Join Processing

The query continues to use sequential scanning and a hash join. Execution time remained nearly unchanged, moving from 2.907 ms to 2.912 ms.

This illustrates that indexes may provide limited benefits when PostgreSQL determines that scanning and joining the relevant data is more efficient.

### Q4 — Most-Liked Posts

The query aggregates likes across the dataset and returns the most-liked posts.

Execution time decreased from 55.615 ms to 46.598 ms. However, the plan still relies on sequential scans, a hash join, aggregation, and sorting.

The observed improvement should not automatically be attributed to the additional indexes.

## 6. Limitations

The recorded measurements are based on individual benchmark executions rather than repeated controlled trials.

Execution times may be influenced by caching, system activity, PostgreSQL statistics, and other environmental conditions.

Repeated measurements using median execution times would provide stronger evidence of consistent performance changes.

## 7. Conclusion

The experiment demonstrates that indexing can significantly improve certain database queries, particularly when suitable indexes support selective retrieval.

However, additional indexes do not guarantee faster execution for every workload. Query structure, selectivity, join strategies, and PostgreSQL's query planner influence performance.

## 8. Individual Technical Reflection

[Write your own reflection explaining what you learned from the execution plans, what surprised you about the results, and how this experiment changed your understanding of database indexing.]

## 9. AI Use Declaration

ChatGPT assisted with SQL examples, interpretation of execution plans, and documentation structure. The SQL scripts were executed and the benchmark results were obtained using PostgreSQL. The student reviewed the generated material and is responsible for verifying the submitted results.

## 10. References

- PostgreSQL Documentation — Using EXPLAIN: https://www.postgresql.org/docs/18/using-explain.html
- PostgreSQL Documentation — Indexes: https://www.postgresql.org/docs/18/indexes.html
- PostgreSQL Documentation — ANALYZE: https://www.postgresql.org/docs/18/sql-analyze.html