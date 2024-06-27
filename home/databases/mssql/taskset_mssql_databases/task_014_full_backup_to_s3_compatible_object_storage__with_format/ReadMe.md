# Backup To S3 Compatible Object Storage

- [learn.microsoft.com » SQL Server backup to URL for S3-compatible object storage](https://learn.microsoft.com/en-us/sql/relational-databases/backup-restore/sql-server-backup-to-url-s3-compatible-object-storage?view=sql-server-ver16)
- [learn.microsoft.com » Quickstart: SQL backup and restore to S3-Compatible Object Storage](https://learn.microsoft.com/en-us/sql/relational-databases/tutorial-sql-server-backup-and-restore-to-s3?view=sql-server-ver16&tabs=SSMS)

---

<br>

## Start the database locally

```bash
# Press cntr+c to stop, data would get deleted and container would get removed
docker run --rm -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=<your_password>" \
   -p 1433:1433 --name sql1 --hostname sql1 \
   mcr.microsoft.com/mssql/server:2022-latest
```

---

<br>

## Backup to OCI object storage

- Create credential using task_013 first.
- Backup script

```sql
USE [master];
GO

-- Assuming
    -- Credentials created
    -- Namespace: abcdefghijklm
    -- Bucket Name : backup-bucket,
    -- Database to Backup : SQLTestDB

BACKUP DATABASE [SQLTestDB]
TO      URL = 's3://abcdefghikjlm.compat.objectstorage.ap-mumbai-1.oraclecloud.com:443/backup-bucket/SQLTestDB.bak'
WITH    FORMAT /* overwrite any existing backup sets */
,       STATS = 10
,       COMPRESSION
,       BACKUP_OPTIONS = '{"s3": {"region":"ap-mumbai-1"}}';
```

> Note: You have to add BACKUP_OPTIONS which is not given explicitly in the documentation example.

---

<br>

## Validate Backup on s3

```bash
AWS_ACCESS_KEY_ID=<your_key_id> AWS_SECRET_ACCESS_KEY=<your_secret_key> aws s3 ls  s3://backup-bucket --endpoint-url https://abcdefghikjlm.compat.objectstorage.ap-mumbai-1.oraclecloud.com --region ap-mumbai-1 
```
