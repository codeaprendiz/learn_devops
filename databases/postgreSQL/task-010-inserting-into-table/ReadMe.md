- To insert into a table you can use

```sql
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

- To view 

```bash
postgres=# select * from products;
 id |    name    | price 
----+------------+-------
  1 | green ball | 24.00
(1 row)
```