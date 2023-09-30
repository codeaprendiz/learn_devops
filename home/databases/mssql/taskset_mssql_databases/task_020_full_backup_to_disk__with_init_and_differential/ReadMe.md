# Full Backup to Disk with Init And Differential

- [learn.microsoft.com » Differential backups (SQL Server)](https://learn.microsoft.com/en-us/sql/relational-databases/backup-restore/differential-backups-sql-server?view=sql-server-ver16)

- Assuming that the database (SQLTestDB) and table (SQLTest) is already created.

- Taking the first backup `WITH INIT` which acts as base for all the differential backups

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

- Let's check the status

```sql
RESTORE HEADERONLY 
FROM DISK = 'SQLTestDB.bak';
```

- Output

| Backup Name           | Backup Description                                 |
|-----------------------|----------------------------------------------------|
| Full Backup of SQLTestDB | This is a full backup of the SQLTestDB database |

- Now let's add some data into the table

```sql
IF NOT EXISTS (SELECT 1 FROM SQLTest WHERE ID = 7)
    INSERT INTO SQLTest (ID, c1) VALUES (7, 'test7');
```

- Let's take differential backup 1

```sql
-- Create a differential backup of database upon base.  
BACKUP DATABASE [SQLTestDB]
TO DISK = 'SQLTestDB.bak'
WITH    DIFFERENTIAL,
        NAME = 'Diff-1 of SQLTestDB',
        DESCRIPTION = 'This diff-1 should include id 7 row';
GO
```

- Check the status again

```sql
RESTORE HEADERONLY 
FROM DISK = 'SQLTestDB.bak';
```

- Output

| Backup Name              | Backup Description                                       |
|--------------------------|----------------------------------------------------------|
| Full Backup of SQLTestDB | This is a full backup of the SQLTestDB database          |
| Diff-1 of SQLTestDB      | This diff-1 should include id 7 row                      |

- Now let's insert one more row

```sql
IF NOT EXISTS (SELECT 1 FROM SQLTest WHERE ID = 8)
    INSERT INTO SQLTest (ID, c1) VALUES (8, 'test8');
```

- Let's take another diff-2 backup

```sql
-- Create a differential backup of database upon base.  
BACKUP DATABASE [SQLTestDB]
TO DISK = 'SQLTestDB.bak'
WITH    DIFFERENTIAL,
        NAME = 'Diff-2 of SQLTestDB',
        DESCRIPTION = 'This diff-2 should include id 8 row';
GO
```

- Check the status again

```sql
RESTORE HEADERONLY 
FROM DISK = 'SQLTestDB.bak';
```

- Output

| Backup Name              | Backup Description                                       |
|--------------------------|----------------------------------------------------------|
| Full Backup of SQLTestDB | This is a full backup of the SQLTestDB database          |
| Diff-1 of SQLTestDB      | This diff-1 should include id 7 row                      |
| Diff-2 of SQLTestDB      | This diff-2 should include id 8 row                      |
