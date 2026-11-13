# Portfolio 2 — Query Processing and Optimisation

**Course:** MIT 8103 — Advanced Database Systems  
**Case Study:** ConnectSphere — Social Media / Comment System  
**Database:** PostgreSQL 18  
**Environment:** PostgreSQL 18, pgAdmin 4, Windows

## 1. Objective

The aim of this portfolio is to understand how PostgreSQL processes SQL queries and how database indexing can affect query performance.

For this practical, I continued using ConnectSphere, my social media database, to investigate how different queries behave before and after creating additional indexes.

I focused on query execution plans, indexing, joins, aggregation, and performance comparison.

I used PostgreSQL 18 and pgAdmin 4 to execute the SQL scripts and examine the results.

## 2. Experimental Dataset

I generated a synthetic dataset to simulate activities on the ConnectSphere social media platform.

The dataset contained:

| Table | Records |
|---|---:|
| `users` | 1,000 |
| `posts` | 10,000 |
| `comments` | 50,000 |
| `post_likes` | 100,000 |
| `follows` | 20,000 |
| **Total** | **181,000** |

The records were generated for testing purposes and did not contain real user information.

Using a larger dataset helped me observe how PostgreSQL processes queries involving multiple records, relationships, and aggregation.

## 3. Methodology

I tested four SQL queries representing common operations in a social media application.

I used PostgreSQL's `EXPLAIN (ANALYZE, BUFFERS)` command to examine how each query was executed.

The experiment followed these steps:

1. Generated and verified the synthetic dataset.
2. Executed the four queries before creating the additional indexes.
3. Saved the baseline execution plans and execution times.
4. Created the additional indexes.
5. Refreshed the database statistics.
6. Executed the same queries again.
7. Saved the new execution plans and compared the results.

The execution times were obtained from PostgreSQL's reported execution statistics.

This allowed me to compare how PostgreSQL processed each query before and after indexing.

## 4. Performance Results

The following table shows the actual results obtained during the experiment.

| Query | Before (ms) | After (ms) | Change |
|---|---:|---:|---|
| Q1 | 3.007 | 0.222 | 92.6% faster |
| Q2 | 1.202 | 1.237 | 2.9% slower |
| Q3 | 2.907 | 2.912 | 0.2% slower |
| Q4 | 55.615 | 46.598 | 16.2% faster |

From these results, Q1 recorded the largest improvement after indexing.

Q4 also recorded a lower execution time, while Q2 and Q3 showed very small increases.

This helped me understand that creating indexes does not guarantee that every query will execute faster.

## 5. Execution Plan Analysis

### 5.1 Q1 — Indexed Post Retrieval

The first query focused on retrieving posts using filtering conditions.

After creating the index `idx_posts_user_created`, PostgreSQL used a Bitmap Index Scan in the optimised execution plan.

The recorded execution time reduced from **3.007 ms to 0.222 ms**, representing a 92.6% improvement.

This was the biggest performance improvement in the experiment.

From the execution plan, I understood that the index helped PostgreSQL locate the required records more efficiently.

This showed me why indexes can be useful when queries frequently search for specific records.

### 5.2 Q2 — Comment Retrieval

The second query focused on retrieving comments.

The optimised execution plan used the index `idx_comments_post_created`.

However, the execution time changed from **1.202 ms to 1.237 ms**.

This represented a small increase of approximately 2.9%.

At first, I expected every query to become faster after indexing, but this result showed me that it does not always happen.

The difference was very small, so it would not be enough to conclude that the index made the query slower in general.

I learned that execution time can be affected by other operations and normal variations during testing.

### 5.3 Q3 — Join Processing

The third query focused on joining related data.

The execution plan continued to use sequential scanning and a hash join.

The execution time changed from **2.907 ms to 2.912 ms**.

This was almost the same performance before and after indexing.

From this result, I understood that PostgreSQL does not always need an index to process a query efficiently.

Sometimes, the query planner may choose sequential scans and hash joins because they are suitable for the amount of data being processed.

This helped me understand that the query planner decides how to execute queries based on the available information and estimated cost.

### 5.4 Q4 — Most-Liked Posts

The fourth query focused on retrieving the most-liked posts on ConnectSphere.

This query required PostgreSQL to process and aggregate likes across the dataset.

The execution time reduced from **55.615 ms to 46.598 ms**, representing an improvement of approximately 16.2%.

However, the execution plan still used sequential scans, a hash join, aggregation, and sorting.

This means that although the recorded execution time improved, I cannot conclude that the additional indexes were responsible for the improvement.

Other factors, such as caching and normal execution differences, may have affected the result.

This query helped me understand why aggregation queries can require more processing than simple record retrieval.

## 6. Limitations

One limitation of this experiment was that I used individual execution measurements rather than running each query many times.

Because of this, the recorded times may have been affected by caching, background system activity, and other conditions.

Another limitation was that the experiment used synthetic data rather than real social media activity.

Although the dataset contained 181,000 records, it may not represent the distribution and workload of a production social media platform.

I also learned that creating additional indexes can introduce storage costs and extra work when records are inserted, updated, or deleted.

For a more reliable performance comparison, I would repeat each query several times and compare the median execution times.

I would also test different data sizes and query conditions to understand how performance changes as the database grows.

## 7. Conclusion

This practical helped me understand how PostgreSQL processes queries and how indexing can affect performance.

The results showed that some queries benefited from additional indexes, while others showed little or no improvement.

Q1 recorded the largest improvement, reducing execution time by 92.6%.

Q2 and Q3 remained almost unchanged, while Q4 recorded a lower execution time without clear evidence that the index caused the improvement.

Overall, I learned that database optimisation requires more than simply creating indexes.

It is important to examine execution plans, understand the type of query being executed, and compare actual performance results.

## 8. Individual Technical Reflection

Before this practical, I already understood that indexes help databases search for records faster, but I had not really studied how PostgreSQL decides whether to use an index or scan a table.

One of the most important things I learned was how to read query execution plans using `EXPLAIN (ANALYZE, BUFFERS)`.

At first, the execution plans looked complicated because they contained different operations such as sequential scans, bitmap index scans, hash joins, aggregation, and sorting.

After comparing the results, I started to understand what these operations mean and how they affect the way PostgreSQL retrieves data.

The result that interested me most was Q1.

Before creating the index, the query took 3.007 ms. After indexing, it took only 0.222 ms.

This showed me how choosing a suitable index can make a big difference for certain queries.

What surprised me was that Q2 and Q3 did not become faster after indexing.

I initially thought that adding indexes would automatically improve the performance of all queries.

However, this experiment showed me that PostgreSQL may still prefer other execution methods, depending on the query and the amount of data involved.

Another interesting result was Q4.

Although its execution time improved, the execution plan still relied on scans, joins, aggregation, and sorting.

This taught me that I should not assume an index caused a performance improvement just because the recorded execution time became lower.

As a software developer, I can apply this knowledge when building applications that handle large amounts of data.

For example, in a social media platform, users frequently retrieve posts, comments, likes, and other information.

If these queries are not properly designed, they may become slower as the number of users and records increases.

I now understand why it is important to examine query plans and measure performance before deciding which indexes to create.

Overall, this practical improved my understanding of database optimisation and taught me to make decisions based on actual execution results rather than assumptions.

## 9. AI Use Declaration

I used ChatGPT as a learning assistant during this portfolio.

It helped me understand PostgreSQL query optimisation concepts, prepare SQL examples, interpret execution plans, and organise the testing workflow.

I independently executed the SQL scripts using PostgreSQL 18 and pgAdmin 4 on my Windows laptop.

I generated and verified the synthetic dataset, executed the baseline and optimised queries, and saved the execution plans as evidence.

ChatGPT also assisted me in preparing this documentation based on the actual results recorded during the practical.

The benchmark figures presented in this report were obtained from my PostgreSQL environment.

## 10. References

- PostgreSQL 18 Documentation — Using EXPLAIN: https://www.postgresql.org/docs/18/using-explain.html
- PostgreSQL 18 Documentation — Indexes: https://www.postgresql.org/docs/18/indexes.html
- PostgreSQL 18 Documentation — ANALYZE: https://www.postgresql.org/docs/18/sql-analyze.html