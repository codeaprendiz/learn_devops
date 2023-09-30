# Restore from Full Backup on Disk with Init and Differential

- [learn.microsoft.com » Restore a differential database backup (SQL Server)](https://learn.microsoft.com/en-us/sql/relational-databases/backup-restore/restore-a-differential-database-backup-sql-server?view=sql-server-ver16)

- Copy the backup file `SQLTestDB.bak` to required location inside SQL Server container

```bash
$ docker exec -it sql1 bash
mssql@sql1:/$ cd /var/opt/mssql/
mssql@sql1:/var/opt/mssql$ mkdir backup
mssql@sql1:/var/opt/mssql$ exit 
exit

$ docker cp SQLTestDB.bak sql1:/var/opt/mssql/backup/SQLTestDB.bak
Successfully copied 5.52MB to sql1:/var/opt/mssql/backup/SQLTestDB.bak
```

- Switch to master and show databases

```sql
-- Switch to master
PRINT '...Switching to master';
USE [master];
GO

SELECT NAME FROM SYS.DATABASES;
GO
```

- Output

| Database Name |
|---------------|
| master        |
| tempdb        |
| model         |
| msdb          |

- You can inspect the backup file as well

- Output

| Backup Name              | Backup Description                                       |
|--------------------------|----------------------------------------------------------|
| Full Backup of SQLTestDB | This is a full backup of the SQLTestDB database          |
| Diff-1 of SQLTestDB      | This diff-1 should include id 7 row                      |
| Diff-2 of SQLTestDB      | This diff-2 should include id 8 row                      |

- Let's first restore the first i.e. `Full Backup of SQLTestDB`

```sql
-- Assume the database is lost, and restore full database,   
-- specifying the original full database backup and NORECOVERY,   
-- which allows subsequent restore operations to proceed.
RESTORE DATABASE [SQLTestDB]
FROM DISK = N'/var/opt/mssql/backup/SQLTestDB.bak' -- The backup is located at this location inside database
WITH 
    FILE = 1,
    NORECOVERY;
GO
```

- Let's check the databases

```sql
-- Switch to master
PRINT '...Switching to master';
USE [master];
GO

SELECT NAME FROM SYS.DATABASES;
GO
```

- Output

| Database Name |
|---------------|
| master        |
| tempdb        |
| model         |
| msdb          |
| SQLTestDB     |

- Lets restore the Diff-1 differential backup

```sql
-- Restore the first differential backup
RESTORE DATABASE [SQLTestDB]
FROM DISK = N'/var/opt/mssql/backup/SQLTestDB.bak' -- The backup is located at this location inside database
WITH 
    FILE = 2,
    NORECOVERY;
GO
```

- Let's restore the Diff-2 differential backup, which is the last one

```sql
-- Restore the second differential backup
RESTORE DATABASE [SQLTestDB]
FROM DISK = N'/var/opt/mssql/backup/SQLTestDB.bak' -- The backup is located at this location inside database
WITH 
    FILE = 3,
    RECOVERY;
GO
```

- Now let's check the data inside the database

```sql
USE SQLTestDB;
GO

SELECT * FROM SQLTest;
GO
```

| ID | C1    | DT1                     |
|----|-------|-------------------------|
| 1  | test1 | 2023-09-30 11:06:13.510 |
| 2  | test2 | 2023-09-30 11:06:13.513 |
| 3  | test3 | 2023-09-30 11:06:13.517 |
| 4  | test4 | 2023-09-30 11:06:13.520 |
| 5  | test5 | 2023-09-30 11:06:13.520 |
| 6  | test6 | 2023-09-30 11:06:13.523 |
| 7  | test7 | 2023-09-30 11:09:03.667 |
| 8  | test8 | 2023-09-30 11:12:28.603 |