# [Exercise - Create an image of an Azure VM from the Azure CLI and provision a new VM](https://learn.microsoft.com/en-us/training/modules/deploy-vms-from-vhd-templates/4-exercise-create-image-provision-vm?pivots=windows-cloud)

## Set your default resource group

```bash
az configure --defaults group="learn-fcd3cc98-3fab-45d5-b679-f2ddfaf86f6c"
```

## Create a virtual machine

Create

```bash
az vm create --name MyWindowsVM --image Win2019Datacenter --admin-username azureuser
```

install IIS and set up a default webpage:

```bash
az vm extension set --name CustomScriptExtension --vm-name MyWindowsVM --publisher Microsoft.Compute --settings '{"commandToExecute":"powershell Add-WindowsFeature Web-Server; Add-Content -Path \"C:\\inetpub\\wwwroot\\Default.htm\" -Value $(hostname)"}'
```

open port 80 to the web server:

```bash
az vm open-port --name MyWindowsVM --port 80
```

get public ip

```bash
echo http://$(az vm list-ip-addresses --name MyWindowsVM --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" --output tsv)
```

## Generalize the virtual machine

![img](https://learn.microsoft.com/en-us/training/modules/deploy-vms-from-vhd-templates/media/4-sysprep.png)

deallocate the virtual machine

```bash
az vm deallocate --name MyWindowsVM
```

generalize the virtual machine:

```bash
az vm generalize --name MyWindowsVM
```

## Create a virtual machine image

```bash
az image create --name MyVMIMage --source MyWindowsVM
```

## Create a virtual machine by using the new image

Create a new virtual machine from the image:

```bash
az vm create --name MyVMFromImage --computer-name MyVMFromImage --image MyVMImage --admin-username azureuser
```

update the default web page with the server name:

```bash
az vm extension set --name CustomScriptExtension --vm-name MyVMFromImage --publisher Microsoft.Compute --settings '{"commandToExecute":"powershell Clear-Content -Path \"C:\\inetpub\\wwwroot\\Default.htm\"; Add-Content -Path \"C:\\inetpub\\wwwroot\\Default.htm\" -Value $(hostname)"}'
```

open port 80 to the web server:

```bash
az vm open-port --name MyVMFromImage --port 80
```

get public ip

```bash
echo http://$(az vm list-ip-addresses --name MyVMFromImage --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" --output tsv)
```

