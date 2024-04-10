# Install PostgreSQL client

## Ubuntu

- [how-to-install-psql-without-postgres](https://askubuntu.com/questions/1040765/how-to-install-psql-without-postgres)

```bash
$ apt-get install -y postgresql-client
.
$ psql --version  
psql (PostgreSQL) 14.8 (Ubuntu 14.8-0ubuntu0.22.04.1)
```

## MacOS

[pgadmin](https://www.pgadmin.org/download)

psql

[stackoverflow.com » Correct way to install psql without full Postgres on macOS](https://stackoverflow.com/questions/44654216/correct-way-to-install-psql-without-full-postgres-on-macos)

```bash
# For psql, 
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
```
