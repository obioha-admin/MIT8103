# Portfolio 4 — NoSQL and Advanced Data Models

**Course:** MIT 8103 — Advanced Database Systems  
**Case Study:** ConnectSphere — Social Media / Comment System  
**Database:** MongoDB 9.0.8

## 1. Objective

This portfolio explores how the ConnectSphere social media platform can be represented using a document-oriented NoSQL database.

MongoDB was selected to demonstrate flexible document structures, embedded data, CRUD operations, aggregation, indexing, and query execution analysis.

## 2. NoSQL Data Model

The implementation uses three MongoDB collections:

| Collection | Purpose |
|---|---|
| users | Stores social media user profiles |
| posts | Stores posts with embedded comments |
| activity_events | Records simulated user activities |

Comments are embedded inside their parent post documents rather than stored in a separate relational table.

This allows a post and its comments to be retrieved together without performing a relational join.

## 3. Dataset Implementation

A synthetic dataset was generated using MongoDB Shell.

| Data | Records |
|---|---:|
| Users | 100 |
| Posts | 500 |
| Embedded comments | 750 |
| Activity events | 200 |

The data was stored in the `connectsphere_p4_db` database.

## 4. CRUD Operations

MongoDB document operations were demonstrated using the provided scripts.

These operations included document retrieval, insertion, modification, and deletion.

Aggregation queries were also used to retrieve and summarise social media information.

## 5. Indexing and Query Processing

MongoDB indexes were created and inspected using the indexing and explain script.

The experiment demonstrates how MongoDB's query planner selects execution strategies.

Index scans can improve selective queries, while collection scans may remain appropriate for other workloads.

[Insert the actual index names, query plans, and any execution statistics recorded during testing.]

## 6. PostgreSQL versus MongoDB

| Feature | PostgreSQL | MongoDB |
|---|---|---|
| Data model | Relational tables | Document collections |
| Relationships | Foreign keys and joins | Embedded documents and references |
| Schema | Explicit relational constraints | Flexible document structure with optional validation |
| Queries | SQL | MongoDB Query Language |
| Transactions | ACID transactions | ACID transactions supported |
| Nested comments | Separate comments table | Embedded within posts |

### Suitability

PostgreSQL is appropriate when ConnectSphere requires strong relational integrity, complex joins, and carefully controlled relationships.

MongoDB can be suitable for content-oriented workloads where posts and their associated comments are frequently retrieved together.

However, embedding large or unbounded comment collections may lead to document growth and update overhead. A production system may require a hybrid approach using references or separate comment documents.

## 7. Limitations

The experiment used a relatively small synthetic dataset.

The MongoDB instance was configured for local development without access control. This environment should not be exposed to untrusted networks.

The implementation demonstrates document modelling concepts but does not establish production-scale performance.

## 8. Individual Technical Reflection

[Explain what you learned about document-oriented databases, the differences from PostgreSQL, and the advantages and disadvantages of embedding comments.]

## 9. AI Use Declaration

ChatGPT assisted with MongoDB script examples, NoSQL modelling explanations, and documentation structure. The student executed the scripts and verified the implementation using MongoDB Shell.

## 10. References

- MongoDB Documentation — Data Modelling: https://www.mongodb.com/docs/manual/data-modeling/
- MongoDB Documentation — CRUD Operations: https://www.mongodb.com/docs/manual/crud/
- MongoDB Documentation — Indexes: https://www.mongodb.com/docs/manual/indexes/
- PostgreSQL 18 Documentation: https://www.postgresql.org/docs/18/