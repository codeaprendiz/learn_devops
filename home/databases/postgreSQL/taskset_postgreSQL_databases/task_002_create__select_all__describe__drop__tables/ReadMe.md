# Create -- Select all -- Drop -- Tables

- [Create -- Select all -- Drop -- Tables](#create----select-all----drop----tables)
  - [Create](#create)
  - [Select all tables](#select-all-tables)
  - [Describe](#describe)
  - [Drop](#drop)

## Create

To create a table

```sql
CREATE TABLE IF NOT EXISTS products
(
    id SERIAL,
    name TEXT NOT NULL,
    price NUMERIC(10,2) NOT NULL DEFAULT 0.00,
    CONSTRAINT products_pkey PRIMARY KEY (id)
);
```

## Select all tables

```sql
SELECT table_schema || '.' || table_name 
FROM information_schema.tables 
WHERE table_type = 'BASE TABLE' AND table_schema NOT IN ('pg_catalog', 'information_schema');
```

Output

```bash
postgres=# SELECT table_schema || '.' || table_name 
postgres-# FROM information_schema.tables 
postgres-# WHERE table_type = 'BASE TABLE' AND table_schema NOT IN ('pg_catalog', 'information_schema');
    ?column?     
-----------------
 public.products
(1 row)
```

You can also run the following to get list of relations/tables

```bash
\d
```

```bash
postgres=# \d
              List of relations
 Schema |      Name       |   Type   | Owner 
--------+-----------------+----------+-------
 public | products        | table    | root
 public | products_id_seq | sequence | root
(2 rows)
```

## Describe

[postgres-describe-table](https://www.postgresqltutorial.com/postgresql-describe-table/)

Run the following

```sql
SELECT 
   table_name, 
   column_name, 
   data_type 
FROM 
   information_schema.columns
WHERE 
  table_name = '<your_table_name>';
```

Output

```bash
postgres=# SELECT 
postgres-#    table_name, 
postgres-#    column_name, 
postgres-#    data_type 
postgres-# FROM 
postgres-#    information_schema.columns
postgres-# WHERE 
postgres-#   table_name = 'products';
 table_name | column_name | data_type 
------------+-------------+-----------
 products   | id          | integer
 products   | price       | numeric
 products   | name        | text
(3 rows)
```

You can also do it using the following command

```bash
\d <tableName>
```

```bash
## Switch to right database
postgres=# \c postgres
psql (13.2, server 13.3 (Debian 13.3-1.pgdg100+1))
You are now connected to database "postgres" as user "postgres".
postgres=# \d products
                               Table "public.products"
 Column |     Type      | Collation | Nullable |               Default                
--------+---------------+-----------+----------+--------------------------------------
 id     | integer       |           | not null | nextval('products_id_seq'::regclass)
 name   | text          |           | not null | 
 price  | numeric(10,2) |           | not null | 0.00
Indexes:
    "products_pkey" PRIMARY KEY, btree (id)
```

## Drop

Use the following to drop a table

```bash
DROP TABLE <schemaName>.<tableName>;
```

Output

```bash
postgres=# drop table products;
DROP TABLE
postgres=# \d
Did not find any relations.
postgres=#
```
