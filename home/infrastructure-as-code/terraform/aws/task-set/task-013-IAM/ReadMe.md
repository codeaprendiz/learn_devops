## Objective 


1) To create a group `administrators`
2) To create two users `admin1` and `admin2` and add them to the group.
3) To attach policy `AdministratorAccess` to the group.


- Init

```bash
$ terraform init   
```

- Plan

```                                 
$ terraform plan 
.
.
.
Plan: 5 to add, 0 to change, 0 to destroy.
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
Apply complete! Resources: 5 added, 0 changed, 0 destroyed.

Outputs:

warning = WARNING: make sure you're not using the AdministratorAccess policy for other users/groups/roles. If this is the case, don't run terraform destroy, but manually unlink the created resources
```



- Destroy
```bash
$ terraform destroy                                 
Destroy complete! Resources: 5 destroyed.
```