# Insert into table

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
