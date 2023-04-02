# Building a VPN Between Google Cloud and AWS with Terraform

[https://www.cloudskillsboost.google](https://www.cloudskillsboost.google)

[Select - Quest -  Managing Cloud Infrastructure with Terraform](https://www.cloudskillsboost.google/paths)

**High Level Objectives**
- Build custom VPC networks with user-specified CIDR blocks in Google Cloud and AWS
- Deploy a VM instance in each VPC network
- Create VPN gateways in each VPC network and related resources for two IPsec tunnels



**Skills**
- terraform
- vpc
- vpn gateways
- aws
- gcp



**Version Stack**

| Stack     | Version |
|-----------|---------|
| Terraform | v1.4.1  |





## Deployment architecture



## Intro

While Google Cloud uses routes to support equal-cost multi-path (ECMP) routing, 
AWS supports VPN gateways with two tunnels, active and standby, for redundancy and availability.

The lab configuration uses Cloud Router to demonstrate dynamic routing. 
Cloud Router exchanges your VPC network route updates with your environment in AWS using 
Border Gateway Protocol (BGP). Dynamic routing by Cloud Router requires a separate Cloud 
Router for each IPsec tunnel.



## Preparing your Google Cloud working environment

- Clone the tutorial code

```bash
gsutil cp gs://spls/gsp854/autonetdeploy-multicloudvpn2.tar .
tar -xvf autonetdeploy-multicloudvpn2.tar

cd autonetdeploy-multicloudvpn
```

- Verify the Google Cloud region and zone

## Preparing for AWS use







- aws compute
![img.png](.images/aws-compute.png)

- aws vpc

![img.png](.images/aws-vpc.png)

- aws subnets

![img.png](.images/aws-subnets.png)

- aws internet gateway

![img.png](.images/aws-intenet-gatway.png)

- aws vpn connections

![img.png](.images/aws-vpn-connections.png)

- aws customer gateways

![img.png](.images/aws-customer-gatways.png)

- aws virtual private gateways

![img.png](.images/aws-virtual-private-gateway-gatway.png)






- gcp compute

![img.png](.images/gcp-compute.png)

- gcp network

![img.png](.images/gcp-network.png)

- gcp peer vpn gateways

![img.png](.images/gcp-peer-vpn-gatway.png)

- gcp cloud vpn gateway

![img.png](.images/gcp-cloud-vpn-gatways.png)

- gcp cloud vpn tunnels

![img.png](.images/gcp-cloud-vpn-tunnels.png)


- gcp cloud router

![img.png](.images/gcp-cloud-router.png)


- gcp cloud router details

![img.png](.images/gcp-cloud-router-details.png)


- gcp cloud firewall

![img.png](.images/gcp-cloud-firewall.png)

- gcp cloud routes

![img.png](.images/gcp-cloud-routes.png)

- gcp cloud IP addresses

![img.png](.images/gcp-cloud-ip-addresses.png)