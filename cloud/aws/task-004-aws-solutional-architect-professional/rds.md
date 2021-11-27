# RDS

[Cheat Sheet - RDS](https://tutorialsdojo.com/amazon-relational-database-service-amazon-rds)

[RDS Read Replicas](https://aws.amazon.com/rds/features/read-replicas/)

- provide enhanced performance and durability for RDS database (DB) instances
- They make it easy to elastically scale out beyond the capacity constraints of a single DB instance for read-heavy database workloads.
- You can create one or more replicas of a given source DB Instance and serve high-volume application read traffic from multiple copies of your data
- Read replicas can also be promoted when needed to become standalone DB instances
- Read replicas are available in Amazon RDS for MySQL, MariaDB, PostgreSQL, Oracle, and SQL Server as well as Amazon Aurora.
- You can reduce the load on your source DB instance by routing read queries from your applications to the read replica

## Backing up and restoring an Amazon RDS DB instance

[Backing up and restoring an Amazon RDS DB instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_CommonTasks.BackupRestore.html)

### Restoring a DB instance to a specified time

- You can restore a DB instance to a specific point in time, creating a new DB instance.
- RDS uploads transaction logs for DB instances to Amazon S3 every 5 minutes.
- To see the latest restorable time for a DB instance, use the AWS CLI describe-db-instances command and look at the value returned in the LatestRestorableTime field for the DB instance.
- To see the latest restorable time for each DB instance in the Amazon RDS console, choose Automated backups.


## NOTES

- The Amazon RDS MySQL does not have a single reader endpoint for read replicas. You must use Amazon Aurora for MySQL to support this. Creating read replicas is recommended to increase the read performance of an RDS cluster.