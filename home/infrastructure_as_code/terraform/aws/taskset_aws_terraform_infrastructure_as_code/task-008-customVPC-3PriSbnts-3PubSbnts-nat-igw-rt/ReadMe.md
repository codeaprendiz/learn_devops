## Objective 

1) To create a custom VPC with CIDR block 10.0.0.0/16
2) To create 3 public subnets (main-public-1, main-public-2, main-public-3). Accordingly choose their CIDR blocks.
3) To create 3 private subnets (main-private-1, main-private-2, main-private-3). Accordingly choose their CIDR blocks.
4) To create an internet gateway resource
5) To create a main-public route table to have a route to internet (0.0.0.0/0) via the internet gateway and associate this route table to all the 3 public subnets.
6) To create an elastic IP, NAT gateway and associate that elastic IP with NAT gateway
7) To create a private route table to have a route to internet (0.0.0.0/0) via the NAT gateway. Associate this private route table to all the 3 private subnets.


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
Plan: 18 to add, 0 to change, 0 to destroy.
```


- apply
```bash
$ terraform apply -var-file=../../terraform.tfvars
.
.
.
Apply complete! Resources: 18 added, 0 changed, 0 destroyed.
```

- destroy
```bash
$ terraform destroy -var-file=../../terraform.tfvars

Destroy complete! Resources: 18 destroyed.
```