# Portfolio 3 — Transactions and Concurrency Control

**Course:** MIT 8103 — Advanced Database Systems  
**Case Study:** ConnectSphere — Social Media / Comment System  
**Database:** PostgreSQL 18  
**Environment:** PostgreSQL 18, pgAdmin 4, Windows

## 1. Objective

The aim of this portfolio is to understand how PostgreSQL manages database transactions and controls what happens when different users access or modify the same data at the same time.

For this practical, I continued using ConnectSphere, my social media system, and added a simulated wallet system to demonstrate transactions.

I focused on COMMIT, ROLLBACK, atomicity, isolation levels, and row-level locking.

I used PostgreSQL 18 and pgAdmin 4 to execute the SQL scripts and observe how the database behaves in different situations.

## 2. Database Setup

I created a separate database called `connectsphere_p3_test_db` for this practical.

The database included the main ConnectSphere tables and an additional table called `p3_wallets`.

The wallet table was used to simulate transferring money between two users, Alice and Bob.

Their initial balances were:

| User | Initial Balance |
|---|---:|
| Alice | 1000 |
| Bob | 500 |

This allowed me to test transactions using simple examples that were easy to understand.

## 3. Transaction Experiments

### 3.1 COMMIT

The first experiment demonstrated how COMMIT works.

I executed a transaction using `BEGIN` and `COMMIT` to transfer 100 from Alice to Bob.

After the transaction was committed, the balances were:

| User | Before | After |
|---|---:|---:|
| Alice | 1000 | 900 |
| Bob | 500 | 600 |

The transaction executed successfully, and the changes were saved.

From this experiment, I understood that COMMIT makes the changes performed within a transaction permanent.

### 3.2 ROLLBACK

The second experiment demonstrated ROLLBACK.

I executed a transaction that modified the wallet balances and then used ROLLBACK instead of COMMIT.

After the rollback, the changes made during the transaction were cancelled, and the previous balances were restored.

This showed me that PostgreSQL can undo uncommitted changes when a transaction is cancelled.

I learned that ROLLBACK is important when an operation fails or when the application decides not to continue with a transaction.

### 3.3 Atomicity and Constraint Enforcement

The third experiment focused on atomicity and database constraints.

I attempted an operation that would result in a negative wallet balance.

PostgreSQL rejected the operation because it violated the `p3_wallets_balance_check` constraint.

The database returned the following error code:

`SQLSTATE 23514`

This showed that PostgreSQL was enforcing the rule that a wallet balance should not become negative.

I also learned that when an error occurs inside an explicit transaction, PostgreSQL marks the transaction as failed until it is rolled back or recovered using an appropriate savepoint.

From this experiment, I understood that atomicity helps ensure that related database operations are treated as one unit rather than leaving only part of a failed transaction completed.

## 4. Isolation Levels

### 4.1 READ COMMITTED

I used two separate sessions in pgAdmin to test the READ COMMITTED isolation level.

In the experiment, Session A first read Alice's wallet balance.

Session B then updated the same balance and committed the change.

When Session A executed another SELECT statement, it was able to see the newly committed value.

The expected sequence was:

| Stage | Balance |
|---|---:|
| Session A — First SELECT | 1000 |
| Session B — UPDATE and COMMIT | 1100 |
| Session A — Second SELECT | 1100 |

The test passed and demonstrated how READ COMMITTED works.

I understood that under this isolation level, different SELECT statements within the same transaction can see different committed values if another transaction makes changes between them.

### 4.2 REPEATABLE READ

I also attempted to test the REPEATABLE READ isolation level.

The purpose of this experiment was to understand how PostgreSQL maintains a consistent view of data throughout a transaction.

Under REPEATABLE READ, when Session A reads a balance and Session B updates and commits that balance, Session A should continue seeing the original value until its transaction ends.

The expected behaviour was:

| Stage | Expected Balance |
|---|---:|
| Session A — First SELECT | 1000 |
| Session B — UPDATE and COMMIT | 1100 |
| Session A — Second SELECT | 1000 |
| Session A — After transaction ends | 1100 |

During my practical, I encountered the following warning:

`WARNING: there is no transaction in progress`

This occurred when COMMIT was executed without an active transaction in the session.

I investigated the warning and learned that transaction boundaries are important when testing isolation levels.

The experiment helped me understand the expected behaviour of REPEATABLE READ, although I did not fully verify the final balance sequence during the recorded test.

## 5. Row-Level Locking

Another concept I explored was row-level locking.

PostgreSQL provides `SELECT ... FOR UPDATE`, which can be used to lock selected rows during a transaction.

The purpose of this experiment was to understand what happens when two sessions attempt to modify the same wallet record at the same time.

The experiment was prepared using two sessions.

Session A would acquire a row lock using `SELECT ... FOR UPDATE`.

Session B would then attempt to update the same wallet record.

A three-second lock timeout was included to demonstrate how PostgreSQL can stop waiting when a lock cannot be acquired within the configured time.

The expected behaviour was that Session B would either wait until Session A released the lock or receive a lock timeout error if the waiting period exceeded the configured limit.

The final waiting or timeout result was not fully confirmed from my recorded practical output.

However, the exercise helped me understand why row-level locking is important when multiple transactions may update the same record.

## 6. Technical Discussion

From the experiments, I learned that transactions are important for maintaining data consistency.

For example, when transferring money between two wallets, the debit and credit operations should be treated as one transaction.

If one part of the operation fails, the system should not leave the database in an incomplete state.

I also learned that isolation levels determine how different transactions see changes made by other transactions.

READ COMMITTED allows a transaction to see newly committed data when it executes another query.

REPEATABLE READ is designed to maintain a consistent snapshot throughout a transaction.

Row-level locking provides another way to coordinate concurrent operations by preventing conflicting updates from proceeding at the same time.

These concepts are useful when developing applications that handle shared data, especially financial systems and applications with many users.

## 7. Limitations

The experiments used a small simulated wallet dataset containing only two users.

The concurrency tests were performed manually using separate pgAdmin sessions rather than automated concurrent workloads.

The practical demonstrated basic transaction behaviour but did not test how PostgreSQL performs under heavy traffic.

I also encountered a warning during the REPEATABLE READ experiment, and the final results of that experiment and the row-locking test were not fully verified.

Therefore, the confirmed results mainly demonstrate COMMIT, ROLLBACK, constraint enforcement, and READ COMMITTED isolation.

## 8. Individual Technical Reflection

Before this practical, I understood that databases use transactions to manage changes, but I had not really explored how transactions behave when multiple users are working with the same data.

One of the important things I learned was that COMMIT and ROLLBACK are not just SQL commands. They help protect data from being left in an incorrect state.

For example, when I tested the wallet transfer, I understood why the debit and credit operations should be handled together.

The atomicity experiment was also interesting because PostgreSQL rejected an operation that would have created a negative wallet balance.

At first, the error looked like a problem with the script, but after checking it, I understood that the database was actually enforcing the constraint as expected.

Another thing I learned was how isolation levels affect what users can see when transactions happen at the same time.

Using two sessions in pgAdmin helped me understand this better because I could observe the operations from different database connections.

I also faced a challenge during the REPEATABLE READ test when PostgreSQL displayed a warning that there was no transaction in progress.

This taught me that I need to be careful about where transactions begin and end, especially when testing concurrent database operations.

The row-locking exercise also helped me understand why databases need mechanisms to coordinate updates to shared records.

As a software developer, I can apply these concepts when building applications that involve wallets, payments, account balances, or other operations where data must remain correct.

Overall, this portfolio improved my understanding of PostgreSQL transactions and showed me how important it is to test database behaviour rather than only reading about it.

## 9. AI Use Declaration

I used ChatGPT as a learning assistant during this portfolio.

It helped me understand transaction concepts, prepare SQL examples, organise the practical workflow, and interpret PostgreSQL error messages.

I independently executed the SQL scripts using PostgreSQL 18 and pgAdmin 4 on my Windows laptop.

I verified the COMMIT, ROLLBACK, constraint enforcement, and READ COMMITTED experiments.

ChatGPT also assisted me in writing and organising this documentation based on the results and challenges encountered during the practical.

The results presented as confirmed are based on my actual testing. Experiments that were not fully verified have been clearly identified.

## 10. References

- PostgreSQL 18 Documentation — Transaction Isolation: https://www.postgresql.org/docs/18/transaction-iso.html
- PostgreSQL 18 Documentation — Explicit Locking: https://www.postgresql.org/docs/18/explicit-locking.html
- PostgreSQL 18 Documentation — BEGIN: https://www.postgresql.org/docs/18/sql-begin.html
- PostgreSQL 18 Documentation — ROLLBACK: https://www.postgresql.org/docs/18/sql-rollback.html
- PostgreSQL 18 Documentation — COMMIT: https://www.postgresql.org/docs/18/sql-commit.html