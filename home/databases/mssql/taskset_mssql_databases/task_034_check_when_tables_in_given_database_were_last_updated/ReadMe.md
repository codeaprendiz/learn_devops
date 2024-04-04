# Check when tables in a given database were last modified

- [stackoverflow.com » SQL Server database last updated date time](https://stackoverflow.com/questions/29535074/sql-server-database-last-updated-date-time)

```sql
SELECT * FROM SYS.OBJECTS
ORDER BY MODIFY_DATE DESC
```

```sql
-- Replace DBNAME with required database
SELECT 
    t.name AS TableName,
    MAX(ius.last_user_update) AS LastUpdate
FROM 
    sys.tables t
LEFT JOIN 
    sys.dm_db_index_usage_stats ius ON t.object_id = ius.object_id
WHERE 
    ius.database_id = DB_ID('<DBNAME>') OR ius.database_id IS NULL
GROUP BY 
    t.name
ORDER BY 
    LastUpdate DESC;
```
