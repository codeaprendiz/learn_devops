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

```bash
postgres=# SELECT 
   table_name, 
   column_name, 
   data_type 
FROM 
   information_schema.columns
WHERE 
  table_name = 'products';
 table_name | column_name | data_type 
------------+-------------+-----------
 products   | id          | integer
 products   | name        | text
 products   | price       | numeric
(3 rows)
```


You can also do it using the following command

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