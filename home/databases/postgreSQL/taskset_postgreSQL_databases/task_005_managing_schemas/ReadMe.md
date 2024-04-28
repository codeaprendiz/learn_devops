# Managing Schemas

- [Managing Schemas](#managing-schemas)
  - [List all Schemas](#list-all-schemas)

## List all Schemas

To list all the schemas you can use

```sql
SELECT schema_name FROM information_schema.schemata;
```

Output

```bash
postgres=# SELECT schema_name FROM information_schema.schemata;
    schema_name     
--------------------
 public
 information_schema
 pg_catalog
 pg_toast
(4 rows)
```

You can also use

```sql
SELECT nspname FROM pg_catalog.pg_namespace;
```

Output

```bash
postgres=# SELECT nspname FROM pg_catalog.pg_namespace;
      nspname       
--------------------
 pg_toast
 pg_catalog
 public
 information_schema
(4 rows)
```

You can also use

```sql
\dn
```

```sql
postgres=> \dn
    List of schemas
  Name  |     Owner
--------+---------------
 public | adminuser
(1 row)
```
