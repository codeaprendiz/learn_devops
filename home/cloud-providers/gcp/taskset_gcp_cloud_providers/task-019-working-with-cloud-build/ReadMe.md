# Working with Cloud Build

[https://www.cloudskillsboost.google](https://www.cloudskillsboost.google)

[Select - Getting Started with Google Kubernetes Engine Course](https://www.cloudskillsboost.google)

**High Level Objectives**
- Confirm that needed APIs are enabled
- Building containers with DockerFile and Cloud Build
- Building containers with a build configuration file and Cloud Build
- Building and testing containers with a build configuration file and Cloud Build

**Skills**
- gcp
- cloud-build
- cloud-shell
- cloud-shell-editor
- containers
- docker
- dockerfile

### Confirm that needed APIs are enabled

- Cloud Build
- Container Registry

### Building containers with DockerFile and Cloud Build

```bash
# Create file
touch quickstart.sh
```

```shell
#!/bin/sh
echo "Hello, world! The time is $(date)."
```

- Dockerfile

```Dockerfile
FROM alpine
COPY quickstart.sh /
CMD ["/quickstart.sh"]
```

```bash
chmod +x quickstart.sh
```

- In Cloud Shell, run the following command to build the Docker container image in Cloud Build:

```bash
gcloud builds submit --tag gcr.io/${GOOGLE_CLOUD_PROJECT}/quickstart-image .
```

- In the Google Cloud Console, on the Navigation menu (Navigation menu icon), click Container Registry > Images.

### Building containers with a build configuration file and Cloud Build

- In Cloud Shell enter the following command to clone the repository to the lab Cloud Shell:

```bash
git clone https://github.com/GoogleCloudPlatform/training-data-analyst

# Create a soft link as a shortcut to the working directory:
ln -s ~/training-data-analyst/courses/ak8s/v1.1 ~/ak8s

# Change to the directory that contains the sample files for this lab:
cd ~/ak8s/Cloud_Build/a

cat cloudbuild.yaml

# In Cloud Shell, execute the following command to start a Cloud Build using cloudbuild.yaml as the build configuration file:
gcloud builds submit --config cloudbuild.yaml .
```

- Container Registry > Images and then click quickstart-image.
- Navigation menu (Navigation menu icon), click Cloud Build > History.

### Building and testing containers with a build configuration file and Cloud Build


- In Cloud Shell, change to the directory that contains the sample files for this lab:

```bash
cd ~/ak8s/Cloud_Build/b

# In Cloud Shell, execute the following command to view the contents of cloudbuild.yaml
cat cloudbuild.yaml


# In Cloud Shell, execute the following command to start a Cloud Build using cloudbuild.yaml as the build configuration file:
gcloud builds submit --config cloudbuild.yaml .

# Confirm that your command shell knows that the build failed:
echo $?


```