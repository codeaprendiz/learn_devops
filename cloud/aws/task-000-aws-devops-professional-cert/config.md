## AWS Config

[What Is AWS Config?](https://docs.aws.amazon.com/config/latest/developerguide/WhatIsConfig.html)

- AWS Config provides a detailed view of the configuration of AWS resources in your AWS account. This includes how the resources are related to one another and how they were configured in the past so that you can see how the configurations and relationships change over time




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

