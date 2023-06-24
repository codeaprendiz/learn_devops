# Whitepapers

[Network-to-Amazon VPC connectivity options](https://docs.aws.amazon.com/whitepapers/latest/aws-vpc-connectivity-options/network-to-amazon-vpc-connectivity-options.html)

[AWS Direct Connect + VPN](https://docs.aws.amazon.com/whitepapers/latest/aws-vpc-connectivity-options/aws-direct-connect-vpn.html)

- With AWS Direct Connect + VPN, you can combine AWS Direct Connect dedicated network connections with the Amazon VPC VPN. AWS Direct Connect **public VIF** established a dedicated network connection between your network to public AWS resources, such as an Amazon virtual private gateway IPsec endpoint. The following figure illustrates this option.
- You must use a public virtual interface for your AWS Direct Connect (DX) connection and not a private one


- [Blue Green Deployments](https://d0.awsstatic.com/whitepapers/AWS_Blue_Green_Deployments.pdf)
- [Clone a Stack in AWS OpsWorks and Update DNS](https://docs.aws.amazon.com/whitepapers/latest/blue-green-deployments/clone-a-stack-in-aws-opsworks-and-update-dns.html)
  - AWS OpsWorks utilizes the concept of stacks, which are logical groupings of AWS resources (EC2 instances, Amazon RDS, Elastic Load Balancing, and so on) that have a common purpose and should be logically managed together
- [Building a Scalable and Secure Multi-VPC AWS Network Infrastructure](https://d1.awsstatic.com/whitepapers/building-a-scalable-and-secure-multi-vpc-aws-network-infrastructure.pdf)

- [Centralized egress to internet](https://docs.aws.amazon.com/whitepapers/latest/building-scalable-secure-multi-vpc-network-infrastructure/centralized-egress-to-internet.html)

  - Deploying a NAT Gateway in every spoke VPC can become expensive because you pay an hourly charge for every NAT Gateway you deploy (see Amazon VPC pricing), so centralizing it could be a viable option. 
  - To centralize, we create an egress VPC in the network services account and route all egress traffic from the spoke VPCs via a NAT Gateway sitting in this VPC leveraging Transit Gateway

- [Transit Gateway](https://docs.aws.amazon.com/whitepapers/latest/building-scalable-secure-multi-vpc-network-infrastructure/transit-gateway.html)
  - AWS Transit Gateway provides a hub and spoke design for connecting VPCs and on-premises networks as a fully managed service without requiring you to provision virtual appliances like the Cisco CSRs.

- [AWS Transit Gateway](https://docs.aws.amazon.com/whitepapers/latest/aws-vpc-connectivity-options/aws-transit-gateway.html)

  - AWS Transit Gateway is a highly available and scalable service to consolidate the AWS VPC routing configuration for a region with a hub-and- spoke architecture. 
  - Each spoke VPC only needs to connect to the Transit Gateway to gain access to other connected VPCs. 
  - Transit Gateway across different regions can peer with each other to enable VPC communications across regions. 
  - With large number of VPCs, Transit Gateway provides simpler VPC-to-VPC communication management over VPC Peering

- [Security Groups and Network Access Control Lists (Network ACLs) (BP5)](https://docs.aws.amazon.com/whitepapers/latest/aws-best-practices-ddos-resiliency/security-groups-and-network-access-control-lists-nacls-bp5.html)
- [Using AWS for Disaster Recovery](https://aws.amazon.com/blogs/aws/new-whitepaper-use-aws-for-disaster-recovery)
- [Overview of Deployment Options on AWS](https://docs.aws.amazon.com/whitepapers/latest/overview-deployment-options/aws-deployment-services.html)
- [AWS Best Practices for DDoS Resiliency](https://docs.aws.amazon.com/whitepapers/latest/aws-best-practices-ddos-resiliency/welcome.html)

