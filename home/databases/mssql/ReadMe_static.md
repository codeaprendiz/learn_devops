# MS-SQL

## [IDE](https://learn.microsoft.com/en-us/sql/azure-data-studio/download-azure-data-studio?view=sql-server-ver16&tabs=redhat-install%2Credhat-uninstall#download-azure-data-studio)

Plugins

- MySQL
- PostgreSQL
- SandDance for Azure Data Studio
- SQL Database Projects
- SQL Server Schema Compare
- Visual Studio IntelliCode

## [Backup](https://learn.microsoft.com/en-us/sql/t-sql/statements/backup-transact-sql?view=sql-server-ver16)

- [COMPRESSION](https://learn.microsoft.com/en-us/sql/t-sql/statements/backup-transact-sql?view=sql-server-ver16#compression) : Explicitly enables backup compression.
- [FORMAT](https://learn.microsoft.com/en-us/sql/t-sql/statements/backup-transact-sql?view=sql-server-ver16#-noformat--format-) Specifies that a new media set be created.
- [MEDIANAME](https://learn.microsoft.com/en-us/sql/t-sql/statements/backup-transact-sql?view=sql-server-ver16#medianame---media_name--media_name_variable-) : Specifies the media name for the entire backup media set
- [NORECOVERY](https://learn.microsoft.com/en-us/sql/t-sql/statements/backup-transact-sql?view=sql-server-ver16#-norecovery--standby--undo_file_name-) : Backs up the tail of the log and leaves the database in the RESTORING state
- [STATS](https://learn.microsoft.com/en-us/sql/t-sql/statements/backup-transact-sql?view=sql-server-ver16#stats---percentage-) : Displays a message each time another percentage completes, and is used to gauge progress

## [Restore](https://learn.microsoft.com/en-us/sql/t-sql/statements/restore-statements-arguments-transact-sql?view=sql-server-ver16)

- [FILE](https://learn.microsoft.com/en-us/sql/t-sql/statements/restore-statements-arguments-transact-sql?view=sql-server-ver16#file---logical_file_name_in_backup-logical_file_name_in_backup_var) : Names a file to include in the database restore.
- [NOUNLOAD](https://learn.microsoft.com/en-us/sql/t-sql/statements/restore-statements-arguments-transact-sql?view=sql-server-ver16#-unload--nounload-) : Specifies that after the RESTORE operation the tape remains loaded on the tape drive.
- [STATS](https://learn.microsoft.com/en-us/sql/t-sql/statements/restore-statements-arguments-transact-sql?view=sql-server-ver16#stats---percentage-) : Displays a message each time another percentage completes, and is used to gauge progress


## Blogs

- [aws.amazon.com » Backup SQL Server databases to Amazon S3](https://aws.amazon.com/blogs/modernizing-with-aws/backup-sql-server-to-amazon-s3/)

## Upgrade Considerations

- [learn.microsoft.com » Restore a Database to a New Location (SQL Server)](https://learn.microsoft.com/en-us/sql/relational-databases/backup-restore/restore-a-database-to-a-new-location-sql-server?view=sql-server-ver16)

> If you restore a SQL Server 2005 (9.x) or higher database to SQL Server, the database is automatically upgraded.

- [learn.microsoft.com » Upgrade SQL Server](https://learn.microsoft.com/en-us/sql/database-engine/install-windows/upgrade-sql-server?view=sql-server-ver16)
