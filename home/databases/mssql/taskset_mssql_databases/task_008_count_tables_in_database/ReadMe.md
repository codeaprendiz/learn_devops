# Count Tables in Particular Database

- [stackoverflow - Count the Number of Tables in a SQL Server Database](https://stackoverflow.com/questions/45464661/count-the-number-of-tables-in-a-sql-server-database)

```sql
USE MyDatabase
GO

SELECT COUNT(*)
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
GO

-- OR you can also use
USE MyDatabase;
GO

SELECT COUNT(*) as TableCount FROM sys.tables;
GO
```
