### EC2

[dedicated-hosts](https://aws.amazon.com/ec2/dedicated-hosts)

- Network Load Balancers do not use security groups.

[iam-roles-for-amazon-ec2](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/iam-roles-for-amazon-ec2.html)

- The AWS SDKs assume the IAM roles attached in the instances and get temporary credentials by interacting with the AWS STS service.

[security-group-load-balancer](https://aws.amazon.com/premiumsupport/knowledge-center/security-group-load-balancer/)

[How do I stop and start Amazon EC2 instances at regular intervals using Lambda?](https://aws.amazon.com/premiumsupport/knowledge-center/start-stop-lambda-cloudwatch)

To stop and start EC2 instances at regular intervals using Lambda, do the following:
- Create a custom AWS Identity and Access Management (IAM) policy and execution role for your Lambda function. 
- Create Lambda functions that stop and start your EC2 instances. 
- Test your Lambda functions. 
- Create CloudWatch Events rules that trigger your function on a schedule.

This example setup is a simple solution. For a more robust solution, use the AWS Instance Scheduler


#### No Spot capacity available

[Why am I receiving a "no Spot capacity available" error when trying to launch an Amazon EC2 Spot Instance?](https://aws.amazon.com/premiumsupport/knowledge-center/ec2-spot-instance-insufficient-capacity/)

- Be flexible about which instance types you request and which Availability Zones you deploy your workload in