# Portfolio 3 — Transactions and Concurrency Control

**Course:** MIT 8103 — Advanced Database Systems  
**Case Study:** ConnectSphere  
**Database:** PostgreSQL 18

## 1. Objective

This portfolio demonstrates transaction management, atomicity, isolation levels, and concurrency control using PostgreSQL.

A simulated wallet system was added to ConnectSphere to demonstrate financial transactions and concurrent database operations.

## 2. Transaction Experiments

### COMMIT

A transaction was executed using `BEGIN` and `COMMIT` to demonstrate that committed changes persist in the database.

### ROLLBACK

A transaction was executed and rolled back to demonstrate that uncommitted changes can be undone.

### Atomicity and Constraint Enforcement

An attempt to create a negative wallet balance violated the `p3_wallets_balance_check` constraint.

PostgreSQL returned SQLSTATE `23514`, demonstrating enforcement of the balance constraint.

Within an explicit transaction, the error places the transaction in a failed state until rollback or appropriate savepoint recovery.

## 3. Isolation Levels

### READ COMMITTED

Two concurrent sessions were used. Session A read a wallet balance, Session B updated and committed the balance, and Session A performed another SELECT.

Session A observed the newly committed value, demonstrating PostgreSQL's READ COMMITTED behaviour.

### REPEATABLE READ

A transaction was configured to use REPEATABLE READ isolation.

Under this isolation level, successive SELECT statements within the same transaction use a consistent snapshot, preventing non-repeatable reads.

[Insert the actual observed before-and-after balances and explain whether the experiment demonstrated the expected behaviour.]

## 4. Row-Level Locking

PostgreSQL's `SELECT ... FOR UPDATE` was used to acquire a row lock.

A second session attempted to update the same wallet record with a three-second lock timeout.

[Record the observed result, including the SQLSTATE if a timeout occurred.]

## 5. Technical Discussion

Transactions help maintain database consistency by ensuring that related operations are handled as a logical unit.

Isolation levels determine how concurrent transactions observe changes made by other transactions.

Row-level locking helps prevent conflicting modifications to shared records.

## 6. Limitations

The experiments used a small simulated wallet dataset and manually coordinated sessions.

The results illustrate PostgreSQL transaction behaviour but do not constitute a high-concurrency load test.

## 7. Individual Technical Reflection

[Explain in your own words what you learned about transactions, isolation, and locking. Describe any challenges encountered, including the COMMIT warning and how you investigated it.]

## 8. AI Use Declaration

ChatGPT assisted with SQL examples, explanations of transaction behaviour, and documentation structure. The experiments were executed using PostgreSQL, and the student is responsible for verifying and accurately reporting the observed results.

## 9. References

- PostgreSQL 18 — Transaction Isolation: https://www.postgresql.org/docs/18/transaction-iso.html
- PostgreSQL 18 — Explicit Locking: https://www.postgresql.org/docs/18/explicit-locking.html
- PostgreSQL 18 — BEGIN: https://www.postgresql.org/docs/18/sql-begin.html