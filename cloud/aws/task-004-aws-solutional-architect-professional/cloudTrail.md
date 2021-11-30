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