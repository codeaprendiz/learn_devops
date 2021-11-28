# AWS Cognito

[What Is Amazon Cognito?](https://docs.aws.amazon.com/cognito/latest/developerguide/what-is-amazon-cognito.html)

[Cheat Sheet - Cognito](https://tutorialsdojo.com/amazon-cognito)

[Cheat Sheet - Amazon Cognito User and Identity Pools Explained](https://tutorialsdojo.com/amazon-cognito-user-pools-and-identity-pools-explained)

- Amazon Cognito provides authentication, authorization, and user management for your web and mobile apps. 
- Your users can sign in directly with a user name and password, or through a third party such as Facebook, Amazon, Google or Apple.
- The two main components of Amazon Cognito are user pools and identity pools. 
- User pools are user directories that provide sign-up and sign-in options for your app users. 
- Identity pools enable you to grant your users access to other AWS services. 
- You can use identity pools and user pools separately or together.


## Amazon Cognito Identity Pools (Federated Identities)

[Amazon Cognito Identity Pools (Federated Identities)](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-identity.html)

- Amazon Cognito identity pools (federated identities) enable you to create unique identities for your users and federate them with identity providers.
- With an identity pool, you can obtain temporary, limited-privilege AWS credentials to access other AWS services

### Identity Pools (Federated Identities) External Identity Providers

[Identity Pools (Federated Identities) External Identity Providers](https://docs.aws.amazon.com/cognito/latest/developerguide/external-identity-providers.html)

- Using the logins property, you can set credentials received from an identity provider. 
- Moreover, you can associate an identity pool with multiple identity providers.
- For example, you could set both the Facebook and Google tokens in the logins property, so that the unique Amazon Cognito identity would be associated with both identity provider logins
- No matter which account the end user uses for authentication, Amazon Cognito returns the same user identifier.

#### Open ID Connect Providers (Identity Pools)

[Open ID Connect Providers (Identity Pools](https://docs.aws.amazon.com/cognito/latest/developerguide/open-id.html)

- OpenID Connect is an open standard for authentication that is supported by a number of login providers
- Amazon Cognito supports linking of identities with OpenID Connect providers that are configured through AWS Identity and Access Management.

## Integrating Amazon Cognito with web and mobile apps

[Integrating Amazon Cognito with web and mobile apps](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-integrate-apps.html)

[simplifying-token-vending-machine-deployment-with-aws-cloudformation](https://aws.amazon.com/blogs/mobile/simplifying-token-vending-machine-deployment-with-aws-cloudformation)

- By integrating Amazon Cognito with your client code, you connect your app to backend AWS functionality that aids authentication and authorization workflows.
- Your app will use the Amazon Cognito API to, for example, create new users in your user pool, retrieve user pool tokens, and obtain temporary credentials from your identity pool. 
- To integrate Amazon Cognito with your web or mobile app, use the SDKs and libraries that the AWS Amplify framework provides.




## SSO FAQs

[Single Sign On FAQs](https://aws.amazon.com/single-sign-on/faqs)
