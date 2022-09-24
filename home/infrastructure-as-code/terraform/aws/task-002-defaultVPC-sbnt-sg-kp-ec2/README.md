## OBJECTIVE : 
- To use the default VPC with attached internet gateway. 
- Use the default subnet.
- Create security group (for ssh) and keypair (for ssh)
- Start ubuntu instance and login into the instance.

#### Before executing you should have created AWS_ACCESS_KEY_ID AND AWS_SECRET_ACCESS_KEY with administrative privileges.

- Export the keys in your current shell by using following commands

```bash
export AWS_ACCESS_KEY_ID=YOUR_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=YOUR_SECRET_ACCESS_KEY
```

#### The following sequence of commands will be executed.
> terraform init

```bash
$ terraform init
```

> terraform plan
```bash
$ terraform plan
provider.aws.region
  The region where AWS operations will take place. Examples
  are us-east-1, us-west-2, etc.

  Enter a value: us-east-2
.
.
.
Plan: 5 to add, 0 to change, 0 to destroy.
 
 ------------------------------------------------------------------------
```

> terraform apply

```bash
$ terraform apply
.
.
.
Apply complete! Resources: 5 added, 0 changed, 0 destroyed.
```

- Login into the instance
```bash
$ ssh ubuntu@3.12.166.210
.
.
.
ubuntu@ip-172-31-7-16:~$ 
```