# Dynamodb

[Cheatsheet - Dynamodb](https://tutorialsdojo.com/amazon-dynamodb/?src=udemy#core-components)

- fast
- highly scalable
- highly available, 
- cost-effective 
- non-relational database service

[Best Practices for Storing Large Items and Attributes](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/bp-use-s3-too.html)

- Amazon DynamoDB currently limits the size of each item that you store in a table (see Service, Account, and Table Quotas in Amazon DynamoDB). If your application needs to store more data in an item than the DynamoDB size limit permits, you can try compressing one or more large attributes or breaking the item into multiple items (efficiently indexed by sort keys). You can also store the item as an object in Amazon Simple Storage Service (Amazon S3) and store the Amazon S3 object identifier in your DynamoDB item.


### Note

- RDS MySQL is not as scalable and cost-effective as DynamoDB.