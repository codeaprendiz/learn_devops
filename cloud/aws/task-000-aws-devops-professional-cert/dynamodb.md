


# Dynamodb

[Introduction](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Introduction.html)

What Is Amazon DynamoDB?

Amazon DynamoDB is a fully managed NoSQL database service that provides fast and predictable performance with seamless scalability. DynamoDB lets you offload the administrative burdens of operating and scaling a distributed database so that you don't have to worry about hardware provisioning, setup and configuration, replication, software patching, or cluster scaling. DynamoDB also offers encryption at rest, which eliminates the operational burden and complexity involved in protecting sensitive data

**High Availability and Durability**

- DynamoDB automatically spreads the data and traffic for your tables over a sufficient number of servers to handle your throughput and storage requirements, while maintaining consistent and fast performance. All of your data is stored on solid-state disks (SSDs) and is automatically replicated across multiple Availability Zones in an AWS Region, providing built-in high availability and data durability
- You can use global tables to keep DynamoDB tables in sync across AWS Regions


## Global Tables

- Amazon DynamoDB global tables provide a fully managed solution for deploying a multiregion, multi-active database, without having to build and maintain your own replication solution. With global tables you can specify the AWS Regions where you want the table to be available. DynamoDB performs all of the necessary tasks to create identical tables in these Regions and propagate ongoing data changes to all of them.
- 


[Dynamodb best practices](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/best-practices.html)
