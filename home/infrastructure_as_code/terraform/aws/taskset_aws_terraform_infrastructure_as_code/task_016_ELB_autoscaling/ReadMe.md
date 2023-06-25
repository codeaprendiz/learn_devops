## Objective

- To create a load balancer  
    - with Port Configuration - 80 (HTTP) forwarding to 80 (HTTP)
    - Should be available in 2 availability zones (us-east-1a and us-east-1b)
    - it can receive HTTP traffic over TCP protocol on port 80 from any source 0.0.0.0/0
    - Ping Target : HTTP:80/
    
 - To create an autoscaling group with
    - Min : 2
    - Max : 2
    - Desired Capacity : 2
    - health_check_grace_period : 300
    - health_check_type         : "ELB"
    - attach a launch configuration to it which spins up an EC2 t2.micro instance and runs nginx on port 80.
    Run a script to show the IP of the instance when hit on port 80.
    - It should only respond to traffic which it receives on port 80 from the load balancer.
    
    
### Let's Begin


- init
```bash
$ terraform init
```

- plan
```bash
$ terraform plan
Plan: 18 to add, 0 to change, 0 to destroy.
```

- apply
```bash
terraform apply
Apply complete! Resources: 18 added, 0 changed, 0 destroyed.

Outputs:

ELB = my-elb-2112550202.us-east-1.elb.amazonaws.com
```


- Now you can check the ELB external address by using the following command
```bash
$ host my-elb-2112550202.us-east-1.elb.amazonaws.com
my-elb-2112550202.us-east-1.elb.amazonaws.com has address 3.210.52.31
```

- To check if the load balancing is happening, use the following
```bash
$ curl my-elb-2112550202.us-east-1.elb.amazonaws.com
this is: 10.0.1.228


$ curl my-elb-2112550202.us-east-1.elb.amazonaws.com
this is: 10.0.1.228
```


- Destroy
```bash
$ terraform destroy
Destroy complete! Resources: 18 destroyed.
```

