# Show Databases

- [https://learn.microsoft.com/en-us/sql/relational-databases/databases/view-a-list-of-databases-on-an-instance-of-sql-server?view=sql-server-ver16](https://learn.microsoft.com/en-us/sql/relational-databases/databases/view-a-list-of-databases-on-an-instance-of-sql-server?view=sql-server-ver16)

```bash
SELECT name, database_id, create_date  
FROM sys.databases;  
GO
```
