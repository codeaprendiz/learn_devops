# Taking a logical backup

- [learn.microsoft.com » install sqlpackage](https://learn.microsoft.com/en-us/sql/tools/sqlpackage/sqlpackage?view=sql-server-ver16)

```bash
mkdir sqlpackage
unzip ~/Downloads/sqlpackage-osx-<version string>.zip -d ~/sqlpackage
chmod +x ~/sqlpackage/sqlpackage
echo 'export PATH="$PATH:~/sqlpackage"' >> ~/.bash_profile
source ~/.bash_profile
sqlpackage
```

- Before executing SQL package

```bash
sudo spctl --master-disable
```

- SQL Package command to take logical backup

```bash
~/sqlpackage/sqlpackage /Action:Export /SourceServername:localhost /SourceDatabaseName:<DBNAME_TO_EXPORT> /SourceUser:<user like `sa`> /SourcePassword:<Password_to_connect> /TargetFile:<DBNAME.bacpac> /SourceTrustServerCertificate:True
```

- SQL Package command to import the logical backup

```bash
~/sqlpackage/sqppackage /Action:Import /TargetServername: localhost /TargetDatabaseName:<DBNAME_TO_IMPORT> /TargetUser:<user like `sa`> /TargetPassword:<Password_to_connect> /SourceFile:<DBNAME.bacpac> /TargetTrustServerCertificate: True 
```

- After execution

```bash
sudo spctl --master-enable
```