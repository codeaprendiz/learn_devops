# Create -- Select -- Grant READONLY access -- Drop -- User

- [Create -- Select -- Grant READONLY access -- Drop -- User](#create----select----grant-readonly-access----drop----user)
  - [Create User](#create-user)
  - [To show the grants you can use](#to-show-the-grants-you-can-use)
  - [To show the grants of current user](#to-show-the-grants-of-current-user)
  - [Get the list of users and corresponding hosts allowed to login](#get-the-list-of-users-and-corresponding-hosts-allowed-to-login)
  - [Give READONLY priviledge to login](#give-readonly-priviledge-to-login)
  - [Drop the user](#drop-the-user)
  - [Alter user](#alter-user)
  - [Check when the password was last changed](#check-when-the-password-was-last-changed)

## Create User

Create a user

```sql
CREATE USER 'app_user'@'%' IDENTIFIED BY 'somepassword';
```

```sql
-- The `%` symbol in SQL user specifications acts as a wildcard, allowing connections from any host; other possible values include specific hostnames or IP addresses to restrict user access to particular sources.
mysql> CREATE USER 'app_user'@'%' IDENTIFIED BY 'somepassword';
Query OK, 0 rows affected (0.07 sec)
```

## To show the grants you can use

```sql
show grants for 'app_user'@'%';
```

```sql
mysql> show grants for 'app_user'@'%';
+--------------------------------------------------------------------------------------------------+
| Grants for app_user@%                                                                            |
+--------------------------------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO `app_user`@`%`                                                             |
| GRANT ALL PRIVILEGES ON `someusername_db_dev`.* TO `app_user`@`%` WITH GRANT OPTION              |
+--------------------------------------------------------------------------------------------------+
```

## To show the grants of current user

```sql
mysql> show grants;
+--------------------------------------------------------------------------------------------------+
| Grants for app_user@% .                                                                          |
+--------------------------------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO `app_user`@`%`                                                             |
| GRANT ALL PRIVILEGES ON `someusername_db_dev`.* TO `app_user`@`%` WITH GRANT OPTION              |
+--------------------------------------------------------------------------------------------------+
2 rows in set (0.05 sec)
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
| app_user          | %         |
```

Alter the user password

```sql
ALTER USER 'app_user'@'%' IDENTIFIED BY 'newpassword'; 
```

```sql
-- https://dev.mysql.com/doc/refman/8.0/en/resetting-permissions.html
mysql> ALTER USER 'app_user'@'%' IDENTIFIED BY 'newpassword'; 
```

## Check when the password was last changed

```sql
SELECT user, host, password_last_changed 
FROM mysql.user 
WHERE user = 'app_user';
```

```sql
mysql> SELECT user, host, password_last_changed FROM mysql.user WHERE user = 'app_user';
+----------+------+-----------------------+
| user     | host | password_last_changed |
+----------+------+-----------------------+
| app_user | %    | 2024-04-28 10:57:45   |
+----------+------+-----------------------+
1 row in set (0.01 sec)
```
