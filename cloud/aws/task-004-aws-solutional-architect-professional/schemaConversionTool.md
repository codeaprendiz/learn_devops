# Schema Conversion Tool

[What Is the AWS Schema Conversion Tool?](https://docs.aws.amazon.com/SchemaConversionTool/latest/userguide/CHAP_Welcome.html)

- You can use the AWS Schema Conversion Tool (AWS SCT) to convert your existing database schema from one database engine to another. 
- You can convert relational OLTP schema, or data warehouse schema. 
- Your converted schema is suitable for an Amazon Relational Database Service (Amazon RDS) MySQL, MariaDB, Oracle, SQL Server, PostgreSQL DB, an Amazon Aurora DB cluster, or an Amazon Redshift cluster. 
- The converted schema can also be used with a database on an Amazon EC2 instance or stored as data on an Amazon S3 bucket.

## Migrating data from an on-premises data warehouse to Amazon Redshift

- You can use an AWS SCT agent to extract data from your on-premises data warehouse and migrate it to Amazon Redshift. The agent extracts your data and uploads the data to either Amazon S3 
- or, for large-scale migrations, an AWS Snowball Edge device. 
- You can then use AWS SCT to copy the data to Amazon Redshift.