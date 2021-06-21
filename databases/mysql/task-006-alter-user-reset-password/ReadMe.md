- First check the users

```mysql
mysql> select user,host from mysql.user;
+-------------------+-----------+
| user              | host      |
+-------------------+-----------+
| test1             | %         |
```

- Alter the user

```mysql
mysql> ALTER USER 'test1'@'%' IDENTIFIED WITH mysql_native_password BY 'somepassword';
```