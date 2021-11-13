# Dynamodb

[Cheatsheet - Dynamodb](https://tutorialsdojo.com/amazon-dynamodb/?src=udemy#core-components)

- fast
- highly scalable
- highly available, 
- cost-effective 
- non-relational database service

[Best Practices for Storing Large Items and Attributes](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/bp-use-s3-too.html)

- Amazon DynamoDB currently limits the size of each item that you store in a table (see Service, Account, and Table Quotas in Amazon DynamoDB). If your application needs to store more data in an item than the DynamoDB size limit permits, you can try compressing one or more large attributes or breaking the item into multiple items (efficiently indexed by sort keys). You can also store the item as an object in Amazon Simple Storage Service (Amazon S3) and store the Amazon S3 object identifier in your DynamoDB item.


### Global Tables


[Global Tables: Multi-Region Replication with DynamoDB](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/GlobalTables.html)

- Amazon DynamoDB global tables provide a fully managed solution for deploying a multiregion, multi-active database, without having to build and maintain your own replication solution.
- With global tables you can specify the AWS Regions where you want the table to be available.
- DynamoDB performs all of the necessary tasks to create identical tables in these Regions and propagate ongoing data changes to all of them.

[Amazon DynamoDB global tables](https://aws.amazon.com/dynamodb/global-tables/)




### Note

- RDS MySQL is not as scalable and cost-effective as DynamoDB.