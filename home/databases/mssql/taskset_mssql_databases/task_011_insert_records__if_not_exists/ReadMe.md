# Insert Records IF NOT EXISTS

```sql
-- Switch to SQLTestDB, we want to insert records in this table, refer task_010 for table structure
PRINT '...Switching to SQLTestDB';
USE [SQLTestDB];
GO
-- Insert record with ID=1 if it doesn't exist
IF NOT EXISTS (SELECT 1 FROM SQLTest WHERE ID = 1)
    INSERT INTO SQLTest (ID, c1) VALUES (1, 'test1');
-- Insert record with ID=2 if it doesn't exist
IF NOT EXISTS (SELECT 1 FROM SQLTest WHERE ID = 2)
    INSERT INTO SQLTest (ID, c1) VALUES (2, 'test2');
```

- Message (When records do not exist)

```bash
...Switching to SQLTestDB
(1 row affected)
(1 row affected)
```

- Message (When records exists)

```bash
...Switching to SQLTestDB
Commands completed successfully.
```
