# Create Database

[learn.microsoft.com » sql » relational-databases » databases » create-a-database](https://learn.microsoft.com/en-us/sql/relational-databases/databases/create-a-database?view=sql-server-ver16)

- Create a new database Sales

```sql
USE master;
GO
CREATE DATABASE Sales
```

- Create database if NOT EXISTS [stackoverflow : Create database if db does not exist](https://stackoverflow.com/questions/59641684/create-database-if-db-does-not-exist)

```sql
USE master
GO

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'MyTestDataBase')
BEGIN
  CREATE DATABASE MyTestDataBase;
END;
GO
```
