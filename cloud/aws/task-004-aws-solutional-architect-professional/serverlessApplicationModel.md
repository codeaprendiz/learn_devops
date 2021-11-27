# Serverless Applicaton Model


[CheatSheet - AWS Serverless Application Model](https://tutorialsdojo.com/aws-serverless-application-model-sam)


## What is the AWS Serverless Application Model (AWS SAM)?

[What is the AWS Serverless Application Model (AWS SAM)?](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html)

- The AWS Serverless Application Model (AWS SAM) is an open-source framework that you can use to build serverless applications on AWS.

### Deploying serverless applications gradually

- If you use AWS SAM to create your serverless application, it comes built-in with CodeDeploy to provide gradual Lambda deployments. With just a few lines of configuration, AWS SAM does the following for you:

  - Deploys new versions of your Lambda function, and automatically creates aliases that point to the new version.
  - Gradually shifts customer traffic to the new version until you're satisfied that it's working as expected, or you roll back the update.
  - Defines pre-traffic and post-traffic test functions to verify that the newly deployed code is configured correctly and your application operates as expected.
  - Rolls back the deployment if CloudWatch alarms are triggered.
