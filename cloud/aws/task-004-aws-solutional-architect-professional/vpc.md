# VPC


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

### Compare NAT gateways and NAT instances

[Compare NAT gateways and NAT instances](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-comparison.html)



