# Create Table

Create a table named `students` in the `student_db` database

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

Show tables

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
