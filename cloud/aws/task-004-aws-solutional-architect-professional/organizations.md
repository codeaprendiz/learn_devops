# Organizations

[Organization](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_introduction.html)

- AWS Organizations is an account management service that enables you to consolidate multiple AWS accounts into an organization that you create and centrally manage. 
- AWS Organizations includes account management and consolidated billing capabilities that enable you to better meet the budgetary, security, and compliance needs of your business. 
- As an administrator of an organization, you can create accounts in your organization and invite existing accounts to join the organization.


## Using AWS Services


### Using AWS Organizations with other AWS services

[Using AWS Organizations with other AWS services](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_integrate_services.html)

- You can use trusted access to enable a supported AWS service that you specify, called the trusted service, to perform tasks in your organization and its accounts on your behalf. 
- This involves granting permissions to the trusted service but does not otherwise affect the permissions for IAM users or roles. 
- When you enable access, the trusted service can create an IAM role called a service-linked role in every account in your organization whenever that role is needed. 
- That role has a permissions policy that allows the trusted service to do the tasks that are described in that service's documentation
- The trusted service only creates service-linked roles when it needs to perform management actions on accounts, and not necessarily in all accounts of the organization.

#### AWS Resource Access Manager and AWS Organizations

- AWS Resource Access Manager (AWS RAM) enables you to share specified AWS resources that you own with other AWS accounts. 
- It's a centralized service that provides a consistent experience for sharing different types of AWS resources across multiple accounts.

Service-linked roles created when you enable integration

- The following service-linked role is automatically created in your organization's management account when you enable trusted access. 
- This role allows AWS RAM to perform supported operations within your organization's accounts in your organization.
- You can delete or modify this role only if you disable trusted access between AWS RAM and Organizations, or if you remove the member account from the organization.

```bash
  AWSServiceRoleForResourceAccessManager
```  