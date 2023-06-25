# Managing deployments using Kubernetes Engine


[https://www.cloudskillsboost.google](https://www.cloudskillsboost.google)

[Select - Quest -  DevOps Essentials](https://www.cloudskillsboost.google/paths)


**High Level Objectives**
- Learn about deployment object
- Create a deployment
- Rolling Update
- Canary deployments
- Blue/Green deployments



**Skills**
- gcp
- kubernetes
- canary deployments
- blue green deployment



## Set the zone

```bash
gcloud config set compute/zone us-east5-b
```

## Get sample code for this lab

```bash
gsutil -m cp -r gs://spls/gsp053/orchestrate-with-kubernetes .
cd orchestrate-with-kubernetes/kubernetes

# Create a cluster with 3 nodes (this will take a few minutes to complete):
gcloud container clusters create bootcamp \
  --machine-type e2-small \
  --num-nodes 3 \
  --scopes "https://www.googleapis.com/auth/projecthosting,storage-rw"
```


## Learn about the deployment object

```bash
kubectl explain deployment

# We can also see all of the fields using the --recursive option:
kubectl explain deployment --recursive

# We can also see the documentation for a specific field:
kubectl explain deployment.spec.replicas
```

## Create a deployment

```bash 
# change to auth:1.0.0
kubectl create -f deployments/auth.yaml

kubectl get deployments

# When you create a Deployment in Kubernetes, it automatically creates a 
#ReplicaSet as well. The ReplicaSet is responsible for maintaining a 
#specified number of replicas of the Pods defined in the Deployment.

# The Deployment object provides declarative updates for Pods and 
# ReplicaSets, and manages the creation and scaling of ReplicaSets 
# based on the user's desired state. When a Deployment is updated with a 
# new desired state, it creates a new ReplicaSet and gradually scales it 
# up while scaling down the old ReplicaSet, ensuring that the transition 
# between the old and new state is smooth and does not cause downtime.
kubectl get replicasets

kubectl get pods

kubectl create -f services/auth.yaml

# Now, do the same thing to create and expose the hello deployment:
kubectl create -f deployments/hello.yaml
kubectl create -f services/hello.yaml


# And one more time to create and expose the frontend deployment:
kubectl create secret generic tls-certs --from-file tls/
kubectl create configmap nginx-frontend-conf --from-file=nginx/frontend.conf
kubectl create -f deployments/frontend.yaml
kubectl create -f services/frontend.yaml


kubectl get secret tls-certs -o yaml
``` 

- Interact with the frontend by grabbing its external IP and then curling to it:

```bash
kubectl get services frontend

curl -ks https://<EXTERNAL-IP>

# OR
curl -ks https://`kubectl get svc frontend -o=jsonpath="{.status.loadBalancer.ingress[0].ip}"`
```

- Scale a deployment

```bash
kubectl explain deployment.spec.replicas

kubectl scale deployment hello --replicas=5

# verify
kubectl get pods | grep hello- | wc -l

# scale down
kubectl scale deployment hello --replicas=3

# Again, verify that you have the correct number of Pods:
kubectl get pods | grep hello- | wc -l
```

## Rolling update

![img.png](.images/rolling-update.png)

```bash
kubectl edit deployment hello

# change image to hello:2.0.0

# See the new ReplicaSet that Kubernetes creates.:
kubectl get replicaset

# You can also see a new entry in the rollout history:
kubectl rollout history deployment hello
```

- Pause a rolling update
- If you detect problems with a running rollout, pause it to stop the update.

```bash
kubectl rollout pause deployment/hello

# Verify the current state of the rollout:
kubectl rollout status deployment/hello

# You can also verify this on the Pods directly:
kubectl get pods -o jsonpath --template='{range .items[*]}{.metadata.name}{"\t"}{"\t"}{.spec.containers[0].image}{"\n"}{end}'
```

- Resume a rolling update

```bash
kubectl rollout resume deployment/hello

# When the rollout is complete, you should see the following when running the status command:
kubectl rollout status deployment/hello
```

- Rollback an update

```bash
kubectl rollout undo deployment/hello

# Verify the roll back in the history:
kubectl rollout history deployment hello

# Finally, verify that all the Pods have rolled back to their previous versions:
kubectl get pods -o jsonpath --template='{range .items[*]}{.metadata.name}{"\t"}{"\t"}{.spec.containers[0].image}{"\n"}{end}'
```

## Canary deployments

![img.png](.images/canary-deployments.png)

```bash
kubectl create -f deployments/hello-canary.yaml

# On the hello service, the selector uses the app:hello selector which will match pods in both the prod 
# deployment and canary deployment. However, because the canary deployment has a fewer number of pods, 
# it will be visible to fewer users

# You can verify the hello version being served by the request:
curl -ks https://`kubectl get svc frontend -o=jsonpath="{.status.loadBalancer.ingress[0].ip}"`/version

```

- Canary deployments in production - session affinity

- In this lab, each request sent to the Nginx service had a chance to be served by the canary 
  deployment. But what if you wanted to ensure that a user didn't get served by 
  the Canary deployment?
- You can do this by creating a service with session affinity. This way the same user will 
  always be served from the same version. In the example below the service is the same as before, 
  but a new sessionAffinity field has been added, and set to ClientIP. All clients 
  with the same IP address will have their requests sent to the same version of the hello application.


```yaml
kind: Service
apiVersion: v1
metadata:
  name: "hello"
spec:
  sessionAffinity: ClientIP
  selector:
    app: "hello"
  ports:
    - protocol: "TCP"
      port: 80
      targetPort: 80
```

## Blue-green deployments

![img.png](.images/blue-green-deployments.png)


```bash
# A major downside of blue-green deployments is that you will need to have at least 2x the 
# resources in your cluster necessary to host your application
kubectl apply -f services/hello-blue.yaml


kubectl create -f deployments/hello-green.yaml

# Once you have a green deployment and it has started up properly, verify that the current version of 1.0.0 is still being used:
curl -ks https://`kubectl get svc frontend -o=jsonpath="{.status.loadBalancer.ingress[0].ip}"`/version

# Now, update the service to point to the new version:
kubectl apply -f services/hello-green.yaml

# When the service is updated, the "green" deployment will be used immediately. You can now verify that the new version is always being used:
curl -ks https://`kubectl get svc frontend -o=jsonpath="{.status.loadBalancer.ingress[0].ip}"`/version

```

- Blue-Green rollback

```bash
# While the "blue" deployment is still running, just update the service back to the old version:
kubectl apply -f services/hello-blue.yaml

# Once you have updated the service, your rollback will have been successful. 
# Again, verify that the right version is now being used:
curl -ks https://`kubectl get svc frontend -o=jsonpath="{.status.loadBalancer.ingress[0].ip}"`/version
```