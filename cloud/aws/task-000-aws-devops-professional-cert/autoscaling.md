## EC2 AutoScaling

[Scheduled scaling for Amazon EC2 Auto Scaling](https://docs.aws.amazon.com/autoscaling/ec2/userguide/schedule_time.html)

- cooldown timer does not influence the scheduled activity

[Cooldown](https://docs.aws.amazon.com/autoscaling/ec2/userguide/Cooldown.html)

- even if the cooldown timer is running, the scheduled action takes high priority and executes immediately

[Amazon EC2 Auto Scaling lifecycle hooks](https://docs.aws.amazon.com/autoscaling/ec2/userguide/lifecycle-hooks.html)

- When a scale-out event occurs, your newly launched instance completes its startup sequence and transitions to a wait state. 
- While the instance is in a wait state, it runs a script to download and install the needed software packages for your application, 
  making sure that your instance is fully ready before it starts receiving traffic. 
- When the script is finished installing software, it sends the complete-lifecycle-action command to continue.

[AutoScalingReplacingUpdate policy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-attribute-updatepolicy.html)

To specify how AWS CloudFormation handles replacement updates for an Auto Scaling group, use the AutoScalingReplacingUpdate policy. This policy enables you to specify whether AWS CloudFormation replaces an Auto Scaling group with a new one or replaces only the instances in the Auto Scaling group.


### Supports Following Deployment Methods

- AllAtOnce
- HalfAtATime
- OneAtATime. 


But it does not support the canary type.

### Auto Scaling groups with multiple instance types and purchase options

- You can launch and automatically scale a fleet of On-Demand Instances and Spot Instances within a single Auto Scaling group. In addition to receiving discounts for using Spot Instances, you can use Reserved Instances or a Savings Plan to receive discounted rates of the regular On-Demand Instance pricing.

### Monitoring

#### Health checks for Auto Scaling instances

[Health checks for Auto Scaling instances](https://docs.aws.amazon.com/autoscaling/ec2/userguide/healthcheck.html)

The health status of an Auto Scaling instance is either healthy or unhealthy. All instances in your Auto Scaling group start in the healthy state. Instances are assumed to be healthy unless Amazon EC2 Auto Scaling receives notification that they are unhealthy. This notification can come from one or more of the following sources: Amazon EC2, Elastic Load Balancing (ELB), or a custom health check.

**Instance health status**

Amazon EC2 Auto Scaling can determine the health status of an instance using one or more of the following:

- Status checks provided by Amazon EC2 to identify hardware and software issues that may impair an instance. The default health checks for an Auto Scaling group are EC2 status checks only.
- Health checks provided by Elastic Load Balancing (ELB). These health checks are disabled by default but can be enabled.
- Your custom health checks.

Using custom health checks

```bash
aws autoscaling set-instance-health --instance-id i-123abc45d --health-status Unhealthy
```

Health check grace period

- By default, the health check grace period is 300 seconds when you create an Auto Scaling group from the AWS Management Console. Its default value is 0 seconds when you create an Auto Scaling group using the AWS CLI or an SDK.
- If you add a lifecycle hook, the grace period does not start until the lifecycle hook actions are completed and the instance enters the InService state.


### Scaling Your Group

#### Temporarily removing instances from your Auto Scaling group

[Temporarily removing instances from your Auto Scaling group](https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-enter-exit-standby.html)

- You can put an instance that is in the InService state into the Standby state, update or troubleshoot the instance, and then return the instance to service. Instances that are on standby are still part of the Auto Scaling group, but they do not actively handle load balancer traffic.
- Amazon EC2 Auto Scaling does not perform health checks on instances that are in a standby state.

```bash
aws autoscaling enter-standby --instance-ids i-05b4f7d5be44822a6 \
  --auto-scaling-group-name my-asg --should-decrement-desired-capacity
```