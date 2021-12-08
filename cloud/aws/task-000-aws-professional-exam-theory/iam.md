# Identify And Access Management

[Cheat Sheet - Identify And Access Management](https://tutorialsdojo.com/aws-identity-and-access-management-iam)

[Cheat Sheet - SCP vs IAM](https://tutorialsdojo.com/service-control-policies-scp-vs-iam-policies)

[Cheat Sheet - security-identity-services](https://tutorialsdojo.com/aws-cheat-sheets-security-identity-services)

[Enabling SAML 2.0 federated users to access the AWS Management Console](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_enable-console-saml.html)

- You can use a role to configure your SAML 2.0-compliant identity provider (IdP) and AWS to permit your federated users to access the AWS Management Console. 
- The role grants the user permissions to carry out tasks in the console.


## Logging IAM and AWS STS API calls with AWS CloudTrail

[Logging IAM and AWS STS API calls with AWS CloudTrail](https://docs.aws.amazon.com/IAM/latest/UserGuide/cloudtrail-integration.html)

- IAM and AWS STS are integrated with AWS CloudTrail, a service that provides a record of actions taken by an IAM user or role.
- CloudTrail captures all API calls for IAM and AWS STS as events, including calls from the console and from API calls. 
- If you create a trail, you can enable continuous delivery of CloudTrail events to an Amazon S3 bucket. 
- If you don't configure a trail, you can still view the most recent events in the CloudTrail console in Event history



## How IAM roles differ from resource-based policies

[How IAM roles differ from resource-based policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_compare-resource-policies.html)

- For some AWS services, you can grant cross-account access to your resources.
- To do this, you attach a policy directly to the resource that you want to share, instead of using a role as a proxy.
- The resource that you want to share must support resource-based policies. 
-  Unlike an identity-based policy, a resource-based policy specifies who (which principal) can access that resource.


### Temporary security credentials in IAM

[Temporary security credentials in IAM](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp.html)

- You can use the AWS Security Token Service (AWS STS) to create and provide trusted users with temporary security credentials that can control access to your AWS resources.
  - Temporary security credentials are short-term, as the name implies. They can be configured to last for anywhere from a few minutes to several hours
  - Temporary security credentials are not stored with the user but are generated dynamically and provided to the user when requested.


## Actions

[UploadServerCertificate](https://docs.aws.amazon.com/IAM/latest/APIReference/API_UploadServerCertificate.html)

- Uploads a server certificate entity for the AWS account. The server certificate entity includes a public key certificate, a private key, and an optional certificate chain, which should all be PEM-encoded.



## Tutorials

### IAM tutorial: Delegate access across AWS accounts using IAM roles

[IAM tutorial: Delegate access across AWS accounts using IAM roles](https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_cross-account-with-roles.html)

The above tutorial teaches you how to use a role to delegate access to resources in different AWS accounts that you own called Production and Development