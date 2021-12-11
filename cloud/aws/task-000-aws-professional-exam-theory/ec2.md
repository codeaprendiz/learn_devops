# EC2

[Cheat Sheet - EBS](https://tutorialsdojo.com/amazon-ebs)

[EC2](https://tutorialsdojo.com/amazon-elastic-compute-cloud-amazon-ec2)


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


## EC2 Spot

### Getting Started with Amazon EC2 Spot Instances

[Getting Started with Amazon EC2 Spot Instances](https://aws.amazon.com/ec2/spot/getting-started/)


#### No Spot capacity available

[Why am I receiving a "no Spot capacity available" error when trying to launch an Amazon EC2 Spot Instance?](https://aws.amazon.com/premiumsupport/knowledge-center/ec2-spot-instance-insufficient-capacity/)

- Be flexible about which instance types you request and which Availability Zones you deploy your workload in


[Spot Instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-spot-instances.html)


### Elastic network interfaces

[Elastic network interfaces](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-eni.html)

- An elastic network interface is a logical networking component in a VPC that represents a virtual network card.

### Multiple IP addresses

[Multiple IP addresses](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/MultipleIP.html)

- You can specify multiple private IPv4 and IPv6 addresses for your instances. 
- The number of network interfaces and private IPv4 and IPv6 addresses that you can specify for an instance depends on the instance type.

## Fleets

### Example 5: Launch a Spot Fleet using the diversified allocation strategy

[Example 5: Launch a Spot Fleet using the diversified allocation strategy](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-fleet-examples.html#fleet-config5)

- A best practice to increase the chance that a spot request can be fulfilled by EC2 capacity in the event of an outage in one of the Availability Zones is to diversify across zones.
- For this scenario, include each Availability Zone available to you in the launch specification. And, instead of using the same subnet each time, use three unique subnets (each mapping to a different zone).


## Storage

### Amazon EBS volume types

[Amazon EBS volume types](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-volume-types.html)

- Solid state drives (SSD) — Optimized for transactional workloads involving frequent read/write operations with small I/O size, where the dominant performance attribute is IOPS.
- Hard disk drives (HDD) — Optimized for large streaming workloads where the dominant performance attribute is throughput.
- Previous generation — Hard disk drives that can be used for workloads with small datasets where data is accessed infrequently and performance is not of primary importance

There are several factors that can affect the performance of EBS volumes, such as instance configuration, I/O characteristics, and workload demand


[Comparision of varios block storage types](https://aws.amazon.com/ebs/features)


## Instances

### Reserved Instances

[Reserved Instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-reserved-instances.html)

- Reserved Instances provide you with significant savings on your Amazon EC2 costs compared to On-Demand Instance pricing. 
- Reserved Instances are not physical instances, but rather a billing discount applied to the use of On-Demand Instances in your account.


## Security

#### Supported resource-level permissions for Amazon EC2 API actions

[Supported resource-level permissions for Amazon EC2 API actions](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/iam-policy-structure.html#ec2-supported-iam-actions-resources)

- Resource-level permissions refers to the ability to specify which resources users are allowed to perform actions on. 
- Amazon EC2 has partial support for resource-level permissions. 
- This means that for certain Amazon EC2 actions, you can control when users are allowed to use those actions based on conditions that have to be fulfilled, or specific resources that users are allowed to use. 
- For example, you can grant users permissions to launch instances, but only of a specific type, and only using a specific AMI.


## VM Import/Export

[VM Import/Export](https://aws.amazon.com/ec2/vm-import)

- VM Import/Export enables you to easily import virtual machine images from your existing environment to Amazon EC2 instances and export them back to your on-premises environment


## Dynamic Scaling

### Scaling based on Amazon SQS

[Scaling based on Amazon SQS](https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-using-sqs-queue.html)
