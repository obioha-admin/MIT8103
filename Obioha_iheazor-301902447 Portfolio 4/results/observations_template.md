# Observations

## Seed Counts

The MongoDB data generation script executed successfully, and I verified the following records:

| Collection / Data | Total |
|---|---:|
| Users | 100 |
| Posts | 500 |
| Embedded Comments | 750 |
| Activity Events | 200 |
| **Total Records** | **1,550** |

The database used for this experiment was `connectsphere_p4_db`, running on MongoDB 9.0.8.

## Before Index

- **Winning plan:** Not recorded in the results shared.
- **Documents examined:** Not recorded.
- **Keys examined:** Not recorded.
- **Execution time (ms):** Not recorded.

## After Index

- **Winning plan:** Not recorded in the results shared.
- **Documents examined:** Not recorded.
- **Keys examined:** Not recorded.
- **Execution time (ms):** Not recorded.

The indexing and explain script executed successfully, but the exact execution statistics still need to be copied from the output.

## My Interpretation

In this practical, I learned how MongoDB stores and retrieves data using collections and documents instead of relational tables.

I successfully generated the sample data and tested different MongoDB operations, including inserting, retrieving, updating, and deleting documents.

I also explored how indexes work in MongoDB. From my understanding, an index helps the database locate matching documents without necessarily checking every document in a collection.

Without a suitable index, MongoDB may use a collection scan (`COLLSCAN`). With an appropriate index, MongoDB may use an index scan (`IXSCAN`), depending on the query and the query planner.

I learned that creating an index does not automatically mean every query will become faster. The improvement depends on the number of documents, the query conditions, and whether the index is suitable for that query.

Since my experiment used a relatively small dataset, the execution time differences may be small. I would need the actual explain statistics to make a reliable performance comparison.

Overall, this practical helped me understand the importance of indexing and how MongoDB processes queries. It also showed me the difference between storing comments inside post documents and storing them separately in a relational database.