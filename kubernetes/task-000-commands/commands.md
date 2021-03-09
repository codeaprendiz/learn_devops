# kubectl


Command / Options |  Use Case        |     Example      |  
| ------------- |-------------| -------------| 
| [apply](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#apply) | ||
|-f | Apply resources.yaml | kubectl apply -f resources.yaml |
| [config](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#config) ||
| | Display the current context | kubectl config current-context   |
|--raw <br> -o json | Display merged kubeconfig settings | kubectl config view --raw -o json |
|--client-key=$PWD/dave.key <br> --embed-certs=true | To set a user 'dave' entry in kubeconfig | kubectl config set-credentials dave --client-key=$PWD/dave.key --embed-certs=true
| [cordon](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#cordon) | | |
| | Mark node as unschedulable | kubectl cordon node-01 |
| [create](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#create) | | |
| | Create a namespace dev-ns | kubectl create namespace dev-ns | 
| --dry-run=client <br> --replicas=4| Crete Deployment YAML file (-o yaml). <br> Don't create it(--dry-run) <br> Ensure 4 Replicas (--replicas=4) | kubectl create deployment --image=nginx nginx --dry-run=client --replicas=4 -o yaml > nginx-deployment.yaml |
| -f | Create a pod using the data in pod.json. | kubectl create -f ./pod.json |
|--from-file=app_config.properties | Create a configmap based on a file |  kubectl create configmap app-config --from-file=app_config.properties |
|--from-literal=APP_NAME=test-app | Create a configmap based on a specified literal value | kubectl create configmap app-config --from-literal=APP_NAME=test-app --from-literal=APP_ENV=dev |
|--image=nginx | Create a deployment using nginx image | kubectl create deployment --image=nginx nginx |
|--tcp =5678:8080 | Create a new ClusterIP service named my-cs | kubectl create service clusterip my-cs --tcp=5678:8080
| --tcp=80:80 <br> --node-port=30080| Create a Service named nginx of type NodePort to expose pod nginx's port 80 on port 30080 on the nodes <br> This will automatically use the pod's labels as selectors, but you cannot specify the node port <br> You have to generate a definition file and then add the node port in manually before creating the service with the pod | kubectl create service nodeport nginx --tcp=80:80 --node-port=30080 --dry-run=client -o yaml |
|-o yaml  <br> --dry-run | Generate Deployment YAML file (-o yaml). <br>  Don't create it(--dry-run) | kubectl create deployment --image=nginx nginx --dry-run=client -o yaml |
| [delete](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#delete) | | |
| | Delete deployment with name 'www' from default namespace | kubectl delete deployment www | 
| -f| Delete a pod using the type and name specified in pod.json | kubectl delete -f ./pod.json |
| --force <br> --grace-period=0 | To immediately remove resources from API and bypass graceful deletion. | kubectl delete pod <PODNAME> --grace-period=0 --force --namespace <NAMESPACE> |
| --namespace| Delete pod web-pack in namespace frontend | kubectl delete pod web-pack --namespace frontend
| [describe](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#describe) | | |
| -n ingress | Describe a pod with name 'traefik-nb8p2' in ingress namespace | kubectl describe pod traefik-nb8p2 -n ingress |
| | To get the Taints on master node | kubectl describe nodes master &#124; grep -i taints  |
| [drain](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#drain) | | |
| | Drain node in preparation for maintenance | kubectl drain node-01 |
| [edit](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#edit) | | 
| |  To change the image of nginx deployment to 1.9.0 | kubectl create deployment my-dep --image=nginx <br> kubectl edit deployment my-dep <br> kubectl describe deployment my-dep &#124; grep -i image 
| [exec](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#exec) | |
| --prefix <br> -keys-only | To list all the keys stored by kubernetes | kubectl exec etcd-master -n kube-system etcdctl get --prefix -keys-only
| [explain](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#explain) | | 
|--recursive | Print the fields of fields | kubectl explain pod --recursive &#124; less |
| [expose](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#expose) | |
| --port=6379 <br> --name redis-service <br> --dry-run=client <br> -o yaml| Create a Service named redis-service of type ClusterIP to expose pod redis on port 6379 using dry-run mode | kubectl expose pod redis --port=6379 --name redis-service --dry-run=client -o yaml |
| --port=80 <br> --target-port=8000| Create a service for an nginx deployment, which serves on port 80 and connects to the containers on port 8000. | kubectl expose deployment nginx --port=80 --target-port=8000
|--port=80 <br> --name nginx-service <br> --type=NodePort <br> --dry-run=client <br> -o yaml | Create a Service named nginx of type NodePort to expose pod nginx's port 80 on port 30080 on the nodes. <br> This will automatically use the pod's labels as selectors, but you cannot specify the node port. <br> You have to generate a definition file and then add the node port in manually before creating the service with the pod | kubectl expose pod nginx --port=80 --name nginx-service --type=NodePort --dry-run=client -o yaml
| [get](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get) | |
| events | Events such as the ones you saw at the end of kubectl describe pod are persisted in etcd <br> To list all events you can use | kubectl get events |
| --help | To get help! | kubectl get --help |
| | To find option which we need for all namespaces | kubectl get --help &#124; grep namespaces |
| | To find what is the argument for no-headers in kubernetes commands |  kubectl get --help &#124; grep -i header 
| namespaces | To get all the namespace resources | kubectl get namespace |
|--no-headers | To get all the pods in given namespace and do not give header columns | kubectl get pods -n kube-system --no-headers |
| nodes | To get all the nodes in the kubernetes cluster | kubectl get nodes |
| --show-labels | To show the labels present on the nodes | kubectl get nodes --show-labels |
| -n ingress | To get all the pod resources in namespace ingress | kubectl get pod -n ingress |
|-n ingress <br> -o yaml | To output all the pods in namespace ingress in yaml format | kubectl get pod -n ingress -o yaml |
| | To output single pod with name 'traefik-nb8p2' in namespace ingress in yaml format | kubectl get pod traefik-nb8p2 -n ingress -o yaml |
|--all-namespaces | To view all the pods from all namespaces | kubectl get pods --all-namespaces |
| -n kube-system | To view the pods in kube-system namespace | kubectl get pods -n kube-system |
| -o wide | To check which pod is present in which particular node | kubectl get pods -o wide |
| --selector <br> -l | Prints a table of the most important information about the specified resources. <br> You can filter the list using a label selector and the --selector flag | kubectl get pods --selector app=App1 <br> OR <br> kubectl get pod -l env=prod,bu=finance,tier=frontend
|--show-labels | To list the existing pods and also show the labels in default namespace | kubectl get pods --show-labels |
| [label](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#label) | | 
| | Update the label on node node-1 with key 'size' and value 'Large' | kubectl label nodes node-1 size=Large |
| [logs](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#logs) | |
| since | To get the output of logs of a given resource like 'pod' since last one hour | KUBECONFIG=$HOME/kubernetes/kubeconfig kubectl logs --since=1h module-5c8986fb69-8jvwx -n backend |
| -f | Begin streaming the logs of the ruby container in pod web-1 | kubectl logs -f -c ruby web-1
| --all-containers=true | Begin streaming the logs from all containers in pods defined by label app=nginx | kubectl logs -f -lapp=nginx --all-containers=true 
| | Begin stream logs of simple-webapp container in pod webapp-2 having multiple containers | kubectl logs -f webapp-2 simple-webapp
| [replace](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#replace) | | 
| | Replace a pod using the data in pod.json. | kubectl replace -f ./pod.json |
| [rollout](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#rollout) | | 
| history | View previous rollout revisions and configurations.<br> In following case we are checking the rollout history of deployment. | kubectl rollout history deployment/myapp-deployment
| status | Show the status of the rollout. | kubectl rollout status deployment/myapp-deployment |
| undo | Rollback to a previous rollout. In the following case roll back to previous deployment   | kubectl rollout undo deployment/myapp-deployment |
| [run](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#run) | | |
| --dry-run | To NOT create nginx pod, only generate yaml  | kubectl run nginx --image=nginx --dry-run=client -o yaml | 
| --image | To create NGINX pod |  kubectl run nginx --image=nginx |
| | To create a pod with image redis and name redis in namespace kube-system | kubectl run redis --image=redis --dry-run=client -n kube-system -o yaml > pod.yaml ; kubectl apply -f . <br> OR <br> kubectl run redis --image=redis -n kube-system
|-o yaml  | To create nginx pod and generate the yaml | kubectl run nginx --image=nginx -o yaml  |
| -p | Create a new pod called custom-nginx using the nginx image and expose it on container port 8080 | kubectl run custom-nginx --image=nginx --port=5701 |
| [scale](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#scale) | | 
| --replicas=3 | To scale a deployment named httpd-frontend to 3 replicas | kubectl scale deployment httpd-frontend --replicas=3 |
| [set](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#set) | | 
| | Set a deployment's nginx container image to nginx:1.9.1 | kubectl create deployment my-dep --image=nginx <br> kubectl set image deployment my-dep nginx=nginx:1.9.1 <br> kubectl describe deployment my-dep &#124; grep -i image 
| [taint](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#taint) | |
| | Update node 'node1' with a taint with key 'app' and value 'blue' and effect 'NoSchedule'. | kubectl taint nodes node1 app=blue:NoSchedule |
| | Remove from node 'foo' the taint with key 'dedicated' and effect 'NoSchedule' if one exists. <br> Put a - at the end of Taint (which you can get using  kubectl describe node master &#124; grep -i taint  | kubectl taint nodes foo dedicated:NoSchedule-
| [uncordon](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#uncordon) | | 
| | Mark node as schedulable. | kubectl uncordon node-01 | 




```bash
kubectl get all --all-namespaces
kubectl  get ep
```

### json path

[kubectl/jsonpath/](https://kubernetes.io/docs/reference/kubectl/jsonpath/)

- Suppose we deploy sample nginx pod

```bash
$ kubectl get pods        
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          11m
```

- Get the full json object

```bash
$ kubectl get pods -o json
```

- Get the type of object

```bash
$ kubectl get pods -o=jsonpath='{$.kind}'
List
```

- Get the name of the pod

```bash
$ kubectl get pods -o=jsonpath='{.items[0].metadata.name}'
nginx
```

- Get the nodeName

```bash
$ kubectl get pods -o=jsonpath='{.items[0].spec.nodeName}'
docker-desktop
```

- Get the container details 

```bash
$ kubectl get pods -o=jsonpath='{.items[0].spec.containers}'
[{"image":"nginx","imagePullPolicy":"Always","name":"nginx","resources":{},"terminationMessagePath":"/dev/termination-log","terminationMessagePolicy":"File","volumeMounts":[{"mountPath":"/var/run/secrets/kubernetes.io/serviceaccount","name":"default-token-qg6zs","readOnly":true}]}]
```

- Get the deployed image name

```bash
$ kubectl get pods -o=jsonpath='{.items[0].spec.containers[0].image}'
nginx
```

- Get the pod IPs in pretty format

```bash
$ kubectl get pods -o=jsonpath='{.items[0].status.podIPs}' | jq
[
  {
    "ip": "10.1.5.59"
  }
]
```

- Get the phase of the pod

```bash
$ kubectl get pods -o=jsonpath='{.items[0].status.phase}'
Running
```

- Get the restart count of the first container

```bash
$ kubectl get pods -o=jsonpath='{.items[0].status.containerStatuses}' | jq

[
  {
    "containerID": "docker://55704ca318bc577589652a8851deac7fafa0b99b1d10a4527777bf816d5c5041",
    "image": "nginx:latest",
    "imageID": "docker-pullable://nginx@sha256:f3693fe50d5b1df1ecd315d54813a77afd56b0245a404055a946574deb6b34fc",
    "lastState": {},
    "name": "nginx",
    "ready": true,
    "restartCount": 0,
    "started": true,
    "state": {
      "running": {
        "startedAt": "2021-03-03T12:44:39Z"
      }
    }
  }
]

$ kubectl get pods -o=jsonpath='{.items[0].status.containerStatuses[0].restartCount}' | jq
0
```

- To get the list of pv's sorted by capacity storage

```bash
controlplane $ kubectl get pv --sort-by='{.spec.capacity.storage}'
NAME       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   REASON   AGE
pv-log-4   40Mi       RWX            Retain           Available                                   5m39s
pv-log-1   100Mi      RWX            Retain           Available                                   5m39s
pv-log-2   200Mi      RWX            Retain           Available                                   5m39s
pv-log-3   300Mi      RWX            Retain           Available                                   5m39s
```