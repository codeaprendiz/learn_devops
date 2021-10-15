
### CodeBuild

[Create a build project (console)](https://docs.aws.amazon.com/codebuild/latest/userguide/create-project-console.html)

- We recommend that you store an environment variable with a sensitive value, such as an AWS access key ID, an AWS secret access key, or a password as a parameter in Amazon EC2 Systems Manager Parameter Store or AWS Secrets Manager.

[Docker images provided by CodeBuild](https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-available.html)

[Extending AWS CodeBuild with Custom Build Environments](https://aws.amazon.com/blogs/devops/extending-aws-codebuild-with-custom-build-environments/)

- Build environments are Docker images that include a complete file system with everything required to build and test your project.
  To use a custom build environment in a CodeBuild project, you build a container image for your platform that contains your build tools,
  push it to a Docker container registry such as Amazon EC2 Container Registry (ECR), and reference it in the project configuration. When
  building your application, CodeBuild will retrieve the Docker image from the container registry specified in the project configuration
  and use the environment to compile your source code, run your tests, and package your application.