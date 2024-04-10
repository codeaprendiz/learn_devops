# Create -- Select -- Grant READONLY access -- Drop -- User

- [Create -- Select -- Grant READONLY access -- Drop -- User](#create----select----grant-readonly-access----drop----user)
  - [Create User](#create-user)
  - [Get the list of users and corresponding hosts allowed to login](#get-the-list-of-users-and-corresponding-hosts-allowed-to-login)
  - [Give READONLY priviledge to login](#give-readonly-priviledge-to-login)
  - [Drop the user](#drop-the-user)
  - [Alter user](#alter-user)

## Create User

Create a user

```sql
CREATE USER 'app_user'@'%' IDENTIFIED BY 'somepassword';
```

```sql
mysql> CREATE USER 'app_user'@'%' IDENTIFIED BY 'somepassword';
Query OK, 0 rows affected (0.07 sec)
```

## Get the list of users and corresponding hosts allowed to login

```sql
select user,host from mysql.user;
```

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

## Give READONLY priviledge to login

```sql
GRANT SELECT, SHOW VIEW ON *.* TO 'app_user'@'%';
```

```sql
mysql> GRANT SELECT, SHOW VIEW ON *.* TO 'app_user'@'%';
Query OK, 0 rows affected (0.09 sec)
```

## Drop the user

```sql
DROP USER 'app_user'@'%';
```

```sql
mysql> DROP USER 'app_user'@'%';
Query OK, 0 rows affected (0.07 sec)
```

## Alter user

First check the users

```sql
mysql> select user,host from mysql.user;
+-------------------+-----------+
| user              | host      |
+-------------------+-----------+
| test1             | %         |
```

Alter the user password

```sql
ALTER USER 'test1'@'%' IDENTIFIED WITH 
```

```sql
mysql> ALTER USER 'test1'@'%' IDENTIFIED WITH mysql_native_password BY 'somepassword';
```
