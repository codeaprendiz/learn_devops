# CloudTrail

[Cheat Sheet - AWS CloudTrail](https://tutorialsdojo.com/aws-cloudtrail)

## What Is AWS CloudTrail?


[What Is AWS CloudTrail?](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-user-guide.html)

- AWS CloudTrail is an AWS service that helps you enable governance, compliance, and operational and risk auditing of your AWS account. 
- Actions taken by a user, role, or an AWS service are recorded as events in CloudTrail. 
- Events include actions taken in the AWS Management Console, AWS Command Line Interface, and AWS SDKs and APIs.


### Global service events 

[Global service events](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-concepts.html#cloudtrail-concepts-global-service-events)

- For most services, events are recorded in the region where the action occurred. 
- For global services such as AWS Identity and Access Management (IAM), AWS STS, and Amazon CloudFront, events are delivered to any trail **that includes global services**.

## Identities

### Logging IAM and AWS STS API calls with AWS CloudTrail

[Logging IAM and AWS STS API calls with AWS CloudTrail](https://docs.aws.amazon.com/IAM/latest/UserGuide/cloudtrail-integration.html)

- IAM and AWS STS are integrated with AWS CloudTrail, a service that provides a record of actions taken by an IAM user or role. 
- CloudTrail captures all API calls for IAM and AWS STS as events, including calls from the console and from API calls. 
- If you create a trail, you can enable continuous delivery of CloudTrail events to an Amazon S3 bucket. 
- If you don't configure a trail, you can still view the most recent events in the CloudTrail console in Event history

## Blogs

- [How to Audit Cross-Account Roles Using AWS CloudTrail and Amazon CloudWatch Events](https://aws.amazon.com/blogs/security/how-to-audit-cross-account-roles-using-aws-cloudtrail-and-amazon-cloudwatch-events)