# Organizations

[Cheat Sheet - AWS Organization](https://tutorialsdojo.com/aws-organizations)

[Cheat Sheet - Multi-Account Multi-Region Data Aggregation On AWS Config
](https://tutorialsdojo.com/multi-account-multi-region-data-aggregation-on-aws-config)

[service-control-policies-scp-vs-iam-policies](https://tutorialsdojo.com/service-control-policies-scp-vs-iam-policies/)

[What is AWS Organizations?](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_introduction.html)

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


## Managing Policies

### Service control policies

[Service control policies (SCPs)](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scps.html)

- Service control policies (SCPs) are a type of organization policy that you can use to manage permissions in your organization.
- SCPs offer central control over the maximum available permissions for all accounts in your organization.
- SCPs help you to ensure your accounts stay within your organization’s access control guidelines. 
- SCPs are available only in an organization that has all features enabled
- An SCP defines a guardrail, or sets limits, on the actions that the account's administrator can delegate to the IAM users and roles in the affected accounts. 
- The administrator must still attach identity-based or resource-based policies to IAM users or roles, or to the resources in your accounts to actually grant permissions

> AWS strongly recommends that you don't attach SCPs to the root of your organization without thoroughly testing the impact that the policy has on accounts.

> SCPs do not affect any service-linked role. Service-linked roles enable other AWS services to integrate with AWS Organizations and can't be restricted by SCPs.


## Tutorial: Monitor important changes to your organization with CloudWatch Events

[Tutorial: Monitor important changes to your organization with CloudWatch Events](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_tutorials_cwe.html)

- You start by configuring a rule that is triggered when users invoke specific AWS Organizations operations. 
- Next, you configure CloudWatch Events to run an AWS Lambda function when the rule is triggered, 
- and you configure Amazon SNS to send an email with details about the event.


## Using other AWS Services

### AWS Config and AWS Organizations

[AWS Config and AWS Organizations
](https://docs.aws.amazon.com/organizations/latest/userguide/services-that-can-integrate-config.html)

- Multi-account, multi-region data aggregation in AWS Config enables you to aggregate AWS Config data from multiple accounts and AWS Regions into a single account.
- An aggregator is a resource type in AWS Config that collects AWS Config data from multiple source accounts and Regions. 
- Create an aggregator in the Region where you want to see the aggregated AWS Config data. 
- While creating an aggregator, you can choose to add either individual account IDs or your organization

## Managing organizational units (OUs)

[Managing organizational units (OUs)](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_ous.html)

- You can use organizational units (OUs) to group accounts together to administer as a single unit.
- you can attach a policy-based control to an OU, and all accounts within the OU automatically inherit the policy. 
- You can create multiple OUs within a single organization, and you can create OUs within other OUs. 
- Each OU can contain multiple accounts, and you can move accounts from one OU to another. 
- However, OU names must be unique within a parent OU or root.


## Blogs

[What's the difference between an AWS Organizations service control policy and an IAM policy?](https://aws.amazon.com/premiumsupport/knowledge-center/iam-policy-service-control-policy)
