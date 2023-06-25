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
Plan: 21 to add, 0 to change, 0 to destroy.
```


- apply
```bash
$ terraform apply -var-file=../../terraform.tfvars
.
.
.
Apply complete! Resources: 21 added, 0 changed, 0 destroyed.
```


- login into the instance so created. Note the private IP after login.
```bash
$ ssh -i ~/.ssh/id_rsa ubuntu@3.94.171.138                                                
.
.
.
ubuntu@ip-10-0-1-132:~$
```

- private IP of logged in instance
```bash
ubuntu@ip-10-0-1-132:~$ ifconfig | egrep inet
          inet addr:10.0.1.132  Bcast:10.0.1.255  Mask:255.255.255.0
```

- routes inside the logged in instance
```bash
ubuntu@ip-10-0-1-132:~$ route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         10.0.1.1        0.0.0.0         UG    0      0        0 eth0
10.0.1.0        0.0.0.0         255.255.255.0   U     0      0        0 eth0
```

- check the volumes inside the logged in instance
```bash
ubuntu@ip-10-0-1-157:~$ df -h
Filesystem      Size  Used Avail Use% Mounted on
udev            491M     0  491M   0% /dev
tmpfs           100M  3.1M   97M   4% /run
/dev/xvda1      7.8G  885M  6.5G  12% /
tmpfs           496M     0  496M   0% /dev/shm
tmpfs           5.0M     0  5.0M   0% /run/lock
tmpfs           496M     0  496M   0% /sys/fs/cgroup
tmpfs           100M     0  100M   0% /run/user/1000
```

- creating an ext4 file system on /dev/xvdh
```bash
ubuntu@ip-10-0-1-157:~$ sudo su

root@ip-10-0-1-157:/home/ubuntu# mkfs.ext4 /dev/xvdh
mke2fs 1.42.13 (17-May-2015)
Creating filesystem with 2621440 4k blocks and 655360 inodes
Filesystem UUID: 94cb34d3-469a-4fc0-9237-a39736ff14e9
Superblock backups stored on blocks: 
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (32768 blocks): done
Writing superblocks and filesystem accounting information: done 

root@ip-10-0-1-157:/home/ubuntu# 
```

- mounting the filesystem we created to /data
```bash
root@ip-10-0-1-157:/home/ubuntu# mkdir -p /data
root@ip-10-0-1-157:/home/ubuntu# mount /dev/xvdh /data
```

- check the file system you added using `df -h` command
```bash
Filesystem      Size  Used Avail Use% Mounted on
udev            491M     0  491M   0% /dev
tmpfs           100M  3.1M   97M   4% /run
/dev/xvda1      7.8G  884M  6.5G  12% /
tmpfs           496M     0  496M   0% /dev/shm
tmpfs           5.0M     0  5.0M   0% /run/lock
tmpfs           496M     0  496M   0% /sys/fs/cgroup
tmpfs           100K     0  100K   0% /run/lxcfs/controllers
tmpfs           100M     0  100M   0% /run/user/1000
/dev/xvdh       9.8G   23M  9.2G   1% /data
```


- This volume will go away when the machine is rebooted. So let's add it in `/etc/fstab`
```bash
root@ip-10-0-1-157:/home/ubuntu# cat /etc/fstab 
LABEL=cloudimg-rootfs   /        ext4   defaults,discard        0 0
/dev/xvdh /data ext4 defaults 0 0
```

- destroy
```bash
$ terraform destroy -var-file=../../terraform.tfvars

Destroy complete! Resources: 21 destroyed.
```