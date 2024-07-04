# [Create a new Virtual Machine from a managed image](https://learn.microsoft.com/en-us/training/modules/customize-windows-server-iaas-virtual-machine-images/3-create-new-virtual-machine-managed-image)

After you have generalized the VM, you can create a managed image. You can then create new VMs from this managed image.

> [!CAUTION]
> Capturing a VM image from a VM will make the VM unusable. Furthermore, this action can't be undone.

## Create a managed image from a generalized VM

The managed image you create will include all of the disks associated with the generalized VM

> [!NOTE]
> The VM is in stopped (deallocated) state before you create the image.

```bash
az image create \
    --name <image name> \
    --resource-group <resource group> \
    --source <generalized virtual machine>
```

## Create a new VM from a managed image

To create a new VM using Azure CLI, use the following command:

```bash
az vm create \
    --resource-group <resource group> \
    --name <new virtual machine name> \
    --image <image name> \
    --location <location of image>
```
