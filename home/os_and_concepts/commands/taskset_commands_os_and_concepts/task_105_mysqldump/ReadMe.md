# mysqldump

- [mysqldump](https://dev.mysql.com/doc/refman/8.0/en/mysqldump.html)

## EXAMPLES

Taking the mysqldump

```bash
mysqldump --databases <database-name>  --master-data=2 --single-transaction --order-by-primary -r filename.sql -h <hostname> -u <username> -p
```