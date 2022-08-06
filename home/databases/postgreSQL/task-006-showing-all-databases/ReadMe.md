[Doc](https://www.postgresqltutorial.com/postgresql-show-databases/)

To get the list of all databases

```bash
postgres=# \l

```


You can also use

```bash
SELECT datname FROM pg_database;
```