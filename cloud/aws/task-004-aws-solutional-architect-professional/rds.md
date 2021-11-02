# RDS

[Cheat Sheet - RDS](https://tutorialsdojo.com/amazon-relational-database-service-amazon-rds/)

[RDS Read Replicas](https://aws.amazon.com/rds/features/read-replicas/)

- provide enhanced performance and durability for RDS database (DB) instances
- They make it easy to elastically scale out beyond the capacity constraints of a single DB instance for read-heavy database workloads.
- You can create one or more replicas of a given source DB Instance and serve high-volume application read traffic from multiple copies of your data
- Read replicas can also be promoted when needed to become standalone DB instances
- Read replicas are available in Amazon RDS for MySQL, MariaDB, PostgreSQL, Oracle, and SQL Server as well as Amazon Aurora.
- You can reduce the load on your source DB instance by routing read queries from your applications to the read replica