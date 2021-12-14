# CloudWatch

[Cheat Sheet - CloudWatch](https://tutorialsdojo.com/amazon-cloudwatch)

[cloudwatch-agent-vs-ssm-agent-vs-custom-daemon-scripts](https://tutorialsdojo.com/cloudwatch-agent-vs-ssm-agent-vs-custom-daemon-scripts)

## Schedule Expressions for Rules

[Schedule Expressions for Rules](https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html)

- You can create rules that self-trigger on an automated schedule in CloudWatch Events using cron or rate expressions. 
- All scheduled events use UTC time zone and the minimum precision for schedules is 1 minute.

## Analyzing log data with CloudWatch Logs Insights

[Analyzing log data with CloudWatch Logs Insights](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/AnalyzingLogData.html)

- CloudWatch Logs Insights enables you to interactively search and analyze your log data in Amazon CloudWatch Logs
- You can perform queries to help you more efficiently and effectively respond to operational issues
-  If an issue occurs, you can use CloudWatch Logs Insights to identify potential causes and validate deployed fixes


### Installing the CloudWatch agent on on-premises servers

[Installing the CloudWatch agent on on-premises servers](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/install-CloudWatch-Agent-on-premise.html)

- If you have downloaded the CloudWatch agent on one computer and created the agent configuration file you want, you can use that configuration file to install the agent on other on-premises servers.

## Using Amazon CloudWatch alarms

[Using Amazon CloudWatch alarms](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/AlarmThatSendsEmail.html)

- You can create both metric alarms and composite alarms in CloudWatch.
  - A metric alarm 
    - watches a single CloudWatch metric or the result of a math expression based on CloudWatch metrics. 
    - The alarm performs one or more actions based on the value of the metric or expression relative to a threshold over a number of time periods. 
    - The action can be sending a notification to an Amazon SNS topic, performing an Amazon EC2 action or an Amazon EC2 Auto Scaling action, or creating an OpsItem or incident in Systems Manager
  - A composite alarm 
    - includes a rule expression that takes into account the alarm states of other alarms that you have created. 
    - The composite alarm goes into ALARM state only if all conditions of the rule are met. 
    - The alarms specified in a composite alarm's rule expression can include metric alarms and other composite alarms.


## Creating metrics from log events using filters

- You can search and filter the log data coming into CloudWatch Logs by creating one or more metric filters. 
- Metric filters define the terms and patterns to look for in log data as it is sent to CloudWatch Logs. 
- CloudWatch Logs uses these metric filters to turn log data into numerical CloudWatch metrics that you can graph or set an alarm on.

### Creating metric filters

[Creating metric filters](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/MonitoringPolicyExamples.html)



[Monitoring deployments with Amazon CloudWatch Events](https://docs.aws.amazon.com/codedeploy/latest/userguide/monitoring-cloudwatch-events.html)


- You can use Amazon CloudWatch Events to detect and react to changes in the state of an instance or a deployment (an "event") in your CodeDeploy operations. 
- Then, based on rules you create, CloudWatch Events will invoke one or more target actions when a deployment or instance enters the state you specify in a rule. 
- Depending on the type of state change, you might want to send notifications, capture state information, take corrective action, initiate events, or take other actions. 
- You can select the following types of targets when using CloudWatch Events as part of your CodeDeploy operations:
  - AWS Lambda functions
  - Kinesis streams
  - Amazon SQS queues
  
Built-in targets (EC2 CreateSnapshot API call, EC2 RebootInstances API call, EC2 StopInstances API call , and EC2 TerminateInstances API call)

Amazon SNS topics


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
