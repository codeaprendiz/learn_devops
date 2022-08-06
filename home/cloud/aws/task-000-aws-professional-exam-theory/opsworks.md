# OpsWorks

[Cheat Sheet - AWS OpsWorks](https://tutorialsdojo.com/aws-opsworks/)

- AWS OpsWorks is a configuration management service that provides managed instances of Chef and Puppet. 
- Chef and Puppet are automation platforms that allow you to use code to automate the configurations of your servers. 
- OpsWorks lets you use Chef and Puppet to automate how servers are configured, deployed, and managed across your Amazon EC2 instances or on-premises compute environments.



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