# Route53

[Cheat Sheet - AWS Route53](https://tutorialsdojo.com/amazon-route-53)
[Cheat Sheet - AWS Database Migration Service](https://tutorialsdojo.com/aws-database-migration-service)

## Routing internet traffic to your AWS resources

### Routing traffic to an ELB load balancer

- To route domain traffic to an ELB load balancer, use Amazon Route 53 to create an alias record that points to your load balancer.
- An alias record is a Route 53 extension to DNS. It's similar to a CNAME record, but you can create an alias record both for the root domain, such as example.com, and for subdomains, such as www.example.com.


### Routing traffic to a website that is hosted in an Amazon S3 bucket

[Routing traffic to a website that is hosted in an Amazon S3 bucket](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/RoutingToS3Bucket.html)

- To route domain traffic to an S3 bucket, use Amazon Route 53 to create an alias record that points to your bucket.


### Configuring a static website using a custom domain registered with Route 53

[Configuring a static website using a custom domain registered with Route 53](https://docs.aws.amazon.com/AmazonS3/latest/userguide/website-hosting-custom-domain-walkthrough.html)



