## OpsWorks

AWS OpsWorks is a configuration management service that provides managed instances of Chef and Puppet. Chef and Puppet are automation platforms that allow you to use code to automate the configurations of your servers.

[How to set up AWS OpsWorks Stacks auto healing notifications in Amazon CloudWatch Events](https://aws.amazon.com/blogs/mt/how-to-set-up-aws-opsworks-stacks-auto-healing-notifications-in-amazon-cloudwatch-events/)

- Save the following event pattern as a file named OpsWorksAutoHealingPattern.json

```json
{
  "source": [
    "aws.opsworks"
  ],
  "detail": {
    "initiated_by": [
      "auto-healing"
    ]
  }
}
```