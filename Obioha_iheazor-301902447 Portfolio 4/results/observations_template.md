# Observations

## Seed Counts

I successfully generated and verified the following data in MongoDB:

| Collection / Data | Total |
|---|---:|
| Users | 100 |
| Posts | 500 |
| Embedded Comments | 750 |
| Activity Events | 200 |

**Database:** `connectsphere_p4_db`  
**MongoDB Version:** 9.0.8

## Before Index

- **Winning plan:** `SORT → COLLSCAN`
- **Documents examined:** 500
- **Keys examined:** 0
- **Execution time:** 5 ms
- **Documents returned:** 10

Before creating the index, MongoDB used a collection scan (`COLLSCAN`) to search through all 500 posts. It filtered the public posts and sorted them by their creation date before returning the latest 10 posts.

## After Index

- **Winning plan:** `LIMIT → FETCH → IXSCAN`
- **Index name:** `idx_visibility_created`
- **Index fields:** `{ visibility: 1, createdAt: -1 }`
- **Documents examined:** 10
- **Keys examined:** 10
- **Execution time:** 13 ms
- **Documents returned:** 10

After creating the compound index, MongoDB used an index scan (`IXSCAN`) instead of scanning the entire collection.

The index allowed MongoDB to find the latest 10 public posts in the required order without performing a separate sorting operation.

## Performance Comparison

| Metric | Before Index | After Index |
|---|---:|---:|
| Winning plan | SORT + COLLSCAN | LIMIT + FETCH + IXSCAN |
| Documents examined | 500 | 10 |
| Keys examined | 0 | 10 |
| Execution time | 5 ms | 13 ms |
| Documents returned | 10 | 10 |

The number of documents examined reduced from 500 to 10, which represents a **98% reduction**.

However, the recorded execution time increased from 5 ms to 13 ms in this particular test.

## My Interpretation

In this practical, I learned how indexing affects the way MongoDB searches for documents.

Before creating the index, MongoDB had to check all 500 posts to find the public posts and sort them by their creation date.

After creating the compound index, MongoDB used `IXSCAN` to locate the required posts more directly. It examined only 10 documents and 10 index keys instead of scanning the entire collection.

This helped me understand that an index can reduce the amount of work the database needs to perform.

One interesting thing I noticed was that the execution time increased from 5 ms to 13 ms, even though MongoDB examined fewer documents.

From my understanding, this can happen because the dataset is small, and execution time can be affected by system conditions and other overhead. Since I only compared individual executions, I cannot conclude that the index made the query faster in terms of execution time.

However, the execution plan clearly showed that the index changed how MongoDB processed the query and reduced the number of documents examined by 98%.

As a software developer, I learned that I should not judge database performance by execution time alone. I also need to check the execution plan, the number of documents examined, and whether the database is using the appropriate index.

Overall, this experiment helped me understand how MongoDB indexing works and why choosing the right index is important when building applications that handle large amounts of data.