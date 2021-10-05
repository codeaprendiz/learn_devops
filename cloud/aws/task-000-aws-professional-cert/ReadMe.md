Best Design includes cost optimized design too.

- [Auto Scaling](#Auto-Scaling)
- [Billing and Cost Management](#Billing and Cost Management)
- [CloudFormation](#CloudFormation)
- [CloudWatch](#CloudWatch)
- [Code Commit](#codecommit)
- [Code Deploy](#codedeploy)
- [Code Pipeline]()
- [Dynamodb](#Dynamodb)
- [EC2](#EC2)
- [ECS](#ECS)
- [Elasticbeanstalk](#Elasticbeanstalk)
- [Quicksight](#Quicksight)
- [S3](#S3)
- [Server Migration Service](#Server Migration Service)
- [VPC](#VPC)

### Auto-Scaling

[Scheduled scaling for Amazon EC2 Auto Scaling](https://docs.aws.amazon.com/autoscaling/ec2/userguide/schedule_time.html)

- cooldown timer does not influence the scheduled activity

[Cooldown](https://docs.aws.amazon.com/autoscaling/ec2/userguide/Cooldown.html)

- even if the cooldown timer is running, the scheduled action takes high priority and executes immediately

[Amazon EC2 Auto Scaling lifecycle hooks](https://docs.aws.amazon.com/autoscaling/ec2/userguide/lifecycle-hooks.html)

- When a scale-out event occurs, your newly launched instance completes its startup sequence and transitions to a wait state. While the instance is in a wait state, it runs a script to download and install the needed software packages for your application, making sure that your instance is fully ready before it starts receiving traffic. When the script is finished installing software, it sends the complete-lifecycle-action command to continue.



### Billing and Cost Management

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

[Target tracking scaling policies](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-autoscaling-targettracking.html)

### Elasticbeanstalk

[using-features.rolling-version-deploy](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/using-features.rolling-version-deploy.html)

- AWS Elastic Beanstalk provides several options for how deployments are processed, including deployment policies (All at once, Rolling, Rolling with additional batch, Immutable, and Traffic splitting)
- If you use blue/green deployment stratergy then two environments are required.

[Blue/Green deployments with Elastic Beanstalk](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/using-features.CNAMESwap.html)

### Quicksight

[Quicksight](https://aws.amazon.com/quicksight/)

QuickSight lets you easily create and publish interactive BI dashboards as well as receive answers in seconds through natural langauge queries. QuickSight dashboards can be accessed from any device, and seamlessly embedded into your applications, portals, and websites.


### S3

[object-lifecycle-mgmt](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-lifecycle-mgmt.html)

- storing logs in Amazon S3, and use lifecycle policies to archive to Amazon
  Glacier

### Server Migration Service

[Using Amazon CloudWatch Events and AWS Lambda with AWS SMS](https://docs.aws.amazon.com/server-migration-service/latest/userguide/cwe-sms.html)


### VPC 

[VPC Flow Logs](https://docs.aws.amazon.com/vpc/latest/userguide/flow-logs.html)

VPC Flow Logs is a feature that enables you to capture information about the IP traffic going to and from network interfaces in your VPC. Flow log data can be published to Amazon CloudWatch Logs or Amazon S3. 
