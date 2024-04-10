# Transaction Isolation Levels

Check the current transaction isolation level

```sql
select @@transaction_isolation;
```

Output

```sql
mysql> select @@transaction_isolation;
+-------------------------+
| @@transaction_isolation |
+-------------------------+
| REPEATABLE-READ         |
+-------------------------+
1 row in set (0.00 sec)

mysql> 
```

Check global transaction isolation levels

```sql
select @@global.transaction_isolation;
```

```sql
mysql> select @@global.transaction_isolation;
+--------------------------------+
| @@global.transaction_isolation |
+--------------------------------+
| REPEATABLE-READ                |
+--------------------------------+
1 row in set (0.00 sec)

mysql>
```

Set the transaction isolation level for the current session

```sql
set session transaction isolation level read uncommitted;
```

Output

```sql
mysql> set session transaction isolation level read uncommitted;
Query OK, 0 rows affected (0.00 sec)

mysql> select @@transaction_isolation;
+-------------------------+
| @@transaction_isolation |
+-------------------------+
| READ-UNCOMMITTED        |
+-------------------------+
1 row in set (0.00 sec)

mysql> 
```

