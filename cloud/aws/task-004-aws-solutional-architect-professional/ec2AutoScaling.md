# EC2 Autoscaling

## Autoscaling Groups

[What is Amazon EC2 Auto Scaling?](https://docs.aws.amazon.com/autoscaling/ec2/userguide/what-is-amazon-ec2-auto-scaling.html)

- Amazon EC2 Auto Scaling helps you ensure that you have the correct number of Amazon EC2 instances available to handle the load for your application. 
- You create collections of EC2 instances, called Auto Scaling groups
- You can specify the minimum number of instances in each Auto Scaling group, and Amazon EC2 Auto Scaling ensures that your group never goes below this size. 
- You can specify the maximum number of instances in each Auto Scaling group, and Amazon EC2 Auto Scaling ensures that your group never goes above this size.


### Elastic Load Balancing and Amazon EC2 Auto Scaling

[Elastic Load Balancing and Amazon EC2 Auto Scaling](https://docs.aws.amazon.com/autoscaling/ec2/userguide/autoscaling-load-balancer.html)

- Elastic Load Balancing automatically distributes your incoming application traffic across all the EC2 instances that you are running. 
- Elastic Load Balancing helps to manage incoming requests by optimally routing traffic so that no one instance is overwhelmed.
- To use Elastic Load Balancing with your Auto Scaling group, attach the load balancer to your Auto Scaling group.
- This registers the group with the load balancer, which acts as a single point of contact for all incoming web traffic to your Auto Scaling group.

## Elastic Load Balancing

### Attaching a load balancer to your Auto Scaling group

[Attaching a load balancer to your Auto Scaling group](https://docs.aws.amazon.com/autoscaling/ec2/userguide/attach-load-balancer-asg.html)

- Amazon EC2 Auto Scaling integrates with Elastic Load Balancing to help you to insert an Application Load Balancer, Network Load Balancer, Classic Load Balancer, or Gateway Load Balancer in front of your Auto Scaling group.
- When you attach an Application Load Balancer, Network Load Balancer, or Gateway Load Balancer, you attach a target group. 
- Amazon EC2 Auto Scaling adds instances to the attached target group when they are launched. 
- You can attach one or multiple target groups, and configure health checks on a per target group basis.

### Scaling based on Amazon SQS

[Scaling based on Amazon SQS](https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-using-sqs-queue.html)

- There are some scenarios where you might think about scaling in response to activity in an Amazon SQS queue. 
- For example, suppose that you have a web app that lets users upload images and use them online.