# Restore Full Backup From Disk

- [learn.microsoft.com » Restore a Backup from a Device (SQL Server)
](https://learn.microsoft.com/en-us/sql/relational-databases/backup-restore/restore-a-backup-from-a-device-sql-server?view=sql-server-ver16)

- Assuming you have the backup file `SQLTestDB.bak`, you can move it to the required folder

```bash
# Assuming you started mssql using docker
# Exec into container sql1
$ docker exec -it sql1 bash
mssql@sql1:/$ cd /var/opt/mssql/
mssql@sql1:/var/opt/mssql$ mkdir backup
mssql@sql1:/var/opt/mssql$ exit

$ docker cp SQLTestDB.bak sql1:/var/opt/mssql/backup/SQLTestDB.bak
Successfully copied 4.51MB to sql1:/var/opt/mssql/backup/SQLTestDB.bak
```

- Check databases before restore

```sql
SELECT NAME FROM SYS.DATABASES;
GO
```

- Output

| Name   |
|--------|
| master |
| tempdb |
| model  |
| msdb   |

```sql
RESTORE DATABASE [SQLTestDB]
FROM DISK = N'/var/opt/mssql/backup/SQLTestDB.bak' -- The backup is located at this location inside database
WITH 
    FILE = 1,
    NOUNLOAD,
    STATS = 5;
GO
```

- Messages

```bash
6 percent processed.
...
...
100 percent processed.
Processed 536 pages for database 'SQLTestDB', file 'SQLTestDB' on file 1.
Processed 2 pages for database 'SQLTestDB', file 'SQLTestDB_log' on file 1.
RESTORE DATABASE successfully processed 538 pages in 0.018 seconds (233.289 MB/sec).
```

- Check databases after restore

```sql
SELECT NAME FROM SYS.DATABASES;
GO
```

- Output

| Name      |
|-----------|
| master    |
| tempdb    |
| model     |
| msdb      |
| SQLTestDB |

- Validate data

```sql
USE SQLTestDB;
GO

SELECT * FROM SQLTestDB;
GO
```

- Output

| ID | C1    | DT1                     |
|----|-------|-------------------------|
| 1  | test1 | 2023-09-30 06:19:18.317 |
| 2  | test2 | 2023-09-30 06:19:18.320 |
| 3  | test3 | 2023-09-30 06:19:18.320 |
| 4  | test4 | 2023-09-30 06:19:18.320 |
| 5  | test5 | 2023-09-30 06:19:18.320 |
| 6  | test6 | 2023-09-30 06:19:18.320 |
