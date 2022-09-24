## Objective 


1) To spin up an RDS instance in private subnet in a VPC.
2) To spin up an ec2 instance in public subnet in same VPC
3) Access to the RDS is allowed only from the instance which is in public subnet.


- Init

```bash
$ terraform init   
```

- Plan

```                                 
$ terraform plan -var-file=../../terraform.tfvars
$ terraform plan -var-file=../../terraform.tfvars
var.RDS_PASSWORD
  Enter a value: testpassword
.
.
.
Plan: 19 to add, 0 to change, 0 to destroy.
.
.
.
```


- Apply
```bash
$ terraform apply -var-file=../../terraform.tfvars
var.RDS_PASSWORD
  Enter a value: testpassword
.
.
.
Apply complete! Resources: 19 added, 0 changed, 0 destroyed.

Outputs:

instance = 3.84.29.14
rds = mariadb.cqxustccju3j.us-east-1.rds.amazonaws.com:3306

```


- Login into the instance
```bash
$ ssh ubuntu@3.84.29.14
ubuntu@ip-10-0-1-52:~$
```

- Install mysql-client
```bash
ubuntu@ip-10-0-1-52:~$ sudo apt update
ubuntu@ip-10-0-1-52:~$ sudo apt install mysql-client
```

- Login into the Database
```bash
ubuntu@ip-10-0-1-18:~$ mysql -u root -h mariadb.cqxustccju3j.us-east-1.rds.amazonaws.com -p
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 9
Server version: 5.5.5-10.1.14-MariaDB MariaDB Server

Copyright (c) 2000, 2020, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| innodb             |
| mariadb            |
| mysql              |
| performance_schema |
+--------------------+
5 rows in set (0.00 sec)

mysql> 

```


- Note that the DB hostname resolves to internal IP address
```bash
ubuntu@ip-10-0-1-18:~$ nslookup mariadb.cqxustccju3j.us-east-1.rds.amazonaws.com
Server:         10.0.0.2
Address:        10.0.0.2#53

Non-authoritative answer:
Name:   mariadb.cqxustccju3j.us-east-1.rds.amazonaws.com
Address: 10.0.4.48
```


- Finally Destroy
```bash
$ terraform destroy -var-file=../../terraform.tfvars
.
.
.

Destroy complete! Resources: 19 destroyed.

```