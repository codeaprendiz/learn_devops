- For taking the mongodump of single database 

```bash
$ mongodump --host <hostname> --port 27017 --username <user> --password <password> --authenticationDatabase <usually-admin db> --db <name-of-database-whose-backup-needs-to-be-taken> --gzip --archive=filename.zip
```

- For taking complete all databases backup

```bash
$ mongodump --host <hostname> --port 27017 --username <username> --password <password> --gzip --archive=standalone-complete-host.gzip
```