# Create Credential

- [Create Credential UseCase](https://learn.microsoft.com/en-us/sql/relational-databases/tutorial-sql-server-backup-and-restore-to-s3?view=sql-server-ver16&tabs=tsql#create-credential)

In SQL Server, a `CREDENTIAL` is a record that contains the authentication information (like username and password or access key and secret key) required to connect to a resource outside of SQL Server. This can be a remote data source, a web service, a file system, or, in this case, an S3-compatible storage service.

The `CREATE CREDENTIAL` statement is used to store these details securely within SQL Server so that they can be used by SQL Server to authenticate against external services without exposing sensitive information in scripts or queries.

```sql
CREATE CREDENTIAL   [s3://<endpoint>:<port>/<bucket>]
WITH
        IDENTITY    = 'S3 Access Key',
        SECRET      = '<AccessKeyID>:<SecretKeyID>';
GO
```

When we are using this in OCI object storage with name  `backup-bucket` location in `ap-mumbai-1` and namespace `abcdefghijklm`. You
an find the namespace in bucket details page.

```sql
-- You do not need to include <> while giving access key and secret key values, they should be separated by :
CREATE CREDENTIAL   [s3://abcdefghikjlm.compat.objectstorage.ap-mumbai-1.oraclecloud.com:443/backup-bucket]
WITH
        IDENTITY    = 'S3 Access Key',
        SECRET      = '<AccessKeyID>:<SecretKeyID>';
GO
```

In the context of the provided script:

- `s3://<endpoint>:<port>/<bucket>`: This is the name of the credential. It's a way to identify which external resource this credential pertains to.
  
- `IDENTITY`: This is typically the username or identifier for the external service. For S3-compatible storage, it's usually set to `'S3 Access Key'` as a standard identifier.
  
- `SECRET`: This is typically the password or key for the external service. For S3-compatible storage, it's a combination of the `AccessKeyID` and `SecretKeyID`, separated by a colon.

---

## Select Credential

```sql
-- Check the contents of sys.credentials table
SELECT * FROM sys.credentials
```

---

## If exists Drop credentials, otherwise create

```sql
IF EXISTS (SELECT * FROM sys.credentials WHERE name = 's3://abcdefghikjlm.compat.objectstorage.ap-mumbai-1.oraclecloud.com:443/backup-bucket')
    BEGIN
        DROP CREDENTIAL "s3://abcdefghikjlm.compat.objectstorage.ap-mumbai-1.oraclecloud.com:443/backup-bucket";
        PRINT 'Credential ' + 's3://abcdefghikjlm.compat.objectstorage.ap-mumbai-1.oraclecloud.com:443/backup-bucket' + ' dropped successfully.';
    END
ELSE
    BEGIN
        PRINT 'Credential ' + 's3://abcdefghikjlm.compat.objectstorage.ap-mumbai-1.oraclecloud.com:443/backup-bucket' + ' not found.';
    END
```
