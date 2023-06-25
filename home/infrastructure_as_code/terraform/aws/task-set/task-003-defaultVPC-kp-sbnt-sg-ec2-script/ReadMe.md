## OBJECTIVE : 
- To use the default VPC with attached internet gateway. 
- Use the default subnet.
- Create security group (for ssh, for http default port 80) and keypair (for ssh)
- Start ubuntu instance and login into the instance.
- Copy custom script `script.sh` to the instance and execute it
- Install nginx via `script.sh` execution. Visit the public of instance and check if nginx is installed.


### Initialization

```bash
$ terraform init                                    
...
```

### Plan
```bash
$ terraform plan -var-file=../../terraform.tfvars
Refreshing Terraform state in-memory prior to plan..
...
Plan: 5 to add, 0 to change, 0 to destroy.
...
```

### Apply

```bash
$ terraform apply -var-file=../../terraform.tfvars
data.aws_ami.ubuntu: Refreshing state...
...
  Enter a value: yes
...
aws_security_group.sg_22: Creation complete after 9s [id=sg-09aa504274998a975]
aws_instance.web: Creating...
...
aws_instance.web: Still creating... [30s elapsed]
aws_instance.web: Provisioning with 'file'...
aws_instance.web: Still creating... [40s elapsed]
aws_instance.web: Provisioning with 'remote-exec'...
aws_instance.web (remote-exec): Connecting to remote host via SSH...
aws_instance.web (remote-exec):   Host: 3.82.139.227
aws_instance.web (remote-exec):   User: ubuntu
aws_instance.web (remote-exec):   Password: false
aws_instance.web (remote-exec):   Private key: true
aws_instance.web (remote-exec):   Certificate: false
aws_instance.web (remote-exec):   SSH Agent: true
aws_instance.web (remote-exec):   Checking Host Key: false
aws_instance.web (remote-exec): Connected!
aws_instance.web (remote-exec): 0% [Working]
...
aws_instance.web (remote-exec): 100% [Connecting to security.ubuntu.com]
...
aws_instance.web (remote-exec): The following extra packages will be installed:
aws_instance.web (remote-exec):   fontconfig-config fonts-dejavu-core libfontconfig1 libgd3 libjbig0
aws_instance.web (remote-exec):   libjpeg-turbo8 libjpeg8 libtiff5 libvpx1 libxpm4 libxslt1.1 nginx-common
aws_instance.web (remote-exec):   nginx-core
...
Apply complete! Resources: 5 added, 0 changed, 0 destroyed.
```

### Login into console and Verifying

- EC2 instance screen
![](.ReadMe_images/ec2_details_screen.png)


- Visiting the Public IP and check if nginx is running

![](.ReadMe_images/nginx_on_browser.png)


- Logging into the instance
```bash
$ ssh ubuntu@3.82.139.227  
...
ubuntu@ip-172-31-82-175:~$
ubuntu@ip-172-31-82-175:~$ ps -ef | grep nginx
root      2143     1  0 21:24 ?        00:00:00 nginx: master process /usr/sbin/nginx
www-data  2144  2143  0 21:24 ?        00:00:00 nginx: worker process
www-data  2145  2143  0 21:24 ?        00:00:00 nginx: worker process
www-data  2146  2143  0 21:24 ?        00:00:00 nginx: worker process
www-data  2147  2143  0 21:24 ?        00:00:00 nginx: worker process
```

### Destroying resources
```bash
$ terraform destroy -var-file=../../terraform.tfvars
...
Destroy complete! Resources: 5 destroyed.
```