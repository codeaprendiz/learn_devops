# Create Table IF NOT EXISTS

```sql
-- Switch to SQLTestDB, we need to create table in this database
PRINT '...Switching to SQLTestDB';
USE [SQLTestDB];
GO

-- The IF NOT EXISTS clause checks the sys.tables view to see if a table named "SQLTest" of type 'U' (which stands for User Table) exists in the current database.
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'SQLTest' AND type = 'U')
BEGIN
    CREATE TABLE SQLTest (
        ID INT NOT NULL PRIMARY KEY,
        c1 VARCHAR(100) NOT NULL,
        dt1 DATETIME NOT NULL DEFAULT GETDATE()
    );
    PRINT 'Table successfully created';
END
ELSE
    PRINT 'Table already exists';
GO
```

- Message (When table does not exist)

```bash
...Switching to SQLTestDB
Table successfully created
```

- Message (When table exists)

```bash
...Switching to SQLTestDB
Table already exists
```
