# Create Database - IF NOT EXISTS - Vars NAVCHAR

```sql
-- Declare var for DBName
DECLARE @DatabaseName NVARCHAR(255) = 'SQLTestDB';

-- Create DB if not exists
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = @DatabaseName)
BEGIN
    CREATE DATABASE [SQLTestDB];
    PRINT 'Database' + @DatabaseName + 'Created';
END
ELSE
    PRINT 'Database' + @DatabaseName +  'already exists';
GO
```

- Message (when database exists)

```bash
DatabaseSQLTestDBalready exists
```

- Message (when database does not exist)

```bash
DatabaseSQLTestDBCreated
```
