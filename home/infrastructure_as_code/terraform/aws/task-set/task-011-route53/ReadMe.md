## Objective 



1) To create a hosted zone and get the list of name servers




- Init

```bash
$ terraform init   
```

- Plan

```                                 
$ terraform plan 

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
.
.
.
```


- Apply
```bash
$ terraform apply 
.
.
.
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

devopslink-name-servers = [
  "ns-****.awsdns-11.org",
  "ns-****.awsdns-55.co.uk",
  "ns-*****.awsdns-42.com",
  "ns-*****.awsdns-07.net",
]
devopslink-public-zone-id = Z030********************ZYUV

```

