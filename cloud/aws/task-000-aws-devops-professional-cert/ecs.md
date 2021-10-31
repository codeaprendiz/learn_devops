
### ECS

[What is ECS](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/Welcome.html)

[Target tracking scaling policies](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-autoscaling-targettracking.html)

[How do I troubleshoot Amazon ECS tasks that take a long time to stop when the container instance is set to DRAINING?](https://aws.amazon.com/premiumsupport/knowledge-center/ecs-tasks-stop-delayed-draining/)

[service_definition_parameters](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service_definition_parameters.html)

- If a service is using the rolling update (ECS) deployment type, the minimumHealthyPercent represents a lower limit on the number of your service's tasks that must remain in the RUNNING state during a deployment
- Minimum healthy percent represents a lower limit on the tasks. When the parameter is set to 100, the number of the service's running tasks would be equal or
  more than the desired count of tasks during a rolling update.

[Blue/Green deployment with CodeDeploy](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/deployment-type-bluegreen.html)

- You must configure the service to use either an Application Load Balancer or Network Load Balancer. Classic Load Balancers aren't supported

> The Fargate launch type is unnecessary for the blue/green deployment type. The EC2 launch type is also supported.

- When you initially create a CodeDeploy application and deployment group, you must specify the following:
  You must define two target groups for the load balancer
  