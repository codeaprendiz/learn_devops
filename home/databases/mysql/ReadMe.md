# taskset_mysql_databases

> Auto generated ReadMe. Number of tasks: 6

- [ReadMe\_static](#readme_static)
  - [Mac](#mac)
    - [Start the MySQL database in ephemeral mode](#start-the-mysql-database-in-ephemeral-mode)
    - [Start the MySQL database in persistent mode](#start-the-mysql-database-in-persistent-mode)
    - [Connect to the MySQL database](#connect-to-the-mysql-database)

## Mac

[hub.docker.com » starting mysql locally](https://hub.docker.com/_/mysql)

Start the MySQL database locally with the following command:

### Start the MySQL database in ephemeral mode

```bash
# Start the MySQL database locally, in ephemeral mode
docker run --rm -it --name mysql_lts -p 3306:3306 -e MYSQL_ROOT_PASSWORD=secret -d mysql:lts
# Execute a bash shell in the container
docker exec -it mysql_lts bash
```

### Start the MySQL database in persistent mode

```bash
# Start the MySQL database locally in persistent mode
docker run --name mysql_lts -p 3306:3306 -e MYSQL_ROOT_PASSWORD=secret -v $(pwd)/mysql_data:/var/lib/mysql -d mysql:lts

# Execute a bash shell in the container
docker exec -it mysql_lts bash
```

### Connect to the MySQL database

```bash
# Connect to the MySQL database in the container
mysql -hlocalhost -uroot -psecret
```



| Task     | Description                                                                                                    |
|----------|----------------------------------------------------------------------------------------------------------------|
| task_001 | [task_001_connecting_to_db](taskset_mysql_databases/task_001_connecting_to_db)                                 |
| task_002 | [task_002_mysqldump](taskset_mysql_databases/task_002_mysqldump)                                               |
| task_003 | [task_003_managing_databases](taskset_mysql_databases/task_003_managing_databases)                             |
| task_004 | [task_004_managing_user](taskset_mysql_databases/task_004_managing_user)                                       |
| task_005 | [task_005_set_transaction_isolation_levels](taskset_mysql_databases/task_005_set_transaction_isolation_levels) |
| task_006 | [task_006_managing_tables](taskset_mysql_databases/task_006_managing_tables)                                   |
