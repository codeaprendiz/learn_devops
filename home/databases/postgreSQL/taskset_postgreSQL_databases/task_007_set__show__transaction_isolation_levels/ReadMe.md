# Show -- Transaction Isolation Level

## Show

To show the current transaction isolation level you can run

```sql
show transaction isolation level;
```

Output

```bash
postgres=# show transaction isolation level;
 transaction_isolation 
-----------------------
 read committed
(1 row)
```

## Set

To set the transaction isolation level you can run

```sql
-- You can set the transaction isolation level within a transaction block
BEGIN;
SET TRANSACTION ISOLATION LEVEL <isolation_level>;
```

Output

```bash
postgres=# BEGIN;
BEGIN
postgres=# SET TRANSACTION ISOLATION LEVEL read uncommitted;
SET
postgres=*# show transaction isolation level;
 transaction_isolation 
-----------------------
 read uncommitted
(1 row)
```
