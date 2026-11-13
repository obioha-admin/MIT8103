# Portfolio 3 — Observations and Reflection

## 1. Test Results and Observations

| Test | Expected | Actual Observation | Evidence Filename |
|---|---|---|---|
| COMMIT | Alice 900, Bob 600 | The transaction executed successfully. Alice's balance changed from 1000 to 900, while Bob's balance increased from 500 to 600. The changes were saved after COMMIT. | `commit.png` |
| ROLLBACK | Prior balances restored | The ROLLBACK test passed. The changes made during the transaction were cancelled, and the balances returned to their previous values. | `rollback.png` |
| CHECK violation | Negative balance rejected; earlier update undone | PostgreSQL rejected the transaction when it attempted to create a negative balance. It returned SQLSTATE 23514 because the operation violated the balance CHECK constraint. | `atomicity.png` |
| READ COMMITTED | A sees 1000 then 1100 | The READ COMMITTED concurrency test passed using two separate database sessions. The test demonstrated how a transaction can see newly committed changes when it runs another query. | `read_committed.png` |
| REPEATABLE READ | A sees 1000 then 1000; after commit 1100 | The test was attempted, but the final balance sequence was not fully verified. PostgreSQL displayed a warning that there was no transaction in progress when COMMIT was executed. | `repeatable_read.png` (if saved) |
| Row lock | B UPDATE waits; then succeeds after A COMMIT | The row-locking experiment was prepared using SELECT FOR UPDATE and a second database session. The final waiting and release behaviour has not yet been confirmed from the recorded results. | `row_lock.png` (if saved) |

*Evidence filenames are suggested names. They should match the actual screenshots saved in the evidence folder.*

## 2. Technical Interpretation

In this portfolio, I used PostgreSQL to understand how database transactions work and how they help protect data when different operations are happening.

I started with COMMIT and ROLLBACK. From the COMMIT test, I understood that a transaction can contain more than one operation and that the changes become permanent when the transaction is committed.

For example, when Alice transferred 100 to Bob, Alice's balance reduced from 1000 to 900, while Bob's balance increased from 500 to 600. This showed me how a database can handle related updates together.

The ROLLBACK test helped me understand the opposite situation. When a transaction is cancelled, PostgreSQL can undo the changes instead of leaving the database with unwanted results.

I also tested what happens when an operation violates a database constraint. During the atomicity test, PostgreSQL rejected an update that would have resulted in a negative balance. This helped me understand why constraints and transactions are important for maintaining data integrity.

For concurrency, I used two separate sessions in pgAdmin to simulate two users accessing the database at the same time.

The READ COMMITTED test demonstrated that a transaction can see a different value when another transaction commits a change between two queries.

I also explored REPEATABLE READ and row locking. These experiments helped me understand how PostgreSQL provides different ways to control concurrent access, although I still needed to verify the final results of those two tests.

## 3. Challenges and Fixes

One challenge I faced was understanding how to test transactions using two separate sessions in pgAdmin. At first, I was more familiar with running SQL queries in one Query Tool window.

I learned that concurrency testing requires separate sessions because each session represents an independent database connection.

Another challenge occurred during the atomicity test. PostgreSQL returned an error with SQLSTATE 23514 when the transaction attempted to create a negative balance.

I checked the error and understood that it was caused by the CHECK constraint. This was actually the expected behaviour because the database was preventing invalid data.

I also encountered a warning during the REPEATABLE READ experiment:

`WARNING: there is no transaction in progress`

This happened when COMMIT was executed without an active transaction in that session. It showed me that I needed to pay attention to transaction boundaries and how pgAdmin executes SQL statements.

Through these challenges, I became more comfortable reading PostgreSQL error messages and understanding why a query succeeds or fails.

## 4. Individual Reflection

Before this practical, I understood the basic idea of database transactions, but I had not really explored how they behave when multiple users access the same data.

The most important thing I learned is that a transaction is not just about running SQL statements. It is also about making sure that data remains correct, even when an operation fails or several users are working at the same time.

COMMIT and ROLLBACK helped me understand how changes are saved or cancelled.

The CHECK constraint experiment showed me that the database itself can prevent invalid operations.

I also learned that isolation levels affect what a transaction can see when another transaction changes the same data.

READ COMMITTED allows a new query to see changes that other transactions have committed. REPEATABLE READ is designed to provide a consistent snapshot during a transaction.

Row locking is another important concept because it helps coordinate transactions that want to modify the same record.

As a software developer, I can apply this knowledge when building systems that handle payments, wallets, account balances, or other operations where data consistency is important.

Overall, this portfolio helped me connect what I learned in database theory with practical SQL experiments in PostgreSQL.

## 5. AI Use Declaration

I used ChatGPT as a learning assistant during this portfolio.

It helped me understand transaction concepts, prepare SQL examples, organise the practical experiments, and explain PostgreSQL error messages.

I independently executed the SQL scripts using PostgreSQL and pgAdmin, tested the confirmed operations, and reviewed their results.

ChatGPT also assisted me in structuring and improving this documentation based on the observations from my practical work.

The practical tests were performed in my local database environment, and the results reported as confirmed are based on the experiments I completed.