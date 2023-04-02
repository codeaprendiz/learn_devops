


**High Level Objectives**
- Prepare the environment
- Configure Helm
- Configure and install Jenkins
- Connect to Jenkins


**Skills**
- gcp
- kubernetes
- docker
- nodejs
- pods
- jenkins
- helm
- deployments
- services


## Prepare the environment


```bash
# Set the default Compute Engine zone to us-central1-c:
gcloud config set compute/zone us-central1-c

# Clone the sample code:
git clone https://github.com/GoogleCloudPlatform/continuous-deployment-on-kubernetes.git

# Navigate to the sample code directory:
cd continuous-deployment-on-kubernetes
```


- Creating a Kubernetes cluster

```bash
gcloud container clusters create jenkins-cd \
--num-nodes 2 \
--scopes "https://www.googleapis.com/auth/projecthosting,cloud-platform"
```

- confirm cluster is running

```bash
gcloud container clusters list
```

- Get the credentials for your cluster. Kubernetes Engine uses these credentials to access your newly provisioned cluster.

```bash
gcloud container clusters get-credentials jenkins-cd

# Verify that you can access your cluster by running the following command:
kubectl cluster-info
```


## Configure Helm

- Add Helm's jenkins chart repository:

```bash
helm repo add jenkins https://charts.jenkins.io

# Update the repo to ensure you get the latest list of charts:
helm repo update
```

## Configure and install Jenkins

```bash
# Use the Helm CLI to deploy the chart with your configuration set:
helm upgrade --install -f jenkins/values.yaml myjenkins jenkins/jenkins
```

- Once that command completes ensure the Jenkins pod goes to the Running state and the container is in the READY state.

```bash
kubectl get pods
```

- Run the following command to setup port forwarding to the Jenkins UI from the Cloud Shell:

```bash
echo http://127.0.0.1:8080
kubectl --namespace default port-forward svc/myjenkins 8080:8080 >> /dev/null &
```

- Now, check that the Jenkins Service was created properly:

```bash
kubectl get svc
```

## Connect to Jenkins

- The Jenkins chart will automatically create an admin password for you. To retrieve it, run:

```bash
kubectl exec --namespace default -it svc/myjenkins -c jenkins -- /bin/cat /run/secrets/additional/chart-admin-password && echo
```