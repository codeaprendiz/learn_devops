# Getting started with GKE

[https://www.cloudskillsboost.google](https://www.cloudskillsboost.google)

[Select - DevOps Engineer, SRE Learning Path](https://www.cloudskillsboost.google/paths)

**High Level Objectives**
- Check if required APIs are enabled
- Start a Kubernetes Engine Cluster 
- Run and deploy nginx container
- Expose deployment via LB
- Validate the changes by going to the external IP created.



**Skills**
- gcp
- gke
- kubernetes
- container
- nginx
- loadbalancer
- cloudshell
- external ip


## Check if the APIs are enabled

- Kubernetes Engine API
- Container Registry API

## Start a Kubernetes Engine cluster 

- Run the following commands in cloudshell

```bash
## Set the zone
export MY_ZONE=us-central1-a

## Create k8s cluster
gcloud container clusters create webfrontend --zone $MY_ZONE --num-nodes 2
```

- Once completed

```bash
kubectl get nodes
```

## Run and deploy a container

```bash
## Deploy nginx container
kubectl create deploy nginx --image=nginx:1.17.10

## Check the pods
kubectl get pods

## Expose the deployment to the internet by creating the LoadBalancer type of Service
kubectl expose deployment nginx --port 80 --type LoadBalancer

## Check the services
kubectl get services

## Note no external IP is created yet.
```

- Once the external IP is created, visit the pubic IP. You should see the nginx page.

