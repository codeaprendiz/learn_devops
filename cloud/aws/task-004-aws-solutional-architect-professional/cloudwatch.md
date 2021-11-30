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

### Creating metric filters

[Creating metric filters](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/MonitoringPolicyExamples.html)

