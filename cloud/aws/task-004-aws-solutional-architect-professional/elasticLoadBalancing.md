# Elastic Load Balancing

[Cheat Sheet - ALB vs NLB vs CLB](https://tutorialsdojo.com/application-load-balancer-vs-network-load-balancer-vs-classic-load-balancer)

### Health checks for your target groups

[Health checks for your target groups](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/target-group-health-checks.html)

- Your Application Load Balancer periodically sends requests to its registered targets to test their status. These tests are called health checks.

> If a target group contains only unhealthy registered targets, the load balancer routes requests to all those targets, regardless of their health status.

## Network LoadBalancer

[Troubleshoot your Network Load Balancer](https://docs.aws.amazon.com/elasticloadbalancing/latest/network/load-balancer-troubleshooting.html)


### Target security groups

[Target security groups](https://docs.aws.amazon.com/elasticloadbalancing/latest/network/target-group-register-targets.html#target-security-groups)

- When you register EC2 instances as targets, you must ensure that the security groups for these instances allow traffic on both the listener port and the health check port.




## Notes

-  Network Load Balancers don't have associated security groups.


## Blogs

- [How do I attach a security group to my Elastic Load Balancer?](https://aws.amazon.com/premiumsupport/knowledge-center/security-group-load-balancer)

- [AWS Elastic Load Balancing: Support for SSL Termination](https://aws.amazon.com/blogs/aws/elastic-load-balancer-support-for-ssl-termination)
