## Objective
- Default VPC and Default Availability Zones (a, b, c) created
- Using a [module](https://www.terraform.io/docs/configuration/modules.html) in terraform. 
The module will take some inputs and achieve some functionality. 

## Steps

- Generate the keys (the ones commited are for sample only)
```bash
$ ssh-keygen -f mykey
```

- Run the following to download the module to your local
```bash
$ terraform get        
Downloading github.com/wardviaene/terraform-consul-module.git?ref=terraform-0.12 for consul...
- consul in .terraform/modules/consul
```


- Module that will get downloaded after this would be
```bash
$ cd .terraform
$ tree                 
.
└── modules
    ├── consul
    │   ├── README.md
    │   ├── consul.tf
    │   ├── outputs.tf
    │   ├── shared
    │   │   └── scripts
    │   │       ├── debian_consul.service
    │   │       ├── debian_upstart.conf
    │   │       ├── install.sh
    │   │       ├── ip_tables.sh
    │   │       ├── rhel_consul.service
    │   │       ├── rhel_upstart.conf
    │   │       └── service.sh
    │   └── variables.tf
    └── modules.json

```


- Plan
```bash
terraform plan -var-file=../../terraform.tfvars
```

- Apply
```bash
terraform apply -var-file=../../terraform.tfvars
```

- You can login into the instance using mykey
```bash
$ ssh -i mykey ubuntu@54.87.20.78                                                        
.
.
.
ubuntu@ip-172-31-39-91:~$ 
```


- Destroy
```bash
terraform destroy -var-file=../../terraform.tfvars
```