
### CodePipeline

[Grant approval permissions to an IAM user in CodePipeline](https://docs.aws.amazon.com/codepipeline/latest/userguide/approvals-iam-permissions.html)

- attaching the AWSCodePipelineApproverAccess managed policy to an IAM user

[Approve or reject an approval action in CodePipeline](https://docs.aws.amazon.com/codepipeline/latest/userguide/approvals-approve-or-reject.html)

[Invoke an AWS Lambda function in a pipeline in CodePipeline](https://docs.aws.amazon.com/codepipeline/latest/userguide/actions-invoke-lambda-function.html)

- Do not log the JSON event that CodePipeline sends to Lambda because this can result in user credentials being logged in CloudWatch Logs. The CodePipeline role uses a JSON event to pass temporary credentials to Lambda in the artifactCredentials field.

[CodePipeline pipeline structure reference](https://docs.aws.amazon.com/codepipeline/latest/userguide/reference-pipeline-structure.html)

- To specify parallel actions, use the same integer for each action you want to run in parallel. In the console, you can specify a serial sequence for an action by choosing Add action group at the level in the stage where you want it to run, or you can specify a parallel sequence by choosing Add action. Action group refers to a run order of one or more actions at the same level
- different action groups have different runOrder values and their actions do not run in parallel.

[Configure server-side encryption for artifacts stored in Amazon S3 for CodePipeline](https://docs.aws.amazon.com/codepipeline/latest/userguide/S3-artifact-encryption.html)

```json
{
    "Version": "2012-10-17",
    "Id": "SSEAndSSLPolicy",
    "Statement": [
        {
            "Sid": "DenyUnEncryptedObjectUploads",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::codepipeline-us-west-2-89050EXAMPLE/*",
            "Condition": {
                "StringNotEquals": {
                    "s3:x-amz-server-side-encryption": "aws:kms"
                }
            }
        },
        {
            "Sid": "DenyInsecureConnections",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::codepipeline-us-west-2-89050EXAMPLE/*",
            "Condition": {
                "Bool": {
                    "aws:SecureTransport": "false"
                }
            }
        }
    ]
}
```


[FAQ](https://aws.amazon.com/codepipeline/faqs/)

- Pipeline actions occur in a specified order, in serial or in parallel, as determined in the configuration of the stage
