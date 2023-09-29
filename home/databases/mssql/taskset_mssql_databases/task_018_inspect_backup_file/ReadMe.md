# Inspect the backup file

Let's say we took 1 full backup (INIT) backup followed by 3 differential backups. All stored to the disk.

- Full Backup with `INIT`, ran once

```sql
-- Switch to master
PRINT '...Switching to master';
USE [master];
GO

-- Create a full database backup first.  
BACKUP DATABASE [SQLTestDB]
TO DISK = 'SQLTestDB.bak'
WITH    INIT,
        NAME = 'Full Backup of SQLTestDB',
        DESCRIPTION = 'This is a full backup of the SQLTestDB database';
```

- Differential Backup, ran twice

```sql
-- Switch to master
PRINT '...Switching to master';
USE [master];
GO

-- Create a full database backup first.  
BACKUP DATABASE [SQLTestDB]
TO DISK = 'SQLTestDB.bak'
WITH    DIFFERENTIAL,
        NAME = 'Differential Backup of SQLTestDB',
        DESCRIPTION = 'This is a differential backup of the SQLTestDB database';
GO
```

- Inspecting the backup

```bash
# If you ran mssql via docker, you can login to container and fine the backup
mssql@sql1:/var/opt/mssql/data$ ls -ltrh SQLTestDB.bak 
-rw-r----- 1 mssql root 5.2M Sep 29 16:36 SQLTestDB.bak
```

- Using SQL

```sql
RESTORE HEADERONLY 
FROM DISK = 'SQLTestDB.bak';
```

- Output

| Backup Name                       | Backup Description                                      | Username | Password | Database Name | Position |
|-----------------------------------|---------------------------------------------------------|----------|----------|---------------|----------|
| Full Backup of SQLTestDB          | This is a full backup of the SQLTestDB database         | sa       | sql1     | SQLTestDB     | 1        |
| Differential Backup of SQLTestDB  | This is a differential backup of the SQLTestDB database | sa       | sql1     | SQLTestDB     | 2        |
| Differential Backup of SQLTestDB  | This is a differential backup of the SQLTestDB database | sa       | sql1     | SQLTestDB     | 3        |

```sql
RESTORE FILELISTONLY 
FROM DISK = 'SQLTestDB.bak';
```

- Output

| Logical Name   | PhysicalName                             |
|----------------|------------------------------------------|
| SQLTestDB      | /var/opt/mssql/data/SQLTestDB.mdf        |
| SQLTestDB_log  | /var/opt/mssql/data/SQLTestDB_log.ldf    |
