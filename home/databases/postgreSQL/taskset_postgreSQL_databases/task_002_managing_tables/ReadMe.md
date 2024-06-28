# Managing Tables

- [Managing Tables](#managing-tables)
  - [Create](#create)
  - [Select all tables except ones in `pg_catalog` and `information_schema`](#select-all-tables-except-ones-in-pg_catalog-and-information_schema)
  - [Check tables and corresponding schema](#check-tables-and-corresponding-schema)
  - [Describe](#describe)
  - [Insert into table](#insert-into-table)
  - [Select all from table](#select-all-from-table)
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

## Select all tables except ones in `pg_catalog` and `information_schema`

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

## Check tables and corresponding schema

```sql
SELECT schemaname, tablename FROM pg_tables;
```

Output

```bash
bank=# SELECT schemaname, tablename FROM pg_tables LIMIT 5;
 schemaname |     tablename     
------------+-------------------
 public     | accounts
 public     | entries
 public     | transfers
 public     | schema_migrations
 pg_catalog | pg_statistic
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

You can also do it using the following command [stackoverflow » PostgreSQL "DESCRIBE TABLE"](https://stackoverflow.com/questions/109325/postgresql-describe-table)

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

## Insert into table

- To insert into a table you can use

```sql
-- \d products to see the schema
postgres-# \d products
                               Table "public.products"
 Column |     Type      | Collation | Nullable |               Default                
--------+---------------+-----------+----------+--------------------------------------
 id     | integer       |           | not null | nextval('products_id_seq'::regclass)
 name   | text          |           | not null | 
 price  | numeric(10,2) |           | not null | 0.00
Indexes:
    "products_pkey" PRIMARY KEY, btree (id)
```

```sql
INSERT INTO products(name, price) VALUES('green ball', 24);
INSERT 0 1
```

## Select all from table

To view the inserted data in `products` table

```sql
select * from products;
```

Output

```bash
postgres=# select * from products;
 id |    name    | price 
----+------------+-------
  1 | green ball | 24.00
(1 row)
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
