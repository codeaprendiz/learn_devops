
## CodeDeploy

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


### Working with Deployments

[Stop a deployment with CodeDeploy](https://docs.aws.amazon.com/codedeploy/latest/userguide/deployments-stop.html)

- You can use the CodeDeploy console, the AWS CLI, or the CodeDeploy APIs to stop deployments associated with your AWS account.

[Redeploy and roll back a deployment with CodeDeploy](https://docs.aws.amazon.com/codedeploy/latest/userguide/deployments-rollback-and-redeploy.html#deployments-rollback-and-redeploy-manual-rollbacks)

- CodeDeploy rolls back deployments by redeploying a previously deployed revision of an application as a new deployment. These rolled-back deployments are technically new deployments, with new deployment IDs, rather than restored versions of a previous deployment.
- For an ongoing deployment, you can choose “Stop deployment” or “Stop and roll back deployment” for a deployment.

[Working with deployment configurations in CodeDeploy](https://docs.aws.amazon.com/codedeploy/latest/userguide/deployment-configurations.html)

- A deployment configuration is a set of rules and success and failure conditions used by CodeDeploy during a deployment. These rules and conditions are different, depending on whether you deploy to an EC2/On-Premises compute platform, AWS Lambda compute platform, or Amazon ECS compute platform.

**Predefined deployment configurations for an EC2/on-premises compute platform**
- Consider an example of 9 instances
  - CodeDeployDefault.AllAtOnce	
    - In-place deployments: 
      - attempts to deploy to all nine instances at once
      - The overall deployment succeeds if deployment to even a single instance is successful.
      - It fails only if deployments to all nine instances fail.
    - BlueGreen
      - Deployment to replacement environment: Follows the same deployment rules as CodeDeployDefault.AllAtOnce for in-place deployments.
      - Traffic rerouting: 
        - Routes traffic to all instances in the replacement environment at once. 
        - Succeeds if traffic is successfully rerouted to at least one instance. 
        - Fails after rerouting to all instances fails.
  - CodeDeployDefault.HalfAtATime	
  - CodeDeployDefault.OneAtATime	

**Deployment configurations on an AWS Lambda compute platform**

- When you deploy to an AWS Lambda compute platform, the deployment configuration specifies the way traffic is shifted to the new Lambda function versions in your application
  - Canary: Traffic is shifted in two increments. You can choose from predefined canary options that specify the percentage of traffic shifted to your updated Lambda function version in the first increment and the interval, in minutes, before the remaining traffic is shifted in the second increment. 
  - Linear: Traffic is shifted in equal increments with an equal number of minutes between each increment. You can choose from predefined linear options that specify the percentage of traffic shifted in each increment and the number of minutes between each increment. 
  - All-at-once: All traffic is shifted from the original Lambda function to the updated Lambda function version all at once.

Predefined deployment configurations for an AWS Lambda compute platform (for all please refer the documentation)
- CodeDeployDefault.LambdaCanary10Percent5Minutes: Shifts 10 percent of traffic in the first increment. The remaining 90 percent is deployed five minutes later.
- CodeDeployDefault.LambdaLinear10PercentEvery3Minutes : Shifts 10 percent of traffic every three minutes until all traffic is shifted.
- CodeDeployDefault.LambdaAllAtOnce: Shifts all traffic to the updated Lambda functions at once.


### Supported By

**CanaryDeployment**
- AWS Lambda
- ECS

