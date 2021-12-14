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

## Using an IAM role to grant permissions to applications running on Amazon EC2 instances

[Using an IAM role to grant permissions to applications running on Amazon EC2 instances](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2.html#roles-usingrole-ec2instance-roles)

- Applications that run on an EC2 instance must include AWS credentials in the AWS API requests
- you can and should use an IAM role to manage temporary credentials for applications that run on an EC2 instance.

## Tutorials

### IAM tutorial: Delegate access across AWS accounts using IAM roles

[IAM tutorial: Delegate access across AWS accounts using IAM roles](https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_cross-account-with-roles.html)

The above tutorial teaches you how to use a role to delegate access to resources in different AWS accounts that you own called Production and Development

### Providing access to an IAM user in another AWS account that you own

[Providing access to an IAM user in another AWS account that you own](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_common-scenarios_aws-accounts.html)


## Controlling access to AWS resources using tags

[Controlling access to AWS resources using tags](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_tags.html)

- You can use tags to control access to your AWS resources that support tagging, including IAM resources. 

## Using an IAM role to grant permissions to applications running on Amazon EC2 instances

### Using instance profiles

[Using instance profiles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2_instance-profiles.html)

- Use an instance profile to pass an IAM role to an EC2 instance.
- you can and should use an IAM role to manage temporary credentials for applications that run on an EC2 instance

## Identity providers and federation

- If you already manage user identities outside of AWS, you can use IAM identity providers instead of creating IAM users in your AWS account. 
- With an identity provider (IdP), you can manage your user identities outside of AWS and give these external user identities permissions to use AWS resources in your account


## Providing access to externally authenticated users (identity federation)

[Providing access to externally authenticated users (identity federation)](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_common-scenarios_federated-users.html)

- Your users might already have identities outside of AWS, such as in your corporate directory. 
- If those users need to work with AWS resources (or work with applications that access those resources), then those users also need AWS security credentials. 
- You can use an IAM role to specify permissions for users whose identity is federated from your organization or a third-party identity provider (IdP).

### Federating users of a mobile or web-based app with Amazon Cognito

- If you create a mobile or web-based app that accesses AWS resources, the app needs security credentials in order to make programmatic requests to AWS. 
- For most mobile application scenarios, we recommend that you use Amazon Cognito.

### Federating users of a mobile or web-based app with Amazon Cognito

- for more advanced scenarios, you can work directly with a third-party service like Login with Amazon, Facebook, Google, or any IdP that is compatible with OpenID Connect (OIDC).

### Federating users with SAML 2.0

- If your organization already uses an identity provider software package that supports SAML 2.0 (Security Assertion Markup Language 2.0), you can create trust between your organization as an identity provider (IdP) and AWS as the service provider.
- You can then use SAML to provide your users with federated single-sign on (SSO) to the AWS Management Console or federated access to call AWS API operations.

### Federating users by creating a custom identity broker application

- If your identity store is not compatible with SAML 2.0, then you can build a custom identity broker application to perform a similar function. 
- The broker application authenticates users, requests temporary credentials for users from AWS, and then provides them to the user to access AWS resources.



## Premium Support

[What's the difference between an AWS Organizations service control policy and an IAM policy?](https://console.aws.amazon.com/console/home?nc2=h_ct&src=header-signin&hashArgs=%23)


