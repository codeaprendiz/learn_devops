# Full Backup To Disk

- [learn.microsoft.com » Create a Full Database Backup](https://learn.microsoft.com/en-us/sql/relational-databases/backup-restore/create-a-full-database-backup-sql-server?source=recommendations&view=sql-server-ver16#a-back-up-to-a-disk-device)

---

## Start the database locally

```bash
# Press cntr+c to stop, data would get deleted and container would get removed
docker run --rm -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=<your_password>" \
   -p 1433:1433 --name sql1 --hostname sql1 \
   mcr.microsoft.com/mssql/server:2022-latest
```

---

## Take Backup

```sql
USE SQLTestDB;
GO
BACKUP DATABASE SQLTestDB
TO DISK = 'SQLTestDB.bak'
   WITH FORMAT,
      MEDIANAME = 'SQLServerBackups',
      NAME = 'Full Backup of SQLTestDB';
GO
```

- Message

```bash
Commands completed successfully.
Processed 392 pages for database 'SQLTestDB', file 'SQLTestDB' on file 1.
Processed 2 pages for database 'SQLTestDB', file 'SQLTestDB_log' on file 1.
BACKUP DATABASE successfully processed 394 pages in 0.035 seconds (87.834 MB/sec).
```

- Exec into the container and validate

```bash
$ docker exec -it sql1 bash
mssql@sql1:/$ cd /var/opt/mssql/data
mssql@sql1:/var/opt/mssql/data$ du -sh SQLTestDB.bak         
3.2M    SQLTestDB.bak
```
