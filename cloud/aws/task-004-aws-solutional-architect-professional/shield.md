# Shield

[AWS Shield](https://docs.aws.amazon.com/waf/latest/developerguide/shield-chapter.html)

[Cheat Sheet - AWS Shield](https://tutorialsdojo.com/aws-shield)

- AWS Shield is a managed Distributed Denial of Service (DDoS) protection service that safeguards applications running on AWS.
- AWS Shield provides always-on detection and automatic inline mitigations that minimize application downtime and latency
- There are two tiers of AWS Shield - Standard and Advanced.

- All AWS customers benefit from the automatic protections of AWS Shield Standard, at no additional charge
- AWS Shield Standard defends against most common, frequently occurring network and transport layer DDoS attacks that target your web site or applications. 
- When you use AWS Shield Standard with Amazon CloudFront and Amazon Route 53, you receive comprehensive availability protection against all known infrastructure (Layer 3 and 4) attacks.
- For higher levels of protection against attacks targeting your applications running on Amazon Elastic Compute Cloud (EC2), Elastic Load Balancing (ELB), Amazon CloudFront, AWS Global Accelerator and Amazon Route 53 resources, you can subscribe to AWS Shield Advanced. 

[AWS Shield - Managed DDoS protection](https://aws.amazon.com/shield/?whats-new-cards.sort-by=item.additionalFields.postDateTime&whats-new-cards.sort-order=desc)

- AWS provides AWS Shield Standard and AWS Shield Advanced for protection against DDoS attacks. 
- AWS Shield Standard is automatically included at no extra cost beyond what you already pay for AWS WAF and your other AWS services.
- You can add Shield Advanced protection for any of the following resource types:
  - Amazon CloudFront distributions
  - Amazon Route 53 hosted zones
  - AWS Global Accelerator accelerators
  - Application Load Balancers
  - Elastic Load Balancing (ELB) load balancers
  - Amazon Elastic Compute Cloud (Amazon EC2) Elastic IP addresses


> There are two types of AWS Shield: the Standard one which is free and the Advanced type which has an additional cost of around $3,000 per month.

