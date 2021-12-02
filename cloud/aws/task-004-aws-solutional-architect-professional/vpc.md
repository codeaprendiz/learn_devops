# VPC

[Cheat Sheet - AWS VPC](https://tutorialsdojo.com/amazon-vpc)
[Cheat Sheet - VPC Peering](https://tutorialsdojo.com/vpc-peering)


## Network ACLs

[Network ACLs](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html)

- A network access control list (ACL) is an optional layer of security for your VPC that acts as a firewall for controlling traffic in and out of one or more subnets. 
- You might set up network ACLs with rules similar to your security groups in order to add an additional layer of security to your VPC.

## VPC Networking Components

## NAT gateways

[NAT gateways](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-gateway.html)

- A NAT gateway is a Network Address Translation (NAT) service. 
- You can use a NAT gateway so that instances in a private subnet can connect to services outside your VPC but external services cannot initiate a connection with those instances.

- When you create a NAT gateway, you specify one of the following connectivity types:
  - Public – (Default) Instances in private subnets can connect to the internet through a public NAT gateway, but cannot receive unsolicited inbound connections from the internet.
  - Private – Instances in private subnets can connect to other VPCs or your on-premises network through a private NAT gateway. 
    - You can route traffic from the NAT gateway through a transit gateway or a virtual private gateway. 
    - You cannot associate an elastic IP address with a private NAT gateway.
    

### NAT instances

[NAT instances](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_NAT_Instance.html)

- You can create your own AMI that provides network address translation and use your AMI to launch an EC2 instance as a NAT instance. 
- You launch a NAT instance in a public subnet to enable instances in the private subnet to initiate outbound IPv4 traffic to the internet or other AWS services, but prevent the instances from receiving inbound traffic initiated on the internet.

### NAT devices for your VPC

[NAT devices for your VPC](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat.html)



### Compare NAT gateways and NAT instances

[Compare NAT gateways and NAT instances](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-comparison.html)



## VPC peering

[VPC peering](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-peering.html)

- A VPC peering connection is a networking connection between two VPCs that enables you to route traffic between them privately. 
- Instances in either VPC can communicate with each other as if they are within the same network. 
- You can create a VPC peering connection between your own VPCs, with a VPC in another AWS account, or with a VPC in a different AWS Region.


## VPC Flow Logs

[VPC Flow Logs](https://docs.aws.amazon.com/vpc/latest/userguide/flow-logs.html)

- VPC Flow Logs is a feature that enables you to capture information about the IP traffic going to and from network interfaces in your VPC.
- Flow log data can be published to Amazon CloudWatch Logs or Amazon S3.
- After you create a flow log, you can retrieve and view its data in the chosen destination.

- Flow logs can help you with a number of tasks, such as:
  - Diagnosing overly restrictive security group rules
  - Monitoring the traffic that is reaching your instance
  - Determining the direction of the traffic to and from the network interfaces

## VPC Endpoints

### Interface VPC endpoints (AWS PrivateLink)

[Interface VPC endpoints (AWS PrivateLink)](https://docs.aws.amazon.com/vpc/latest/privatelink/vpce-interface.html)

- An interface VPC endpoint (interface endpoint) allows you to connect to services powered by AWS PrivateLink
- These services include some AWS services, services hosted by other AWS customers and Partners in their own VPCs (referred to as endpoint services), and supported AWS Marketplace Partner services. 
- The owner of the service is the service provider, and you, as the principal creating the interface endpoint, are the service consumer.

[How do I configure security and network ACLs for my interface-based Amazon VPC endpoint for endpoint services?](https://aws.amazon.com/premiumsupport/knowledge-center/security-network-acl-vpc-endpoint)

> When you create an Amazon VPC endpoint interface with AWS PrivateLink, an Elastic Network Interface is created inside of the subnet that you specify. This interface VPC endpoint (interface endpoint) inherits the network ACL of the associated subnet. You must associate a security group with the interface endpoint to protect incoming and outgoing requests.

## DNS support for your VPC

[DNS attributes in your VPC](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-dns.html#vpc-dns-support)

DNS attributes in your VPC

- enableDnsHostnames	
- enableDnsSupport

>  IF both attributes are enabled, an instance launched into the VPC receives a public DNS hostname IF it is assigned a public IPv4 address or an Elastic IP address at creation.

## DHCP options sets for your VPC

[DHCP options sets for your VPC](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_DHCP_Options.html)

- The Dynamic Host Configuration Protocol (DHCP) provides a standard for passing configuration information to hosts on a TCP/IP network. 
- The options field of a DHCP message contains configuration parameters, including the domain name, domain name server, and the netbios-node-type.
- When you create a VPC, we automatically create a set of DHCP options and associate them with the VPC. You can configure your own DHCP options set for your VPC.


### Work with shared VPCs

[Blog - VPC sharing: A new approach to multiple accounts and VPC management](https://aws.amazon.com/blogs/networking-and-content-delivery/vpc-sharing-a-new-approach-to-multiple-accounts-and-vpc-management)

[Work with shared VPCs](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-sharing.html)

- VPC sharing allows multiple AWS accounts to create their application resources, such as Amazon EC2 instances, Amazon Relational Database Service (RDS) databases, Amazon Redshift clusters, and AWS Lambda functions, into shared, centrally-managed virtual private clouds (VPCs)
- In this model, the account that owns the VPC (owner) shares one or more subnets with other accounts (participants) that belong to the same organization from AWS Organizations
- After a subnet is shared, the participants can view, create, modify, and delete their application resources in the subnets shared with them. 
- Participants cannot view, modify, or delete resources that belong to other participants or the VPC owner.

## Blogs

[How to set up an outbound VPC proxy with domain whitelisting and content filtering](https://aws.amazon.com/blogs/security/how-to-set-up-an-outbound-vpc-proxy-with-domain-whitelisting-and-content-filtering)