# Continuous Delivery with Jenkins in Kubernetes Engine

**High Level Objectives**
- 


**Skills**
- gcp


## Download the source code

- run the following command to set your zone us-east1-c:

```bash
gcloud config set compute/zone us-east1-c

# Then copy the lab's sample code:
gsutil cp gs://spls/gsp051/continuous-deployment-on-kubernetes.zip .

unzip continuous-deployment-on-kubernetes.zip

cd continuous-deployment-on-kubernetes
```

## Provisioning Jenkins

```bash
# command to provision a Kubernetes cluster:
gcloud container clusters create jenkins-cd \
--num-nodes 2 \
--machine-type n1-standard-2 \
--scopes "https://www.googleapis.com/auth/source.read_write,cloud-platform"


# confirm that your cluster is running by executing the following command:
gcloud container clusters list

# Now, get the credentials for your cluster:
gcloud container clusters get-credentials jenkins-cd

# confirm that you can connect to it by running the following command
kubectl cluster-info
```


## Setup Helm

```bash
# Add Helm's stable chart repo:
helm repo add jenkins https://charts.jenkins.io

# Ensure the repo is up to date:
helm repo update

```

## Configure and Install Jenkins

values file to automatically configure your Kubernetes Cloud and add the following necessary plugins:

- Kubernetes:latest
- Workflow-multibranch:latest
- Git:latest
- Configuration-as-code:latest
- Google-oauth-plugin:latest
- Google-source-plugin:latest
- Google-storage-plugin:latest

```bash
# Use the Helm CLI to deploy the chart with your configuration settings:
helm install cd jenkins/jenkins -f jenkins/values.yaml --wait

# Check pods
kubectl get pods

# Configure the Jenkins service account to be able to deploy to the cluster:
kubectl create clusterrolebinding jenkins-deploy --clusterrole=cluster-admin --serviceaccount=default:cd-jenkins

# Run the following command to setup port forwarding to the Jenkins UI from the Cloud Shell:
export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/component=jenkins-master" -l "app.kubernetes.io/instance=cd" -o jsonpath="{.items[0].metadata.name}")
kubectl port-forward $POD_NAME 8080:8080 >> /dev/null &

# check that the Jenkins Service was created properly:
kubectl get svc

```

## Connect to Jenkins

```bash
# Jenkins chart will automatically create an admin password for you. To retrieve it, run:
printf $(kubectl get secret cd-jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode);echo

# If asked, log in with username admin and your auto-generated password.
```

## Understanding the Application


## Deploying the Application

You will deploy the application into two different environments:
- Production: The live site that your users access.
- Canary: A smaller-capacity site that receives only a percentage of your user traffic. Use this environment to validate 
  your software with live traffic before it's released to all of your users.


```bash
cd sample-app

## Create the Kubernetes namespace to logically isolate the deployment:
kubectl create ns production

# Create the production and canary deployments, and the services using the kubectl apply commands:
kubectl apply -f k8s/production -n production

kubectl apply -f k8s/canary -n production

kubectl apply -f k8s/services -n production

# Scale up the production environment frontends by running the following command
kubectl scale deployment gceme-frontend-production -n production --replicas 4

# Now confirm that you have 5 pods running for the frontend, 4 for production traffic and 1 for canary releases 
kubectl get pods -n production -l app=gceme -l role=frontend

# Also confirm that you have 2 pods for the backend, 1 for production and 1 for canary:
kubectl get pods -n production -l app=gceme -l role=backend

#Retrieve the external IP for the production services:
kubectl get service gceme-frontend -n production

# Now, store the frontend service load balancer IP in an environment variable for use later:
export FRONTEND_SERVICE_IP=$(kubectl get -o jsonpath="{.status.loadBalancer.ingress[0].ip}" --namespace=production services gceme-frontend)

# Confirm that both services are working by opening the frontend external IP address in your browser.

# Check the version output of the service by running the following command (it should read 1.0.0):
curl http://$FRONTEND_SERVICE_IP/version
```

## Creating the Jenkins Pipeline

- Creating the Jenkins Pipeline

```bash
gcloud source repos create default

git init

# Initialize the sample-app directory as its own Git repository:
git config credential.helper gcloud.sh

# Run the following command
git remote add origin https://source.developers.google.com/p/$DEVSHELL_PROJECT_ID/r/default

# Set the username and email address for your Git commits. 
# Replace [EMAIL_ADDRESS] with your Git email address and [USERNAME] with your Git username:
git config --global user.email "[EMAIL_ADDRESS]"

git config --global user.name "[USERNAME]"

git add .

git commit -m "Initial commit"

git push origin master
```


- Adding your service account credentials

- In the Jenkins user interface, click Manage Jenkins in the left navigation then click Manage Credentials
  , Click Global credentials (unrestricted).

- Configure Jenkins Cloud for Kubernetes

- Creating the Jenkins job

```bash

# https://source.developers.google.com/p/[PROJECT_ID]/r/default
```


## Creating the development environment

```bash
# Create a development branch and push it to the Git server:
git checkout -b new-feature



```

- Modifying the pipeline definition
- Use the Jenkinsfile
  - Add your PROJECT_ID to the REPLACE_WITH_YOUR_PROJECT_ID value in the Jenkinsfile.
  - CLUSTER_ZONE to to us-east1-c
- Change the two instances of <div class="card blue"> with <div class="card orange"> in the html.go file.
- main.go change the version to 2.0.0


## Kick off Deployment


- Commit and push your changes

```bash
git add Jenkinsfile html.go main.go

git commit -m "Version 2.0.0"

git push origin new-feature
```

- Once that's all taken care of, start the proxy in the background:

```bash
kubectl proxy &

# If it stalls, press Ctrl + C to exit out. Verify that your application is accessible by 
# sending a request to localhost and letting kubectl proxy forward it to your service
curl \
http://localhost:8001/api/v1/namespaces/new-feature/services/gceme-frontend:80/proxy/version

# You should see it respond with 2.0.0, which is the version that is now running.

```

## Deploying a canary release

- Create a canary branch and push it to the Git server:

```bash
git checkout -b canary

git push origin canary

```

- In Jenkins, you should see the canary pipeline has kicked off. Once complete, 
  you can check the service URL to ensure that some of the traffic is being served by your new version. 
  You should see about 1 in 5 requests (in no particular order) returning version 2.0.0.

```bash
export FRONTEND_SERVICE_IP=$(kubectl get -o \
jsonpath="{.status.loadBalancer.ingress[0].ip}" --namespace=production services gceme-frontend)


while true; do curl http://$FRONTEND_SERVICE_IP/version; sleep 1; done
# Output
1.0.0
1.0.0
1.0.0
2.0.0
1.0.0
1.0.0
1.0.0
```

## Deploying to production

- Create a canary branch and push it to the Git server:

```bash
git checkout master

git merge canary

git push origin master

# Trigger master job
export FRONTEND_SERVICE_IP=$(kubectl get -o \
jsonpath="{.status.loadBalancer.ingress[0].ip}" --namespace=production services gceme-frontend)

# All should be 2.0
while true; do curl http://$FRONTEND_SERVICE_IP/version; sleep 1; done
# Output
2.0.0
2.0.0
2.0.0
2.0.0
2.0.0
2.0.0

# 
kubectl get service gceme-frontend -n production
```