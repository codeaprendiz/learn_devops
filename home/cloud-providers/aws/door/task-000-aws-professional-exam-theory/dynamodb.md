> Revision Count: 0

# Dynamodb

[Cheatsheet - Dynamodb](https://tutorialsdojo.com/amazon-dynamodb)

- fast
- highly scalable
- highly available, 
- cost-effective 
- non-relational database service



[Introduction](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Introduction.html)

What Is Amazon DynamoDB?

Amazon DynamoDB is a fully managed NoSQL database service that provides fast and predictable performance with seamless scalability. DynamoDB lets you offload the administrative burdens of operating and scaling a distributed database so that you don't have to worry about hardware provisioning, setup and configuration, replication, software patching, or cluster scaling. DynamoDB also offers encryption at rest, which eliminates the operational burden and complexity involved in protecting sensitive data

[Best Practices for Storing Large Items and Attributes](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/bp-use-s3-too.html)

- Amazon DynamoDB currently limits the size of each item that you store in a table (see Service, Account, and Table Quotas in Amazon DynamoDB). If your application needs to store more data in an item than the DynamoDB size limit permits, you can try compressing one or more large attributes or breaking the item into multiple items (efficiently indexed by sort keys). You can also store the item as an object in Amazon Simple Storage Service (Amazon S3) and store the Amazon S3 object identifier in your DynamoDB item.


**High Availability and Durability**

- DynamoDB automatically spreads the data and traffic for your tables over a sufficient number of servers to handle your throughput and storage requirements, while maintaining consistent and fast performance. All of your data is stored on solid-state disks (SSDs) and is automatically replicated across multiple Availability Zones in an AWS Region, providing built-in high availability and data durability
- You can use global tables to keep DynamoDB tables in sync across AWS Regions



[Dynamodb best practices](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/best-practices.html)


### Global Tables


[Global Tables: Multi-Region Replication with DynamoDB](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/GlobalTables.html)

- Amazon DynamoDB global tables provide a fully managed solution for deploying a multiregion, multi-active database, without having to build and maintain your own replication solution.
- With global tables you can specify the AWS Regions where you want the table to be available.
- DynamoDB performs all of the necessary tasks to create identical tables in these Regions and propagate ongoing data changes to all of them.

[Amazon DynamoDB global tables](https://aws.amazon.com/dynamodb/global-tables/)

## Security

### Identity and Access Management in Amazon DynamoDB

[Identity and Access Management in Amazon DynamoDB](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/authentication-and-access-control.html)

- Access to Amazon DynamoDB requires credentials. Those credentials must have permissions to access AWS resources, such as an Amazon DynamoDB table or an Amazon Elastic Compute Cloud (Amazon EC2) instance.
  - Authentication
  - Access Control


## Error Handling with DynamoDB

[Error Handling with DynamoDB](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Programming.Errors.html)




## Note

- RDS MySQL is not as scalable and cost-effective as DynamoDB.
- It is not recommended to store authorization tokens permanently on DynamoDB tables. These tokens should be generated upon user authentication and then temporarily saved on a DynamoDB for a fixed session length.


## Blogs

[New – Auto Scaling for Amazon DynamoDB](https://aws.amazon.com/blogs/aws/new-auto-scaling-for-amazon-dynamodb)