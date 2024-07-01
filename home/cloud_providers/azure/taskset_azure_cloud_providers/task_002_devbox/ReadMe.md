# Devbox

- [Devbox](#devbox)
  - [What is Microsoft Dev Box?](#what-is-microsoft-dev-box)
  - [Key concepts for Microsoft Dev Box](#key-concepts-for-microsoft-dev-box)
  - [Quickstart: Configure Microsoft Dev Box](#quickstart-configure-microsoft-dev-box)
    - [Create a dev center](#create-a-dev-center)
    - [Create a project](#create-a-project)
    - [Create a dev box definition](#create-a-dev-box-definition)
    - [Create a dev box pool](#create-a-dev-box-pool)
    - [Provide access to a dev box project](#provide-access-to-a-dev-box-project)
  - [Quickstart: Create and connect to a dev box by using the Microsoft Dev Box developer portal](#quickstart-create-and-connect-to-a-dev-box-by-using-the-microsoft-dev-box-developer-portal)
    - [Create a dev box](#create-a-dev-box)
    - [Connect to a dev box](#connect-to-a-dev-box)
  - [Microsoft Dev Box architecture overview](#microsoft-dev-box-architecture-overview)
    - [How does Microsoft Dev Box work?](#how-does-microsoft-dev-box-work)
    - [Microsoft Dev Box architecture](#microsoft-dev-box-architecture)
    - [Network connectivity](#network-connectivity)
    - [Microsoft Intune integration](#microsoft-intune-integration)
    - [Identity services](#identity-services)

## [What is Microsoft Dev Box?](https://learn.microsoft.com/en-us/azure/dev-box/overview-what-is-microsoft-dev-box)

- gives developers self-service access to ready-to-code cloud workstations called dev boxes
- configure dev boxes with tools, source code, and prebuilt binaries
- create your own customized image, or use a preconfigured image from Azure Marketplace
- was designed with three organizational roles in mind: platform engineers, development team leads, and developers

> A dev box is a virtual machine (VM) preconfigured with the tools and resources the developer needs for a project.

![img](https://learn.microsoft.com/en-us/azure/dev-box/media/overview-what-is-microsoft-dev-box/dev-box-roles.png#lightbox)

## [Key concepts for Microsoft Dev Box](https://learn.microsoft.com/en-us/azure/dev-box/concept-dev-box-concepts)

## [Quickstart: Configure Microsoft Dev Box](https://learn.microsoft.com/en-us/azure/dev-box/quickstart-configure-dev-box-service)

Two phases

- platform engineers configure the necessary Microsoft Dev Box resources through the Azure portal
- users can proceed to the next phase, creating and managing their dev boxes through the developer portal

steps required to configure Microsoft Dev Box in the Azure portal.

![img](https://learn.microsoft.com/en-us/azure/dev-box/media/quickstart-configure-dev-box-service/dev-box-build-stages.png#lightbox)

### [Create a dev center](https://learn.microsoft.com/en-us/azure/dev-box/quickstart-configure-dev-box-service#create-a-dev-center)

provides a centralized place to manage a

- collection of projects,
- the configuration of available dev box images and sizes, and
- the networking settings to enable access to organizational resources

### [Create a project](https://learn.microsoft.com/en-us/azure/dev-box/quickstart-configure-dev-box-service#create-a-project)

- Dev box projects enable you to manage team-level settings
- These settings include providing access to development teams so developers can create dev boxes.

### [Create a dev box definition](https://learn.microsoft.com/en-us/azure/dev-box/quickstart-configure-dev-box-service#create-a-dev-box-definition)

- A dev box definition defines the VM image and the VM SKU (compute size + storage) that are used in the creation of the dev boxes.
- The dev box definitions you create in a dev center are available for all projects associated with that dev center

### [Create a dev box pool](https://learn.microsoft.com/en-us/azure/dev-box/quickstart-configure-dev-box-service#create-a-dev-box-pool)

- A dev box pool is the collection of dev boxes that have the same settings, such as the dev box definition and network connection.
- Developers that have access to the project in the dev center, can then choose to create a dev box from a dev box pool.
- Dev box pools define the location of the dev boxes through the specified network connection

### [Provide access to a dev box project](https://learn.microsoft.com/en-us/azure/dev-box/quickstart-configure-dev-box-service#provide-access-to-a-dev-box-project)

- you must provide access for users through role assignments
- Dev Box User role enables dev box users to create, manage, and delete their own dev boxes
- You grant access for the user at the level of the project.

## [Quickstart: Create and connect to a dev box by using the Microsoft Dev Box developer portal](https://learn.microsoft.com/en-us/azure/dev-box/quickstart-create-dev-box)

### [Create a dev box](https://learn.microsoft.com/en-us/azure/dev-box/quickstart-create-dev-box#create-a-dev-box)

### [Connect to a dev box](https://learn.microsoft.com/en-us/azure/dev-box/quickstart-create-dev-box#connect-to-a-dev-box)

## [Microsoft Dev Box architecture overview](https://learn.microsoft.com/en-us/azure/dev-box/concept-dev-box-architecture)

### [How does Microsoft Dev Box work?](https://learn.microsoft.com/en-us/azure/dev-box/concept-dev-box-architecture)

The following diagram gives an overview of the relationship between the different components in Microsoft Dev Box.

![img](https://learn.microsoft.com/en-us/azure/dev-box/media/concept-dev-box-architecture/dev-box-concepts-overview.png#lightbox)

- dev center
  - dev center is the top-level resource for Microsoft Dev Box
  - dev center contains the collection of projects and the shared resources for these projects, such as dev box definitions and network connections
- project
  - A dev box project is the point of access for development teams.
  - You assign a developer the Dev Box User role to a project to grant the developer permissions to create dev boxes.
- dev box definition
  - dev box definition specifies the configuration of the dev boxes, such as the virtual machine image and compute resources for the dev boxes.
  - can either choose a VM image from the Azure Marketplace, or use an Azure compute gallery to use custom VM images.
- dev box pools
  - project contains the collection of dev box pools
  - dev box pool specifies the configuration for dev boxes, such as the dev box definition, the network connection, and other settings
  - The network connection that is associated with a dev box pool determines where the dev box is hosted
- dev box
  - Developers can create a dev box from a dev box pool by using the developer portal.

### [Microsoft Dev Box architecture](https://learn.microsoft.com/en-us/azure/dev-box/concept-dev-box-architecture#microsoft-dev-box-architecture)

The following diagrams show the logical architecture of Microsoft Dev Box.

![img](https://learn.microsoft.com/en-us/azure/dev-box/media/concept-dev-box-architecture/dev-box-architecture-diagram.png#lightbox)

For the network connection, you can also choose between a Microsoft-hosted network connection, and an Azure network connection that you create in your own subscription

### [Network connectivity](https://learn.microsoft.com/en-us/azure/dev-box/concept-dev-box-architecture#network-connectivity)

- Network connections control where dev boxes are created and hosted, and enable you to connect to other Azure or corporate resources.
- Depending on your level of control, you can use Microsoft-hosted network connections or bring your own Azure network connections.

### [Microsoft Intune integration](https://learn.microsoft.com/en-us/azure/dev-box/concept-dev-box-architecture#microsoft-intune-integration)

- Microsoft Intune is used to manage your dev boxes.
- Every Dev Box user needs one Microsoft Intune license and can create multiple dev boxes.

### [Identity services](https://learn.microsoft.com/en-us/azure/dev-box/concept-dev-box-architecture#identity-services)

Microsoft Dev Box uses Microsoft Entra ID and, optionally, on-premises Active Directory Domain Services (AD DS).