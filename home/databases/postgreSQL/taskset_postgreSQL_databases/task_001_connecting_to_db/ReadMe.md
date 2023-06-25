- Use the following command

```bash
$ psql -h <hostname> -p <port-usually-5432> --username=admin -d <database-name>     
Password for user admin: 

```

- If the database is newly created and does not contain any other databases, then you can use `postgres` as DB name. This is present by default.

```bash
$ psql -h <hostname> -p <port-usually-5432> --username=admin --db postgres
Password for user admin: 
```
