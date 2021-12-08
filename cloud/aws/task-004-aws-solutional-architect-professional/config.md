# Config

[What Is AWS Config?](https://docs.aws.amazon.com/config/latest/developerguide/WhatIsConfig.html)

- AWS Config provides a detailed view of the configuration of AWS resources in your AWS account. This includes how the resources are related to one another and how they were configured in the past so that you can see how the configurations and relationships change over time

[Cheat Sheet - AWS Config](https://tutorialsdojo.com/aws-config)

- AWS Config provides a detailed view of the configuration of AWS resources in your AWS account.
- This includes how the resources are related to one another and how they were configured in the past so that you can see how the configurations and relationships change over time.
- An AWS resource is an entity you can work with in AWS, such as an Amazon Elastic Compute Cloud (EC2) instance, an Amazon Elastic Block Store (EBS) volume, a security group, or an Amazon Virtual Private Cloud (VPC). 

With AWS Config, you can do the following:

- Evaluate your AWS resource configurations for desired settings.
- Get a snapshot of the current configurations of the supported resources that are associated with your AWS account.
- Retrieve configurations of one or more resources that exist in your account.
- Retrieve historical configurations of one or more resources.
- Receive a notification whenever a resource is created, modified, or deleted.
- View relationships between resources. For example, you might want to find all resources that use a particular security group.

[AWS Config](https://aws.amazon.com/config/)

- AWS Config is a service that enables you to assess, audit, and evaluate the configurations of your AWS resources.
- Config continuously monitors and records your AWS resource configurations and allows you to automate the evaluation of recorded configurations against desired configurations. 
- With Config, you can review changes in configurations and relationships between AWS resources, dive into detailed resource configuration histories, and determine your overall compliance against the configurations specified in your internal guidelines.

## AWS Config Managed Rules

[AWS Config Managed Rules](https://docs.aws.amazon.com/config/latest/developerguide/evaluate-config_use-managed-rules.html)

- AWS Config provides AWS managed rules, which are predefined, customizable rules that AWS Config uses to evaluate whether your AWS resources comply with common best practices.
- For example, you could use a managed rule to quickly start assessing whether your Amazon Elastic Block Store (Amazon EBS) volumes are encrypted or whether specific tags are applied to your resources
- You can set up and activate these rules without writing the code to create an AWS Lambda function, which is required if you want to create custom rules.
- The AWS Config console guides you through the process of configuring and activating a managed rule.

The evaluation triggers are defined as part of the rule, and they can include the following types:

- Configuration changes
    - AWS Config triggers the evaluation when any resource that matches the rule's scope changes in configuration. The evaluation runs after AWS Config sends a configuration item change notification.
- Periodic
    - AWS Config runs evaluations for the rule at a frequency that you choose (for example, every 24 hours).


### Managed Rules

[List of AWS Config Managed Rules](https://docs.aws.amazon.com/config/latest/developerguide/managed-rules-by-aws-config.html)

- [approved-amis-by-id](https://docs.aws.amazon.com/config/latest/developerguide/approved-amis-by-id.html)
  - Checks if running instances are using specified AMIs. Specify a list of approved AMI IDs. Running instances with AMIs that are not on this list are NON_COMPLIANT.


---







### Viewing Compliance History Timeline for Resources

[Viewing Compliance History Timeline for Resources](https://docs.aws.amazon.com/config/latest/developerguide/view-compliance-history.html)

- AWS Config supports storing compliance state changes of resources as evaluated by AWS Config Rules. The resource compliance history is presented in the form of a timeline. The timeline captures changes as ConfigurationItems over a period of time for a specific resource.

### AWS Config Rules

#### Specifying Triggers

[Specifying Triggers for AWS Config Rules](https://docs.aws.amazon.com/config/latest/developerguide/evaluate-config-rules.html)

- When you add a rule to your account, you can specify when you want AWS Config to run the rule; this is called a trigger. AWS Config evaluates your resource configurations against the rule when the trigger occurs.
- There are two types of triggers:
  - Configuration changes
  - Periodic

#### Managing Rules

##### restricted-ssh

[restricted-ssh](https://docs.aws.amazon.com/config/latest/developerguide/restricted-ssh.html)

- Checks if the incoming SSH traffic for the security groups is accessible. The rule is COMPLIANT when IP addresses of the incoming SSH traffic in the security groups are restricted (CIDR other than 0.0.0.0/0). This rule applies only to IPv4.

#### Remediating Noncompliant AWS Resources by AWS Config Rules

[Remediating Noncompliant AWS Resources by AWS Config Rules](https://docs.aws.amazon.com/config/latest/developerguide/remediation.html)

- AWS Config allows you to remediate noncompliant resources that are evaluated by AWS Config Rules. AWS Config applies remediation using AWS Systems Manager Automation documents. These documents define the actions to be performed on noncompliant AWS resources evaluated by AWS Config Rules.

