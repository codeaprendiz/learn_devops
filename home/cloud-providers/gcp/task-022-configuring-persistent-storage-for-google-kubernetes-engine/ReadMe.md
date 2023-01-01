# Configuring Persistent Storage for Google Kubernetes Engine

[https://www.cloudskillsboost.google](https://www.cloudskillsboost.google)

[Select - Getting Started with Google Kubernetes Engine Course](https://www.cloudskillsboost.google)


## High Level Objectives

- Create manifests for PersistentVolumes (PVs) and PersistentVolumeClaims (PVCs) for Google Cloud persistent disks (dynamically created or existing)
- Mount Google Cloud persistent disk PVCs as volumes in Pods
- Use manifests to create StatefulSets
- Mount Google Cloud persistent disk PVCs as volumes in StatefulSets
- Verify the connection of Pods in StatefulSets to particular PVs as the Pods are stopped and restarted


### Create PVs and PVCs

```bash
# Connect to the lab GKE cluster
export my_zone=us-central1-a
export my_cluster=standard-cluster-1

# Configure tab completion for the kubectl command-line tool:
source <(kubectl completion bash)

# Configure access to your cluster for kubectl:
gcloud container clusters get-credentials $my_cluster --zone $my_zone
```

- In Cloud Shell, enter the following command to clone the repository to the lab Cloud Shell:

```bash
git clone https://github.com/GoogleCloudPlatform/training-data-analyst

# Create a soft link as a shortcut to the working directory:
ln -s ~/training-data-analyst/courses/ak8s/v1.1 ~/ak8s

# Change to the directory that contains the sample files for this lab:
cd ~/ak8s/Storage/

# To show that you currently have no PVCs, execute the following command:
kubectl get persistentvolumeclaim

# To create the PVC, execute the following command:
kubectl apply -f pvc-demo.yaml

# To show your newly created PVC, execute the following command:
kubectl get persistentvolumeclaim
```


### Mount and verify Google Cloud persistent disk PVCs in Pods

- To create the Pod with the volume, execute the following command:

```bash
kubectl apply -f pod-volume-demo.yaml

kubectl get pods


# To verify the PVC is accessible within the Pod, you must gain shell access to your Pod. To start the shell session, execute the following command:
kubectl exec -it pvc-demo-pod -- sh

# To create a simple text message as a web page in the Pod enter the following commands:
echo Test webpage in a persistent volume!>/var/www/html/index.html
chmod +x /var/www/html/index.html

# Verify the text file contains your message:
cat /var/www/html/index.html

exit
```

- Test the persistence of the PV

```bash
# Delete the pvc-demo-pod:
kubectl delete pod pvc-demo-pod

kubectl get pods

# To show your PVC, execute the following command:
kubectl get persistentvolumeclaim

# Redeploy the pvc-demo-pod:
kubectl apply -f pod-volume-demo.yaml

kubectl get pods

kubectl exec -it pvc-demo-pod -- sh

# To verify that the text file still contains your message execute the following command:
cat /var/www/html/index.html
```


### Create StatefulSets with PVCs


- Before you can use the PVC with the statefulset, you must delete the Pod that is currently using it. Execute the following command to delete the Pod:

```bash
kubectl delete pod pvc-demo-pod

kubectl delete pod pvc-demo-pod

```

- To create the StatefulSet with the volume, execute the following command:

```bash
kubectl apply -f statefulset-demo.yaml

# Use "kubectl describe" to view the details of the StatefulSet:
kubectl describe statefulset statefulset-demo

# List the Pods in the cluster:
kubectl get pods

# To list the PVCs, execute the following command:
kubectl get pvc

# Use "kubectl describe" to view the details of the first PVC in the StatefulSet:
kubectl describe pvc hello-web-disk-statefulset-demo-0
```

### Verify the persistence of Persistent Volume connections to Pods managed by StatefulSets

- To verify that the PVC is accessible within the Pod, you must gain shell access to your Pod. To start the shell session, execute the following command:

```bash
kubectl exec -it statefulset-demo-0 -- sh

# Verify that there is no index.html text file in the /var/www/html directory:
cat /var/www/html/index.html

# To create a simple text message as a web page in the Pod enter the following commands:
echo Test webpage in a persistent volume!>/var/www/html/index.html
chmod +x /var/www/html/index.html


# Verify the text file contains your message:
cat /var/www/html/index.html

exit


# Delete the Pod where you updated the file on the PVC:
kubectl delete pod statefulset-demo-0

kubectl get pods

kubectl exec -it statefulset-demo-0 -- sh

# Verify that the text file still contains your message:
cat /var/www/html/index.html
```