import json
import boto3

def lambda_handler(event, context):
    # Initialize the CodeBuild client
    codebuild = boto3.client('codebuild')

    # Print the raw event data
    print("Raw Event Data: for repob : 1")
    print(json.dumps(event))

    detail = event.get("detail", {})
    repository_names = detail.get("repositoryNames", [])
    source_version = detail.get("sourceReference", "")
    if source_version and repository_names:
        try:
            # If codecommit reponame is repo-a then codebuild project name will be codebuild-repo-a
            project_name = "codebuild-" + repository_names[0]
            print(f"Project Name: {project_name}")
            # Trigger the build
            response = codebuild.start_build(
                projectName=project_name,
                sourceVersion=source_version
            )
            print("CodeBuild Triggered Successfully")
            print(response)
        except Exception as e:
            print("Failed to trigger CodeBuild")
            print(str(e))
    else:
        print("No source version or project name provided, cannot trigger CodeBuild.")

    # Return a successful response
    return {
        "statusCode": 200,
        "body": json.dumps("Event processed successfully")
    }
