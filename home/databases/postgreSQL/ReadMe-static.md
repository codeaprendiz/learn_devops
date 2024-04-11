# ReadMe-static

- [ReadMe-static](#readme-static)
  - [Install PostgreSQL client](#install-postgresql-client)
    - [Ubuntu](#ubuntu)
    - [MacOS](#macos)
  - [Start PostgreSQL database locally using Docker](#start-postgresql-database-locally-using-docker)

## Install PostgreSQL client

### Ubuntu

- [how-to-install-psql-without-postgres](https://askubuntu.com/questions/1040765/how-to-install-psql-without-postgres)

```bash
$ apt-get install -y postgresql-client
.
$ psql --version  
psql (PostgreSQL) 14.8 (Ubuntu 14.8-0ubuntu0.22.04.1)
```

### MacOS

[pgadmin](https://www.pgadmin.org/download)

psql

[stackoverflow.com » Correct way to install psql without full Postgres on macOS](https://stackoverflow.com/questions/44654216/correct-way-to-install-psql-without-full-postgres-on-macos)

```bash
# For psql, 
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
```

## Start PostgreSQL database locally using Docker

[hub.docker.com » starting postgres locally](https://hub.docker.com/_/postgres)

Start the PostgreSQL database locally with the following command:

```bash
docker run --rm --name postgres16 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:16-alpine
```
