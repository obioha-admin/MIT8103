# MIT 8103 — Advanced Database Systems

**Academic Session:** 2026/2027  
**Assessment:** Individual Practical Database Portfolio  
**Case Study:** ConnectSphere — Social Media / Comment System  
**Technologies:** PostgreSQL 18, MongoDB 9.0.8, pgAdmin 4, MongoDB Shell

## Project Overview

This repository contains my practical work for MIT 8103 — Advanced Database Systems.

For this assignment, I selected ConnectSphere, a simulated social media platform that allows users to create posts, comment, like content, follow other users, and receive notifications.

The project explores relational database design, query optimisation, transaction management, NoSQL databases, and distributed database concepts.

All experiments were carried out locally using PostgreSQL and MongoDB on Windows.

## Portfolio Contents

| Portfolio | Topic | Description |
|---|---|---|
| 1 | Database Design and Modelling | Relational schema, ER diagram, normalisation, keys and constraints |
| 2 | Query Processing and Optimisation | SQL execution plans, indexing and performance comparisons |
| 3 | Transactions and Concurrency Control | COMMIT, ROLLBACK, atomicity and isolation experiments |
| 4 | NoSQL and Advanced Data Models | MongoDB collections, embedded comments, CRUD operations and indexing |
| 5 | Distributed and Cloud Databases | Local partitioning, replication simulation, consistency and proposed architecture |

Each portfolio folder contains its implementation scripts, documentation and supporting evidence.

## Key Practical Results

### Portfolio 1 — Database Design

- Created seven relational tables in PostgreSQL.
- Verified 15 foreign-key constraints.
- Implemented primary keys, composite keys and check constraints.
- Designed an ER diagram and documented normalisation.

### Portfolio 2 — Query Optimisation

- Generated 181,000 synthetic records.
- Compared four SQL queries before and after indexing.
- Recorded a 92.6% execution-time improvement for Q1.
- Examined sequential scans, index scans, hash joins and aggregation.

### Portfolio 3 — Transactions

- Demonstrated COMMIT and ROLLBACK.
- Tested wallet balance constraints and atomicity.
- Demonstrated READ COMMITTED using two database sessions.
- Explored REPEATABLE READ and row-level locking, with some final observations not fully verified.

### Portfolio 4 — MongoDB

- Created 100 users, 500 posts, 750 embedded comments and 200 activity events.
- Executed CRUD and aggregation operations.
- Created a compound index on `visibility` and `createdAt`.
- Reduced documents examined from 500 to 10 in the indexing experiment.

### Portfolio 5 — Distributed Databases

- Generated 10,000 synthetic posts.
- Created four local PostgreSQL hash partitions.
- Executed partition-pruning experiments.
- Simulated replica lag and manual synchronisation.
- Designed a proposed distributed database architecture.

The fifth portfolio uses local simulations, not actual distributed sharding, native replication or cloud deployment.

## Final Report

The final report summarises the implementation, experimental results, challenges and lessons learned across all five portfolios.

**File:** `MIT8103_Final_Portfolio_Report.pdf`

## Tools and Environment

- PostgreSQL 18
- pgAdmin 4
- MongoDB 9.0.8
- MongoDB Shell (`mongosh`)
- Windows
- Git and GitHub

## Evidence and Reproducibility

The repository contains SQL scripts, MongoDB scripts, diagrams, execution plans, screenshots and README documentation.

The scripts are organised by portfolio to make it easier to review and reproduce the experiments.

Separate test databases were used for the practical exercises to avoid interfering with the original ConnectSphere database.

## AI Use Declaration

I used ChatGPT as a learning assistant to understand database concepts, prepare SQL and MongoDB examples, troubleshoot errors, interpret results and organise the documentation.

I executed the practical experiments locally and reviewed the recorded results.

The repository distinguishes confirmed experimental results from simulations and experiments that were not fully verified.

## References

- PostgreSQL Documentation: https://www.postgresql.org/docs/18/
- MongoDB Documentation: https://www.mongodb.com/docs/manual/
- pgAdmin Documentation: https://www.pgadmin.org/docs/pgadmin4/latest/