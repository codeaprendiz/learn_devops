
- Create a user
```sql
mysql> CREATE USER 'app_user'@'%' IDENTIFIED BY 'somepassword';
Query OK, 0 rows affected (0.07 sec)
```

- Get the list of users and corresponding hosts allowed to login

```sql
mysql> select user,host from mysql.user;
+-------------------+-----------+
| user              | host      |
+-------------------+-----------+
| admin             | %         |
| app_user          | %         |
| mysql.infoschema  | localhost |
| mysql.session     | localhost |
| mysql.sys         | localhost |
+-------------------+-----------+
5 rows in set (0.06 sec)
```


- Give READONLY priviledge to login

```sql
mysql> GRANT SELECT, SHOW VIEW ON *.* TO 'app_user'@'%';
Query OK, 0 rows affected (0.09 sec)
```



- Drop the user

```sql
mysql> DROP USER 'app_user'@'%';
Query OK, 0 rows affected (0.07 sec)
```




