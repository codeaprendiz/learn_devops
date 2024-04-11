# Create -- show all -- Database

- [Create -- show all -- Database](#create----show-all----database)
  - [Create](#create)
  - [Show all databases](#show-all-databases)

## Create

[sql-createdatabase](https://www.postgresql.org/docs/9.0/sql-createdatabase.html)

To create a database with owner as `admin`

```bash
CREATE DATABASE sales OWNER admin
CREATE DATABASE
```

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