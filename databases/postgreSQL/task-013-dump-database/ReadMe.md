[Docs](https://www.postgresql.org/docs/9.1/backup-dump.html)

- To dump the database you can use 

```bash
$ pg_dump -h <hostname> -p 5432 --username=<username> --db <databasename> > outputfile.sql 
```

