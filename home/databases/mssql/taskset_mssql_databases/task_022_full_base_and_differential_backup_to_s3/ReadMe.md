# Full Base And Differential Backup to S3

- [learn.microsoft.com » Differential backups (SQL Server)](https://learn.microsoft.com/en-us/sql/relational-databases/backup-restore/differential-backups-sql-server?view=sql-server-ver16)
- [aws.amazon.com » Backup SQL Server databases to Amazon S3](https://aws.amazon.com/blogs/modernizing-with-aws/backup-sql-server-to-amazon-s3/)
- [learn.microsoft.com » SQL Server backup to URL for S3-compatible object storage](https://learn.microsoft.com/en-us/sql/relational-databases/backup-restore/sql-server-backup-to-url-s3-compatible-object-storage?view=sql-server-ver16)

> Note: Appending is not supported. To overwrite a backup, use WITH FORMAT. This means each differential backup would be a separate file on S3.

- You will have to create credential as per task-013.
- Assuming you have also created the Database (SQLTestDB) and Table (SQLTest) with initial data

- Let's take the first full backup which will act as base for all the subsequent differential backups

```sql
USE [master];
GO

-- Assuming
    -- Credentials created
    -- Namespace: abcdefghijklm
    -- Bucket Name : backup-bucket,
    -- Database to Backup : SQLTestDB
-- Take the first full backup which would act as base for all the differentil backups
BACKUP DATABASE [SQLTestDB]
TO      URL = 's3://abcdefghikjlm.compat.objectstorage.ap-mumbai-1.oraclecloud.com:443/backup-bucket/SQLTestDB-Base.bak'
WITH    INIT /* initiate a base for taking differential backups */
,       BACKUP_OPTIONS = '{"s3": {"region":"ap-mumbai-1"}}';
```

- Let's add some data to our Table in DB

```sql
IF NOT EXISTS (SELECT 1 FROM SQLTest WHERE ID = 7)
    INSERT INTO SQLTest (ID, c1) VALUES (7, 'test7');
```

- Let's take the first differential backup

```sql
-- Take the first differential backup
BACKUP DATABASE [SQLTestDB]
TO      URL = 's3://abcdefghikjlm.compat.objectstorage.ap-mumbai-1.oraclecloud.com:443/backup-bucket/SQLTestDB-Diff-1.bak'
WITH    DIFFERENTIAL /* Take the first differential backup */
,       BACKUP_OPTIONS = '{"s3": {"region":"ap-mumbai-1"}}';
```

- Let's add some more data to our Table in DB

```sql
IF NOT EXISTS (SELECT 1 FROM SQLTest WHERE ID = 8)
    INSERT INTO SQLTest (ID, c1) VALUES (8, 'test8');
```

- Let's take the second differential backup

```sql
-- Take the second differential backup
BACKUP DATABASE [SQLTestDB]
TO      URL = 's3://abcdefghikjlm.compat.objectstorage.ap-mumbai-1.oraclecloud.com:443/backup-bucket/SQLTestDB-Diff-2.bak'
WITH    DIFFERENTIAL /* Take the first differential backup */
,       BACKUP_OPTIONS = '{"s3": {"region":"ap-mumbai-1"}}';
```

- You can check the backups on S3 now

```bash
$ AWS_ACCESS_KEY_ID=<your_key_id> AWS_SECRET_ACCESS_KEY=<your_secret_key> aws s3 ls  s3://backup-bucket --endpoint-url https://abcdefghikjlm.compat.objectstorage.ap-mumbai-1.oraclecloud.com --region ap-mumbai-1 
2023-09-30 16:08:55   21757952 SQLTestDB-Base.bak
2023-09-30 16:17:11   21757952 SQLTestDB-Diff-1.bak
2023-09-30 16:20:59   21757952 SQLTestDB-Diff-2.bak
```
