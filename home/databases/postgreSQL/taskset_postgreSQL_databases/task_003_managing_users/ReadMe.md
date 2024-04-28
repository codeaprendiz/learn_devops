# Managing Users

- [Managing Users](#managing-users)
  - [Create a User](#create-a-user)
  - [Grant Priviledges to user `app_user_microservice` on Database `student`](#grant-priviledges-to-user-app_user_microservice-on-database-student)
  - [Validate Priviledges for user `app_user_microservice` on Database](#validate-priviledges-for-user-app_user_microservice-on-database)
    - [Database level priviledges](#database-level-priviledges)
    - [Schema level priviledges](#schema-level-priviledges)
  - [Grant Priviledges to user `app_user_microservice` on ALL Tables in `public` schema for `bank` database](#grant-priviledges-to-user-app_user_microservice-on-all-tables-in-public-schema-for-bank-database)
    - [Validate Priviledges for user `app_user_microservice` on Tables](#validate-priviledges-for-user-app_user_microservice-on-tables)
    - [Table level priviledges](#table-level-priviledges)
  - [Show all Users](#show-all-users)
  - [Reset Password for a User](#reset-password-for-a-user)

## Create a User

To create a user you can run

```sql
CREATE USER app_user_microservice WITH PASSWORD 'somepassword';
```

```bash
# CREATE USER <username> WITH PASSWORD '<password>'; 
postgres=> CREATE USER app_user_microservice WITH PASSWORD 'somepassword';
CREATE ROLE

```

## Grant Priviledges to user `app_user_microservice` on Database `student`

Granting priviledge to a database for that user

```bash
GRANT ALL PRIVILEGES ON DATABASE student to app_user_microservice;
```

Output

```bash
postgres=> GRANT ALL PRIVILEGES ON DATABASE <dbname> to <username>;
GRANT
```

## Validate Priviledges for user `app_user_microservice` on Database

### Database level priviledges

```sql
SELECT datname, has_database_privilege('app_user_microservice', datname, 'CONNECT') 
FROM pg_database;
```

```bash
postgres=# SELECT datname, has_database_privilege('app_user_microservice', datname, 'CONNECT') 
postgres-# FROM pg_database;
   datname   | has_database_privilege 
-------------+------------------------
 postgres    | t
 root        | t
 template1   | t
 template0   | t
 bank | t
(5 rows)
```

### Schema level priviledges

```sql
SELECT nspname, has_schema_privilege('app_user_microservice', nspname, 'USAGE') 
FROM pg_catalog.pg_namespace;
```

```bash
postgres=# SELECT nspname, has_schema_privilege('app_user_microservice', nspname, 'USAGE') 
postgres-# FROM pg_catalog.pg_namespace;
      nspname       | has_schema_privilege 
--------------------+----------------------
 pg_toast           | f
 pg_catalog         | t
 public             | t
 information_schema | t
(4 rows)
```

## Grant Priviledges to user `app_user_microservice` on ALL Tables in `public` schema for `bank` database

Make sure you are connected to the database `bank`

```bash
\c bank
```

```sql
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO app_user_microservice;
```

```bash
postgres=# \c bank
You are now connected to database "bank" as user "root".
postgres=# GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO app_user_microservice;
GRANT
```

### Validate Priviledges for user `app_user_microservice` on Tables

### Table level priviledges

```sql
SELECT tablename, has_table_privilege('app_user_microservice', tablename, 'SELECT') 
FROM pg_tables
WHERE schemaname = 'public';
```

```bash
bank=# SELECT tablename, has_table_privilege('app_user_microservice', tablename, 'SELECT') 
bank-# FROM pg_tables
bank-# WHERE schemaname = 'public';
     tablename     | has_table_privilege 
-------------------+---------------------
 accounts          | t
 entries           | t
 transfers         | t
 schema_migrations | t
(4 rows)
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

## Reset Password for a User

[postgresql.org/docs » ALTER USER](https://www.postgresql.org/docs/8.0/sql-alteruser.html)

```sql
ALTER USER app_user_microservice WITH PASSWORD 'secret';
```

Output

```bash
## Username : app_user_microservice, new password : secret
postgres=# ALTER USER app_user_microservice WITH PASSWORD 'secret';
```
