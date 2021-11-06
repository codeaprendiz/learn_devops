# Resource Access Manager

[What is AWS Resource Access Manager?](https://docs.aws.amazon.com/ram/latest/userguide/what-is.html)

- AWS Resource Access Manager (AWS RAM) helps you securely share the AWS resources that you create in one AWS account with other AWS accounts
- If you have multiple AWS accounts, you can create a resource once and use AWS RAM to make that resource accessible to those other accounts.
- If your account is managed by AWS Organizations, then you can share resources with all of the other accounts in the organization, or only those contained by one or more specified organizational units (OUs).
- You can also share with specific AWS accounts by account ID, regardless of whether the account is part of an organization.

## Sharing your AWS resources

[Sharing your AWS resources](https://docs.aws.amazon.com/ram/latest/userguide/getting-started-sharing.html)

- Enable resource sharing within AWS Organizations (optional)
```bash
aws ram enable-sharing-with-aws-organization
```