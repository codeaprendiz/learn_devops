# AWS Codebuild Test Reports

- [AWS Codebuild Test Reports](#aws-codebuild-test-reports)
  - [Docs](#docs)
  - [Create a repository in CodeCommit : repo-d](#create-a-repository-in-codecommit--repo-d)
  - [Create a codebuild project : repo-d](#create-a-codebuild-project--repo-d)
  - [Go to the Report Groups section](#go-to-the-report-groups-section)

## Docs

[stackoverflow.com » Viewing Unit Test and Coverage Reports Generated in AWS CodeBuild](https://stackoverflow.com/questions/49664524/viewing-unit-test-and-coverage-reports-generated-in-aws-codebuild)

[docs.aws.amazon.com » View test reports](https://docs.aws.amazon.com/codebuild/latest/userguide/test-view-reports.html)

[docs.aws.amazon.com » Working with reports](https://docs.aws.amazon.com/codebuild/latest/userguide/test-report.html)

[aws.amazon.com » Test Reports with AWS CodeBuild](https://aws.amazon.com/blogs/devops/test-reports-with-aws-codebuild/)

## Create a repository in CodeCommit : repo-d

## Create a codebuild project : repo-d

Use the `buildspec.yml` file in the root of the project.

Trigger build manually using `Start build` button.

## Go to the Report Groups section

You should see `repo-d-SurefireReports` group.

[aws cli » list-report-groups](https://docs.aws.amazon.com/cli/latest/reference/codebuild/list-report-groups.html)

[stackoverflow » turn off pager](https://stackoverflow.com/questions/60122188/how-to-turn-off-the-pager-for-aws-cli-return-value)

```bash
AWS_PAGER="" aws codebuild list-report-groups 
```

Get the reports

```bash
AWS_PAGER="" aws codebuild list-reports-for-report-group --report-group-arn <>
```
