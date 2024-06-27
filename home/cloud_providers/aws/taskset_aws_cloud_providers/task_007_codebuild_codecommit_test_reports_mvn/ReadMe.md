# AWS Codebuild Test Reports

- [AWS Codebuild Test Reports](#aws-codebuild-test-reports)
  - [Docs](#docs)
  - [Create a repository in CodeCommit : repo-d](#create-a-repository-in-codecommit--repo-d)
  - [Create a codebuild project : repo-d](#create-a-codebuild-project--repo-d)
  - [Go to the Report Groups section](#go-to-the-report-groups-section)

<br>

## Docs

[stackoverflow.com » Viewing Unit Test and Coverage Reports Generated in AWS CodeBuild](https://stackoverflow.com/questions/49664524/viewing-unit-test-and-coverage-reports-generated-in-aws-codebuild)

[docs.aws.amazon.com » View test reports](https://docs.aws.amazon.com/codebuild/latest/userguide/test-view-reports.html)

[docs.aws.amazon.com » Working with reports](https://docs.aws.amazon.com/codebuild/latest/userguide/test-report.html)

[aws.amazon.com » Test Reports with AWS CodeBuild](https://aws.amazon.com/blogs/devops/test-reports-with-aws-codebuild/)

<br>

## Create a repository in CodeCommit : repo-d

<br>

## Create a codebuild project : repo-d

Use the `buildspec.yml` file in the root of the project. Make sure you give the right path to the test reports in the `buildspec.yml` file.
The files get generated in the project in directory `target/surefire-reports`.

```yaml
reports: #New
  SurefireReports: # CodeBuild will create a report group called "SurefireReports".
    files: #Store all of the files
      - '**/*'
    base-directory: 'target/surefire-reports' # Location of the report
```

Trigger build manually using `Start build` button.

<br>

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
