- To list all the schemas you can use

```sql
SELECT schema_name FROM information_schema.schemata;
    schema_name
-------------------
```

- You can also use

```sql
SELECT nspname FROM pg_catalog.pg_namespace;
      nspname
--------------------

```

- You can also use

```sql
postgres=> \dn
    List of schemas
  Name  |     Owner
--------+---------------
 public | adminuser
(1 row)
```