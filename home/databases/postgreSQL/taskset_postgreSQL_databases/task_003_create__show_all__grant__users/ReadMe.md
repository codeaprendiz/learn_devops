# Create -- Show all -- Grant Priviledges -- Users

## Create a User

To create a user you can run

```bash
postgres=> CREATE USER app_user_microservice WITH PASSWORD 'somepassword';
CREATE ROLE

```

## Grant Priviledges

Granting priviledge to a database for that user

```bash
GRANT ALL PRIVILEGES ON DATABASE <dbname> to app_user_microservice;
```

Output

```bash
postgres=> GRANT ALL PRIVILEGES ON DATABASE <dbname> to app_user_microservice;
GRANT
```

## Show all Users

Run the following

```bash
\du
```

Output

```bash
postgres=# \du
                             List of roles
 Role name |                         Attributes                         
-----------+------------------------------------------------------------
 root      | Superuser, Create role, Create DB, Replication, Bypass RLS
```