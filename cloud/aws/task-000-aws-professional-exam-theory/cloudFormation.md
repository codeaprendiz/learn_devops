# CloudFormation

[What is AWS CloudFormation?](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/Welcome.html)

[Cheat Sheet - AWS CloudFormation](https://tutorialsdojo.com/aws-cloudformation)

[Cheat Sheet - aws-cloudformation-stacksets-and-nested-stacks](https://tutorialsdojo.com/aws-cloudformation-stacksets-and-nested-stacks)

[Cheat Sheet - Elastic Beanstalk vs CloudFormation vs OpsWorks vs CodeDeploy](https://tutorialsdojo.com/elastic-beanstalk-vs-cloudformation-vs-opsworks-vs-codedeploy)

- AWS CloudFormation is a service that helps you model and set up your AWS resources so that you can spend less time managing those resources and more time focusing on your applications that run in AWS.
- You create a template that describes all the AWS resources that you want (like Amazon EC2 instances or Amazon RDS DB instances), and CloudFormation takes care of provisioning and configuring those resources for you.



### Working with AWS CloudFormation StackSets

[AWS CloudFormation StackSets](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/what-is-cfnstacksets.html)

- AWS CloudFormation StackSets extends the functionality of stacks by enabling you to create, update, or delete stacks across multiple accounts and Regions with a single operation.

### Updating stacks using change sets

[Updating stacks using change sets](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-updating-stacks-changesets.html)

- When you need to update a stack, understanding how your changes will affect running resources before you implement them can help you update stacks with confidence
- Change sets allow you to preview how proposed changes to a stack might impact your running resources, for example, whether your changes will delete or replace any critical resources, AWS CloudFormation makes the changes to your stack only when you decide to execute the change set, allowing you to decide whether to proceed with your proposed changes or explore other changes by creating another change set.

```bash
 CloudFormation CLI create-change-set
```

### Conditionally create resources for a production, development, or test stack

[Conditionally create resources for a production, development, or test stack](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/conditions-sample-templates.html)

- In some cases, you might want to create stacks that are similar but with minor tweaks. 
- For example, you might have a template that you use for production applications. 
- You want to create the same production stack so that you can use it for development or testing.

### Exporting stack output values

[Exporting stack output values](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-exports.html)

- To share information between stacks, export a stack's output values. 
- Other stacks that are in the same AWS account and region can import the exported values.

### Listing stacks that import an exported output value

[Listing stacks that import an exported output value](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-imports.html)

- When you export an output value, stacks that are in the same AWS account and region can import that value. 
- To see which stacks are importing a particular output value, use the list import action.


### DeletionPolicy attribute

[DeletionPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-attribute-deletionpolicy.html)

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


### UpdateReplacePolicy attribute

[UpdateReplacePolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-attribute-updatereplacepolicy.html)

- Use the UpdateReplacePolicy attribute to retain or, in some cases, backup the existing physical instance of a resource when it's replaced during a stack update operation.
- When you initiate a stack update, AWS CloudFormation updates resources based on differences between what you submit and the stack's current template and parameters. 
- If you update a resource property that requires that the resource be replaced, CloudFormation recreates the resource during the update. 
- Recreating the resource generates a new physical ID.


### Walkthrough: Refer to resource outputs in another AWS CloudFormation stack

[Walkthrough: Refer to resource outputs in another AWS CloudFormation stack](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/walkthrough-crossstackref.html)

- To export resources from one AWS CloudFormation stack to another, create a cross-stack reference. Cross-stack references let you use a layered or service-oriented architecture. 
- Instead of including all resources in a single stack, you create related AWS resources in separate stacks; then you can refer to required resource outputs from other stacks. 
- By restricting cross-stack references to outputs, you control the parts of a stack that are referenced by other stacks.


- There are some limitations if there is a cross-stack reference
  between two CloudFormation stacks. Stack A cannot be deleted if it has a resource output
  that is referenced by stack B.
- You cannot modify the output value that is referenced by
  another stack
- you can update stack B to remove the cross-stack reference.


### Custom resources

[Custom resources](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-custom-resources.html)


- Custom resources enable you to write custom provisioning logic in templates that AWS CloudFormation runs anytime you create, update (if you changed the custom resource), or delete stacks. 
-  For example, you might want to include resources that aren't available as AWS CloudFormation resource types. 
- You can include those resources by using custom resources.

**How custom resources work**

- The template developer defines a custom resource in their template, which includes a service token and any input data parameters. Depending on the custom resource, the input data might be required; however, the service token is always required.
- The service token specifies where AWS CloudFormation sends requests to, such as an Amazon SNS topic ARN or an AWS Lambda function ARN


  
## Intrinsic Functions

[Intrinsic function reference](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/intrinsic-function-reference.html)

- AWS CloudFormation provides several built-in functions that help you manage your stacks. Use intrinsic functions in your templates to assign values to properties that are not available until runtime.


### Fn::GetAtt

[Fn::GetAtt](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/intrinsic-function-reference-getatt.html)

- The Fn::GetAtt intrinsic function returns the value of an attribute from a resource in the template

## Blogs

[Use CloudFormation StackSets to Provision Resources Across Multiple AWS Accounts and Regions](https://aws.amazon.com/blogs/aws/use-cloudformation-stacksets-to-provision-resources-across-multiple-aws-accounts-and-regions)


