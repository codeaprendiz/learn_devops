### mongorestore

#### Restoring the mongodump back into mongodb database

- `standalone-complete-host-1616062771.gzip` includes the complete backup including all the databases.

- `--nsInclude` include only these databases.

- `--drop` drop the existing collections if exist

- Ensuring we are 
```bash
$ uri_complete=mongodb://username:password@mongodbhost.company.com:27017/admin:27017/admin

$ mongorestore --uri=$uri_complete -v --gzip --archive=standalone-complete-host-1616062771.gzip --nsInclude="module-*" --nsInclude="cli*" --numInsertionWorkersPerCollection=15 --bypassDocumentValidation --drop --preserveUUID --convertLegacyIndexes
```


#### Restoring dump of single database
- Note the protocol here is `mongodb+srv`

```bash
mongorestore --uri="mongodb+srv://<username>:<password>@<hostname>/<database-to-be-restored>?retryWrites=true&w=majority" --gzip --archive=filename.gzip --numInsertionWorkersPerCollection=15 --bypassDocumentValidation --drop --convertLegacyIndexes
```