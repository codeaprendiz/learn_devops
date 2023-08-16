# Get current database

[learn.microsoft.com » sql » functions » db-name-transact-sql](https://learn.microsoft.com/en-us/sql/t-sql/functions/db-name-transact-sql?view=sql-server-ver16)

- Returning the current database name. `[Current Database]` is not placeholder and actually works as it is.

```sql
SELECT DB_NAME() AS [Current Database];  
GO
```
