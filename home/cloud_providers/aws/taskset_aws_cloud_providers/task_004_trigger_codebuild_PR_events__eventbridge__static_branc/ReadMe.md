# Trigger Codebuild on PR events using EventBridge (the hardcoded branch get's triggered)

- [Trigger Codebuild on PR events using EventBridge (the hardcoded branch get's triggered)](#trigger-codebuild-on-pr-events-using-eventbridge-the-hardcoded-branch-gets-triggered)
  - [Docs Referred](#docs-referred)
  - [Existing Issue](#existing-issue)
  - [Create a repository in AWS CodeCommit](#create-a-repository-in-aws-codecommit)
  - [Create a CodeBuild project - codebuild-app](#create-a-codebuild-project---codebuild-app)
  - [Create Pipeline in CodePipeline](#create-pipeline-in-codepipeline)
  - [Commit to the repository and check if build get's triggered](#commit-to-the-repository-and-check-if-build-gets-triggered)
  - [Create EventBridge Rule](#create-eventbridge-rule)
  - [Create a PR and check if build gets triggered](#create-a-pr-and-check-if-build-gets-triggered)

## Docs Referred

[Automated Code Review on Pull Requests using AWS CodeCommit and AWS CodeBuild](https://aws.amazon.com/blogs/devops/automated-code-review-on-pull-requests-using-aws-codecommit-and-aws-codebuild/)

## Existing Issue

The codebuild always runs against the same branch which is hardcoded in the codebuild project. We want to trigger the codebuild on PR events with the source branch as the PR branch.

## Create a repository in AWS CodeCommit

```bash
mkdir tmp # tmp is added to .gitignore
cd tmp
```

```bash
# Make sure you upload your public key to AWS IAM user security credentials section
cat ~/.ssh/config            
Host git-codecommit.*.amazonaws.com
  User <Add-Your-AWS-KEY-ID-Here> 
  IdentityFile ~/.ssh/id_rsa
```

## Create a CodeBuild project - codebuild-app

Role Created automatically - `codebuild-app-codebuild-service-Role`

## Create Pipeline in CodePipeline

New Role created `AWSCodePipelineServiceRole-xx-region-y-app-pipeline`

## Commit to the repository and check if build get's triggered

## Create EventBridge Rule

Role created `Amazon_EventBridge_Invoke_CodeBuild_5492177`

Create a rule in default event bus

## Create a PR and check if build gets triggered

```bash
gco -b "feat_pr_3"
echo "test" >> ReadMe.md
```

> Note: The submitted is rule/pr_event_rule but the branch name is `ref/heads/master`
