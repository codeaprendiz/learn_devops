# Manage Databases

- [Manage Databases](#manage-databases)
  - [Create Database- CREATE -- SHOW -- Databases](#create-database--create----show----databases)
  - [Show Databases](#show-databases)
  - [Drop Database](#drop-database)

## Create Database- [CREATE -- SHOW -- Databases](#create----show----databases)

```sql
CREATE DATABASE student_db;
```

Output

```sql
mysql> CREATE DATABASE student_db;
Query OK, 1 row affected (0.01 sec)
```

## Show Databases

```sql
show databases;
```

```sql
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| student_db         |
| sys                |
+--------------------+
5 rows in set (0.01 sec)
```

## Drop Database

```sql
DROP DATABASE student_db;
```

Output

```sql
mysql> DROP DATABASE student_db;
Query OK, 0 rows affected (0.02 sec)
```
