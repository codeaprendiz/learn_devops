> Revision Count: 1

# Single Sign-On

## What is AWS Single Sign-On?

[What is AWS Single Sign-On?](https://docs.aws.amazon.com/singlesignon/latest/userguide/what-is.html)

- AWS Single Sign-On is a cloud-based single sign-on (SSO) service that makes it easy to centrally manage SSO access to all of your AWS accounts and cloud applications
- Specifically, it helps you manage SSO access and user permissions across all your AWS accounts in AWS Organizations. 
- AWS SSO-integrated applications as well as custom applications that support Security Assertion Markup Language (SAML) 2.0.

## Connect to your Microsoft AD directory

[Connect to your Microsoft AD directory](https://docs.aws.amazon.com/singlesignon/latest/userguide/manage-your-identity-source-ad.html)

- With AWS Single Sign-On, administrators can connect their self-managed Active Directory (AD) or their AWS Managed Microsoft AD directory using AWS Directory Service. 
- This Microsoft AD directory defines the pool of identities that administrators can pull from when using the AWS SSO console to assign single sign-on (SSO) access. 
- After connecting their corporate directory to AWS SSO, administrators can then grant their AD users or groups access to AWS accounts, cloud applications, or both.


## Notes

- AWS SSO supports single sign-on to business applications through web browsers only.
- AWS SSO supports only SAML 2.0–based applications so an OpenID Connect-compatible solution will not work here