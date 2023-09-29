# Show all tables in a particular database

- To show all tables in a given database `Test` [stackoverflow](https://stackoverflow.com/questions/175415/how-do-i-get-list-of-all-tables-in-a-database-using-tsql)

```sql
USE Test;

SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE'
```
