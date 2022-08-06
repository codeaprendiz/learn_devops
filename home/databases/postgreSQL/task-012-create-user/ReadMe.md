- To create a user you can run

```bash
postgres=> CREATE USER app_user_microservice WITH PASSWORD 'somepassword';
CREATE ROLE

```

- Granting priviledge to a database for that user

```bash
postgres=> GRANT ALL PRIVILEGES ON DATABASE <dbname> to app_user_microservice;
GRANT
```