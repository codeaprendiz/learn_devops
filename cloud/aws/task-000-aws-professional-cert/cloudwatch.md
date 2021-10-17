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


[Sending and Receiving Events Between AWS Accounts](https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/CloudWatchEvents-CrossAccountEventDelivery.html)


The overall process is as follows:

- On the receiver account, edit the permissions on the default event bus to allow specified AWS accounts, an organization, or all AWS accounts to send events to the receiver account.
- On the sender account, set up one or more rules that have the receiver account's default event bus as the target.
- On the receiver account, set up one or more rules that match events that come from the sender account.