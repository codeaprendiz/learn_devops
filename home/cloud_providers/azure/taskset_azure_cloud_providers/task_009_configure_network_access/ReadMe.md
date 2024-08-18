# [Configure Network Access](https://learn.microsoft.com/en-us/training/modules/describe-azure-compute-networking-services/9-exercise-configure-network-access)

> [!NOTE]
> you can associate same NSG for multiple network interfaces and/or subnets

> [!TIP]
> A network interface (NIC) enables an Azure virtual machine (VM) to communicate with internet, Azure, and on-premises resources.

[Create, change, or delete a network interface](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-network-interface?tabs=azure-portal)

[Network security groups](https://learn.microsoft.com/en-us/azure/virtual-network/network-security-groups-overview)

[NSG-Can i assigned 1 NSG to multiple Instance , what is the limit](https://learn.microsoft.com/en-us/answers/questions/1353503/nsg-can-i-assigned-1-nsg-to-multiple-instance-what)

## Access your web server

List VMs

```bash
az vm list
```

Get VM IP

```bash
IPADDRESS="$(az vm list-ip-addresses --resource-group "<resource_group>" --name my-vm --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" --output tsv)"
```

curl to download homepage

```bash
curl --connect-timeout 5 http://$IPADDRESS
```

Output

```bash
curl: (28) Failed to connect to 13.64.199.115 port 80 after 5002 ms: Timeout was reached
```

## List the current network security group rules

Run the following az network nsg list command to list the network security groups that are associated with your VM:

```bash
az network nsg list --resource-group "<resource_group>" --query '[].name' --output tsv
```

Output

```bash
my-vmNSG
```

Run the following az network nsg rule list command to list the rules associated with the NSG named my-vmNSG:

```bash
az network nsg rule list --resource-group "<resource_group>" --nsg-name my-vmNSG
```

## Create the network security rule

Run the following az network nsg rule create command to create a rule called allow-http that allows inbound access on port 80:

```bash
az network nsg rule create --resource-group "<resource_group>" --nsg-name my-vmNSG --name allow-http --protocol tcp --priority 100 --destination-port-range 80 --access Allow
```

Validate

```bash
az network nsg rule list --resource-group "<resource_group>" --nsg-name my-vmNSG --query '[].{Name:name, Priority:priority, Port:destinationPortRange, Access:access}' --output table
```

Output

```bash
Name               Priority    Port    Access
-----------------  ----------  ------  --------
default-allow-ssh  1000        22      Allow
allow-http         100         80      Allow
```

## Access your web server again

```bash
curl --connect-timeout 5 http://$IPADDRESS
```

Output

```bash
<html><body><h2>Welcome to Azure! My name is my-vm.</h2></body></html>
```

## Resources created in security group

```bash
az resource list --resource-group <resource_group> --query "[].type" -o tsv
Microsoft.Storage/storageAccounts
Microsoft.Network/publicIPAddresses
Microsoft.Network/networkSecurityGroups
Microsoft.Network/virtualNetworks
Microsoft.Network/networkInterfaces
Microsoft.Compute/virtualMachines
Microsoft.Compute/disks
Microsoft.Compute/virtualMachines/extensions
```
