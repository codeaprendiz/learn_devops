# Clients

## Docs Referred

- [autonomous-database/doc/connect-dedicated-adb.html](https://docs.oracle.com/en-us/iaas/autonomous-database/doc/connect-dedicated-adb.html)


## Prerequisite installation required

```bash
╰─ brew install java

╰─ java -version
openjdk version "19" 2022-09-20
OpenJDK Runtime Environment Homebrew (build 19)
OpenJDK 64-Bit Server VM Homebrew (build 19, mixed mode, sharing)
```


### Using SQL Developer

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

### Using SQLPlus

[autonomous-database/doc/connect-sqlplus.html](https://docs.oracle.com/en-us/iaas/autonomous-database/doc/connect-sqlplus.html)

```bash
╰─ brew tap InstantClientTap/instantclient
╰─ brew update                     
╰─ brew install instantclient-basic
╰─ brew install instantclient-sqlplus


╰─ sqlplus -v                                                                                                         

SQL*Plus: Release 19.0.0.0.0 - Production
Version 19.8.0.0.0
```

- Go to the database

![img.png](.images/db.png)


- Click on `DB connection`

- Download the `instance` wallet

- Remember the password you create while downloading the wallet `mypass`

```bash
╰─ mkdir wallet-unzipped                                                                                            
╰─ mv Wallet_deletemedb.zip wallet-unzipped 
╰─ unzip Wallet_deletemedb.zip
╰─ ls
README                cwallet.sso           ewallet.pem           ojdbc.properties      tnsnames.ora
Wallet_deletemedb.zip ewallet.p12           keystore.jks          sqlnet.ora            truststore.jks

## Only ZSH users ## https://unix.stackexchange.com/questions/706227/how-can-i-use-the-sed-command-to-replace-home-user-with
╰─ print -P '%~'
~/workspace/codeaprendiz/devops-essentials/home/databases/oracle19c/task-000-clients-setup/wallet-unzipped

## Make changes in sqlnet.ora, 
╰─ cat sqlnet.ora    
WALLET_LOCATION = (SOURCE = (METHOD = file) (METHOD_DATA = (DIRECTORY="/Users/username/workspace/codeaprendiz/devops-essentials/home/databases/oracle19c/task-000-clients-setup/wallet-unzipped")))
SSL_SERVER_DN_MATCH=yes


╰─ export TNS_ADMIN=/Users/username/workspace/codeaprendiz/devops-essentials/home/databases/oracle19c/task-000-clients-setup/wallet-unzipped


╰─ cat tnsnames.ora | grep  deletemedb_high
deletemedb_high = (.........)

╰─ sqlplus -l  admin/yourdbpassword@deletemedb_high
Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.17.0.1.0
SQL> 
```




### SQLCL

- [autonomous-database/doc/connect-oracle-sqlcl.html](https://docs.oracle.com/en-us/iaas/autonomous-database/doc/connect-oracle-sqlcl.html)
- [homebrew sqlcl](https://formulae.brew.sh/cask/sqlcl)

```bash
brew install --cask sqlcl
```

- Download the wallet in the same way as above

- Change the `sqlnet.ora` file in unzipped wallet

```bash
╰─ cat sqlnet.ora                          
WALLET_LOCATION = (SOURCE = (METHOD = file) (METHOD_DATA = (DIRECTORY="/Users/username/workspace/codeaprendiz/devops-essentials/home/databases/oracle19c/task-000-clients-setup/wallet-unzipped")))
SSL_SERVER_DN_MATCH=yes
```
- Set the `TNS_ADMIN`

```bash
╰─ export TNS_ADMIN=/Users/username/workspace/codeaprendiz/devops-essentials/home/databases/oracle19c/task-000-clients-setup/wallet-unzipped
```

- Connect

```bash
╰─ sql /nolog
SQLcl: Release 22.2 Production on Fri Sep 30 07:41:27 2022
Copyright (c) 1982, 2022, Oracle.  All rights reserved.
SQL> set cloudconfig /Users/username/workspace/codeaprendiz/devops-essentials/home/databases/oracle19c/task-000-clients-setup/Wallet_deletemedb.zip
SQL> connect admin/qWert1234567@deletemedb_high
Connected.
```


### Dbeaver

- [dbeaver.io/download](https://dbeaver.io/download)

- New connection -> Oracle
- Select `TNS` and give the 
> TNS Names path : /Users/username/workspace/codeaprendiz/devops-essentials/home/databases/oracle19c/task-000-clients-setup/wallet-unzipped

- Give the username and password for the database
- Now go to `Driver Properties`. It might download drivers needed to connect depending on whether they are already present
  or not.
- Set the values for the following
  - javax.net.ssl.keyStore : /Users/username/workspace/codeaprendiz/devops-essentials/home/databases/oracle19c/task-000-clients-setup/wallet-unzipped/keystore.jks
  - javax.net.ssl.keyStorePassword: <your_wallet_password_that_you_gave_while_downloading_wallet>
  - javax.net.ssl.trustStore: /Users/username/workspace/codeaprendiz/devops-essentials/home/databases/oracle19c/task-000-clients-setup/wallet-unzipped/truststore.jks
  - javax.net.ssl.trustStorePassword : <your_wallet_password_that_you_gave_while_downloading_wallet>

![img.png](.images/dbeaver.png)