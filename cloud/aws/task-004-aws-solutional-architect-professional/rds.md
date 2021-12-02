# RDS

[Cheat Sheet - RDS](https://tutorialsdojo.com/amazon-relational-database-service-amazon-rds)

[RDS Read Replicas](https://aws.amazon.com/rds/features/read-replicas)

- provide enhanced performance and durability for RDS database (DB) instances
- They make it easy to elastically scale out beyond the capacity constraints of a single DB instance for read-heavy database workloads.
- You can create one or more replicas of a given source DB Instance and serve high-volume application read traffic from multiple copies of your data
- Read replicas can also be promoted when needed to become standalone DB instances
- Read replicas are available in Amazon RDS for MySQL, MariaDB, PostgreSQL, Oracle, and SQL Server as well as Amazon Aurora.
- You can reduce the load on your source DB instance by routing read queries from your applications to the read replica

[Working with read replicas](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_ReadRepl.html)


### Multi-AZ deployments for high availability

[Multi-AZ deployments for high availability](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.MultiAZ.html)

- Multi-AZ deployments can have one standby or two standby DB instances. 
- When the deployment has one standby DB instance, it's called a Multi-AZ DB instance deployment. 
  - A Multi-AZ DB instance deployment has one standby DB instance that provides failover support, but doesn't serve read traffic. 
- When the deployment has two standby DB instances, it's called a Multi-AZ DB cluster deployment. 
  - A Multi-AZ DB cluster deployment has standby DB instances that provide failover support and can also serve read traffic.


## Backing up and restoring an Amazon RDS DB instance

[Backing up and restoring an Amazon RDS DB instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_CommonTasks.BackupRestore.html)

### Restoring a DB instance to a specified time

- You can restore a DB instance to a specific point in time, creating a new DB instance.
- RDS uploads transaction logs for DB instances to Amazon S3 every 5 minutes.
- To see the latest restorable time for a DB instance, use the AWS CLI describe-db-instances command and look at the value returned in the LatestRestorableTime field for the DB instance.
- To see the latest restorable time for each DB instance in the Amazon RDS console, choose Automated backups.

### Amazon RDS DB instance storage

[Amazon RDS DB instance storage](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Storage.html)

- DB instances for Amazon RDS for MySQL, MariaDB, PostgreSQL, Oracle, and Microsoft SQL Server use Amazon Elastic Block Store (Amazon EBS) volumes for database and log storage.
- Amazon RDS provides three storage types: General Purpose SSD (also known as gp2), Provisioned IOPS SSD (also known as io1), and magnetic (also known as standard)
  - General Purpose SSD – General Purpose SSD volumes offer cost-effective storage that is ideal for a broad range of workloads. 
  - Provisioned IOPS – Provisioned IOPS storage is designed to meet the needs of I/O-intensive workloads, particularly database workloads, that require low I/O latency and consistent I/O throughput.
  - Magnetic – Amazon RDS also supports magnetic storage for backward compatibility. We recommend that you use General Purpose SSD or Provisioned IOPS for any new storage needs.

## NOTES

- The Amazon RDS MySQL does not have a single reader endpoint for read replicas. You must use Amazon Aurora for MySQL to support this. Creating read replicas is recommended to increase the read performance of an RDS cluster.
- Amazon RDS does not support certain features in Oracle such as Multitenant Database, Real Application Clusters (RAC), Unified Auditing, Database Vault, Recovery Manager (RMAN)

## Blogs

- [Understanding Burst vs. Baseline Performance with Amazon RDS and GP2](https://aws.amazon.com/blogs/database/understanding-burst-vs-baseline-performance-with-amazon-rds-and-gp2/)

- [How to use CloudWatch metrics to decide between General Purpose or Provisioned IOPS for your RDS database](https://aws.amazon.com/blogs/database/how-to-use-cloudwatch-metrics-to-decide-between-general-purpose-or-provisioned-iops-for-your-rds-database)

- [Amazon RDS Multi-AZ Deployments](https://aws.amazon.com/rds/features/multi-az)

- [Amazon RDS – Multi-AZ Deployments For Enhanced Availability & Reliability](https://aws.amazon.com/blogs/aws/amazon-rds-multi-az-deployment)

- [Implementing a disaster recovery strategy with Amazon RDS](https://aws.amazon.com/blogs/database/implementing-a-disaster-recovery-strategy-with-amazon-rds)