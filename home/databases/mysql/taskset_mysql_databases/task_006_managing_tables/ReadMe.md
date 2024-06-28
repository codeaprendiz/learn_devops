# Manage Tables

- [Manage Tables](#manage-tables)
  - [Create a table named `students` in the `student_db` database](#create-a-table-named-students-in-the-student_db-database)
  - [Show tables](#show-tables)
  - [Insert into table](#insert-into-table)
  - [Drop Table (if exists)](#drop-table-if-exists)

## Create a table named `students` in the `student_db` database

```sql
USE student_db;
CREATE TABLE students (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  balance BIGINT NOT NULL,
  currency VARCHAR(3) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
```

Output

```sql
Query OK, 0 rows affected (0.03 sec)
```

## Show tables

```sql
show tables;
```

Output

```sql
mysql> show tables;
+----------------------+
| Tables_in_student_db |
+----------------------+
| students             |
+----------------------+
1 row in set (0.00 sec)

mysql> 
```

## Insert into table

Insert into table `students` in `student_db` database.

```sql
USE student_db;
INSERT INTO students (name, balance, currency) VALUES ('Alice', 1000, 'USD'), ('Bob', 1500, 'USD'), ('Charlie', 1200, 'USD');
```

Output

```sql
Query OK, 3 rows affected (0.01 sec)
mysql> select * from students;
+----+---------+---------+----------+---------------------+
| id | name    | balance | currency | created_at          |
+----+---------+---------+----------+---------------------+
|  1 | Alice   |    1000 | USD      | 2024-04-10 16:25:53 |
|  2 | Bob     |    1500 | USD      | 2024-04-10 16:25:53 |
|  3 | Charlie |    1200 | USD      | 2024-04-10 16:25:53 |
+----+---------+---------+----------+---------------------+
3 rows in set (0.00 sec)

mysql>
```

## Drop Table (if exists)

```sql
DROP TABLE IF EXISTS students;
```

Output

```sql
mysql> DROP TABLE IF EXISTS students;
Query OK, 0 rows affected (0.03 sec)
```
