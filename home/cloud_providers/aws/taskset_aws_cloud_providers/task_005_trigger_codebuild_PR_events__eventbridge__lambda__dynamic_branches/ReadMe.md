# Trigger codebuild PR events using EventBridge (Lambda, Dynamic Branches)

- [Trigger codebuild PR events using EventBridge (Lambda, Dynamic Branches)](#trigger-codebuild-pr-events-using-eventbridge-lambda-dynamic-branches)
  - [Objective](#objective)
  - [Reasearch Links and docs with relevant information](#reasearch-links-and-docs-with-relevant-information)
  - [Create repo-a in Codecommit](#create-repo-a-in-codecommit)
  - [Create repo-b in Codecommit](#create-repo-b-in-codecommit)
  - [Create a codebuild project for repo-a - codebuild-repo-a](#create-a-codebuild-project-for-repo-a---codebuild-repo-a)
  - [Create a codebuild project for repo-b - codebuild-repo-b](#create-a-codebuild-project-for-repo-b---codebuild-repo-b)
  - [Create codepipeline for repo-a - codepipeline-repo-a](#create-codepipeline-for-repo-a---codepipeline-repo-a)
  - [Create codepipeline for repo-b - codepipeline-repo-b](#create-codepipeline-for-repo-b---codepipeline-repo-b)
  - [Create a lambda function to trigger respetive codebuilds](#create-a-lambda-function-to-trigger-respetive-codebuilds)
  - [Create a rule for repo-a in EventBridge to trigger the lambda function](#create-a-rule-for-repo-a-in-eventbridge-to-trigger-the-lambda-function)
  - [Create PR for repo-a](#create-pr-for-repo-a)
    - [Check logs for lambda in cloudwatch when PR is created](#check-logs-for-lambda-in-cloudwatch-when-pr-is-created)
    - [Logs in codebuild-repo-a](#logs-in-codebuild-repo-a)
  - [Create a rule for repo-b in EventBridge to trigger the lambda function](#create-a-rule-for-repo-b-in-eventbridge-to-trigger-the-lambda-function)
  - [Create PR for repo-b](#create-pr-for-repo-b)

## Objective

- The PR in codebuild get's raised always with the branch hardcoded in build project.
- We want to trigger codebuild with PR branches which requires involvement of lambda function.

## Reasearch Links and docs with relevant information

[aws . codebuild . start-build](https://docs.aws.amazon.com/cli/latest/reference/codebuild/start-build.html)

You can start codebuild using commands dynamically. You can use the same command in lambda function to trigger the codebuild project.

[docs.aws.amazon.com » Monitoring CodeCommit events in Amazon EventBridge and Amazon CloudWatch Events](https://docs.aws.amazon.com/codecommit/latest/userguide/monitoring-events.html#pullRequestStatusChanged)

You can get the payload from the event and use it in the lambda function for testing.

[stackoverflow.com » Creating Lambda Function to Trigger Codebuild Project using Nodejs](https://stackoverflow.com/questions/56568921/creating-lambda-function-to-trigger-codebuild-project-using-nodejs)

Trigger lambda using nodejs

[docs.aws.amazon.com » Environment variables in build environments](https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-env-vars.html)

You can use environment variables in the buildspec.yaml file to get the source branch and use it in the buildspec.yaml file

## Create repo-a in Codecommit

## Create repo-b in Codecommit

## Create a codebuild project for repo-a - codebuild-repo-a

## Create a codebuild project for repo-b - codebuild-repo-b

## Create codepipeline for repo-a - codepipeline-repo-a

## Create codepipeline for repo-b - codepipeline-repo-b

## Create a lambda function to trigger respetive codebuilds

Copy the code `lambda.py` to the lambda function

Click on deploy to deploy the lambda function (your code get updated in the function)

Click on Test and it should ask you to create a sample event using which we can test the lambda function

Get the event from [docs.aws.amazon.com » Monitoring CodeCommit events in Amazon EventBridge and Amazon CloudWatch Events](https://docs.aws.amazon.com/codecommit/latest/userguide/monitoring-events.html#pullRequestStatusChanged) and paste it in the event

Click on Test

You will get error

Add the permissions w.r.t to lambda_service_role (`codebuild-dynamic-communicator-role-py375219`) to trigger the codebuild project

```json
		{
            "Effect": "Allow",
            "Action": "codebuild:StartBuild",
            "Resource": "arn:aws:codebuild:xx-region-y:xxxxxxxxxxxxxx:project/*"
        }
```

## Create a rule for repo-a in EventBridge to trigger the lambda function

Select default event bus and create rule

Give the arn of codecommit repo-a as source with events as PR_STATUS_CHANGE

Select the target as lambda function

Create rule

## Create PR for repo-a

Add a `buildspec.yaml` file in repo-a to know the latest commit changes and update the codebuild-project-a

```bash
$ gst
On branch feat_pr_from_repo_a
Changes not staged for commit:
        deleted:    repo_a__commit_4
Untracked files:
        repo_a__commit_5
```

Create the pull request

### Check logs for lambda in cloudwatch when PR is created

### Logs in codebuild-repo-a

Add commits to PR

```bash
$ gst
On branch feat_pr_from_repo_a
Changes not staged for commit:
        deleted:    repo_a__commit_5

Untracked files:
        repo_a__commit_6

# Push the changes as new commit
```

See the build is triggered against PR branch

Latest commit information is available in build logs

```bash
[Container] 2024/04/27 04:19:26.605628 Running command ls -ltrh
total 4.0K
-rw-r--r-- 1 root root   0 Apr 27 04:19 repo_a__commit_6
-rw-r--r-- 1 root root 273 Apr 27 04:19 buildspec.yaml
```

> Note: The branch name is refs/heads/feat_pr_from_repo_a

## Create a rule for repo-b in EventBridge to trigger the lambda function

## Create PR for repo-b

```bash
$ git branch --show-current
feat_pr_from_repo_b_branch1

$ gst                      
On branch feat_pr_from_repo_b_branch1
Changes not staged for commit:
        deleted:    repo_a__test5
Untracked files:
        repo_a__test6
# commit the changes
```

Logs of codebuild-repo-b

```bash
[Container] 2024/04/27 04:38:28.453263 Running command ls -ltrh
total 4.0K
-rw-r--r-- 1 root root   0 Apr 27 04:38 repo_a__test6
-rw-r--r-- 1 root root 273 Apr 27 04:38 buildspec.yaml
```

> Note: The branch name is refs/heads/feat_pr_from_repo_b_branch1 and has latest commit
