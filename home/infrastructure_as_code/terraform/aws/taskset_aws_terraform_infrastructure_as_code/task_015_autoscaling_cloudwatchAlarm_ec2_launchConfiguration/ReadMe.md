## Objective

1) To make an autoscaling group with 
```hcl-terraform
  min_size                  = 1     // min instance required
  max_size                  = 2     // max instance required
```
2) To have an autoscaling policy `example-cpu-policy` of type `Simple scaling`. 

3) Choose an Amazon CloudWatch alarm `example-cpu-alarm` to associate with this policy. The alarm will 
automatically execute the policy when its threshold is breached

4) `example-cpu-alarm` breaches the alarm threshold: CPUUtilization >= 30 for 2 consecutive periods of 120 seconds
   for the metric dimensions AutoScalingGroupName = example-autoscaling
   - Take the action: Add 1 capacity units	
   - And then wait: 300 seconds before allowing another scaling activity

5) Similarly have a scale down policy `example-cpu-policy-scaledown` of type `Simple scaling`.

6) `example-cpu-alarm-scaledown` breaches the alarm threshold: CPUUtilization <= 5 for 2 consecutive periods of 120 seconds
   for the metric dimensions AutoScalingGroupName = example-autoscaling
   - Take the action: Remove 1 capacity units	
   - And then wait: 300 seconds before allowing another scaling activity
   
7) You can test all these scenarios by installing `stress` on the first instance.








### Let's Start

- init
```bash
terraform init
```


- plan
```bash
terraform plan
Plan: 22 to add, 0 to change, 0 to destroy.
```


- apply
```bash
$ terraform apply
Apply complete! Resources: 22 added, 0 changed, 0 destroyed.
```

- Get the public IP from the console and login to the instance. Note that there will be only one instance for now.

```bash
$ ssh ubuntu@34.207.94.36           

ubuntu@ip-10-0-1-196:~$ 
```

- Now install `stress` on this instance.
```bash
ubuntu@ip-10-0-1-196:~$ sudo su
root@ip-10-0-1-196:/home/ubuntu# apt update
root@ip-10-0-1-196:/home/ubuntu# apt-get install stress
```

- Now let's timeout this instance and check if our auto scaling policy works good enough.

```bash
root@ip-10-0-1-196:/home/ubuntu# stress --cpu 2 --timeout 300
stress: info: [11505] dispatching hogs: 2 cpu, 0 io, 0 vm, 0 hdd
stress: info: [11505] successful run completed in 300s
root@ip-10-0-1-196:/home/ubuntu# 
```

- Now wait for 5 minutes and see if the new instance spins up. The `example-cpu-alarm` alarm will
go in state `In alarm` and a new instance would spin up according to our autoscaling policy.

- Now wait for 5 more minutes and see that the `example-cpu-alarm-scaledown` alarm would go in 
`In alarm` state and one of the instances would be brought down by our scale-down policy.


- Once you have witnessed this holy with your own eyes! You can destroy the resources.


```bash
terraform destroy
Destroy complete! Resources: 22 destroyed.

```