# taskset_mssql_databases

> Auto generated ReadMe. Number of tasks: 37
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

| Task     | Description                                                                                                                                                            |
|----------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| task_000 | [task_000_docs_and_vscode_setup](taskset_mssql_databases/task_000_docs_and_vscode_setup)                                                                               |
| task_001 | [task_001_connecting_to_db](taskset_mssql_databases/task_001_connecting_to_db)                                                                                         |
| task_002 | [task_002_show_databases](taskset_mssql_databases/task_002_show_databases)                                                                                             |
| task_003 | [task_003_drop_database](taskset_mssql_databases/task_003_drop_database)                                                                                               |
| task_004 | [task_004_get_current_database](taskset_mssql_databases/task_004_get_current_database)                                                                                 |
| task_005 | [task_005_create_database](taskset_mssql_databases/task_005_create_database)                                                                                           |
| task_006 | [task_006_check_version](taskset_mssql_databases/task_006_check_version)                                                                                               |
| task_007 | [task_007_create_database__if_not_exists__vars_navchar](taskset_mssql_databases/task_007_create_database__if_not_exists__vars_navchar)                                 |
| task_008 | [task_008_count_tables_in_database](taskset_mssql_databases/task_008_count_tables_in_database)                                                                         |
| task_009 | [task_009_switch_to_particular_db](taskset_mssql_databases/task_009_switch_to_particular_db)                                                                           |
| task_010 | [task_010_create_table__if_not_exists](taskset_mssql_databases/task_010_create_table__if_not_exists)                                                                   |
| task_011 | [task_011_insert_records__if_not_exists](taskset_mssql_databases/task_011_insert_records__if_not_exists)                                                               |
| task_012 | [task_012_select_all_from_table](taskset_mssql_databases/task_012_select_all_from_table)                                                                               |
| task_013 | [task_013_create_credential_and_select_credential](taskset_mssql_databases/task_013_create_credential_and_select_credential)                                           |
| task_014 | [task_014_full_backup_to_s3_compatible_object_storage__with_format](taskset_mssql_databases/task_014_full_backup_to_s3_compatible_object_storage__with_format)         |
| task_015 | [task_015_get_connection_info__kill](taskset_mssql_databases/task_015_get_connection_info__kill)                                                                       |
| task_016 | [task_016_full_backup_to_disk__with_format](taskset_mssql_databases/task_016_full_backup_to_disk__with_format)                                                         |
| task_017 | [task_017_show_all_tables_in_specific_database](taskset_mssql_databases/task_017_show_all_tables_in_specific_database)                                                 |
| task_018 | [task_018_inspect_backup_to_disk__with_init_and_differential](taskset_mssql_databases/task_018_inspect_backup_to_disk__with_init_and_differential)                     |
| task_019 | [task_019_restore_full_backup__from_disk](taskset_mssql_databases/task_019_restore_full_backup__from_disk)                                                             |
| task_020 | [task_020_full_backup_to_disk__with_init_and_differential](taskset_mssql_databases/task_020_full_backup_to_disk__with_init_and_differential)                           |
| task_021 | [task_021_restore_from_full_backup_on_disk__with_init_and_differential](taskset_mssql_databases/task_021_restore_from_full_backup_on_disk__with_init_and_differential) |
| task_022 | [task_022_full_base_and_differential_backup_to_s3](taskset_mssql_databases/task_022_full_base_and_differential_backup_to_s3)                                           |
| task_023 | [task_023_restore_full_base_and_differential_backup_to_s3](taskset_mssql_databases/task_023_restore_full_base_and_differential_backup_to_s3)                           |
| task_024 | [task_024_get_current_date_and_time](taskset_mssql_databases/task_024_get_current_date_and_time)                                                                       |
| task_025 | [task_025_licence_and_version](taskset_mssql_databases/task_025_licence_and_version)                                                                                   |
| task_026 | [task_026_check_default_schema](taskset_mssql_databases/task_026_check_default_schema)                                                                                 |
| task_027 | [task_027_stored_procedures](taskset_mssql_databases/task_027_stored_procedures)                                                                                       |
| task_028 | [task_028_create_and_validate_jobs](taskset_mssql_databases/task_028_create_and_validate_jobs)                                                                         |
| task_029 | [task_029_add_jobstep_and_validate](taskset_mssql_databases/task_029_add_jobstep_and_validate)                                                                         |
| task_030 | [task_030_add_job_schedule_and_validate](taskset_mssql_databases/task_030_add_job_schedule_and_validate)                                                               |
| task_031 | [task_031_attach_schedule_to_job_and_validate](taskset_mssql_databases/task_031_attach_schedule_to_job_and_validate)                                                   |
| task_032 | [task_032_add_job_to_server_and_validate](taskset_mssql_databases/task_032_add_job_to_server_and_validate)                                                             |
| task_033 | [task_033_logical_backup](taskset_mssql_databases/task_033_logical_backup)                                                                                             |
| task_034 | [task_034_check_when_tables_in_given_database_were_last_updated](taskset_mssql_databases/task_034_check_when_tables_in_given_database_were_last_updated)               |
| task_035 | [task_035_slow_queries](taskset_mssql_databases/task_035_slow_queries)                                                                                                 |
| task_036 | [task_036_monitoring_using_influxdb_telegraf_grafana](taskset_mssql_databases/task_036_monitoring_using_influxdb_telegraf_grafana)                                     |
