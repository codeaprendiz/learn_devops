# Managing Database

- [Managing Database](#managing-database)
  - [Create](#create)
  - [Show all databases](#show-all-databases)
  - [Connect to required database](#connect-to-required-database)
  - [Drop a database](#drop-a-database)
  - [Dump](#dump)
  - [Restore](#restore)

<br>

## Create

[sql-createdatabase](https://www.postgresql.org/docs/9.0/sql-createdatabase.html)

To create a database with owner as `admin`

```bash
CREATE DATABASE sales OWNER admin
CREATE DATABASE
```

<br>

## Show all databases

[Doc](https://www.postgresqltutorial.com/postgresql-show-databases/)

To get the list of all databases

```bash
postgres=# \l
```

You can also use

```bash
SELECT datname FROM pg_database;
```

<br>

## Connect to required database

- First see all databases

```bash
postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
```

- To connect to right db

```bash
postgres=# \c postgres
psql (13.2, server 13.3 (Debian 13.3-1.pgdg100+1))
You are now connected to database "postgres" as user "postgres".
```

<br>

## Drop a database

[Docs](https://www.postgresql.org/docs/8.2/sql-dropdatabase.html)

- You can use the following command

```bash
DROP DATABASE <database_name>
```

<br>

## Dump

[Docs](https://www.postgresql.org/docs/9.1/backup-dump.html)

To dump the database you can use

```bash
pg_dump -h <hostname> -p 5432 --username=<username> --db <databasename> > outputfile.sql 
```

<br>

## Restore

[Docs](https://www.postgresql.org/docs/9.1/backup-dump.html)

- To restore the database dump you can use

```bash
psql -h <hostname>  -p 5432 --username=<username> --db <databasename> -f  filename.sql
```
