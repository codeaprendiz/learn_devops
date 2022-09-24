## OBJECTIVE : 
- To create an EC2 instance.
- Saving the private IP of provisioned instance in local file `private_ips.txt`
- 'Output' the public IP of the instance on the console



## The following commands will be executed.

- Initialization

```bash
$ terraform init -var-file=../../terraform.tfvars
```

- Planning

```bash
$ terraform plan -var-file=../../terraform.tfvars
...
Plan: 1 to add, 0 to change, 0 to destroy.
...
```

- Apply
```bash
$ terraform apply -var-file=../../terraform.tfvars
...
Enter a value: yes
...
aws_instance.web: Provisioning with 'local-exec'...
aws_instance.web (local-exec): Executing: ["/bin/sh" "-c" "echo 172.31.84.47 >> private_ips.txt"]
aws_instance.web: Creation complete after 32s [id=i-05cea08cdcea5a334]

...
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

ip = 54.242.130.22

$ cat private_ips.txt  
172.31.84.47
``` 



- Destroy
```bash
$ terraform destroy -var-file=../../terraform.tfvars
...
  Enter a value: yes
...
Destroy complete! Resources: 1 destroyed.
```