### CloudWatch

[Monitoring deployments with Amazon CloudWatch Events](https://docs.aws.amazon.com/codedeploy/latest/userguide/monitoring-cloudwatch-events.html)

```bash
The following are some use cases:
Use a Lambda function to pass a notification to a Slack channel whenever deployments fail.
Push data about deployments or instances to a Kinesis stream to support comprehensive, real-time status monitoring.
Use CloudWatch alarm actions to automatically stop, terminate, reboot, or recover Amazon EC2 instances when a deployment or instance event you specify occurs.
```

[dynamic-dns-for-route-53](https://aws.amazon.com/blogs/compute/building-a-dynamic-dns-for-route-53-using-cloudwatch-events-and-lambda/)

[Real-time processing of log data with subscriptions](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/Subscriptions.html)

- You can use subscriptions to get access to a real-time feed of log events from CloudWatch Logs and have it delivered to other services such as an Amazon Kinesis stream, an Amazon Kinesis Data Firehose stream, or AWS Lambda for custom processing, analysis, or loading to other systems

[Sending and Receiving Events Between AWS Accounts](https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/CloudWatchEvents-CrossAccountEventDelivery.html)


The overall process is as follows:

- On the receiver account, edit the permissions on the default event bus to allow specified AWS accounts, an organization, or all AWS accounts to send events to the receiver account.
- On the sender account, set up one or more rules that have the receiver account's default event bus as the target.
- On the receiver account, set up one or more rules that match events that come from the sender account.


#### Creating metrics for log events using filter

##### Filter and Pattern Syntax

[Filter and pattern syntax](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/FilterAndPatternSyntax.html)

- You can use metric filters to search for and match terms, phrases, or values in your log events. When a metric filter finds one of the terms, phrases, or values in your log events, you can increment the value of a CloudWatch metric. For example, you can create a metric filter to search for and count the occurrence of the word ERROR in your log events.
- When a metric filter finds one of the matching terms, phrases, or values in your log events, it increments the count in the CloudWatch metric by the amount you specify for Metric Value. The metric value is aggregated and reported every minute.

##### Example: Count HTTP 404 codes

- Example: Count HTTP 404 codes
```bash
For Filter Pattern, type [IP, UserInfo, User, Timestamp, RequestInfo, StatusCode=404, Bytes]. 
```


#### Publishing custom metrics

[Publishing custom metrics](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/publishingMetrics.html)

[put-metric-data¶](https://docs.aws.amazon.com/cli/latest/reference/cloudwatch/put-metric-data.html)

- You can publish your own metrics to CloudWatch using the AWS CLI or an API. You can view statistical graphs of your published metrics with the AWS Management Console.

- instead of calling put-metric-data multiple times for three data points that are within 3 seconds of each other, you can aggregate the data into a statistic set that you publish with one call, using the --statistic-values parameter.

```bash
aws cloudwatch put-metric-data --metric-name PageViewCount --namespace MyService --statistic-values Sum=11,Minimum=2,Maximum=5,SampleCount=3 --timestamp 2016-10-14T12:00:00.000Z
```

