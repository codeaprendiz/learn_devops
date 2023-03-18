# Getting started with VPC Networking and Google Compute Engine

[https://www.cloudskillsboost.google](https://www.cloudskillsboost.google)

[Select - DevOps Engineer, SRE Learning Path](https://www.cloudskillsboost.google/paths)


## Explore the default network


- View the subnets
- View the routes
  - Notice that there is a route for each subnet and one for the Default internet gateway (0.0.0.0/0)
- View the Firewall rules
  - there are 4 Ingress firewall rules for the default network:
     - default-allow-icmp
     - default-allow-rdp
     - default-allow-ssh
     - default-allow-internal
     - Note: These firewall rules allow ICMP, RDP, and SSH ingress traffic from anywhere (0.0.0.0/0) and all TCP, UDP, and ICMP traffic within the network (10.128.0.0/9). The Targets, Filters, Protocols/ports, and Action columns explain these rules.

## Delete the Firewall Rules and Default Network (only for testing, don't do it in production :) )

- Delete the Firewall rules
- Delete the default network
- Try to create a VM instance
  - Notice the error


## Create a VPC network and VM instances

- Create a VPC using automode `mynetwork`
- Create a VM instance in us-central1

| Property | Value         |
|----------|---------------|
| Name     | mynet-us-vm   |
| Region   | us-central1   |
| Zone     | us-central1-c |

- The Internal IP should be 10.128.0.2 because 10.128.0.1 is reserved for the gateway and you have not configured any other instances in that subnet.

- Create a VM instance in europe-central2

| Property | Value             |
|----------|-------------------|
| Name     | mynet-eu-vm       |
| Region   | europe-central2   |
| Zone     | europe-central2-a |

- The Internal IP should be 10.186.0.2 because 10.186.0.1 is reserved for the gateway and you have not configured any other instances in that subnet.

## Explore the connectivity for VM instances

- For mynet-us-vm, click SSH to launch a terminal and connect.

```bash
ping -c 3 <Enter mynet-eu-vm's internal IP here>
ping -c 3 <Enter mynet-eu-vm's external IP here>
```

- Remove the allow-icmp firewall rules

```bash
ping -c 3 <Enter mynet-eu-vm's internal IP here>
# The 100% packet loss indicates that you cannot ping mynet-eu-vm's external IP. This is expected because you deleted the allow-icmp firewall rule!
ping -c 3 <Enter mynet-eu-vm's external IP here>
```

- Remove the allow-custom firewall rules

```bash
# Note: The 100% packet loss indicates that you cannot ping mynet-eu-vm's internal IP. This is expected because you deleted the allow-custom firewall rule!
ping -c 3 <Enter mynet-eu-vm's internal IP here>
```

- Remove the allow-ssh firewall rules
  - Note: The Connection failed message indicates that you cannot SSH to mynet-us-vm because you deleted the allow-ssh firewall rule!
