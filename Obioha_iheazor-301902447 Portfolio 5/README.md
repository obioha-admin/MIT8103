# Portfolio 5 — Distributed and Cloud Databases

**Course:** MIT 8103 — Advanced Database Systems  
**Case Study:** ConnectSphere — Social Media / Comment System  
**Environment:** PostgreSQL 18, pgAdmin 4, Windows  
**Database:** `connectsphere_p5_db`

## 1. Objective

The aim of this portfolio is to understand how distributed databases work and how they can help applications manage large amounts of data.

For this practical, I continued using ConnectSphere, my social media system, to explore horizontal partitioning, replication, consistency, and availability.

I used PostgreSQL to perform local experiments that demonstrate some of these concepts.

The practical was carried out on my Windows laptop using PostgreSQL 18 and pgAdmin 4. I did not deploy a real distributed database cluster or cloud database.

## 2. Database Setup

I created a separate database named `connectsphere_p5_db` for this portfolio.

The SQL scripts used a separate schema called `p5`, so the experiments did not interfere with the main ConnectSphere database created in Portfolio 1.

I executed the scripts individually using pgAdmin 4, following the required order.

The setup script generated 10,000 synthetic posts, which were used for the partitioning experiment.

This allowed me to test the concepts using sample data without affecting the original application tables.

## 3. Horizontal Partitioning

The first major experiment focused on horizontal partitioning.

I used PostgreSQL hash partitioning to divide the posts into four partitions based on `author_id`.

The partitions were created inside the same PostgreSQL database instance.

After executing the partitioning script, I verified that the partitioned table contained a total of 10,000 posts.

From my understanding, partitioning helps organise a large table into smaller parts while allowing the application to query it as one logical table.

For example, instead of keeping all posts in one physical table, PostgreSQL can store different groups of posts in separate partitions.

This can make data management easier and may improve some queries when PostgreSQL can avoid reading partitions that do not contain the required records.

However, I also learned that partitioning is not the same as distributed sharding.

In this practical, all four partitions were stored on one PostgreSQL instance. In a real sharded system, data may be distributed across independent database servers.

## 4. Partition Pruning and Query Processing

After creating the partitions, I executed the partition-pruning script to examine how PostgreSQL processes queries against a partitioned table.

The script used `EXPLAIN (ANALYZE, BUFFERS)` to display query execution plans.

One of the queries filtered posts using:

```sql
WHERE author_id = 42
```

This experiment was designed to demonstrate partition pruning.

Partition pruning means that PostgreSQL can identify which partition is relevant to a query and avoid scanning unnecessary partitions.

I completed the experiment and saved the execution plans as evidence.

The purpose of comparing the plans was to understand how filtering by a partition key can affect query execution.

The exact partitions scanned and the execution statistics are recorded in the saved execution-plan evidence.

From this exercise, I learned that the performance benefits of partitioning depend on the query conditions and how the partition key is used.

Partitioning does not automatically make every query faster.

## 5. Replication and Consistency Simulation

The next experiment focused on replication and consistency.

I used SQL scripts to create a replica snapshot of the source posts.

This was a local simulation using copied data, not PostgreSQL streaming replication.

The experiment demonstrated three stages.

### Stage 1 — Initial Synchronisation

The source table and replica snapshot were brought into the same state.

This represented a situation where the replica had received the latest data from the primary database.

### Stage 2 — Replica Lag

A new post was added to the source table without immediately updating the replica snapshot.

This demonstrated how a replica can temporarily contain older information than the primary database.

For example, in a social media application, a user might publish a new post but not see it immediately if the application reads from a replica that has not yet received the update.

### Stage 3 — Synchronisation

The replica snapshot was manually refreshed to bring it up to date with the source.

This represented the process of a replica catching up with changes made on the primary database.

I executed the replication simulation and saved the results as evidence.

This experiment helped me understand that data replication and data consistency are related but are not exactly the same thing.

A system can have multiple copies of data, but those copies may not always contain the same information at every moment.

## 6. Proposed Distributed Architecture

For a production version of ConnectSphere, I designed a proposed distributed database architecture.

The architecture includes:

- An application server handling user requests.
- A primary PostgreSQL database responsible for writes.
- Read replicas that could serve selected read requests.
- Four logical partitions representing how posts can be divided.
- Replication connections between the primary database and the proposed replicas.

The architecture is illustrated in the diagram saved in the `diagrams` folder.

**Diagram:** `diagrams/connectsphere_distributed_architecture.png`

**Figure 1: Proposed ConnectSphere Distributed Database Architecture.**

The diagram represents a possible production design. It does not mean that I deployed these components as separate servers.

In my actual implementation, I used local PostgreSQL partitions and a manually synchronised replica snapshot.

### Sharding

In a real distributed system, sharding can be used to distribute data across multiple database servers.

For example, ConnectSphere could distribute posts using an author identifier.

However, this would require additional components to route queries to the correct database server.

It would also introduce challenges such as cross-shard queries, maintaining relationships, and redistributing data when the system grows.

## 7. Availability and Consistency

This practical helped me understand the relationship between availability and consistency in distributed systems.

Availability means that a system can continue providing services when users need them.

Consistency concerns how reliably users see the expected data, particularly when multiple copies of the database exist.

For example, if ConnectSphere uses asynchronous replication, a new post might be saved successfully on the primary database but take some time to appear on a read replica.

This could affect the user experience if someone expects to see their post immediately.

One possible solution would be to direct operations that require the latest information to the primary database, while using read replicas for other queries that can tolerate some delay.

I also learned that having replicas does not automatically guarantee high availability.

A production system would need proper monitoring, failure detection, failover procedures, backups, and recovery testing.

These components were discussed as part of the proposed architecture but were not implemented in this practical.

## 8. Cloud Database Deployment

I also explored how the ConnectSphere database could be deployed using cloud infrastructure.

Managed PostgreSQL services can provide features such as automated backups, monitoring, database replicas, and deployment across availability zones.

For a social media application, these features could help improve reliability and reduce the amount of infrastructure management required.

However, using cloud services also introduces additional costs and configuration requirements.

Before deploying ConnectSphere in a production environment, I would need to consider security, database performance, network access, backup policies, monitoring, and disaster recovery.

No actual cloud deployment was carried out during this portfolio.

## 9. Evaluation and Limitations

The experiments were completed successfully, but there were some limitations.

First, the practical was carried out on one PostgreSQL instance rather than multiple database servers.

This means that the partitioning experiment demonstrated local horizontal partitioning, not real distributed sharding.

Second, the replication experiment used a manually updated snapshot rather than PostgreSQL's native replication system.

Although this helped demonstrate stale data and synchronisation concepts, it did not measure real replication lag.

Third, I did not implement automatic failover, load balancing, or cloud deployment.

Therefore, the practical cannot be used to claim that the system achieved high availability.

Finally, the experiments used synthetic data and a limited workload, so the results do not represent production-scale performance.

Despite these limitations, the practical helped me understand the main concepts and how they could be applied to a larger system.

## 10. Individual Technical Reflection

Before this practical, I understood that distributed databases involve storing data across multiple servers, but I had not really explored how some of the underlying concepts work.

One of the interesting things I learned was the difference between partitioning and sharding.

At first, they seemed similar because both involve dividing data into smaller parts.

However, after implementing the four PostgreSQL partitions, I understood that partitioning can happen inside one database instance, while distributed sharding involves placing data across separate database nodes.

I also learned about partition pruning and why choosing the right partition key matters.

For example, when a query filters by `author_id`, PostgreSQL can potentially identify the relevant partition instead of checking every partition.

Another important lesson was the replication simulation.

What interested me most was seeing how a replica snapshot could become outdated when a new record was added to the source database.

This made me understand why a user might sometimes experience delays before seeing updated information in an application that uses read replicas.

As a software developer, I can relate this to a social media feed, where users expect their new posts, comments, and likes to appear quickly.

I learned that improving performance and availability can introduce trade-offs in consistency.

For a production system, I would pay more attention to how data is replicated, how failures are handled, and which operations require the most up-to-date information.

I would also consider proper authentication, backups, monitoring, and automated failover before deploying the system.

Overall, this portfolio helped me understand distributed database concepts beyond the theoretical explanations. Even though I used local simulations, the practical gave me a clearer idea of how these concepts can affect the design of real applications.

## 11. AI Use Declaration

I used ChatGPT as a learning assistant during this portfolio.

It helped me understand distributed database concepts, prepare SQL scripts, explain partitioning and replication, and organise the practical workflow.

I independently executed the SQL scripts using PostgreSQL 18 and pgAdmin 4 on my Windows laptop.

I also verified the generated records, completed the experiments, and saved screenshots and execution plans as evidence.

ChatGPT assisted with the architecture explanation and documentation based on the practical work.

The implementation was limited to local experiments, and I have clearly stated which components were simulated rather than deployed.

## 12. References

- PostgreSQL 18 Documentation — Table Partitioning: https://www.postgresql.org/docs/18/ddl-partitioning.html
- PostgreSQL 18 Documentation — High Availability: https://www.postgresql.org/docs/18/high-availability.html
- PostgreSQL 18 Documentation — Warm Standby: https://www.postgresql.org/docs/18/warm-standby.html
- PostgreSQL 18 Documentation — Using EXPLAIN: https://www.postgresql.org/docs/18/using-explain.html