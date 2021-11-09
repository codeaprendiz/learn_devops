# CloudFormation

[What is AWS CloudFormation?](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/Welcome.html)

- AWS CloudFormation is a service that helps you model and set up your AWS resources so that you can spend less time managing those resources and more time focusing on your applications that run in AWS.
- You create a template that describes all the AWS resources that you want (like Amazon EC2 instances or Amazon RDS DB instances), and CloudFormation takes care of provisioning and configuring those resources for you.


## Resource Attributes

### Deletion Policy

[DeletionPolicy attribute](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-attribute-deletionpolicy.html)

- With the DeletionPolicy attribute you can preserve, and in some cases, backup a resource when its stack is deleted.
- You specify a DeletionPolicy attribute for each resource that you want to control.
- If a resource has no DeletionPolicy attribute, AWS CloudFormation deletes the resource by default.
