# Attach Schedule to Job and Validate

- [learn.microsoft.com » sp_attach_schedule](https://learn.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/sp-attach-schedule-transact-sql?view=sql-server-ver16)
- [learn.microsoft.com » dbo.sysjobs](https://learn.microsoft.com/en-us/sql/relational-databases/system-tables/dbo-sysjobs-transact-sql?view=sql-server-ver16)
- [learn.microsoft.com » dbo.sysjobschedules](https://learn.microsoft.com/en-us/sql/relational-databases/system-tables/dbo-sysjobschedules-transact-sql?view=sql-server-ver16)
- [learn.microsoft.com » dbo.sysschedules](https://learn.microsoft.com/en-us/sql/relational-databases/system-tables/dbo-sysschedules-transact-sql?view=sql-server-ver16)

## Background

| Object Name              | Type             | Description                                                                                                                                           |
|--------------------------|------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------|
| msdb.dbo.sysjobs         | Table            | Stores information for each scheduled job in SQL Server. Includes details like job ID, name, enabled status, etc.                                     |
| msdb.dbo.sysjobschedules | Table            | Contains information for each time a job is scheduled to run. Links jobs in `sysjobs` to their respective schedules in `sysschedules`.                |
| msdb.dbo.sysschedules    | Table            | Contains information about the schedules for jobs, alerts, and operators, such as the schedule's type, frequency, active range, etc.                  |
| sp_attach_schedule       | Stored Procedure | A system stored procedure that attaches an existing schedule to a job. It takes the job name and schedule name as parameters and links them together. |

## Attach schedule to a job

This script is attaching a schedule named `EveryMinuteBackupSchedule` to a job named `Daily SQLTestDB backup` within the SQL Server Agent, using the `msdb` system database. This means that the job `Daily SQLTestDB backup` will be executed following the schedule defined as `EveryMinuteBackupSchedule`. If the schedule or job does not exist, or if there's an issue with permissions, the stored procedure will return an error.

```sql
USE msdb;  -- Switch to using the 'msdb' database which is used by SQL Server Agent for scheduling alerts and jobs.
GO  -- A batch terminator, it signals the end of a batch of Transact-SQL statements to the SQL Server utilities.

EXEC sp_attach_schedule  -- Execute the stored procedure to attach a schedule to a job.
   @job_name = N'Daily SQLTestDB backup',  -- Specify the name of the job to which the schedule will be attached.
   @schedule_name = N'EveryMinuteBackupSchedule';  -- Specify the name of the schedule to be attached to the job.
GO  -- Batch terminator.
```

## Validate

This following script selects the job name and schedule name from the msdb database, joining the sysjobs, sysjobschedules, and sysschedules tables together and filtering the results based on the specified job name and schedule name. If the script returns a row with the specified job name and schedule name, it indicates that the schedule is attached to the job. If it returns no rows, it indicates that the schedule is not attached to the job.

```sql
USE msdb;  -- Use the msdb system database which stores SQL Server Agent data
GO  -- Submit the previous statement batch for execution

SELECT 
    j.name AS JobName,  -- Select and rename the 'name' column from sysjobs as JobName
    s.name AS ScheduleName  -- Select and rename the 'name' column from sysschedules as ScheduleName
FROM 
    msdb.dbo.sysjobs j  -- Specify the sysjobs table in msdb database with alias 'j'
JOIN 
    msdb.dbo.sysjobschedules js ON j.job_id = js.job_id  -- Join sysjobschedules (alias 'js') using the job_id as the key
JOIN 
    msdb.dbo.sysschedules s ON js.schedule_id = s.schedule_id  -- Join sysschedules (alias 's') using the schedule_id as the key
WHERE 
    j.name = N'Daily SQLTestDB backup'  -- Filter the results to only include rows where the job name is 'Daily SQLTestDB backup'
    AND s.name = N'EveryMinuteBackupSchedule';  -- AND where the schedule name is 'EveryMinuteBackupSchedule'
GO  -- Submit the SELECT statement batch for execution
```

- Output

| JobName                | ScheduleName              |
|------------------------|---------------------------|
| Daily SQLTestDB backup | EveryMinuteBackupSchedule |
