# Creating Google Kubernetes Engine Deployments

[https://www.cloudskillsboost.google](https://www.cloudskillsboost.google)

[Select - Getting Started with Google Kubernetes Engine Course](https://www.cloudskillsboost.google)

## High Level Objectives

- Create deployment manifests, deploy to cluster
- Trigger manual scaling up and down of Pods in deployments
- Trigger deployment rollout (rolling update to new version) and rollbacks
- Perform a Canary deployment


### Create deployment manifests and deploy to the cluster

- Connect

```bash
# set the environment variable for the zone and cluster name
export my_zone=us-central1-a
export my_cluster=standard-cluster-1

# Configure kubectl tab completion in Cloud Shell:
source <(kubectl completion bash)

# configure access to your cluster for the kubectl command-line tool, using the following command:
gcloud container clusters get-credentials $my_cluster --zone $my_zone

# In Cloud Shell enter the following command to clone the repository to the lab Cloud Shell:
git clone https://github.com/GoogleCloudPlatform/training-data-analyst

# Create a soft link as a shortcut to the working directory:
ln -s ~/training-data-analyst/courses/ak8s/v1.1 ~/ak8s

# Change to the directory that contains the sample files for this lab:
cd ~/ak8s/Deployments/

```


- Create a deployment manifest

- nginx-deployment.yaml
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: nginx:1.7.9
          ports:
            - containerPort: 80
```

- Apply

```bash
kubectl apply -f ./nginx-deployment.yaml

kubectl get deployments
```

### Manually scale up and down the number of Pods in deployments

- Navigation menu ( Navigation menu icon), click Kubernetes Engine > Workloads.
- nginx-deployment (your deployment) to open the Deployment details page.
- ACTIONS > Scale > Edit Replicas.

```bash
kubectl get deployments

# To scale the Pod back up to three replicas, execute the following command:
kubectl scale --replicas=3 deployment nginx-deployment


# View
kubectl get deployments

```

### Trigger a deployment rollout and a deployment rollback


- To update the version of nginx in the deployment, execute the following command:

```bash
kubectl set image deployment.v1.apps/nginx-deployment nginx=nginx:1.9.1 --record


# To view the rollout status, execute the following command:
kubectl rollout status deployment.v1.apps/nginx-deployment

# To verify the change, get the list of deployments:
kubectl get deployments

# View the rollout history of the deployment:
kubectl rollout history deployment nginx-deployment
```

- Trigger a deployment rollback

```bash
# To roll back to the previous version of the nginx deployment, execute the following command:
kubectl rollout undo deployments nginx-deployment

# View the updated rollout history of the deployment:
kubectl rollout history deployment nginx-deployment

# View the details of the latest deployment revision:
kubectl rollout history deployment/nginx-deployment --revision=3
```


### Define the service type in the manifest

- Define service types in the manifest

- service-nginx.yaml

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx
spec:
  type: LoadBalancer
  selector:
    app: nginx
  ports:
  - protocol: TCP
    port: 60000
    targetPort: 80
```

- In the Cloud Shell, to deploy your manifest, execute the following command:

```bash
kubectl apply -f ./service-nginx.yaml

# To view the details of the nginx service, execute the following command:
kubectl get service nginx
```

- When the external IP appears, open http://[EXTERNAL_IP]:60000/ in a new browser tab to see the server being served through network load balancing.


### Perform a canary deployment

- The manifest file nginx-canary.yaml that is provided for you deploys a single pod running a newer version of nginx than your main deployment. In this task, you create a canary deployment using this new deployment file:

- nginx-canary.yaml
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-canary
  labels:
    app: nginx
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
        track: canary
        Version: 1.9.1
    spec:
      containers:
      - name: nginx
        image: nginx:1.9.1
        ports:
        - containerPort: 80
```


```bash
# Create the canary deployment based on the configuration file:
kubectl apply -f nginx-canary.yaml

# When the deployment is complete, verify that both the nginx and the nginx-canary deployments are present:
kubectl get deployments

# Switch back to the Cloud Shell and scale down the primary deployment to 0 replicas:
kubectl scale --replicas=0 deployment nginx-deployment

# Verify that the only running replica is now the Canary deployment:
kubectl get deployments
```


- Session affinity

- This potential to switch between different versions may cause problems if there are significant changes in functionality in the canary release. To prevent this you can set the sessionAffinity field to ClientIP in the specification of the service if you need a client's first request to determine which Pod will be used for all subsequent connections.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx
spec:
  type: LoadBalancer
  sessionAffinity: ClientIP
  selector:
    app: nginx
  ports:
  - protocol: TCP
    port: 60000
    targetPort: 80
```

