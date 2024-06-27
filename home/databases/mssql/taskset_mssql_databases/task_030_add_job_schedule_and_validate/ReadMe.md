# Add Job Schedule And Validate

- [learn.microsoft.com » sp_add_schedule](https://learn.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/sp-add-schedule-transact-sql?view=sql-server-ver16)
- [learn.microsoft.com » msdb.dbo.sysschedules](https://learn.microsoft.com/en-us/sql/relational-databases/system-tables/dbo-sysschedules-transact-sql?view=sql-server-ver16)

<br>

## Background

| Object Name             | Type             | Description                                                                                                                                                   |
|-------------------------|------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `sp_add_schedule`       | Stored Procedure | A system stored procedure that allows users to create a new schedule for executing SQL Server Agent Jobs at specific times or in response to specific events. |
| `msdb.dbo.sysschedules` | System Table     | A table in the MSDB database that stores details about schedules in SQL Server Agent, including their names, types, and when they are supposed to run.        |

<br>

## Create a Job Schedule

> This takes backup every minute and can create havoc in production. Change the schedule accordingly.

```sql
-- Add a new schedule to SQL Server Agent using the 'sp_add_schedule' stored procedure.
EXEC dbo.sp_add_schedule  
    @schedule_name = N'EveryMinuteBackupSchedule',  -- Specify the name of the new schedule.
    @freq_type = 4,  -- Set the frequency type to 'Daily'. (4 indicates 'Daily')
    @freq_interval = 1,  -- Set the frequency interval to 'Every 1 day'.
    @freq_subday_type = 4,  -- Set the subday type to 'Minutes'. (4 indicates 'Minutes')
    @freq_subday_interval = 1,  -- Set the subday interval to 'Every 1 minute'.
    @active_start_time = 170800,  -- Set the active start time to 5:08:00 PM (time is in HHMMSS format).
    @active_end_time = 235959;  -- Set the active end time to 11:59:59 PM (time is in HHMMSS format).
```

<br>

## Validate the created job schedule

```sql
-- Use the msdb database
USE msdb;
-- GO is a batch terminator, it signals the end of a batch of statements to SQL Server.
GO

-- Select specific columns from the sysschedules table
SELECT 
    name AS ScheduleName,  -- Select the name of the schedule and alias it as ScheduleName.
    freq_type,  -- Select the type of frequency (e.g., once, daily, weekly, etc.).
    freq_interval,  -- Select the interval of frequency (e.g., every 1 day, every 2 weeks, etc.).
    freq_subday_type,  -- Select the type of subday frequency (e.g., hour, minute, etc.).
    freq_subday_interval,  -- Select the interval of subday frequency (e.g., every 1 minute, every 2 hours, etc.).
    active_start_time,  -- Select the time when the schedule becomes active (in HHMMSS format).
    active_end_time  -- Select the time when the schedule becomes inactive (in HHMMSS format).
    schedule_id  -- Select the unique identifier for the schedule, which is an integer that uniquely identifies each schedule in the sysschedules table.
-- Specify the table to select the columns from
FROM 
    msdb.dbo.sysschedules  -- From the sysschedules table in the msdb database.
-- Filter the results to only include rows where the schedule name is 'EveryMinuteBackupSchedule'
WHERE 
    name = N'EveryMinuteBackupSchedule';  -- Where the name of the schedule is 'EveryMinuteBackupSchedule'.

```

- Output

| ScheduleName              | freq_type | freq_interval | freq_subday_type | freq_subday_interval | active_start_time | active_end_time | schedule_id |
|---------------------------|-----------|---------------|------------------|----------------------|-------------------|-----------------|-------------|
| EveryMinuteBackupSchedule | 4         | 1             | 4                | 1                    | 84200             | 235959          | 8           |
