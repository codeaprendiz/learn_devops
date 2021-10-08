Best Design includes cost optimized design too.

- [AutoScaling](#AutoScaling)
- [Billing and Cost Management](#BillingAndCostManagement)
- [CloudFormation](#CloudFormation)
- [CloudWatch](#CloudWatch)
- [Code Commit](#codecommit)
- [Code Deploy](#codedeploy)
- [Code Pipeline]()
- [Dynamodb](#Dynamodb)
- [EC2](#EC2)
- [ECS](#ECS)
- [Elasticbeanstalk](#Elasticbeanstalk)
- [Elastic Load Balancing](#ElasticLoadBalancing)
- [Quicksight](#Quicksight)
- [S3](#S3)
- [Server Migration Service](#ServerMigrationService)
- [VPC](#VPC)

### AutoScaling

[Scheduled scaling for Amazon EC2 Auto Scaling](https://docs.aws.amazon.com/autoscaling/ec2/userguide/schedule_time.html)

- cooldown timer does not influence the scheduled activity

[Cooldown](https://docs.aws.amazon.com/autoscaling/ec2/userguide/Cooldown.html)

- even if the cooldown timer is running, the scheduled action takes high priority and executes immediately

[Amazon EC2 Auto Scaling lifecycle hooks](https://docs.aws.amazon.com/autoscaling/ec2/userguide/lifecycle-hooks.html)

- When a scale-out event occurs, your newly launched instance completes its startup sequence and transitions to a wait state. While the instance is in a wait state, it runs a script to download and install the needed software packages for your application, making sure that your instance is fully ready before it starts receiving traffic. When the script is finished installing software, it sends the complete-lifecycle-action command to continue.

[AutoScalingReplacingUpdate policy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-attribute-updatepolicy.html)

To specify how AWS CloudFormation handles replacement updates for an Auto Scaling group, use the AutoScalingReplacingUpdate policy. This policy enables you to specify whether AWS CloudFormation replaces an Auto Scaling group with a new one or replaces only the instances in the Auto Scaling group.

### BillingAndCostManagement

[Cost Alloc Tags](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/cost-alloc-tags.html)
- After you activate cost allocation tags, AWS uses the cost allocation tags



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

### CloudWatch

[Monitoring deployments with Amazon CloudWatch Events](https://docs.aws.amazon.com/codedeploy/latest/userguide/monitoring-cloudwatch-events.html)

```bash
The following are some use cases:
Use a Lambda function to pass a notification to a Slack channel whenever deployments fail.
Push data about deployments or instances to a Kinesis stream to support comprehensive, real-time status monitoring.
Use CloudWatch alarm actions to automatically stop, terminate, reboot, or recover Amazon EC2 instances when a deployment or instance event you specify occurs.
```

[dynamic-dns-for-route-53](https://aws.amazon.com/blogs/compute/building-a-dynamic-dns-for-route-53-using-cloudwatch-events-and-lambda/)

- Cheap

### CodeCommit

[auth-and-access-control-iam-identity-based-access-control](https://docs.aws.amazon.com/codecommit/latest/userguide/auth-and-access-control-iam-identity-based-access-control.html#identity-based-policies-example-4)

- To restrict push to master

```json
{ "Effect": "Allow",
"Action": [
"codecommit:GitPush",
"codecommit:Merge*" ],
"Resource": [ "arn:aws:codecommit:*:*:the-repo-name" ],
"Condition": {
"StringNotEquals": {
"codecommit:References": [ "refs/heads/master" ] }
}
}
```

Data in AWS CodeCommit repositories is already encrypted in transit as
well as at rest.

[how-to-migrate-existing-share](https://docs.aws.amazon.com/codecommit/latest/userguide/how-to-migrate-repository-existing.html#how-to-migrate-existing-share)

### CodeDeploy

[Register an on-premises instance with CodeDeploy](https://docs.aws.amazon.com/codedeploy/latest/userguide/on-premises-instances-register.html)

[Use the register command (IAM user ARN) to register an on-premises instance](https://docs.aws.amazon.com/codedeploy/latest/userguide/instances-on-premises-register-instance.html)

The register command can create an IAM user for the server and register the server with CodeDeploy

```bash
aws deploy register --instance-name AssetTag234AESDD --tags
Key=Name,Value=CodeDeployDemo-OnPremise --region eu-west-1
```

[Manually remove on-premises instance tags from an on-premises instance](https://docs.aws.amazon.com/codedeploy/latest/userguide/on-premises-instances-operations-remove-tags.html)

Typically, you remove an on-premises instance tag from an on-premises instance when that tag is no longer being used, or you want to remove the on-premises instance from any deployment groups that rely on that tag. You can use the AWS CLI or the AWS CodeDeploy console to remove on-premises instance tags from on-premises instances.

[Create a deployment group for an in-place deployment (console)]()

### CodePipeline

[Grant approval permissions to an IAM user in CodePipeline](https://docs.aws.amazon.com/codepipeline/latest/userguide/approvals-iam-permissions.html)

- attaching the AWSCodePipelineApproverAccess managed policy to an IAM user

[Approve or reject an approval action in CodePipeline](https://docs.aws.amazon.com/codepipeline/latest/userguide/approvals-approve-or-reject.html)

[Invoke an AWS Lambda function in a pipeline in CodePipeline](https://docs.aws.amazon.com/codepipeline/latest/userguide/actions-invoke-lambda-function.html)

- Do not log the JSON event that CodePipeline sends to Lambda because this can result in user credentials being logged in CloudWatch Logs. The CodePipeline role uses a JSON event to pass temporary credentials to Lambda in the artifactCredentials field.


### Dynamodb

[Dynamodb best practices](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/best-practices.html)



### EC2

[dedicated-hosts](https://aws.amazon.com/ec2/dedicated-hosts)

- Network Load Balancers do not use security groups.

[iam-roles-for-amazon-ec2](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/iam-roles-for-amazon-ec2.html)

- The AWS SDKs assume the IAM roles attached in the instances and get temporary credentials by interacting with the AWS STS service.

[security-group-load-balancer](https://aws.amazon.com/premiumsupport/knowledge-center/security-group-load-balancer/)

### ECS

[What is ECS](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/Welcome.html)

[Target tracking scaling policies](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-autoscaling-targettracking.html)

[How do I troubleshoot Amazon ECS tasks that take a long time to stop when the container instance is set to DRAINING?](https://aws.amazon.com/premiumsupport/knowledge-center/ecs-tasks-stop-delayed-draining/)

[service_definition_parameters](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service_definition_parameters.html)

- If a service is using the rolling update (ECS) deployment type, the minimumHealthyPercent represents a lower limit on the number of your service's tasks that must remain in the RUNNING state during a deployment
- Minimum healthy percent represents a lower limit on the tasks. When the parameter is set to 100, the number of the service's running tasks would be equal or
  more than the desired count of tasks during a rolling update.
  
[Blue/Green deployment with CodeDeploy](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/deployment-type-bluegreen.html)
  
- You must configure the service to use either an Application Load Balancer or Network Load Balancer. Classic Load Balancers aren't supported

> The Fargate launch type is unnecessary for the blue/green deployment type. The EC2 launch type is also supported.

- When you initially create a CodeDeploy application and deployment group, you must specify the following:
  You must define two target groups for the load balancer
  
### Elasticbeanstalk

[using-features.rolling-version-deploy](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/using-features.rolling-version-deploy.html)

- AWS Elastic Beanstalk provides several options for how deployments are processed, including deployment policies (All at once, Rolling, Rolling with additional batch, Immutable, and Traffic splitting)
- If you use blue/green deployment stratergy then two environments are required.

[Blue/Green deployments with Elastic Beanstalk](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/using-features.CNAMESwap.html)

### ElasticLoadBalancing

[Deregistration delay](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-target-groups.html#deregistration-delay)

### Quicksight

[Quicksight](https://aws.amazon.com/quicksight/)

QuickSight lets you easily create and publish interactive BI dashboards as well as receive answers in seconds through natural langauge queries. QuickSight dashboards can be accessed from any device, and seamlessly embedded into your applications, portals, and websites.


### S3

[object-lifecycle-mgmt](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-lifecycle-mgmt.html)

- storing logs in Amazon S3, and use lifecycle policies to archive to Amazon
  Glacier

### ServerMigrationService

[Using Amazon CloudWatch Events and AWS Lambda with AWS SMS](https://docs.aws.amazon.com/server-migration-service/latest/userguide/cwe-sms.html)


### VPC 

[VPC Flow Logs](https://docs.aws.amazon.com/vpc/latest/userguide/flow-logs.html)

VPC Flow Logs is a feature that enables you to capture information about the IP traffic going to and from network interfaces in your VPC. Flow log data can be published to Amazon CloudWatch Logs or Amazon S3. 
