### mysqldump

Taking the mysqldump

```bash
mysqldump --databases <database-name>  --master-data=2 --single-transaction --order-by-primary -r filename.sql -h <hostname> -u <username> -p
```