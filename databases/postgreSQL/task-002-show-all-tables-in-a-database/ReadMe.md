## Show all tables present in a database

```sql
SELECT table_schema || '.' || table_name 
FROM information_schema.tables 
WHERE table_type = 'BASE TABLE' AND table_schema NOT IN ('pg_catalog', 'information_schema');
```

```bash
db=> SELECT table_schema || '.' || table_name 
db-> FROM information_schema.tables 
db-> WHERE table_type = 'BASE TABLE' AND table_schema NOT IN ('pg_catalog', 'information_schema');
          ?column?          
----------------------------
 schema.table1
 schema.table2
```