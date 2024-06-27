# Add job to the server and validate

- [learn.microsoft.com » sp_add_jobserver](https://learn.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/sp-add-jobserver-transact-sql?view=sql-server-ver16)
- [learn.microsoft.com » dbo.sysjobs](https://learn.microsoft.com/en-us/sql/relational-databases/system-tables/dbo-sysjobs-transact-sql?view=sql-server-ver16)
- [learn.microsoft.com » sys.servers](https://learn.microsoft.com/en-us/sql/relational-databases/system-compatibility-views/sys-sysservers-transact-sql?view=sql-server-ver16)
- [learn.microsoft.com » dbo.sysjobservers](https://learn.microsoft.com/en-us/sql/relational-databases/system-tables/dbo-sysjobservers-transact-sql?view=sql-server-ver16)

<br>

## Add job to the server

This script is ensuring that the SQL Server Agent job named `'Daily SQLTestDB backup'` is targeted to run on the local server (since no specific server is provided). This is a necessary step after creating a job and before it can be run, as SQL Server needs to know where the job should be executed. If you're in a multi-server environment and you want the job to run on a different server, you would specify that server in the `sp_add_jobserver` procedure.

```sql
USE msdb;  -- Switch to using the 'msdb' database which is used by SQL Server Agent for scheduling alerts and jobs.
GO  -- A batch terminator, it signals the end of a batch of Transact-SQL statements to the SQL Server utilities.

EXEC dbo.sp_add_jobserver  -- Execute the stored procedure to target the job to run on a server.
    @job_name = N'Daily SQLTestDB backup';  -- Specify the name of the job to be targeted to run on the server.
GO  -- 
```

<br>

## Validate

In this SQL query, we are retrieving the name of a job and the name of the server where the job is executed from the SQL Server Agent job tables. We use joins to link the `sysjobs`, `sysjobservers`, and `sysservers` tables together to get the desired information. The `WHERE` clause is used to filter the results to only include the job named 'Daily SQLTestDB backup'.

```sql
SELECT 
    j.name AS JobName,  -- Select the name of the job and alias it as JobName.
    s.srvname AS ServerName  -- Select the name of the server and alias it as ServerName.
FROM 
    msdb.dbo.sysjobs j  -- Specify the sysjobs table from the msdb database as the main table and alias it as j.
JOIN 
    msdb.dbo.sysjobservers js ON j.job_id = js.job_id  -- Join with the sysjobservers table using the job_id field and alias the table as js.
JOIN 
    master.dbo.sysservers s ON js.server_id = s.srvid  -- Join with the sysservers table from the master database using the server_id field and alias the table as s.
WHERE 
    j.name = N'Daily SQLTestDB backup';  -- Filter the results to only include rows where the job name is 'Daily SQLTestDB backup'.
```

- Output

| JobName                | ServerName    |
|------------------------|---------------|
| Daily SQLTestDB backup | sqlEnterprise |
