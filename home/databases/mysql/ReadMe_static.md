# ReadMe_static

- [ReadMe\_static](#readme_static)
  - [Mac](#mac)
    - [Start the MySQL database in ephemeral mode](#start-the-mysql-database-in-ephemeral-mode)
    - [Start the MySQL database in persistent mode](#start-the-mysql-database-in-persistent-mode)
    - [Connect to the MySQL database](#connect-to-the-mysql-database)

## Mac

[hub.docker.com » starting mysql locally](https://hub.docker.com/_/mysql)

Start the MySQL database locally with the following command:

### Start the MySQL database in ephemeral mode

```bash
# Start the MySQL database locally, in ephemeral mode
docker run --rm -it --name mysql_lts -p 3306:3306 -e MYSQL_ROOT_PASSWORD=secret -d mysql:lts
# Execute a bash shell in the container
docker exec -it mysql_lts bash
```

### Start the MySQL database in persistent mode

```bash
# Start the MySQL database locally in persistent mode
docker run --name mysql_lts -p 3306:3306 -e MYSQL_ROOT_PASSWORD=secret -v $(pwd)/mysql_data:/var/lib/mysql -d mysql:lts

# Execute a bash shell in the container
docker exec -it mysql_lts bash
```

### Connect to the MySQL database

```bash
# Connect to the MySQL database in the container
mysql -hlocalhost -uroot -psecret
```


