# Switching to a particular database

- [Download Azure Data Studio for apple silicon](https://learn.microsoft.com/en-us/sql/azure-data-studio/download-azure-data-studio?view=sql-server-ver16&tabs=redhat-install%2Credhat-uninstall)

```sql
-- Switch to master
PRINT '...Switching to master';
USE [master];
GO

SELECT DB_NAME() AS [Current Database];  
GO
```

- Messages

```bash
...Switching to master
(1 row affected)
```

- Results

|   | Current Database |
|---|------------------|
| 1 | master           |
