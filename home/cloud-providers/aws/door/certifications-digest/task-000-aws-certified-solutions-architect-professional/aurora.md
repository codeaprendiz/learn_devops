# Aurora

[Cheat Sheet - RDS](https://tutorialsdojo.com/amazon-relational-database-service-amazon-rds)

[What is Amazon Aurora?](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html)

- Amazon Aurora (Aurora) is a fully managed relational database engine that's compatible with MySQL and PostgreSQL
- The code, tools, and applications you use today with your existing MySQL and PostgreSQL databases can be used with Aurora.
- With some workloads, Aurora can deliver up to five times the throughput of MySQL and up to three times the throughput of PostgreSQL without requiring changes to most of your existing applications.

## Amazon Aurora DB clusters

[Amazon Aurora DB clusters](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Aurora.Overview.html)

- An Amazon Aurora DB cluster consists of one or more DB instances and a cluster volume that manages the data for those DB instances.
- An Aurora cluster volume is a virtual database storage volume that spans multiple Availability Zones, with each Availability Zone having a copy of the DB cluster data.
  - Primary DB instance – Supports read and write operations, and performs all of the data modifications to the cluster volume. Each Aurora DB cluster has one primary DB instance.
  - Aurora Replica – Connects to the same storage volume as the primary DB instance and supports only read operations. Each Aurora DB cluster can have up to 15 Aurora Replicas in addition to the primary DB instance

### Amazon Aurora storage and reliability

[Amazon Aurora storage and reliability](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Aurora.Overview.StorageReliability.html)

- Aurora data is stored in the cluster volume, which is a single, virtual volume that uses solid state drives (SSDs).
- A cluster volume consists of copies of the data across three Availability Zones in a single AWS Region
- Aurora cluster volumes automatically grow as the amount of data in your database increases. 
- An Aurora cluster volume can grow to a maximum size of 128 tebibytes (TiB). 
- Even though an Aurora cluster volume can grow up to 128 tebibytes (TiB), you are only charged for the space that you use in an Aurora cluster volume.

### High availability for Amazon Aurora

[High availability for Amazon Aurora](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Concepts.AuroraHighAvailability.html)

- The Amazon Aurora architecture involves separation of storage and compute
- The data remains safe even if some or all of the DB instances in the cluster become unavailable.


## Managing DB instance

[Working with storage for Amazon RDS DB instances](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_PIOPS.StorageTypes.html)

- To specify how you want your data stored in Amazon RDS, choose a storage type and provide a storage size when you create or modify a DB instance.
- Later, you can increase the amount or change the type of storage by modifying the DB instance.

### Overview of Amazon Aurora global databases

[Overview of Amazon Aurora global databases](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-global-database.html#aurora-global-database-overview)

- Amazon Aurora global databases span multiple AWS Regions, enabling low latency global reads and providing fast recovery from the rare outage that might affect an entire AWS Region. 
- An Aurora global database has a primary DB cluster in one Region, and up to five secondary DB clusters in different Regions.

### Connecting to an Amazon Aurora global database

How you connect to an Aurora global database depends on whether you need to write to the database or read from the database:
- For read-only requests or queries, you connect to the reader endpoint for the Aurora cluster in your AWS Region.
- To run data manipulation language (DML) or data definition language (DDL) statements, you connect to the cluster endpoint for the primary cluster. This endpoint might be in a different AWS Region than your application.