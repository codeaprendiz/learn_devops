### CloudFormation
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
