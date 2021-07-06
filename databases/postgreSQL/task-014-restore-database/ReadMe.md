[Docs](https://www.postgresql.org/docs/9.1/backup-dump.html)

- To restore the database dump you can use

```bash
psql -h <hostname>  -p 5432 --username=<username> --db <databasename> -f  filename.sql
```