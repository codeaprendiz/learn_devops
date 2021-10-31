

### CodeCommit

[auth-and-access-control-iam-identity-based-access-control](https://docs.aws.amazon.com/codecommit/latest/userguide/auth-and-access-control-iam-identity-based-access-control.html#identity-based-policies-example-4)

- To restrict push to master

```json
{ "Effect": "Allow",
"Action": [
"codecommit:GitPush",
"codecommit:Merge*" ],
"Resource": [ "arn:aws:codecommit:*:*:the-repo-name" ],
"Condition": {
"StringNotEquals": {
"codecommit:References": [ "refs/heads/master" ] }
}
}
```

Data in AWS CodeCommit repositories is already encrypted in transit as
well as at rest.

[how-to-migrate-existing-share](https://docs.aws.amazon.com/codecommit/latest/userguide/how-to-migrate-repository-existing.html#how-to-migrate-existing-share)

[Using identity-based policies (IAM Policies) for CodeCommit](https://docs.aws.amazon.com/codecommit/latest/userguide/auth-and-access-control-iam-identity-based-access-control.html)

- AWS manage policy AWSCodeCommitPowerUser allows users access to CodeCommit but disallows the action of deleting
  CodeCommit repositories.


[Cross-account repository access: Actions for the administrator in AccountA](https://docs.aws.amazon.com/codecommit/latest/userguide/cross-account-administrator-a.html)

To allow users or groups in AccountB to access a repository in AccountA, an AccountA administrator must:
- Create a policy in AccountA that grants access to the repository.
- Create a role in AccountA that can be assumed by IAM users and groups in AccountB.
- Attach the policy to the role.

[Cross-account repository access: Actions for the administrator in AccountB](https://docs.aws.amazon.com/codecommit/latest/userguide/cross-account-administrator-b.html)

To allow users or groups in AccountB to access a repository in AccountA, the AccountB
administrator must create a group in AccountB. This group must be configured with a policy having
action `"sts:AssumeRole` that allows group members to assume the role created by the AccountA administrator

[Setup steps for SSH connections to AWS CodeCommit repositories on Linux, macOS, or Unix](https://docs.aws.amazon.com/codecommit/latest/userguide/setting-up-ssh-unixes.html)

After you upload the SSH public key for the IAM user, the user can establish SSH connections to the CodeCommit repositories:

#### Supported Operations
[Change branch settings in AWS CodeCommit](https://docs.aws.amazon.com/codecommit/latest/userguide/how-to-change-branch.html)

- You can change which branch to use as the default branch in the AWS CodeCommit console or with the AWS CLI. For example, if you created your first commit using a Git client that set the  
  default branch to master, you could create a branch named main, and then change the branch settings so that the new branch is set as the default branch for the repository.
  To change other branch settings, you can use Git from a local repo connected to the CodeCommit repository.

[Merge a pull request in an AWS CodeCommit repository](https://docs.aws.amazon.com/codecommit/latest/userguide/how-to-merge-pull-request.html)


#### Working with pull requests

[Edit or delete an approval rule for a pull request](https://docs.aws.amazon.com/codecommit/latest/userguide/how-to-edit-delete-pull-request-approval-rule.html)

- When you have an approval rule on a pull request, you cannot merge that pull request until its conditions have been met. You can change the approval rules for pull requests to make it easier to satisfy their conditions, or to increase the rigor of reviews. You can change the number of users who must approve a pull request.

#### Working with approval rule templates

[Working with approval rule templates](https://docs.aws.amazon.com/codecommit/latest/userguide/approval-rule-templates.html)

- You can create approval rules for pull requests. To automatically apply approval rules to some or all of the pull requests created in repositories, use approval rule templates. Approval rule templates help you customize your development workflows across repositories so that different branches have appropriate levels of approvals and control. You can define different rules for production and development branches. Those rules are applied every time a pull request that matches the rule conditions is created.

#### Working with branches

[Limit pushes and merges to branches in AWS CodeCommit](https://docs.aws.amazon.com/codecommit/latest/userguide/how-to-conditional-branch.html)

- By default, any CodeCommit repository user who has sufficient permissions to push code to the repository can contribute to any branch in that repository.

- For example, this policy denies pushing commits, merging branches, deleting branches, merging pull requests, and adding files to a branch named main and a branch named prod in a repository named MyDemoRepo:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Deny",
            "Action": [
                "codecommit:GitPush",
                "codecommit:DeleteBranch",
                "codecommit:PutFile",
                "codecommit:MergeBranchesByFastForward",
                "codecommit:MergeBranchesBySquash",
                "codecommit:MergeBranchesByThreeWay",
                "codecommit:MergePullRequestByFastForward",
                "codecommit:MergePullRequestBySquash",
                "codecommit:MergePullRequestByThreeWay"
            ],
            "Resource": "arn:aws:codecommit:us-east-2:111111111111:MyDemoRepo",
            "Condition": {
                "StringEqualsIfExists": {
                    "codecommit:References": [
                        "refs/heads/main", 
                        "refs/heads/prod"
                     ]
                },
                "Null": {
                    "codecommit:References": "false"
                }
            }
        }
    ]
}
```


#### Working with repositories

[Manage triggers for an AWS CodeCommit repository](https://docs.aws.amazon.com/codecommit/latest/userguide/how-to-notify.html)

- You can configure a CodeCommit repository so that code pushes or other events trigger actions, such as sending a notification from Amazon Simple Notification Service (Amazon SNS) or invoking a function in AWS Lambda. You can create up to 10 triggers for each CodeCommit repository.

##### Configuring notifications for events in an AWS CodeCommit repository

[Configuring notifications for events in an AWS CodeCommit repository](https://docs.aws.amazon.com/codecommit/latest/userguide/how-to-repository-email.html)

- You can set up notification rules for a repository so that repository users receive emails about the repository event types you specify. Notifications are sent when events match the notification rule settings. You can create an Amazon SNS topic to use for notifications or use an existing one in your Amazon Web Services account

#### Security

[Using identity-based policies (IAM Policies) for CodeCommit](https://docs.aws.amazon.com/codecommit/latest/userguide/auth-and-access-control-iam-identity-based-access-control.html#identity-based-policies-example-4)

- identity-based policies demonstrate how an account administrator can attach permissions policies to IAM identities (users, groups, and roles) to grant permissions to perform operations on CodeCommit resources.

- Example

```josn
{
  "Version": "2012-10-17",
  "Statement" : [
    {
      "Effect" : "Allow",
      "Action" : [
        "codecommit:BatchGetRepositories"
      ],
      "Resource" : [
        "arn:aws:codecommit:us-east-2:111111111111:MyDestinationRepo",
        "arn:aws:codecommit:us-east-2:111111111111:MyDemo*"
      ]
    }
  ]
}
```

