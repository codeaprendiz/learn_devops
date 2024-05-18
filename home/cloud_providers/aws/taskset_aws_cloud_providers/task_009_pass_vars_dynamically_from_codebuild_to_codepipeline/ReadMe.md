# Pass variables dynamically from CodePipeline to CodeBuild

[https://docs.aws.amazon.com/codepipeline/latest/userguide/tutorials-pipeline-variables.html](https://docs.aws.amazon.com/codepipeline/latest/userguide/tutorials-pipeline-variables.html)

```bash
aws codepipeline start-pipeline-execution --name MyVariablesPipeline --variables name=timeout,value=2000
```
