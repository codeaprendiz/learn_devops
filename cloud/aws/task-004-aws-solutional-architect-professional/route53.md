# Route53

[Cheat Sheet - AWS Route53](https://tutorialsdojo.com/amazon-route-53)
[Cheat Sheet - AWS Database Migration Service](https://tutorialsdojo.com/aws-database-migration-service)

## Routing internet traffic to your AWS resources

### Routing traffic to an ELB load balancer

- To route domain traffic to an ELB load balancer, use Amazon Route 53 to create an alias record that points to your load balancer.
- An alias record is a Route 53 extension to DNS. It's similar to a CNAME record, but you can create an alias record both for the root domain, such as example.com, and for subdomains, such as www.example.com.