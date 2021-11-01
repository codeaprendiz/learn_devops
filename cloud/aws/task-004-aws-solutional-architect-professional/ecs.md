# ECS

[Cheetsheet - ECS](https://tutorialsdojo.com/amazon-elastic-container-service-amazon-ecs/?src=udemy)

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