# az | azure cli

[learn.microsoft.com/ » az](https://learn.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest)

- [az | azure cli](#az--azure-cli)
  - [Install](#install)
  - [deallocate | Deallocate a VM](#deallocate--deallocate-a-vm)
  - [group list | List resouce group names](#group-list--list-resouce-group-names)
  - [vm create | To create an image | To create a VM](#vm-create--to-create-an-image--to-create-a-vm)
  - [vm extension | To configure nginx on VM](#vm-extension--to-configure-nginx-on-vm)
  - [resources list | To list all resources in `<resource_group_name>` resourcegroup](#resources-list--to-list-all-resources-in-resource_group_name-resourcegroup)
  - [network | List vnet | List subnets | List rules | create rules](#network--list-vnet--list-subnets--list-rules--create-rules)
  - [vm list | To list virtual machines in a resource group](#vm-list--to-list-virtual-machines-in-a-resource-group)
  - [ad | To list AD users | servicePrincipals](#ad--to-list-ad-users--serviceprincipals)
  - [login](#login)
  - [account](#account)
  - [aks](#aks)
  - [storage](#storage)

## Install

[learn.microsoft.com » Install Azure CLI on macOS](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-macos)

## deallocate | Deallocate a VM

[what's the difference between deallocated and stopped ?](https://learn.microsoft.com/en-us/answers/questions/574969/whats-the-difference-between-deallocated-and-stopp)

```bash
az vm deallocate \
    --resource-group <resource group> \
    --name <virtual machine name>
```

## group list | List resouce group names

```bash
az group list -o table
```

## vm create | To create an image | To create a VM

To create an image from a generalised VM

```bash
az vm create \
    --resource-group <resource group> \
    --name <new virtual machine name> \
    --image <image name> \
    --location <location of image>
```

- run the following az vm create command to create a Linux VM:

```bash
az vm create --resource-group "<resource_group>" --name my-vm --public-ip-sku Standard --image Ubuntu2204 --admin-username azureuser --generate-ssh-keys
```

## vm extension | To configure nginx on VM

Run the following az vm extension set command to configure Nginx on your VM:

```bash
az vm extension set --resource-group "<resource_group>" --vm-name my-vm --name customScript --publisher Microsoft.Azure.Extensions --version 2.1 --settings '{"fileUris":["https://raw.githubusercontent.com/MicrosoftDocs/mslearn-welcome-to-azure/master/configure-nginx.sh"]}' --protected-settings '{"commandToExecute": "./configure-nginx.sh"}'
```

## resources list | To list all resources in `<resource_group_name>` resourcegroup

```bash
az resource list --resource-group <resource_group_name> -o table
```

## network | List vnet | List subnets | List rules | create rules

```bash
az network vnet list -o table
```

List subnets in vnet

```bash
# az network vnet subnet list --vnet-name <VNET_NAME> --resource-group <RESOURCE_GROUP_NAME> -o table
az network vnet subnet list --vnet-name test-dev-network --resource-group test-dev-rg -o table
```

To list Routetables in specific resource group

```bash
# az network route-table list --resource-group <RESOURCE_GROUP_NAME> -o table
az network route-table list --resource-group test-dev-rg -o table
```

To list network interfaces in a resource group:

```bash
# az network nic list --resource-group <RESOURCE_GROUP_NAME> -o table
az network nic list --resource-group test-dev-rg -o table
```

To list network security groups in a resource group:

```bash
# az network nsg list --resource-group <RESOURCE_GROUP_NAME> -o table
az network nsg list --resource-group test-dev-rg -o table
```

To list public IP addresses in a resource group:

```bash
# az network public-ip list --resource-group <RESOURCE_GROUP_NAME> -o table
az network public-ip list --resource-group test-dev-rg -o table
```

Run the following az network nsg rule list command to list the rules associated with the NSG named my-vmNSG:

```bash
az network nsg rule list --resource-group "<resource_group>" --nsg-name my-vmNSG
```

To only query required values for `my-vmNSG`

```bash
az network nsg rule list --resource-group "<resource_group>" --nsg-name my-vmNSG --query '[].{Name:name, Priority:priority, Port:destinationPortRange, Access:access}' --output table
```

Run the following az network nsg rule create command to create a rule called allow-http that allows inbound access on port 80:

```bash
az network nsg rule create --resource-group "<resource_group>" --nsg-name my-vmNSG --name allow-http --protocol tcp --priority 100 --destination-port-range 80 --access Allow
```

## vm list | To list virtual machines in a resource group

```bash
# az vm list --resource-group <RESOURCE_GROUP_NAME> -o table
az vm list --resource-group test-dev-rg -o table
```

## ad | To list AD users | servicePrincipals

To list AD users

```bash
az ad user list
```

To list the `servicePrincipals` created by you

```bash
az ad sp list --query "[?contains(displayName, 'azure-cli-2023-12-23-09-47-11')]" --output table
```

To creat a servicePrincipal

```bash
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<subscription_id>"
```

## login

To Login

```bash
az login
```

## account

To get information about the logged in account.

```bash
# The following should show your root account email that you used to login.
az account show
```

To get the subscription for the account

```bash
az account set --subscription "<subscription_id>"
```

To login using this servicePrincipal

```bash
az login --service-principal -u <CLIENT_ID> -p <CLIENT_SECRET> --tenant <TENANT_ID>
```

## aks

To configure `kubectl` to use the credentials for the Azure Kubernetes Service (AKS) cluster named `test-dev-aks` in the `test-dev-rg` resource group, enabling you to run `kubectl` commands against that cluster.

```bash
az aks get-credentials --resource-group test-dev-rg --name test-dev-aks
```

To run the `kubectl get pods -A` command directly on the AKS cluster named `test-dev-aks` in the `test-dev-rg` resource group, listing all pods in all namespaces within that cluster.

```bash
az aks command invoke -n test-dev-aks -g test-dev-rg -c "kubectl get pods -A"
```

## storage

To get the first key associated with storage account

```bash
az storage account keys list --resource-group <rg> --account-name <storage-account-name> --query '[0].value' -o tsv
```

To list containers in storage account

```bash
az storage container list --account-name <storage-account-name> --account-key $ARM_ACCESS_KEY --output table
```

To list the files (blobs) in a container

```bash
az storage blob list --container-name test-devrg --account-name <storage-account-name> --account-key $ARM_ACCESS_KEY --output table
```

To check VNet peering, you can use

```bash
# az network vnet peering list --resource-group <RESOURCE_GROUP_NAME> --vnet-name <VNET_NAME> --output table
az network vnet peering list --resource-group test-dev-rg --vnet-name test-dev-vnet1-network --output table
```

To check InstanceName, PrivateIp, PublicIP in resource group

```bash
# az vm list -g <RESOURCE_GROUP_NAME> -d --query "[].{Name:name,PrivateIP:privateIps,PublicIP:publicIps}" -o table
az vm list -g test-dev-rg -d --query "[].{Name:name,PrivateIP:privateIps,PublicIP:publicIps}" -o table
```
