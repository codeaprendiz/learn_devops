# To create a k8s cluster in OCI using Quick Create feature and understand the network topology required

We can later use this to create our own cluster using terraform

<br>

## K8S created

![](.images/k8s.png)

<br>

## The VCN Created

![img.png](.images/vcn.png)

oke-vcn-quick-sandbox-k8s-a4bf5e044

- IPV4 CIDR `10.0.0.0/16`
- Default route table `oke-public-routetable-sandbox-k8s-a4bf5e044`



<br>

## Subnets

![](.images/subnets.png)


oke-nodesubnet-quick-sandbox-k8s-a4bf5e044-regional
- CIDR `10.0.10.0/24`
- Private

<br>

### Security List

oke-nodeseclist-quick-sandbox-k8s-a4bf5e044

<br>

#### Ingress

![](.images/ingress-subnet-pri.png)

- 10.0.10.0/24	--------------All Protocols----->
> All traffic for all ports	
> Allow pods on one worker node to communicate with pods on other worker nodes. Anything from within the subnet can communicate with one another
- 10.0.0.0/28	--------------ICMP ------------->
> Path discovery. Anything from API endpoint subnet can communicate over ICMP 
- 10.0.0.0/28  All Ports --------------All Protocols-----------> All Ports
> TCP traffic for ports: All
> TCP access from Kubernetes Control Plane. Anything coming from API endpoint subnet can communicate over TCP, all source ports to all destination ports
- 0.0.0.0/0 All Ports ---------------TCP-----------------------> 22 
> TCP traffic for ports: 22 SSH Remote Login Protocol. Inbound SSH traffic to worker nodes. Anything coming from Internet can communicate over TCP 22 for SSH access

<br>

#### Egress

![](.images/egress-subnet-pri.png)

- All ports--------ALL protocols---------> 10.0.10.0/24	(All ports).      
> Anything from within the subnet can communicate with one another. Allow pods on one worker node to communicate with pods on other worker nodes
- ALL Ports--------TCP -------> 10.0.0.0/28	- Port 6443 (API subnet)
> All ports can communicate to port 6443 of API subnet. Access to Kubernetes API Endpoint.
- ALL Ports--------TCP -------> 10.0.0.0/28	- Port 12250 (API subnet)
> All ports can communicate to port 12250 of API subnet. Kubernetes worker to control plane communication
- -----------------ICMP--------> 10.0.0.0/28
> Path Discovery
- All ports ----------------TCP-------------> All BOM Services In Oracle Services Network, 443 port
> Allow nodes to communicate with OKE to ensure correct start-up and continued functioning
-           ----------------ICMP------------> 0.0.0.0/0
> ICMP Access from Kubernetes Control Plane
- All ports  ----------------All protocols---------------> 0.0.0.0/0, All ports
> Worker Nodes access to Internet

<br>

### RouteTable

oke-private-routetable-sandbox-k8s-a4bf5e044

- If -------------> 0.0.0.0/0,  go to NAT Gateway
> traffic to the internet

- If -------------> All BOM Services In Oracle Services Network, go to Service Gateway
> traffic to OCI services




oke-k8sApiEndpoint-subnet-quick-sandbox-k8s-a4bf5e044-regional
- CIDR `10.0.0.0/28`
- Public

<br>

### Security List

oke-k8sApiEndpoint-quick-sandbox-k8s-a4bf5e044

<br>

#### Ingress

![img.png](.images/ingress-api-subnet.png)

- 0.0.0.0/0 All Ports ---------------TCP-----------------> 6443
> TCP traffic for ports: 6443
> External access to Kubernetes API endpoint

- 10.0.10.0/24 All Ports ------------TCP-----------------> 6443
> TCP traffic for ports: 6443
> Kubernetes worker to Kubernetes API endpoint communication

- 10.0.10.0/24 All Ports -----------TCP--------------------> 12250
> TCP traffic for ports: 12250 
> Kubernetes worker to control plane communication

- 10.0.10.0/24           -----------ICMP-------------------> 
> Path Discovery

<br>

#### Egress

![img.png](.images/egress-api-subnet.png)

- All Ports  ------------------------TCP----------------------->             All BOM Services In Oracle Services Network, 443
> TCP traffic for ports: 443 HTTPS
> Allow Kubernetes Control Plane to communicate with OKE

- All Ports ------------------------TCP----------------------->  10.0.10.0/24, All Ports
> TCP traffic for ports: All
> All traffic to worker nodes

-           ------------------------ICMP----------------------> 10.0.10.0/24	
> Path discovery


<br>

### Route Table


oke-public-routetable-sandbox-k8s-a4bf5e044

- If ------------> 0.0.0.0/0, then go to    Internet Gateway 
> traffic to/from internet


oke-svclbsubnet-quick-sandbox-k8s-a4bf5e044-regional
- CIDR `10.0.20.0/24`
- Public

<br>

### Security List

oke-svclbseclist-quick-sandbox-k8s-a4bf5e044

<br>

#### Ingress

![img.png](.images/ingress-lb-sec.png)

<br>

#### Egress

![img.png](.images/eggress-lb-sec.png)


<br>

### Route Table


oke-public-routetable-sandbox-k8s-a4bf5e044




