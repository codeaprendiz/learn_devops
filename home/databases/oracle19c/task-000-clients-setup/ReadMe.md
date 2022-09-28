# Clients

## Docs Referred

[autonomous-database/doc/download-client-credentials.html](https://docs.oracle.com/en-us/iaas/autonomous-database/doc/download-client-credentials.html)
[prepare-oci-odbc-and-jdbc-oci-connections-01.html](https://docs.oracle.com/en-us/iaas/autonomous-database/doc/prepare-oci-odbc-and-jdbc-oci-connections-01.html)
[oracle.com/database/technologies/instant-client/downloads.html](https://www.oracle.com/database/technologies/instant-client/downloads.html)


## Prerequisite installation required

```bash
╰─ brew install java

╰─ java -version
openjdk version "19" 2022-09-20
OpenJDK Runtime Environment Homebrew (build 19)
OpenJDK 64-Bit Server VM Homebrew (build 19, mixed mode, sharing)
```


## Using SQL Developer

[autonomous-database/doc/connect-oracle-sql-developer.html](https://docs.oracle.com/en-us/iaas/autonomous-database/doc/connect-oracle-sql-developer.html)

- Will work in both the cases when the mTLS is enabled or not
- The database should be reachable by the client machine

[sql-developer](https://www.oracle.com/database/sqldeveloper/technologies/download/)

- Go to the database

![img.png](.images/db.png)


- Click on `DB connection`

- Download the `instance` wallet

- Remember the password you create while downloading the wallet `mypass`

- Open SQL developer and click on create new connection

- Set the following values and click on test connection
  - Connection Type : Cloud Wallet
  - Username and password 
  - Config zip file which you downloaded

![img.png](.images/sql-developer-connect.png)


### SQLCL

[iaas/autonomous-database/doc/connect-oracle-sqlcl.html](https://docs.oracle.com/en-us/iaas/autonomous-database/doc/connect-oracle-sqlcl.html)


[www.oracle.com/database/sqldeveloper/technologies/sqlcl/download](https://www.oracle.com/database/sqldeveloper/technologies/sqlcl/download/)

OR [homebrew sqlcl](https://formulae.brew.sh/cask/sqlcl)

```bash
brew install --cask sqlcl
```

