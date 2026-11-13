# Portfolio 3 — Observations and Reflection

| Test | Expected | Actual (fill after executing) | Evidence filename |
|---|---|---|---|
| COMMIT | Alice 900, Bob 600 | | |
| ROLLBACK | Prior balances restored | | |
| CHECK violation | Negative balance rejected; earlier update undone | | |
| READ COMMITTED | A sees 1000 then 1100 | | |
| REPEATABLE READ | A sees 1000 then 1000; after commit 1100 | | |
| Row lock | B UPDATE waits; then succeeds after A COMMIT | | |

## Technical interpretation

[Describe what you actually observed and explain it in your own words.]

## Challenges and fixes

[Record any issues encountered and how you resolved them.]

## Individual reflection

[What did you learn about isolation and locking?]

## AI use declaration

[Confirm the AI assistance you used and what you independently verified.]
