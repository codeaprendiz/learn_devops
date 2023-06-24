# Building a DevOps Pipeline

[https://www.cloudskillsboost.google](https://www.cloudskillsboost.google)

[Select - DevOps Engineer, SRE Learning Path](https://www.cloudskillsboost.google/paths)

**High Level Objectives**
- Create a Git repository
- Create a simple Python application
- Test Your web application in Cloud Shell
- Define a Docker build
- Manage Docker images with Cloud Build and Container Registry
- Automate builds with triggers
- Test your build changes



**Skills**
- gcp
- devops
- python
- docker
- cloud-build
- cloud-shell
- cloud-registry





![.images/devops-pipeline.png](.images/devops-pipeline.png)




### Create a Git repository

- Use service `Source Repositories`
- Name : `devops-repo`
- Create
- Activate CloudShell
- Clone the repo

```bash
mkdir gcp-course
cd gcp-course
gcloud source repos clone devops-repo
cd devops-repo
```

### Create a simple Python application

- Create the req files and folders
- Run the following


```bash
cd ~/gcp-course/devops-repo
git add --all

git config --global user.email "you@example.com"
git config --global user.name "Your Name"

git commit -a -m "Initial Commit"

git push origin master
```

- Create Dockerfile

### Manage Docker images with Cloud Build and Container Registry

```bash
cd ~/gcp-course/devops-repo
echo $DEVSHELL_PROJECT_ID
gcloud builds submit --tag gcr.io/$DEVSHELL_PROJECT_ID/devops-image:v0.1 .
```

- Check the CloudBuild and ContainerRegistry now

- Let's deploy the container to compute

> Container Image : gcr.io/<your-project-id-here>/devops-image:v0.1

- Allow http traffic

```bash
cd ~/gcp-course/devops-repo
git add --all

git commit -am "Added Docker Support"

git push origin master
```

- Visit the public IP now


### Automate builds with triggers

- Go to the CloudBuild
- Create Trigger
- Select `devops-repo` and `.*(any branch)`
- Choose `Dockerfile` for configuration
- Create
- Manually run the trigger once
- Go to history and check the builds 
- Check the container registry for the new folder `devops-repo`
- Make changes in the `main.py` file and commit again.

```bash
cd ~/gcp-course/devops-repo
git commit -a -m "Testing Build Trigger"
git push origin master
```

###  Test your build changes

- Check the build history in CloudBuilds and copy the Image link, format should be gcr.io/qwiklabs-gcp-00-f23112/devops-repoxx34345xx.
- Create a new compute engine with the new tag and allow http traffic