# Identify And Access Management

[Cheat Sheet - Identify And Access Management](https://tutorialsdojo.com/aws-cloudtrail)

[Enabling SAML 2.0 federated users to access the AWS Management Console](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_enable-console-saml.html)

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