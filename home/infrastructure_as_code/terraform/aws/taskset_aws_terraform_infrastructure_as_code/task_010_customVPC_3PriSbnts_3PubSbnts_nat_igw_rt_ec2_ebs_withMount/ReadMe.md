## Objective 

1) To create a custom VPC with CIDR block 10.0.0.0/16
2) To create 3 public subnets (main-public-1, main-public-2, main-public-3). Accordingly choose their CIDR blocks.
3) To create 3 private subnets (main-private-1, main-private-2, main-private-3). Accordingly choose their CIDR blocks.
4) To create an internet gateway resource
5) To create a main-public route table to have a route to internet (0.0.0.0/0) via the internet gateway and associate this route table to all the 3 public subnets.
6) To create an elastic IP, NAT gateway and associate that elastic IP with NAT gateway
7) To create a private route table to have a route to internet (0.0.0.0/0) via the NAT gateway. Associate this private route table to all the 3 private subnets.
8) To launch an EC2 instance in the main-public-1 subnet. To login into this instance, check its private IP and routes.
9) Attach an aws_ebs_volume to this instance. 
10) If there is no data on the ebs_volume you just mount it as an empty one. If there is data ont the ebs volume, you just mount it without formatting.


## Lets Begin



- init
```bash
terraform init
```

- plan
```bash
$ terraform plan -var-file=../../terraform.tfvars
.
.
.
Plan: 23 to add, 0 to change, 0 to destroy.
```


- apply
```bash
$ terraform apply -var-file=../../terraform.tfvars
.
.
.
Apply complete! Resources: 23 added, 0 changed, 0 destroyed.
```


- login into the instance so created. Note the private IP after login.
```bash
$ ssh -i ~/.ssh/id_rsa ubuntu@54.224.116.49                                               
.
.
.
ubuntu@ip-10-0-1-123:~$ 
```

- private IP of logged in instance
```bash
ubuntu@ip-10-0-1-123:~$ ifconfig | egrep inet
          inet addr:10.0.1.123  Bcast:10.0.1.255  Mask:255.255.255.0
          inet6 addr: fe80::107c:cfff:feec:aae7/64 Scope:Link
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
```

- routes inside the logged in instance
```bash
$ route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         10.0.1.1        0.0.0.0         UG    0      0        0 eth0
10.0.1.0        0.0.0.0         255.255.255.0   U     0      0        0 eth0
```

- check the volumes inside the logged in instance
```bash
ubuntu@ip-10-0-1-123:~$ df -h
Filesystem                Size  Used Avail Use% Mounted on
udev                      491M     0  491M   0% /dev
tmpfs                     100M  4.3M   95M   5% /run
/dev/xvda1                7.8G  1.5G  6.0G  20% /
tmpfs                     496M     0  496M   0% /dev/shm
tmpfs                     5.0M     0  5.0M   0% /run/lock
tmpfs                     496M     0  496M   0% /sys/fs/cgroup
/dev/mapper/data-volume1  9.8G   23M  9.2G   1% /data
tmpfs                     100M     0  100M   0% /run/user/1000
```



- Check the entry in `/etc/fstab`
```bash
ubuntu@ip-10-0-1-123:~$ cat /etc/fstab
LABEL=cloudimg-rootfs   /        ext4   defaults,discard        0 0
/dev/data/volume1 /data ext4 defaults 0 0
```

- destroy
```bash
$ terraform destroy -var-file=../../terraform.tfvars

Destroy complete! Resources: 23 destroyed.
```