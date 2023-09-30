# Restore Full Base And Differential Backup From S3

- [learn.microsoft.com » Differential backups (SQL Server)](https://learn.microsoft.com/en-us/sql/relational-databases/backup-restore/differential-backups-sql-server?view=sql-server-ver16)
- [aws.amazon.com » Backup SQL Server databases to Amazon S3](https://aws.amazon.com/blogs/modernizing-with-aws/backup-sql-server-to-amazon-s3/)
- [learn.microsoft.com » SQL Server backup to URL for S3-compatible object storage](https://learn.microsoft.com/en-us/sql/relational-databases/backup-restore/sql-server-backup-to-url-s3-compatible-object-storage?view=sql-server-ver16)

> Note: Appending is not supported. To overwrite a backup, use WITH FORMAT. This means each differential backup would be a separate file on S3.

- You will have to create credential as per task-013.
- Assuming you have also created the Database (SQLTestDB) and Table (SQLTest) with initial data

- Switch to master and check available databases

```sql
-- Switch to master
PRINT '...Switching to master';
USE [master];
GO

SELECT NAME FROM SYS.DATABASES;
GO
```

- Output

| Databases |
|-----------|
| master    |
| tempdb    |
| model     |
| msdb      |

- We have 3 backup files, `SQLTestDB-Base.bak`, `SQLTestDB-Diff-1.bak`, `SQLTestDB-Diff-2.bak`

- Let's first restore the base backup i.e. `SQLTestDB-Base.bak`

```sql
-- Assuming
    -- Credentials created
    -- Namespace: abcdefghijklm
    -- Bucket Name : backup-bucket,
    -- Database to Backup : SQLTestDB

-- Assume the database is lost, and restore full database,   
-- specifying the original full database backup and NORECOVERY,   
-- which allows subsequent restore operations to proceed.
RESTORE DATABASE [SQLTestDB]
FROM URL = 's3://abcdefghikjlm.compat.objectstorage.ap-mumbai-1.oraclecloud.com:443/backup-bucket/SQLTestDB-Base.bak'
WITH 
    FILE = 1,
    NORECOVERY,
    BACKUP_OPTIONS = '{"s3": {"region":"ap-mumbai-1"}}';
GO
```

- Let's restore the first differential backup `SQLTestDB-Diff-1.bak`

```sql
RESTORE DATABASE [SQLTestDB]
FROM URL = 's3://abcdefghikjlm.compat.objectstorage.ap-mumbai-1.oraclecloud.com:443/backup-bucket/SQLTestDB-Diff-1.bak'
WITH 
    NORECOVERY,
    BACKUP_OPTIONS = '{"s3": {"region":"ap-mumbai-1"}}';
GO
```

- Let's restore the second differential backup `SQLTestDB-Diff-2.bak`

```sql
RESTORE DATABASE [SQLTestDB]
FROM URL = 's3://abcdefghikjlm.compat.objectstorage.ap-mumbai-1.oraclecloud.com:443/backup-bucket/SQLTestDB-Diff-2.bak'
WITH 
    RECOVERY,
    BACKUP_OPTIONS = '{"s3": {"region":"ap-mumbai-1"}}';
GO
```

- Validate the restored data

```sql
USE SQLTestDB;
GO

SELECT * FROM SQLTest;
GO
```

- Output

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
