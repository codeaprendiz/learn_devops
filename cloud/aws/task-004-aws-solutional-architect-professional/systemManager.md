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

