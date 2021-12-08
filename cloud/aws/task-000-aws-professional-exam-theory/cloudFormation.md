# CloudFormation

[What is AWS CloudFormation?](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/Welcome.html)

[Cheat Sheet - AWS CloudFormation](https://tutorialsdojo.com/aws-cloudformation)

[Cheat Sheet - aws-cloudformation-stacksets-and-nested-stacks](https://tutorialsdojo.com/aws-cloudformation-stacksets-and-nested-stacks)

- AWS CloudFormation is a service that helps you model and set up your AWS resources so that you can spend less time managing those resources and more time focusing on your applications that run in AWS.
- You create a template that describes all the AWS resources that you want (like Amazon EC2 instances or Amazon RDS DB instances), and CloudFormation takes care of provisioning and configuring those resources for you.


--

Whenever the CloudFormation stack is redeployed, the software should be installed in the same
physical hosts.

```bash
Tenancy type to be dedicated host.
Specify the allocated HostID
```

[AWS CloudFormation StackSets](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/what-is-cfnstacksets.html)

- AWS CloudFormation StackSets extends the functionality of stacks by enabling you to create, update, or delete stacks across multiple accounts and Regions with a single operation.

[Updating stacks using change sets](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-updating-stacks-changesets.html)

```bash
 CloudFormation CLI create-change-set
```

[Conditionally create resources for a production, development, or test stack](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/conditions-sample-templates.html)

[Exporting stack output values](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-exports.html)

[Listing stacks that import an exported output value](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-imports.html)

[DeletionPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-attribute-deletionpolicy.html)

With the DeletionPolicy attribute you can preserve, and in some cases, backup a resource when its stack is deleted

[UpdateReplacePolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-attribute-updatereplacepolicy.html)

Use the UpdateReplacePolicy attribute to retain or, in some cases, backup the existing physical instance of a resource when it's replaced during a stack update operation.


[Walkthrough: Refer to resource outputs in another AWS CloudFormation stack](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/walkthrough-crossstackref.html)

To export resources from one AWS CloudFormation stack to another, create a cross-stack reference. Cross-stack references let you use a layered or service-oriented architecture.

To create a cross-stack reference, use the Export output field to flag the value of a resource output for export. Then, use the Fn::ImportValue intrinsic function to import the value.


- There are some limitations if there is a cross-stack reference
  between two CloudFormation stacks. Stack A cannot be deleted if it has a resource output
  that is referenced by stack B.
- You cannot modify the output value that is referenced by
  another stack
- you can update stack B to remove the cross-stack reference.

[Custom resources](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-custom-resources.html)

- The template developer defines a custom resource in their template, which includes a service token and any input data parameters. Depending on the custom resource, the input data might be required; however, the service token is always required.
- The service token specifies where AWS CloudFormation sends requests to, such as an Amazon SNS topic ARN or an AWS Lambda function ARN


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


