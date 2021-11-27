# Elastic Load Balancing

### Health checks for your target groups

[Health checks for your target groups](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/target-group-health-checks.html)

- Your Application Load Balancer periodically sends requests to its registered targets to test their status. These tests are called health checks.

> If a target group contains only unhealthy registered targets, the load balancer routes requests to all those targets, regardless of their health status.


