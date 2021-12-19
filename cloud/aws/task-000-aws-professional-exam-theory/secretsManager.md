# Secrets Manager

[Cheat Sheet - Secrets Manager](https://tutorialsdojo.com/aws-secrets-manager/)


- AWS Secrets Manager helps you protect secrets needed to access your applications, services, and IT resources. 
- The service enables you to easily rotate, manage, and retrieve database credentials, API keys, and other secrets throughout their lifecycle. 
- Users and applications retrieve secrets with a call to Secrets Manager APIs, eliminating the need to hardcode sensitive information in plain text. 
- Secrets Manager offers secret rotation with built-in integration for Amazon RDS, Amazon Redshift, and Amazon DocumentDB. 
- Also, the service is extensible to other types of secrets, including API keys and OAuth tokens


## Automate secret creation in AWS CloudFormation

[Automate secret creation in AWS CloudFormation](https://docs.aws.amazon.com/secretsmanager/latest/userguide/integrating_cloudformation.html)

- You can use AWS CloudFormation to create and reference secrets from within your AWS CloudFormation stack template. 
- You can create a secret and then reference it from another part of the template. 
- For example, you can retrieve the user name and password from the new secret and then use that to define the user name and password for a new database. 
- You can create and attach resource-based policies to a secret. 
- You can also configure rotation by defining a Lambda function in your template and associating the function with your new secret as its rotation Lambda function.

- Secrets Manager provides the following resource types that you can use to create secrets in an AWS CloudFormation template:

  - AWS::SecretsManager::Secret – Creates a secret and stores it in Secrets Manager. You can specify a password or Secrets Manager can generate one for you.
  - AWS::SecretsManager::ResourcePolicy – Creates a resource-based policy and attaches it to the secret. A resource-based policy controls who can perform actions on the secret.
  - AWS::SecretsManager::RotationSchedule – Configures a secret to perform automatic periodic rotation using the specified Lambda rotation function.
  - AWS::SecretsManager::SecretTargetAttachment – Configures the secret with the details about the service or database that Secrets Manager needs to rotate the secret. For example, for an Amazon RDS DB instance, Secrets Manager adds the connection details and database engine type as entries in the SecureString property of the secret.

  