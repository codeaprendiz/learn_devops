# Create And Validate Job Step

- [learn.microsoft.com » dbo.sysjobs](https://learn.microsoft.com/en-us/sql/relational-databases/system-tables/dbo-sysjobs-transact-sql?view=sql-server-ver16)
- [learn.microsoft.com » dbo.sysjobsteps](https://learn.microsoft.com/en-us/sql/relational-databases/system-tables/dbo-sysjobsteps-transact-sql?view=sql-server-ver16)
- [learn.microsoft.com » sp_add_jobstep](https://learn.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/sp-add-jobstep-transact-sql?view=sql-server-ver16)

## Background

| Object Name            | Type             | Description                                                                                                                                                                                                                                              |
|------------------------|------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `msdb`                 | Database         | The `msdb` database is a system database that is used by SQL Server Agent for scheduling alerts and jobs, and by other features such as SQL Server Management Studio, Service Broker, and Database Mail.                                                 |
| `msdb.dbo.sysjobs`     | Table            | The `sysjobs` table, located in the `msdb` database, stores information about each scheduled job to be executed by SQL Server Agent. This includes details like the job name, description, enabled status, and more.                                     |
| `msdb.dbo.sysjobsteps` | Table            | The `sysjobsteps` table, also in the `msdb` database, contains details about each step in a SQL Server Agent job. This includes the command to be executed, the order of the step within its job, the database context, and more.                        |
| `sp_add_jobstep`       | Stored Procedure | `sp_add_jobstep` is a system stored procedure that is used to create a step in a SQL Server Agent job. It allows you to specify various parameters like the step name, command, database context, and more to define the actions and flow of a job step. |


## Constructing unique name for the backupfile

```sql
SELECT REPLACE(REPLACE(REPLACE(CONVERT(NVARCHAR, GETDATE(), 120), ':', ''), '-', ''), ' ', '') AS FormattedDateTime;
```

Each `REPLACE()` function is nested inside the next, meaning that the innermost `REPLACE()` function is evaluated first, then the next outer `REPLACE()` function is applied to its result, and so on. This allows you to perform multiple replacements in a single expression by nesting them.

Let's break down the nested `REPLACE()` functions and construct the statement step by step:

### Step 1: Convert Date and Time to String

```sql
SELECT CONVERT(NVARCHAR, GETDATE(), 120) AS FormattedDateTime;
```

This converts the current date and time into a string format `YYYY-MM-DD HH:MI:SS`.

### Step 2: Remove Colons from the Time

```sql
SELECT REPLACE(CONVERT(NVARCHAR, GETDATE(), 120), ':', '') AS FormattedDateTime;
```

This removes the colons `:` from the time portion, resulting in a string like `YYYY-MM-DD HHMISS`.

### Step 3: Remove Hyphens from the Date

```sql
SELECT REPLACE(REPLACE(CONVERT(NVARCHAR, GETDATE(), 120), ':', ''), '-', '') AS FormattedDateTime;
```

This removes the hyphens `-` from the date portion, resulting in a string like `YYYYMMDD HHMISS`.

### Step 4: Remove Space between Date and Time

```sql
SELECT REPLACE(REPLACE(REPLACE(CONVERT(NVARCHAR, GETDATE(), 120), ':', ''), '-', ''), ' ', '') AS FormattedDateTime;
```

This removes the space ` ` between the date and time portions, resulting in a string like `YYYYMMDDHHMISS`.

---

## Add a new job step to existing job

```sql
-- Switch to the 'msdb' database, which is used by SQL Server Agent for configuring and managing scheduled jobs and other automated tasks.
USE msdb;  
GO  -- Execute the previous batch of statements.

-- Add a new step to an existing SQL Server Agent job using the 'sp_add_jobstep' stored procedure.
EXEC sp_add_jobstep  
    @job_name = N'Daily SQLTestDB backup',  -- Specify the name of the job to which the step will be added.
    @step_name = N'Backup database',  -- Specify the name of the new step.
    @subsystem = N'TSQL',  -- Specify the subsystem as 'TSQL', indicating that the step will execute Transact-SQL statements.
    -- The following command parameter contains T-SQL code that will be executed when the job step runs.
    --                      -- Declare a variable to hold the backup file name.
    --                      -- Construct the backup file name by concatenating a base name, a formatted date/time string, and a file extension.
    --                      -- Perform a backup of the 'SQLTestDB' database, specifying the dynamically constructed file name as the target.
    --                      -- Specify additional backup options: 'FORMAT' initializes the backup media, 'MEDIANAME' assigns a name to the backup media, and 'NAME' assigns a name to the backup set.
    @command = N'DECLARE @BackupFileName NVARCHAR(255);  
                SET @BackupFileName = N''SQLTestDB_'' 
                + REPLACE(REPLACE(REPLACE(CONVERT(NVARCHAR, GETDATE(), 120), '':'', ''''), ''-'', ''''), '' '', '''') 
                + ''.bak''; 
                BACKUP DATABASE SQLTestDB 
                TO DISK = @BackupFileName 
                WITH FORMAT, MEDIANAME = ''SQLServerBackups'', NAME = ''Full Backup of SQLTestDB'';',
    @retry_attempts = 5,  -- Specify the number of retry attempts if the step fails.
    @retry_interval = 5,  -- Specify the interval (in minutes) between retry attempts.
    @database_name = 'SQLTestDB';  -- Specify the name of the database in which to execute the step.
GO  -- Execute the batch of statements.

```

## Validate the job step created

```sql
-- Validate Job Steps
-- Retrieve information about the steps of a specific SQL Server Agent job.

SELECT 
    j.name AS JobName,  -- Select the name of the job.
    js.step_id,  -- Select the ID of the step within the job.
    js.step_name,  -- Select the name of the step.
    js.command,  -- Select the command (T-SQL, PowerShell, etc.) that the step will execute.
    js.subsystem  -- Select the subsystem (T-SQL, CmdExec, PowerShell, etc.) that the step uses.
FROM 
    msdb.dbo.sysjobs j  -- From the sysjobs table in the msdb database (aliased as j).
JOIN 
    msdb.dbo.sysjobsteps js ON j.job_id = js.job_id  -- Join to the sysjobsteps table (aliased as js) using the job_id column to match rows.
WHERE 
    j.name = N'Daily SQLTestDB backup';  -- Filter the results to only show rows where the job name is 'Daily SQLTestDB backup'.
```

- Output

| JobName                | step_id | step_name       | command        | subsystem |
|------------------------|---------|-----------------|----------------|-----------|
| Daily SQLTestDB backup | 1       | Backup database | `command here` | TSQL      |
