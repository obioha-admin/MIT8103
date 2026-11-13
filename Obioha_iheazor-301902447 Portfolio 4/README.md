# Portfolio 4 — NoSQL and Advanced Data Models

**Course:** MIT 8103 — Advanced Database Systems  
**Case Study:** ConnectSphere — Social Media / Comment System  
**Database:** MongoDB 9.0.8

## 1. Objective

The aim of this portfolio is to understand how a social media application like ConnectSphere can store and manage data using a NoSQL database.

In Portfolio 1, I used PostgreSQL to design the system using relational tables. In this portfolio, I used MongoDB to explore another way of storing the same type of data using documents and collections.

I focused on document modelling, embedded comments, CRUD operations, aggregation, indexing, and query execution analysis.

## 2. NoSQL Data Model

I implemented three MongoDB collections:

| Collection | Purpose |
|---|---|
| `users` | Stores social media user profiles |
| `posts` | Stores posts together with their embedded comments |
| `activity_events` | Stores simulated activities performed by users |

Unlike PostgreSQL, where comments were stored in a separate table and connected to posts using foreign keys, MongoDB allows comments to be embedded directly inside their parent post documents.

This means that when retrieving a post, its comments can also be retrieved without performing a separate relational join.

I found this approach useful because posts and their comments are often displayed together in a social media application.

However, I also understood that embedding too many comments inside one document could make the document very large and more difficult to manage.

## 3. Dataset Implementation

I generated a synthetic dataset using MongoDB Shell (`mongosh`).

The database used was `connectsphere_p4_db`.

After running the setup script, I verified the following records:

| Data | Records |
|---|---:|
| Users | 100 |
| Posts | 500 |
| Embedded comments | 750 |
| Activity events | 200 |

The setup script executed successfully, and I confirmed the generated records using MongoDB queries.

This helped me understand how MongoDB organises data into collections and documents rather than traditional relational tables.

## 4. CRUD Operations

I executed MongoDB scripts to demonstrate Create, Read, Update, and Delete operations.

These operations showed me how to insert new documents, retrieve existing records, modify document fields, and delete documents.

I also executed aggregation queries to retrieve and summarise information from the social media dataset.

The scripts executed successfully during my practical testing.

From this exercise, I learned that MongoDB provides different ways of querying and modifying data compared with SQL, but the main goal is still to store, retrieve, and manage application information correctly.

## 5. Indexing and Query Processing

I performed an indexing experiment to understand how MongoDB processes queries before and after creating an index.

The query retrieved the latest 10 public posts, sorted by their creation date.

The compound index created was:

`idx_visibility_created`

With the following fields:

```javascript
{ visibility: 1, createdAt: -1 }
```

### Before Creating the Index

The execution plan showed:

- **Winning plan:** `SORT → COLLSCAN`
- **Documents examined:** 500
- **Keys examined:** 0
- **Execution time:** 5 ms
- **Documents returned:** 10

Before creating the index, MongoDB scanned all 500 post documents, filtered the public posts, and sorted the results to return the latest 10 posts.

### After Creating the Index

The execution plan showed:

- **Winning plan:** `LIMIT → FETCH → IXSCAN`
- **Index used:** `idx_visibility_created`
- **Documents examined:** 10
- **Keys examined:** 10
- **Execution time:** 13 ms
- **Documents returned:** 10

After creating the index, MongoDB used an index scan instead of a collection scan.

The compound index helped MongoDB find the required public posts in the correct order without performing a separate sorting operation.

### Performance Comparison

| Metric | Before Index | After Index |
|---|---:|---:|
| Winning plan | SORT + COLLSCAN | LIMIT + FETCH + IXSCAN |
| Documents examined | 500 | 10 |
| Keys examined | 0 | 10 |
| Execution time | 5 ms | 13 ms |
| Documents returned | 10 | 10 |

The number of documents examined reduced from 500 to 10, representing a **98% reduction**.

However, the execution time increased from 5 ms to 13 ms during this particular experiment.

This showed me that an index does not automatically guarantee faster execution in every test.

Because the dataset was small and the results were based on individual executions, factors such as system conditions and query overhead could affect the recorded time.

The execution plan still demonstrated that the index reduced the number of documents examined and removed the need for a separate sorting stage.

## 6. PostgreSQL versus MongoDB

| Feature | PostgreSQL | MongoDB |
|---|---|---|
| Data model | Relational tables | Document collections |
| Relationships | Foreign keys and joins | Embedded documents and references |
| Schema | Explicit relational constraints | Flexible document structure with optional validation |
| Query language | SQL | MongoDB Query Language |
| Transactions | ACID transactions | ACID transactions supported |
| Comments | Stored in a separate table | Embedded inside post documents |

### Suitability for ConnectSphere

From my understanding, PostgreSQL is suitable when the application needs strong relationships between different types of data.

For example, ConnectSphere has users, posts, comments, likes, follows, and notifications. PostgreSQL makes it easier to enforce relationships between these tables using foreign keys and other constraints.

MongoDB is useful when related information needs to be retrieved together.

For example, embedding comments inside posts can simplify the process of retrieving a post and displaying its comments.

However, if a post receives thousands of comments, keeping all comments inside one document may become difficult to manage.

For a larger social media platform, I would consider using separate comment documents or combining embedding with references, depending on how the application accesses its data.

## 7. Limitations

One limitation of this practical was the small dataset. I used only 500 posts, which may not be enough to demonstrate how MongoDB performs under heavy workloads.

Another limitation was that the database was running locally on my laptop rather than on a production server.

MongoDB also displayed a warning that access control was not enabled. This was a local development environment, and I understand that authentication and proper access restrictions would be necessary before deploying a real application.

The indexing experiment was also based on individual execution measurements rather than repeated benchmark runs.

Therefore, the results demonstrate how query plans change, but they are not enough to make a general conclusion about production performance.

## 8. Individual Technical Reflection

Before this practical, most of my database experience was with relational databases such as PostgreSQL and MySQL.

I was already familiar with creating tables, using primary keys and foreign keys, and writing SQL queries to retrieve related data.

Working with MongoDB helped me understand that databases can organise information in different ways depending on the application requirements.

One of the things I found interesting was the concept of embedded documents. Instead of creating a separate table for every type of information, MongoDB allows related data to be stored together.

For ConnectSphere, this was demonstrated by storing comments inside post documents.

I learned that this approach can make retrieving related information easier, especially when the application normally needs that information together.

At the same time, I realised that embedding is not always the best solution. If the number of comments becomes very large, it may affect document size and make updates more difficult.

Another important thing I learned was how to analyse query execution plans.

Before creating the index, MongoDB scanned 500 documents. After creating the index, it examined only 10 documents.

What surprised me was that the indexed query recorded a higher execution time in this particular test.

This helped me understand that database optimisation is not just about creating indexes. It is also about examining query plans, understanding how data is accessed, and testing performance properly.

As a software developer, this practical has improved my understanding of how to choose a database model based on the needs of an application.

If I were building a real social media system, I would consider the relationships between the data, how often the data is accessed, and how the system might grow before deciding whether to use PostgreSQL, MongoDB, or a combination of both.

Overall, this portfolio helped me understand NoSQL databases better and gave me practical experience using MongoDB Shell to manage and analyse document-based data.

## 9. AI Use Declaration

I used ChatGPT as a learning assistant during this portfolio.

It helped me understand MongoDB concepts, prepare sample scripts, explain document modelling, and organise the practical tasks.

I independently executed the scripts using MongoDB Shell on my Windows laptop, verified the generated dataset, and checked the query execution results.

ChatGPT also helped me interpret the indexing results and structure this documentation based on the actual observations from my experiments.

The reported results were obtained from my local MongoDB environment.

## 10. References

- MongoDB Documentation — Data Modelling: https://www.mongodb.com/docs/manual/data-modeling/
- MongoDB Documentation — CRUD Operations: https://www.mongodb.com/docs/manual/crud/
- MongoDB Documentation — Indexes: https://www.mongodb.com/docs/manual/indexes/
- MongoDB Documentation — Explain Results: https://www.mongodb.com/docs/manual/reference/explain-results/
- PostgreSQL 18 Documentation: https://www.postgresql.org/docs/18/