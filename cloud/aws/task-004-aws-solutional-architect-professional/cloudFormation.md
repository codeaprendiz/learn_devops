# CloudFormation

[What is AWS CloudFormation?](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/Welcome.html)

[Cheat Sheet - AWS CloudFormation](https://tutorialsdojo.com/aws-cloudformation)

[Cheat Sheet - aws-cloudformation-stacksets-and-nested-stacks](https://tutorialsdojo.com/aws-cloudformation-stacksets-and-nested-stacks)

- AWS CloudFormation is a service that helps you model and set up your AWS resources so that you can spend less time managing those resources and more time focusing on your applications that run in AWS.
- You create a template that describes all the AWS resources that you want (like Amazon EC2 instances or Amazon RDS DB instances), and CloudFormation takes care of provisioning and configuring those resources for you.


## Resource Attributes

### Deletion Policy

[DeletionPolicy attribute](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-attribute-deletionpolicy.html)

[How do I retain some of my resources when I delete an AWS CloudFormation stack?](https://aws.amazon.com/premiumsupport/knowledge-center/delete-cf-stack-retain-resources)

- With the DeletionPolicy attribute you can preserve, and in some cases, backup a resource when its stack is deleted.
- You specify a DeletionPolicy attribute for each resource that you want to control.
- If a resource has no DeletionPolicy attribute, AWS CloudFormation deletes the resource by default.

> The default policy is Snapshot for AWS::RDS::DBCluster resources and for AWS::RDS::DBInstance resources that don't specify the DBClusterIdentifier property.

**DeletionPolicy options**

- Delete
  - CloudFormation deletes the resource and all its content if applicable during stack deletion
  - By default, if you don't specify a DeletionPolicy, CloudFormation deletes your resources.
- Retain
  - CloudFormation keeps the resource without deleting the resource or its contents when its stack is deleted.
- Snapshot
  - For resources that support snapshots, CloudFormation creates a snapshot for the resource before deleting it
  
## Intrinsic Functions

[Intrinsic function reference](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/intrinsic-function-reference.html)

- AWS CloudFormation provides several built-in functions that help you manage your stacks. Use intrinsic functions in your templates to assign values to properties that are not available until runtime.


### Fn::GetAtt

[Fn::GetAtt](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/intrinsic-function-reference-getatt.html)

- The Fn::GetAtt intrinsic function returns the value of an attribute from a resource in the template

## Blogs

[Use CloudFormation StackSets to Provision Resources Across Multiple AWS Accounts and Regions](https://aws.amazon.com/blogs/aws/use-cloudformation-stacksets-to-provision-resources-across-multiple-aws-accounts-and-regions)
