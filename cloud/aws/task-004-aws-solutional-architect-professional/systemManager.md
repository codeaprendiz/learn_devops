# System Manager

[What is AWS Systems Manager?](https://docs.aws.amazon.com/systems-manager/latest/userguide/what-is-systems-manager.html)

[Cheat Sheet - AWS Systems Manager](https://tutorialsdojo.com/aws-systems-manager)

- AWS Systems Manager (formerly known as SSM)
- you can use to view and control your infrastructure on AWS
- you can view operational data from multiple AWS services and automate operational tasks across your AWS resources.
- helps you maintain security and compliance by scanning your managed instances and reporting on (or taking corrective action on) any policy violations it detects.
- Systems Manager is comprised of individual capabilities, which are grouped into five categories: Operations Management, Application Management, Change Management, Node Management, and Shared Resources.


## Systems Manager Patch Manager

[AWS Systems Manager Patch Manager](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-patch.html)

- Patch Manager, a capability of AWS Systems Manager, automates the process of patching managed instances with both security related and other types of updates
- You can use Patch Manager to apply patches for both operating systems and applications. (On Windows Server, application support is limited to updates for applications released by Microsoft.) 
- You can use Patch Manager to install Service Packs on Windows instances and perform minor version upgrades on Linux instances. 
- You can install patches on a regular basis by scheduling patching to run as a Systems Manager maintenance window task.

[Patching your Windows EC2 instances using AWS Systems Manager Patch Manager](https://aws.amazon.com/blogs/mt/patching-your-windows-ec2-instances-using-aws-systems-manager-patch-manager)


## Monitoring

### Sending SSM Agent logs to CloudWatch Logs

[Sending SSM Agent logs to CloudWatch Logs](https://docs.aws.amazon.com/systems-manager/latest/userguide/monitoring-ssm-agent.html)

- AWS Systems Manager Agent (SSM Agent) is Amazon software that runs on your EC2 instances and your hybrid instances (on-premises instances and virtual machines) that are configured for Systems Manager
- SSM Agent processes requests from the Systems Manager service in the cloud and configures your machine as specified in the request


## Application Management

### AWS Systems Manager Parameter Store

[AWS Systems Manager Parameter Store](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-parameter-store.html)

- Parameter Store, a capability of AWS Systems Manager, provides secure, hierarchical storage for configuration data management and secrets managemen
- You can store data such as passwords, database strings, Amazon Machine Image (AMI) IDs, and license codes as parameter values
- You can store values as plain text or encrypted data
- Parameter Store is also integrated with Secrets Manager

### Setting up AWS Systems Manager for hybrid environments

[Setting up AWS Systems Manager for hybrid environments](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-managedinstances.html)

Configuring your hybrid environment for Systems Manager allows you to do the following:
- Create a consistent and secure way to remotely manage your hybrid workloads from one location using the same tools or scripts.
- Centralize access control for actions that can be performed on your servers and VMs by using AWS Identity and Access Management (IAM).
- Centralize auditing and your view into the actions performed on your servers and VMs by recording all actions in AWS CloudTrail.
- Centralize monitoring by configuring Amazon EventBridge and Amazon Simple Notification Service (Amazon SNS) to send notifications about service execution success.


#### Step 7: (Optional) Create Systems Manager service roles

[Step 7: (Optional) Create Systems Manager service roles](https://docs.aws.amazon.com/systems-manager/latest/userguide/setup-service-role.html)

- This topic explains the difference between a service role and a service-linked role for AWS Systems Manager. It also explains when you need to create or use either type of role.
- Service role: 
  - A service role is an AWS Identity and Access Management (IAM) that grants permissions to an AWS service so that the service can access AWS resources. 
  - Only a few Systems Manager scenarios require a service role. 
  - When you create a service role for Systems Manager, you choose the permissions to grant in order for it to access or interact with other AWS resources.
- Service-linked role: 
  - A service-linked role is predefined by Systems Manager and includes all the permissions that the service requires to call other AWS services on your behalf.


### About SSM documents for patching managed nodes

[About SSM documents for patching managed nodes](https://docs.aws.amazon.com/systems-manager/latest/userguide/patch-manager-ssm-documents.html)

The five recommended SSM documents include:
- AWS-ConfigureWindowsUpdate
- AWS-InstallWindowsUpdates
- AWS-RunPatchBaseline
- AWS-RunPatchBaselineAssociation
- AWS-RunPatchBaselineWithHooks

### About patching schedules using maintenance windows

[About patching schedules using maintenance windows](https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-patch-scheduletasks.html)

- After you configure a patch baseline (and optionally a patch group), you can apply patches to your node by using a maintenance window. 
- A maintenance window can reduce the impact on server availability by letting you specify a time to perform the patching process that doesn't interrupt business operations.

### AWS Systems Manager Automation

[AWS Systems Manager Automation](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-automation.html)

- Automation, a capability of AWS Systems Manager, simplifies common maintenance and deployment tasks of Amazon Elastic Compute Cloud (Amazon EC2) instances and other AWS resources.
  - Build automations to configure and manage instances and AWS resources.
  - Create custom runbooks or use pre-defined runbooks maintained by AWS.
  - Receive notifications about Automation tasks and runbooks by using Amazon EventBridge.
  - Monitor Automation progress and details by using the Systems Manager console.