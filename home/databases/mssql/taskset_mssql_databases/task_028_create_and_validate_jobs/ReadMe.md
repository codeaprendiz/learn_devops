
# Create a Job And Validate

- [learn.microsoft.com » Create a Job](https://learn.microsoft.com/en-us/sql/ssms/agent/create-a-job?view=sql-server-ver16)
- [learn.microsoft.com » sp_add_job](https://learn.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/sp-add-job-transact-sql?view=sql-server-ver16)
- [learn.microsoft.com » dbo.sysjobs](https://learn.microsoft.com/en-us/sql/relational-databases/system-tables/dbo-sysjobs-transact-sql?view=sql-server-ver16)

## Background

| Name          | Type             | Description                                                                                                                                                                                                                                                                                                                                                  |
|---------------|------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `msdb`        | Database         | The `msdb` database is a system database that is used by SQL Server Agent for scheduling alerts and jobs, and recording operators. It stores data for SQL Server Agent configurations, job information, job steps, job schedules, etc. It plays a crucial role in SQL Server jobs and alerts management.                                                     |
| `dbo.sysjobs` | Table            | The `dbo.sysjobs` table is located in the `msdb` database and is part of SQL Server Agent. It stores information about each job that is registered with SQL Server Agent, such as the job name, description, enabled status, date created, date modified, etc. It is often queried directly or joined with other tables to retrieve job-related information. |
| `sp_add_job`  | Stored Procedure | `sp_add_job` is a system stored procedure that is used to create a job in SQL Server Agent. It allows you to specify various properties of the job, such as the job name, owner, description, etc. It is located in the `msdb` database and is commonly used in scripts and applications to automate and manage job creation in SQL Server.                  |

## Creating a job

This script creates a new SQL Server Agent job named `'Daily SQLTestDB backup'` with a specified description and owner using the `sp_add_job` stored procedure.

```sql
USE msdb ;  -- Use the 'msdb' database for subsequent statements. The 'msdb' database is a system database that stores SQL Server Agent job information, among other things.
GO  -- Execute the previous batch of statements.

-- Add a new job using a stored procedure
EXEC dbo.sp_add_job  -- Execute the 'sp_add_job' stored procedure from the 'dbo' schema. 'sp_add_job' is a system stored procedure used to create a new SQL Server Agent job.
    @job_name = N'Daily SQLTestDB backup',  --  This line sets the `@job_name` parameter to `'Daily SQLTestDB backup'`. `@job_name` specifies the name of the job being created. The `N` prefix denotes that the string is in Unicode.
    @description = 'Job to backup SampleDB database',  --  This line sets the `@description` parameter, providing a textual description of the job being created.
    @owner_login_name = 'sa';  -- This line sets the `@owner_login_name` parameter to `'sa'`. `@owner_login_name` specifies the name of the login that owns the job. Note that using 'sa' (system administrator) is often discouraged in production environments due to security considerations, so ensure to replace it with an appropriate login if needed.
GO  -- Execute the batch of statements.
```

---

## Validate the job

This script retrieves and displays information about a SQL Server Agent job named `'Daily SQLTestDB backup'` from the `sysjobs` table in the `msdb` database. If the job exists, information about it will be displayed; if not, no rows will be returned.

```sql
USE msdb;  -- Switch to using the 'msdb' database.
GO  -- Submit the previous statement batch for execution.

-- Validate if Jobs was created
SELECT  -- Begin a query to retrieve data.
    job_id,  -- Select the 'job_id' column, which uniquely identifies each job.
    name AS JobName,  -- Select and rename the 'name' column to 'JobName' for output.
    description AS JobDescription,  -- Select and rename the 'description' column to 'JobDescription' for output.
    enabled,  -- Select the 'enabled' column, indicating whether the job is enabled or not.
    date_created AS DateCreated,  -- Select and rename the 'date_created' column to 'DateCreated' for output.
    date_modified AS DateModified  -- Select and rename the 'date_modified' column to 'DateModified' for output.
FROM  -- Specify the table from which to retrieve the data.
    msdb.dbo.sysjobs  -- Specify the 'sysjobs' table in the 'dbo' schema of the 'msdb' database. `msdb.dbo.sysjobs` is a system table that stores information about SQL Server Agent jobs.
WHERE  -- Introduce a filter to limit the rows returned.
    name = N'Daily SQLTestDB backup';  -- This line filters the results to only return rows where the `name` column equals `'Daily SQLTestDB backup'`. The `N` before the string literal indicates that the string is in Unicode.
```

- Output

| job_id                               | JobName                | JobDescription                  | enabled | DateCreated             | DateModified            |
|--------------------------------------|------------------------|---------------------------------|---------|-------------------------|-------------------------|
| 8995cf2c-18b2-4a7e-974a-d11e4ccf2305 | Daily SQLTestDB backup | Job to backup SampleDB database | 1       | 2023-10-10 13:41:46.223 | 2023-10-10 13:41:49.483 |
