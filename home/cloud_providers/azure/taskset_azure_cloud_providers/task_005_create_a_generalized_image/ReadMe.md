# [Create a generalized image](https://learn.microsoft.com/en-us/training/modules/customize-windows-server-iaas-virtual-machine-images/2-create-generalized-image)

[Training Module » Customize Windows Server IaaS Virtual Machine images](https://learn.microsoft.com/en-us/training/modules/customize-windows-server-iaas-virtual-machine-images/)

[Video Reference : Create a managed image of a generalized virtual machine in Azure](https://learn.microsoft.com/en-us/training/modules/customize-windows-server-iaas-virtual-machine-images/4-create-managed-image-generalized-virtual-machine-azure)

[what's the difference between deallocated and stopped ?](https://learn.microsoft.com/en-us/answers/questions/574969/whats-the-difference-between-deallocated-and-stopp)

## What are VM images?

- When you create a VM, you must specify a VM image that contains a generalized operating system and optionally, other preconfigured software.
- Azure uses the image to create a new virtual hard disk (VHD) from which it can start your VM

## What is a generalized image?

- After you create a VM and customize it by configuring and installing additional applications according to your requirements, you can save it as a new image.
- The new image will be a set of VHDs from which you can create additional VMs.
- However, you need to clean up the image first, because when you create a VM the operating system data is updated with several items, including:

  - The host name of your VM.
  - The administrator username and credentials.
  - Log files.
  - Security identifiers for various operating system services.

These items must be reset to their default settings before you capture an image. When you reset these items in a VM, you generalize the VM.

## Generalize a VM

- Use the Sysprep.exe tool to generalize a Windows VM

![img](https://learn.microsoft.com/en-us/training/wwl-azure/customize-windows-server-iaas-virtual-machine-images/media/m6-system-preparation.png)

- After the VM has been shut down, you should deallocate it while it's in this clean state.

> [!NOTE]  
> The VM might display a state of Stopped, but it isn't deallocated.

If you're using the Azure CLI, run the following command instead:

```bash
az vm deallocate \
    --resource-group <resource group> \
    --name <virtual machine name>
```

> [!TIP]
> When you use the Azure portal to create an image from a VM it automatically deallocates the VM.

> [!IMPORTANT]
> Keep in mind that you continue to pay for compute resources if your VM is stopped but not deallocated.
