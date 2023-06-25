- To show the grants you can use

```mysql
mysql> show grants for 'someusername_user_dev'@'%';
+--------------------------------------------------------------------------------------+
| Grants for someusername_user_dev@%                                                         |
+--------------------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO `someusername_user_dev`@`%`                                          |
| GRANT ALL PRIVILEGES ON `someusername_db_dev`.* TO `someusername_user_dev`@`%` WITH GRANT OPTION |
+--------------------------------------------------------------------------------------+
```


- To show the grants of current user

```mysql
mysql> show grants;
+--------------------------------------------------------------------------------------+
| Grants for someusername_user_dev@%                                                         |
+--------------------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO `someusername_user_dev`@`%`                                          |
| GRANT ALL PRIVILEGES ON `someusername_db_dev`.* TO `someusername_user_dev`@`%` WITH GRANT OPTION |
+--------------------------------------------------------------------------------------+
2 rows in set (0.05 sec)

```