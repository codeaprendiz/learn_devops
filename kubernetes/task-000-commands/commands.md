# kubectl

- [apply-----------------------------------------To apply the yaml resources.yaml](#apply)
- [config](#config)
    - [current-context---------------------------To display the current context](#current-context)
    - [view--------------------------------------To display merged kubeconfig settings or a specified kubeconfig file.](#view)
    - [set-credentials---------------------------To set a user 'dave' entry in kubeconfig](#set-credentials)
- [cordon----------------------------------------Mark node as unschedulable.](#cordon)
- [create----------------------------------------To create a namespace dev-ns](#create)
    - [--dry-run---------------------------------Generate Deployment YAML file (-o yaml). Don't create it(--dry-run) with 4 Replicas (--replicas=4)](#--dry-run)
    - [-f----------------------------------------Create a pod using the data in pod.json.](#-f)
    - [--from-file----------------------------Create a configmap based on aspecified literal value](#)    
    - [--from-literal----------------------------Create a configmap based on aspecified literal value](#--from-literal)
    - [--image-----------------------------------Create a deployment using nginx image, Create a new ClusterIP service named my-cs](#--image)
    - [-o yaml-----------------------------------Generate Deployment YAML file (-o yaml). Don't create it(--dry-run)](#-o-yaml)
- [delete----------------------------------------To delete deployment with name 'www' from default namespace](#delete)
    - [-f----------------------------------------Delete a pod using the type and name specified in pod.json.](#-f)
    - [--force-----------------------------------To immediately remove resources from API and bypass graceful deletion.](#--force)
    - [--grace-period----------------------------To delete a pod with zero grace period, delete immediately](#--grace-period)
    - [--namespace-------------------------------To delete pod web-pack in namespace frontend](#--namespace)
- [describe](#describe)
    - [pod---------------------------------------To describe a pod with name 'traefik-nb8p2' in ingress namespace](#pod)
    - [node--------------------------------------To get the Taints on master node](#node)
- [drain](#drain)
    - [node--------------------------------------Drain node in preparation for maintenance](#node)
- [edit------------------------------------------To change the image of nginx deployment to 1.9.0](#edit)
- [exec------------------------------------------To list all the keys stored by kubernetes](#exec) 
- [explain](#explain)
    [--recursive----------------------------------------------------------------Print the fields of fields](#--recursive)
- [expose----------------------------------------Create a Service named redis-service of type ClusterIP to expose pod redis on port 6379](#expose)
- [get](#get)
    - [events------------------------------------To list all events you can use](#events)
    - [--help------------------------------------To get help!](#--help)
    - [namespace---------------------------------To get all the namespace resources](#namespace)
        - [--no-headers--------------------------To get all the pods in given namespace and do not give header columns](#--no-headers)
    - [nodes--------------------------------------To get all the nodes in kubernetes cluster](#nodes)
        - [--show-label---------------------------To show the labels present on the nodes](#--show-labels)      
    - [pod---------------------------------------To get all the pod resources in namespace ingress](#pod)
        - [--all-namespaces----------------------To view all the pods from all namespaces](#--all-namespaces)
        - [-n------------------------------------To view the pods in kube-system namespace](#-n)
        - [-o wide-------------------------------To check which pod is present in which particular node](#-o-wide)
        - [--selector or -l ---------------------You can filter the list using a label selector and the --selector flag](#--selector-or-l)
        - [--show-labels-------------------------To list the existing pods and also show the labels in default namespace](#--show-labels)
- [label-----------------------------------------Update the label on node node-1 with key 'size' and value 'Large'](#label)
- [logs](#logs)
    - [since-------------------------------------To get the output of logs of a given resource like pod since last one hour](#since)
    - [-f----------------------------------------Begin streaming the logs of the ruby container in pod web-1](#-f)
- [replace---------------------------------------Replace a pod using the data in pod.json.](#replace)
- [rollout](#rollout)
    - [history-----------------------------------View previous rollout revisions and configurations.](#history)
    - [status------------------------------------Check the rollout status of deployment](#status)
    - [undo--------------------------------------Rollback to a previous rollout](#undo)
- [run](#run)
    - [--dry-run---------------------------------To NOT create nginx pod, only generate yaml ](#--dry-run)
    - [--image-----------------------------------To create NGINX pod](#--image)
    - [-n----------------------------------------To create a pod with image redis and name redis in namespace kube-system](#-n)
    - [-o yaml-----------------------------------To create nginx pod and generate the yaml](#-o-yaml)
    - [-p----------------------------------------Create a new pod called custom-nginx using the nginx image and expose it on container port 8080](#-p)
- [scale-----------------------------------------To scale a deployment named httpd-frontend to 3 replicas](#scale)
- [set-------------------------------------------Set a deployment's nginx container image to nginx:1.9.1](#set)
- [taint-----------------------------------------Update node 'node1' with a taint with key 'app' and value 'blue' and effect 'NoSchedule'.](#taint)
- [uncordon--------------------------------------Mark node as schedulable.](#uncordon)

```bash         

controlplane $ kubectl drain node01 --ignore-daemonsets

kubectl get all --all-namespaces -o yaml > all-deploy-services.yaml
```


## apply
[apply](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#apply)

- To apply the yaml resources.yaml
```bash
$ kubectl apply -f resources.yaml
deployment.apps/www created
service/www created
kubectl create serviceaccount <account-name>
```

## config
[config](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#config)

### current-context

- To display the current context
```bash
$ kubectl config current-context                                                  
docker-desktop
```


### view
- To display merged kubeconfig settings or a specified kubeconfig file.
```bash
$ kubectl config view --raw -o json | jq -r '.clusters[].cluster."server"'
https://kubernetes.docker.internal:6443
```


### set-credentials
- To set a user 'dave' entry in kubeconfig

```bash
kubectl config set-credentials dave --client-key=$PWD/dave.key --embed-certs=true
```

## cordon
[cordon](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#cordon)

- Mark node as unschedulable.

```bash
$ kubectl cordon node-01
```


## create
[create](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#create)

- To create a namespace dev-ns
```bash
kubectl create namespace dev-ns
```

### --dry-run
- Generate Deployment YAML file (-o yaml). Don't create it(--dry-run) with 4 Replicas (--replicas=4)
```bash
kubectl create deployment --image=nginx nginx --dry-run=client --replicas=4 -o yaml > nginx-deployment.yaml
```

### -f
- Create a pod using the data in pod.json.
```bash
kubectl create -f ./pod.json
```

### --from-file
- Create a configmap based on a file 
```bash
kubectl create configmap \
  app-config --from-file=app_config.properties
```


### --from-literal
- Create a configmap based on a specified literal value. 
```bash
kubectl create configmap \
  app-config --from-literal=APP_NAME=test-app \
             --from-literal=APP_ENV=dev
```

### --image
- Create a deployment using nginx image
```bash
kubectl create deployment --image=nginx nginx
```
- Create a new ClusterIP service named my-cs
```bash
kubectl create service clusterip my-cs --tcp=5678:8080
```

- Create a Service named nginx of type NodePort to expose pod nginx's port 80 on port 30080 on the nodes. 
  This will automatically use the pod's labels as selectors, but you cannot specify the node port. You have to generate a definition file and then add the node port in manually before creating the service with the pod
```bash
kubectl create service nodeport nginx --tcp=80:80 --node-port=30080 --dry-run=client -o yaml
```
### -o yaml 
- Generate Deployment YAML file (-o yaml). Don't create it(--dry-run)
```bash
kubectl create deployment --image=nginx nginx --dry-run=client -o yaml
```



## delete
[delete](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#delete)

- To delete deployment with name 'www' from default namespace
```bash
$ kubectl delete deployment www
deployment.extensions "www" deleted
```

### -f
- Delete a pod using the type and name specified in pod.json.
```bash
kubectl delete -f ./pod.json
```

### --force
- To immediately remove resources from API and bypass graceful deletion.
```bash
kubectl delete pod <PODNAME> --grace-period=0 --force --namespace <NAMESPACE>
```

### --grace-period
- To delete a pod with zero grace period, delete immediately. It is the period of time in seconds given to the resource to terminate gracefully.
```bash
kubectl delete pod <PODNAME> --grace-period=0 --force --namespace <NAMESPACE>
```

### --namespace
- To delete pod web-pack in namespace frontend
```bash
kubectl delete pod web-pack --namespace frontend
```

## describe
[describe](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#describe)
### pod 

- To describe a pod with name 'traefik-nb8p2' in ingress namespace
```bash
$ kubectl describe pod traefik-nb8p2 -n ingress
Name:           traefik-nb8p2
Namespace:      ingress
.
.
.
Events:          <none>
```

### node

- To get the Taints on master node
```bash
$ kubectl describe nodes master | grep -i taints
```


## drain
[drain](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#drain)

### node 

- Drain node in preparation for maintenance. The given node will be marked unschedulable to prevent new pods from arriving.
- drain waits for graceful termination. You should not operate on the machine until the command completes.
- When you are ready to put the node back into service, use kubectl uncordon, which will make the node schedulable again.

```bash
$ kubectl drain node-01
```



## edit
[edit](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#edit)
- To change the image of nginx deployment to 1.9.0
```bash
$ kubectl create deployment my-dep --image=nginx
deployment.apps/my-dep created
$ kubectl describe deployment my-dep | grep -i image
    Image:        nginx
$ kubectl edit deployment my-dep                    
deployment.apps/my-dep edited
$ kubectl describe deployment my-dep | grep -i image
    Image:        nginx:1.9.0
```


## exec
[exec](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#exec)
- To list all the keys stored by kubernetes
```bash
kubectl exec etcd-master -n kube-system etcdctl get / --prefix -keys-only
```

## explain
[explain](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#explain)
List the fields for supported resources
### --recursive

- Print the fields of fields
```bash
$ kubectl explain pod --recursive | less
```


## expose
[expose](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#expose)

- Create a Service named redis-service of type ClusterIP to expose pod redis on port 6379. Note dry run won't actually create it. 
  We will get the yaml file using the following command.
```bash
kubectl expose pod redis --port=6379 --name redis-service --dry-run=client -o yaml
```

- Create a service for an nginx deployment, which serves on port 80 and connects to the containers on port 8000.
```bash
kubectl expose deployment nginx --port=80 --target-port=8000
```

- Create a Service named nginx of type NodePort to expose pod nginx's port 80 on port 30080 on the nodes. 
  This will automatically use the pod's labels as selectors, but you cannot specify the node port. 
  You have to generate a definition file and then add the node port in manually before creating the service with the pod
```bash
kubectl expose pod nginx --port=80 --name nginx-service --type=NodePort --dry-run=client -o yaml
```

## get
[get](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get)

### events
- Events such as the ones you saw at the end of kubectl describe pod are persisted in etcd and provide high-level information on what is happening in the cluster. To list all events you can use
```bash
$ kubectl get events
```

### --help
- To get help!
```bash
$  kubectl get --help
```

- To find option which we need for `namespaces`
```bash
$ kubectl get --help | grep namespaces
   Prints a table of the most important information about the specified resources. You can filter the list using a label selector and the --selector flag. If the desired resource type is namespaced you will only see results in your current namespace unless you pass --all-namespaces.
kubectl get ds --all-namespaces
```

- To find what is the argument for no-headers in kubernetes commands
```bash
$ kubectl get --help | grep -i header
      --no-headers=false: When using the default or custom-column output format, don't print headers (default print headers).
```


### namespace
- To get all the namespace resources
```bash
$ kubectl get namespace
NAME                   STATUS   AGE
default                Active   9d
```

#### --no-headers

- To get all the pods in given namespace and do not give header columns
```bash
$ kubectl get pods -n kube-system --no-headers
coredns-864fccfb95-gwtl4                 1/1   Running   14    78d
coredns-864fccfb95-qqlmg                 1/1   Running   14    78d
```

### nodes
- To get all the nodes in the kubernetes cluster
```bash
$ kubectl get nodes
```

#### --show-labels
- To show the labels present on the nodes
```bash
$ kubectl get nodes --show-labels
```

### pod
- To get all the pod resources in namespace ingress
```bash
$ kubectl get pod -n ingress
NAME            READY   STATUS    RESTARTS   AGE
traefik-nb8p2   1/1     Running   13         9d
```
- To output all the pods in namespace ingress in yaml format
```bash
$ kubectl get pod -n ingress -o yaml
apiVersion: v1
items:
- apiVersion: v1
  kind: Pod
.
.
.
  selfLink: ""
```
- To output single pod with name 'traefik-nb8p2' in namespace ingress in yaml format
```bash
$ kubectl get pod traefik-nb8p2 -n ingress -o yaml
```

#### --all-namespaces
- To view all the pods from all namespaces
```bash
$ kubectl get pods --all-namespaces
NAMESPACE     NAME                                     READY   STATUS    RESTARTS   AGE
kube-system   coredns-864fccfb95-gwtl4                 1/1     Running   14         78d
kube-system   coredns-864fccfb95-qqlmg                 1/1     Running   14         78d
```

#### -n
- To view the pods in `kube-system` namespace
```bash
$ kubectl get pods -n kube-system        
NAME                                     READY   STATUS    RESTARTS   AGE
coredns-864fccfb95-gwtl4                 1/1     Running   14         78d
coredns-864fccfb95-qqlmg                 1/1     Running   14         78d
```

#### -o-wide

- To check which pod is present in which particular node
```bash
$ kubectl get pods -o wide
```


#### --selector-or-l

-  Prints a table of the most important information about the specified resources. You can filter the list using a label selector and the --selector flag
```bash
$ kubectl get pods --selector app=App1
## OR 
$ kubectl get pods -l env=dev
## Multiple labels
$ kubectl get pod -l env=prod,bu=finance,tier=frontend
```

#### --show-labels

- To list the existing pods and also show the labels in default namespace

```bash
$ kubectl get pods --show-labels
```

## label
[label](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#label)

- Update the label on node node-1 with key 'size' and value 'Large'

```bash
$ kubectl label nodes node-1 size=Large
```



## logs
[logs](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#logs)
### since
- To get the output of logs of a given resource like 'pod' since last one hour
```bash
KUBECONFIG=$HOME/kubernetes/kubeconfig kubectl logs --since=1h module-5c8986fb69-8jvwx -n backend
```

### -f
- Begin streaming the logs of the ruby container in pod web-1
```bash
kubectl logs -f -c ruby web-1
```

- Begin streaming the logs from all containers in pods defined by label app=nginx
```bash
kubectl logs -f -lapp=nginx --all-containers=true
```

- Begin stream logs of `simple-webapp` container in pod `webapp-2` having multiple containers

```bash
kubectl logs -f webapp-2 simple-webapp
```

## replace
[replace](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#replace)
- Replace a pod using the data in pod.json.
```bash
kubectl replace -f ./pod.json
```

## rollout
[rollout](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#rollout)
- Manage the rollout of a resource
  - Valid resource types include:
     - deployments
     - daemonsets
     - statefulsets

### history

- View previous rollout revisions and configurations. In following case we are checking the
  rollout history of deployment.

```bash
kubectl rollout history deployment/myapp-deployment
```

     
### status

- Show the status of the rollout.
- By default 'rollout status' will watch the status of the latest rollout until it's done.
- Check the rollout status of deployment
```bash
$ kubectl rollout status deployment/myapp-deployment
```
     
### undo

- Rollback to a previous rollout. In the following case roll back to previous deployment     
```bash
$ kubectl rollout undo deployment/myapp-deployment
```

## run
[run](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#run)

### --dry-run
- To NOT create nginx pod, only generate yaml 
```bash
kubectl run nginx --image=nginx --dry-run=client -o yaml
```

### --image

- To create NGINX pod
```bash
kubectl run nginx --image=nginx
```

### -n
- To create a pod with image `redis` and name `redis` in namespace `kube-system`
```bash
$ kubectl run redis --image=redis --dry-run=client -n kube-system -o yaml > pod.yaml
$ kubectl apply -f .
OR
$ kubectl run redis --image=redis -n kube-system
```

### -o yaml 
- To create nginx pod and generate the yaml
```bash
kubectl run nginx --image=nginx -o yaml
```

### -p 
- Create a new pod called custom-nginx using the nginx image and expose it on container port 8080
```bash
kubectl run custom-nginx --image=nginx --port=5701
```

## scale
[scale](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#scale)

- To scale a deployment named `httpd-frontend` to 3 replicas
```bash
$ kubectl scale deployment httpd-frontend --replicas=3
```


## set
[set](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#set)

- Set a deployment's nginx container image to `nginx:1.9.1`
```bash
$ kubectl create deployment my-dep --image=nginx
deployment.apps/my-dep created
$ kubectl describe deployment my-dep | grep -i image
    Image:        nginx
$ kubectl set image deployment my-dep nginx=nginx:1.9.1
deployment.apps/my-dep image updated
$ kubectl describe deployment my-dep | grep -i image  
    Image:        nginx:1.9.1
```


## taint
[taint](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#taint)

- Update node 'node1' with a taint with key 'app' and value 'blue' and effect 'NoSchedule'. 
  If a taint with that key and effect already exists, its value is replaced as specified
```bash
$ kubectl taint nodes node1 app=blue:NoSchedule
```

- Remove from node 'foo' the taint with key 'dedicated' and effect 'NoSchedule' if one exists. Put a `-` at the end of Taint (which you can get using
  `kubectl describe node master | grep -i taint`)
```bash
$ kubectl taint nodes foo dedicated:NoSchedule-
```


## uncordon
[uncordon](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#uncordon)

- Mark node as schedulable.
```bash
$ kubectl uncordon node-01
```
