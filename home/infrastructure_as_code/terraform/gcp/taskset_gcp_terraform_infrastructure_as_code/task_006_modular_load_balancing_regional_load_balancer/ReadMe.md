# Modular Load Balancing with Terraform - Regional Load Balancer

[https://www.cloudskillsboost.google](https://www.cloudskillsboost.google)

[Select - Quest -  Managing Cloud Infrastructure with Terraform](https://www.cloudskillsboost.google/paths)

[community/tutorials/modular-load-balancing-with-terraform](https://cloud.google.com/community/tutorials/modular-load-balancing-with-terraform)

**High Level Objectives**
- Use load balancing modules for Terraform
- Create a regional TCP load balancer (Network and Target Pool based)
- Access the minimal php app on external IP
- Go through the code


**Skills**
- VPC Networks
- Subnetwork
- Cloud Router
- Load Balancer
- Terraform
- Cloud Nat
- Managed Instance Group
- Instance Templates
- Firewall Rules
- Health Checks
- Forwarding Rules
- Target Pools

**Version Stack**

| Stack     | Version |
|-----------|---------|
| Terraform | 1.3.9   |

## Clone the examples repository

```bash
git clone https://github.com/GoogleCloudPlatform/terraform-google-lb
cd ~/terraform-google-lb/examples/basic
```


## TCP load balancer with regional forwarding rule

```bash
export GOOGLE_PROJECT=$(gcloud config get-value project)

terraform init

terraform plan

terraform apply


EXTERNAL_IP=$(terraform output | grep load_balancer_default_ip | cut -d = -f2 | xargs echo -n)


echo "http://${EXTERNAL_IP}"
```

## Screenshots
- Service Account
  - A service account in GCP is a special type of Google account that is used to authenticate applications, services, and virtual machines 
    (VMs) running on GCP. 
  - Service accounts are designed to be used by applications and services instead of human users.
  - When you create a service account, you can assign it specific roles and permissions that determine what resources it can access and what actions it can perform. Service accounts    can   be used to authorize API requests, access reso

![img.png](.images/service-account.png)

- VCP Networks

![img.png](.images/vpc-networks.png)

- Subnetworks

![img.png](.images/vpc-subnetworks.png)

- Cloud Router

![img.png](.images/cloud-router.png)

![img.png](.images/cloud-router-details.png)

- Cloud Nat

![img.png](.images/cloud-nat.png)

![img.png](.images/cloud-nat-details.png)




- Managed Instnace Group
  - In Google Cloud Platform (GCP), a Managed Instance Group (MIG) is a scalable, flexible, and highly available service 
    for managing groups of virtual machine (VM) instances. MIGs provide the ability to automatically manage and distribute traffic 
    to a group of homogeneous instances based on the policies and parameters that you define. 
  - A MIG can automatically add or remove instances from a group based on the requirements you set, 
    such as the load on each instance. This ensures that the group can automatically scale up or down to handle changes 
    in traffic or demand. You can use MIGs to distribute traffic across multiple zones, regions, or even continents, 
    helping to improve the performance and reliability of your applications.

![img.png](.images/mig.png)

![img.png](.images/mig-details.png)

![img.png](.images/vm-instances.png)

- Instance Templates
  - An instance template is a resource in Google Cloud Platform (GCP) that defines the configuration for creating instances in a Managed Instance Group (MIG). 
    It provides a convenient way to define the common properties of instances that belong to a group, such as machine type, disk images, network 
    settings, metadata, and startup scripts. 
  - By using instance templates, you can ensure that all instances in the MIG are created with the same configuration, 
    making it easier to manage and scale your infrastructure. You can also update the template to make changes to the group, and the changes 
    will be applied to all new instances that are created based on the updated template.

![img.png](.images/instance-template.png)

![img.png](.images/instance-template-details.png)


- Load Balancers

![img.png](.images/load-balancers.png)

![img.png](.images/basic-load-balancer-default.png)

![img.png](.images/app-with--basic-load-balancer-default.png)


- Firewall Rules
  - In Google Cloud Platform (GCP), firewall rules are used to control network traffic to and from virtual machine instances. 
  - They act as a barrier between your instances and the internet or other networks, allowing you to specify what kind of traffic is allowed or blocked.
![img.png](.images/firewall-rules.png)

![img.png](.images/basic-load-balancer-default-hc-firewall-rule.png)

- Health checks
  - Health checks in GCP are used to monitor the health and availability of instances or endpoints.
    A health check sends requests to an instance or endpoint and analyzes the response to determine whether the instance or endpoint is healthy or not.
  - In GCP, there are several types of health checks available, such as HTTP, HTTPS, TCP, and SSL health checks.
    These health checks can be used to monitor instances running on Compute Engine, instances running on Kubernetes Engine, or endpoints
    running on App Engine, Cloud Functions, or Cloud Run.
  - By using health checks, you can configure load balancers to automatically remove unhealthy instances from a load-balancing pool
    and redirect traffic to healthy instances. This helps to ensure that your applications are always available to users, even
    if some instances or endpoints fail.

![img.png](.images/health-checks.png)

![img.png](.images/basic-load-balancer-custom-hc-hc.png)



- Target Pools
  - In Google Cloud Platform (GCP), a target pool is a group of virtual machine (VM) instances or internet protocol (IP) addresses that receive incoming
    traffic from a Google Cloud load balancer. The target pool defines the set of virtual machines or IP addresses that should receive traffic, and the
    load balancer routes traffic to the instances in the pool based on the load balancing algorithm configured for the load balancer.
  - Target pools provide a way to distribute traffic across multiple instances of a service, which can help improve availability and scalability.
    By grouping instances or IP addresses into a target pool, GCP can direct traffic to available instances, and take instances out of rotation as needed,
    based on health checks or other configurable criteria.

![img.png](.images/target-pools.png)


- Forwarding rules
  - In GCP, a forwarding rule is a configuration that specifies how traffic should be directed to a load balancer. 
    It is a key component of GCP's load balancing service, which distributes incoming traffic to a group of backend instances.
  - A forwarding rule specifies the IP address, protocol, and ports that the load balancer should listen on. 
    It also defines the target pool, which is a group of backend instances that the load balancer will direct traffic to. 
  - There are different types of forwarding rules in GCP, including regional forwarding rules, global forwarding rules, 
    and target forwarding rules. Each type is used for different load balancing scenarios, and each has its own set of configuration options.

![img.png](.images/forwarding-rules.png)





