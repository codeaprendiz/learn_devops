# Route53

[Cheat Sheet - AWS Route53](https://tutorialsdojo.com/amazon-route-53)

[Cheat Sheet - AWS Database Migration Service](https://tutorialsdojo.com/aws-database-migration-service)


## Working with hosted zones

[Working with hosted zones](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/hosted-zones-working-with.html)

- A hosted zone is a container for records, and records contain information about how you want to route traffic for a specific domain, such as example.com, and its subdomains (acme.example.com, zenith.example.com). A hosted zone and the corresponding domain have the same name. 

  - Public hosted zones contain records that specify how you want to route traffic on the internet.
  - Private hosted zones contain records that specify how you want to route traffic in an Amazon VPC

[How do I associate a Route 53 private hosted zone with a VPC in a different AWS account or Region?
](https://aws.amazon.com/premiumsupport/knowledge-center/route53-private-hosted-zone)

### Working with a private hosted zone

#### Associating more VPCs with a private hosted zone

[Associating more VPCs with a private hosted zone](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/hosted-zone-private-associate-vpcs.html)

- You can use the Amazon Route 53 console to associate more VPCs with a private hosted zone if you created the hosted zone and the VPCs by using the same AWS account.

#### Associating an Amazon VPC and a private hosted zone that you created with different AWS accounts

[Associating an Amazon VPC and a private hosted zone that you created with different AWS accounts](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/hosted-zone-private-associate-vpcs-different-accounts.html)



## Routing internet traffic to your AWS resources

### Routing traffic to an ELB load balancer

- To route domain traffic to an ELB load balancer, use Amazon Route 53 to create an alias record that points to your load balancer.
- An alias record is a Route 53 extension to DNS. It's similar to a CNAME record, but you can create an alias record both for the root domain, such as example.com, and for subdomains, such as www.example.com.


### Routing traffic to a website that is hosted in an Amazon S3 bucket

[Routing traffic to a website that is hosted in an Amazon S3 bucket](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/RoutingToS3Bucket.html)

- To route domain traffic to an S3 bucket, use Amazon Route 53 to create an alias record that points to your bucket.


### Configuring a static website using a custom domain registered with Route 53

[Configuring a static website using a custom domain registered with Route 53](https://docs.aws.amazon.com/AmazonS3/latest/userguide/website-hosting-custom-domain-walkthrough.html)


## Creating Amazon Route 53 health checks and configuring DNS failover

[Creating Amazon Route 53 health checks and configuring DNS failover](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover.html)

- Amazon Route 53 health checks monitor the health and performance of your web applications, web servers, and other resources. Each health check that you create can monitor one of the following:
  - The health of a specified resource, such as a web server.
  - The status of other health checks.
  - The status of an Amazon CloudWatch alarm.
  - With Amazon Route 53 Application Recovery Controller, you can set up routing control health checks with DNS failover records to manage traffic failover for your application. 


## Choosing a routing policy

[Choosing a routing policy](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/routing-policy.html)

- Simple routing policy – Use for a single resource that performs a given function for your domain, for example, a web server that serves content for the example.com website.
- Failover routing policy – Use when you want to configure active-passive failover.
- Geolocation routing policy – Use when you want to route traffic based on the location of your users.
- Geoproximity routing policy – Use when you want to route traffic based on the location of your resources and, optionally, shift traffic from resources in one location to resources in another.
- Latency routing policy – Use when you have resources in multiple AWS Regions and you want to route traffic to the Region that provides the best latency with less round-trip time.
- Multivalue answer routing policy – Use when you want Route 53 to respond to DNS queries with up to eight healthy records selected at random.
- Weighted routing policy – Use to route traffic to multiple resources in proportions that you specify

### Configuring DNSSEC for a domain

[Configuring DNSSEC for a domain](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/domain-configure-dnssec.html)

- Attackers sometimes hijack traffic to internet endpoints such as web servers by intercepting DNS queries and returning their own IP addresses to DNS resolvers in place of the actual IP addresses for those endpoints
- Users are then routed to the IP addresses provided by the attackers in the spoofed response, for example, to fake websites.
- You can protect your domain from this type of attack, known as DNS spoofing or a man-in-the-middle attack, by configuring Domain Name System Security Extensions (DNSSEC), a protocol for securing DNS traffic.


## Configuring DNS Failover

### Active-active and active-passive failover

[Active-active and active-passive failover](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover-types.html)

- You can use Route 53 health checking to configure active-active and active-passive failover configurations. 
  - You configure active-active failover using any routing policy (or combination of routing policies) other than failover, 
  - and you configure active-passive failover using the failover routing policy.

## Resolving DNS queries between VPCs and your network

[Resolving DNS queries between VPCs and your network](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/resolver.html)

- When you create a VPC using Amazon VPC, Route 53 Resolver automatically uses a Resolver on the VPC to answer DNS queries for local Amazon VPC domain names for EC2 instances (ec2-192-0-2-44.compute-1.amazonaws.com) and records in private hosted zones (acme.example.com). 
- For all other domain names, Resolver performs recursive lookups against public name servers.

- You also can integrate DNS resolution between Resolver and DNS resolvers on your network by configuring forwarding rules. Your network can include any network that is reachable from your VPC, such as the following:
  - The VPC itself
  - Another peered VPC
  - An on-premises network that is connected to AWS with AWS Direct Connect, a VPN, or a network address translation (NAT) gateway
- Before you start to forward queries, you create Resolver inbound and/or outbound endpoints in the connected VPC. These endpoints provide a path for inbound or outbound queries:
  - Inbound endpoint: DNS resolvers on your network can forward DNS queries to Route 53 Resolver via this endpoint
    - This allows your DNS resolvers to easily resolve domain names for AWS resources such as EC2 instances or records in a Route 53 private hosted zone.
  - Outbound endpoint: Resolver conditionally forwards queries to resolvers on your network via this endpoint
    - To forward selected queries, you create Resolver rules that specify the domain names for the DNS queries that you want to forward (such as example.com), and the IP addresses of the DNS resolvers on your network that you want to forward the queries to

[How do I configure a Route 53 Resolver inbound endpoint to resolve DNS records in my private hosted zone from my remote network?](https://aws.amazon.com/premiumsupport/knowledge-center/route53-resolve-with-inbound-endpoint)

## Blogs

[Simplify DNS management in a multi-account environment with Route 53 Resolver](https://aws.amazon.com/blogs/security/simplify-dns-management-in-a-multiaccount-environment-with-route-53-resolver)