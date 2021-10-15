
### CodeDeploy

[Register an on-premises instance with CodeDeploy](https://docs.aws.amazon.com/codedeploy/latest/userguide/on-premises-instances-register.html)

[Use the register command (IAM user ARN) to register an on-premises instance](https://docs.aws.amazon.com/codedeploy/latest/userguide/instances-on-premises-register-instance.html)

The register command can create an IAM user for the server and register the server with CodeDeploy

```bash
aws deploy register --instance-name AssetTag234AESDD --tags
Key=Name,Value=CodeDeployDemo-OnPremise --region eu-west-1
```

[Manually remove on-premises instance tags from an on-premises instance](https://docs.aws.amazon.com/codedeploy/latest/userguide/on-premises-instances-operations-remove-tags.html)

Typically, you remove an on-premises instance tag from an on-premises instance when that tag is no longer being used, or you want to remove the on-premises instance from any deployment groups that rely on that tag. You can use the AWS CLI or the AWS CodeDeploy console to remove on-premises instance tags from on-premises instances.

[Create a deployment group for an in-place deployment (console)]()

[Deployment configurations on an AWS Lambda compute platform](https://docs.aws.amazon.com/codedeploy/latest/userguide/deployment-configurations.html#deployment-configuration-lambda)

There are three ways traffic can shift during a deployment:

- Canary: Traffic is shifted in two increments. You can choose from predefined canary options that specify the percentage of traffic shifted to your updated Lambda function version in the first increment and the interval, in minutes, before the remaining traffic is shifted in the second increment.
- Linear: Traffic is shifted in equal increments with an equal number of minutes between each increment. You can choose from predefined linear options that specify the percentage of traffic shifted in each increment and the number of minutes between each increment.
- All-at-once: All traffic is shifted from the original Lambda function to the updated Lambda function version all at once.

