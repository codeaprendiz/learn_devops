# show grants of current and specific user

- [show grants of current and specific user](#show-grants-of-current-and-specific-user)
  - [To show the grants you can use](#to-show-the-grants-you-can-use)
  - [To show the grants of current user](#to-show-the-grants-of-current-user)

## To show the grants you can use

```sql
show grants for 'someusername_user_dev'@'%';
```

```sql
mysql> show grants for 'someusername_user_dev'@'%';
+--------------------------------------------------------------------------------------------------+
| Grants for someusername_user_dev@%                                                               |
+--------------------------------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO `someusername_user_dev`@`%`                                                |
| GRANT ALL PRIVILEGES ON `someusername_db_dev`.* TO `someusername_user_dev`@`%` WITH GRANT OPTION |
+--------------------------------------------------------------------------------------------------+
```

## To show the grants of current user

```sql
mysql> show grants;
+--------------------------------------------------------------------------------------------------+
| Grants for someusername_user_dev@% .                                                             |
+--------------------------------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO `someusername_user_dev`@`%`                                                |
| GRANT ALL PRIVILEGES ON `someusername_db_dev`.* TO `someusername_user_dev`@`%` WITH GRANT OPTION |
+--------------------------------------------------------------------------------------------------+
2 rows in set (0.05 sec)
```
