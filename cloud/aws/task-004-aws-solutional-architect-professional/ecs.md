# ECS

[Cheetsheet - ECS](https://tutorialsdojo.com/amazon-elastic-container-service-amazon-ecs/)

[What is Amazon Elastic Container Service?](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/Welcome.html)

- highly scalable, fast container management service that makes it easy to run, stop, and manage containers on a cluster
- Your containers are defined in a task definition that you use to run individual tasks or tasks within a service
- In this context, a service is a configuration that enables you to run and maintain a specified number of tasks simultaneously in a cluster. 
- You can run your tasks and services on a serverless infrastructure that is managed by AWS Fargate. Alternatively, for more control over your infrastructure, you can run your tasks and services on a cluster of Amazon EC2 instances that you manage.


## Using Spot Instances

- A Spot Instance is an unused Amazon EC2 instance that is available for less than the On-Demand price.
- The hourly price for a Spot Instance is called a Spot price


### Spot Instance Draining

- Amazon EC2 terminates, stops, or hibernates your Spot Instance when the Spot price exceeds the maximum price for your request or capacity is no longer available
- Amazon EC2 provides a Spot Instance interruption notice, which gives the instance a two-minute warning before it is interrupted.
- If Amazon ECS Spot Instance draining is enabled on the instance, ECS receives the Spot Instance interruption notice and places the instance in DRAINING status.
- When a container instance is set to DRAINING, Amazon ECS prevents new tasks from being scheduled for placement on the container instance. 
- Service tasks on the draining container instance that are in the PENDING state are stopped immediately
- If there are container instances in the cluster that are available, replacement service tasks are started on them.

```bash
# To enable Spot Instance draining for an existing container instance
# Edit the /etc/ecs/ecs.config file and add the following:

ECS_ENABLE_SPOT_INSTANCE_DRAINING=true
```


[Four Steps to Run ECS Clusters on EC2 Spot Instances](https://aws.amazon.com/ec2/spot/containers-for-less/get-started/)


## Task Definations

Amazon ECS enables you to inject sensitive data into your containers by storing your sensitive data in either AWS Secrets Manager secrets or AWS Systems Manager Parameter Store parameters and then referencing them in your container definition.

- Store the database credentials using the AWS Secrets Manager
- encrypt them using AWS KMS
- Create an IAM Role for your Amazon ECS task execution role
  - and reference it with your task definition which allows access to both KMS and AWS Secrets Manager
- Within your container definition, specify secrets with the name of the environment variable to set in the container and the full ARN of the Secrets Manager secret which contains the sensitive data, to present to the container.
> Systems Manager Parameter Store service doesn't provide dedicated storage with lifecycle management and key rotation, unlike Secrets Manager.


### Amazon ECS task networking

[Amazon ECS task networking](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-networking.html)

- The networking behavior of Amazon ECS tasks hosted on Amazon EC2 instances is dependent on the network mode defined in the task definition. The following are the available network modes. Amazon ECS recommends using the awsvpc network mode unless you have a specific need to use a different network mode.
  - awsvpc — The task is allocated its own elastic network interface (ENI) and a primary private IPv4 address. This gives the task the same networking properties as Amazon EC2 instances.
  - bridge — The task utilizes Docker's built-in virtual network which runs inside each Amazon EC2 instance hosting the task.
  - host — The task bypasses Docker's built-in virtual network and maps container ports directly to the ENI of the Amazon EC2 instance hosting the task. As a result, you can't run multiple instantiations of the same task on a single Amazon EC2 instance when port mappings are used.
  - none — The task has no external network connectivity.

- In order for you to use security groups and network monitoring tools at a more granular level within your ECS tasks, you have to use the awsvpc network mode

## Troubleshooting

### CannotPullContainer task errors

[CannotPullContainer task errors](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_cannot_pull_image.html)

[How can I resolve the Amazon ECR error "CannotPullContainerError: API error" in Amazon ECS?
](https://aws.amazon.com/premiumsupport/knowledge-center/ecs-pull-container-api-error-ecr)

- One reason : because a route to the internet doesn't exist: