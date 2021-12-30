> Revision Count: 1


# Identify And Access Management

[Cheat Sheet - Identify And Access Management](https://tutorialsdojo.com/aws-identity-and-access-management-iam)

[Cheat Sheet - SCP vs IAM](https://tutorialsdojo.com/service-control-policies-scp-vs-iam-policies)

[Cheat Sheet - security-identity-services](https://tutorialsdojo.com/aws-cheat-sheets-security-identity-services)

### Identity providers and federation

[Enabling SAML 2.0 federated users to access the AWS Management Console](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_enable-console-saml.html)

- You can use a role to configure your SAML 2.0-compliant identity provider (IdP) and AWS to permit your federated users to access the AWS Management Console. 
- The role grants the user permissions to carry out tasks in the console.

### Enabling custom identity broker access to the AWS console

[Enabling custom identity broker access to the AWS console](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_enable-console-custom-url.html)

- You can write and run code to create a URL that lets users who sign in to your organization's network securely access the AWS Management Console. 
- The URL includes a sign-in token that you get from AWS and that authenticates the user to AWS.

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
- The administrator uses IAM to create the Get-pics role. 
- In the role's trust policy, the administrator specifies that only EC2 instances can assume the role
- In the role's permission policy, the administrator specifies read-only permissions for the photos bucket.
- A developer launches an EC2 instance and assigns the Get-pics role to that instance.
- When the application runs, it obtains temporary security credentials from Amazon EC2 instance metadata,
- Using the retrieved temporary credentials, the application accesses the photo bucket. 
- Because of the policy attached to the Get-pics role, the application has read-only permissions.

## Tutorials

### IAM tutorial: Delegate access across AWS accounts using IAM roles

[IAM tutorial: Delegate access across AWS accounts using IAM roles](https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_cross-account-with-roles.html)

The above tutorial teaches you how to use a role to delegate access to resources in different AWS accounts that you own called Production and Development

- Step 1: Create a role in the Production Account
  - First, you use the AWS Management Console to establish trust between the Production account (ID number 999999999999) and the Development account (ID number 111111111111). 
  - You start by creating an IAM role named UpdateApp. 
  - When you create the role, you define the Development account as a trusted entity and specify a permissions policy that allows trusted users to update the productionapp bucket.
  

### Providing access to an IAM user in another AWS account that you own

[Providing access to an IAM user in another AWS account that you own](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_common-scenarios_aws-accounts.html)

- You can grant your IAM users permission to switch to roles within your AWS account or to roles defined in other AWS accounts that you own.


## Controlling access to AWS resources using tags

[Controlling access to AWS resources using tags](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_tags.html)

- You can use tags to control access to your AWS resources that support tagging, including IAM resources. 
- Imagine that you have Amazon EC2 instances that are critical to your organization. 
- Instead of directly granting your users permission to terminate the instances, you can create a role with those privileges.

- Example scenario using separate development and production accounts
  - In the production account, an administrator uses IAM to create the UpdateApp role in that account. 
    - In the role, the administrator defines a trust policy that specifies the development account as a Principal, meaning that authorized users from the development account can use the UpdateApp role. 
    - The administrator also defines a permissions policy for the role that specifies the read and write permissions to the Amazon S3 bucket named productionapp.
  - In the development account, an administrator grants members of the Developers group permission to switch to the role. 
    - This is done by granting the Developers group permission to call the AWS Security Token Service (AWS STS) AssumeRole API for the UpdateApp role.
  - The user requests switches to the role
  - AWS STS returns temporary credentials
  - The temporary credentials allow access to the AWS resource


## Using an IAM role to grant permissions to applications running on Amazon EC2 instances

### Using instance profiles

[Using instance profiles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2_instance-profiles.html)

- Use an instance profile to pass an IAM role to an EC2 instance.
- you can and should use an IAM role to manage temporary credentials for applications that run on an EC2 instance

## Identity federation in AWS

[Identity federation in AWS](https://aws.amazon.com/identity/federation)

- Identity federation is a system of trust between two parties for the purpose of authenticating users and conveying information needed to authorize their access to resources. 
- In this system, an identity provider (IdP) is responsible for user authentication, and a service provider (SP), such as a service or an application, controls access to resources.
- By administrative agreement and configuration, the SP trusts the IdP to authenticate users and relies on the information provided by the IdP about them. 
- After authenticating a user, the IdP sends the SP a message, called an assertion, containing the user's sign-in name and other attributes that the SP needs to establish a session with the user and to determine the scope of resource access that the SP should grant. 
 

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
- for more advanced scenarios, you can work directly with a third-party service like Login with Amazon, Facebook, Google, or any IdP that is compatible with OpenID Connect (OIDC).


### Federating users with SAML 2.0

- If your organization already uses an identity provider software package that supports SAML 2.0 (Security Assertion Markup Language 2.0), you can create trust between your organization as an identity provider (IdP) and AWS as the service provider.
- You can then use SAML to provide your users with federated single-sign on (SSO) to the AWS Management Console or federated access to call AWS API operations.

### Federating users by creating a custom identity broker application

- If your identity store is not compatible with SAML 2.0, then you can build a custom identity broker application to perform a similar function. 
- The broker application authenticates users, requests temporary credentials for users from AWS, and then provides them to the user to access AWS resources.



## Premium Support

[What's the difference between an AWS Organizations service control policy and an IAM policy?](https://console.aws.amazon.com/console/home?nc2=h_ct&src=header-signin&hashArgs=%23)

## Blog

[How to Establish Federated Access to Your AWS Resources by Using Active Directory User Attributes](https://aws.amazon.com/blogs/security/how-to-establish-federated-access-to-your-aws-resources-by-using-active-directory-user-attributes)






