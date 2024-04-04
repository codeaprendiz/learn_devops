# Check Default Schema MSSQL

- [stackoverflow.com » Find out default SQL Server schema for session](https://stackoverflow.com/questions/5513053/find-out-default-sql-server-schema-for-session)
- [learn.microsoft.com » Ownership and user-schema separation in SQL Server](https://learn.microsoft.com/en-us/sql/relational-databases/security/authentication-access/ownership-and-user-schema-separation?view=sql-server-ver16)

```sql
-- check default schema
SELECT SCHEMA_NAME()
```

- Output

|     |
|-----|
| dbo |
