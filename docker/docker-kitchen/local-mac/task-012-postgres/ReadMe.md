
- Run the following command

```bash
$ docker run -d \
--name my_postgres \
-v /tmp/data:/var/lib/postgresql/data \
-p 54320:5432 \
-e POSTGRES_PASSWORD=my_password postgres
7d93d3b28d3447f5bd4ed149a7084a7d46872b6efc7d2fc4720d25381dae9169
```

- Check the status of the container

```bash
$ docker ps -a | egrep -v "k8s"
CONTAINER ID   IMAGE                  COMMAND                  CREATED          STATUS          PORTS                                         NAMES
7d93d3b28d34   postgres               "docker-entrypoint.s…"   12 seconds ago   Up 11 seconds   0.0.0.0:54320->5432/tcp, :::54320->5432/tcp   my_postgres
```


- Try connecting to the database

```bash
$ psql -h 127.0.0.1 -p 54320 --username=postgres
Password for user postgres: 
psql (13.2, server 13.3 (Debian 13.3-1.pgdg100+1))
Type "help" for help.

postgres=# 
postgres=# \du
                                   List of roles
 Role name |                         Attributes                         | Member of 
-----------+------------------------------------------------------------+-----------
 postgres  | Superuser, Create role, Create DB, Replication, Bypass RLS | {}


```