
- [Kubernetes Cluster](#Kubernetes-Cluster)
    - [Worker Nodes](#Worker-Nodes)
    - [ETCD Cluster](#ETCD-Cluster)
    - [kube-scheduler](#kube-scheduler)
    - [Node Controller](#Node-Controller)
    - [Replication-Controller](#Replication-Controller)
    - [Replicaset](#Replicaset)
    - [kube-apiserver](#kube-apiserver)    
    - [Container-Runtime Engine](#Container-Runtime-Engine)
    - [kubelet](#kubelet)
    - [Kube-proxy service](#Kube-proxy-service)
    - [Kube-controller Manager](#Kube-controller-Manager)
    - [pod](#pod)
    - [deployment](#deployment)
    - [namespaces](#namespaces)
    - [resource quota](#resource-quota)
    - [services](#services)
        - [nodeport service](#nodeport-service)
        - [clusterip service](#clusterip-service)
        - [load balancer service](#load-balancer-service)
    - [daemonsets](#daemonsets)    
- [How scheduling works](#how-scheduling-works)    
- [Labels And Selectors](#labels-and-selectors)
- [taints-and-tolerations](#taints-and-tolerations)
- [node-affinity](#node-affinity)
- [resource-requirement-and-limits](#resource-requirement-and-limits)
- [static-pods](#static-pods)
- [multiple-schedulers](#multiple-schedulers)
## Kubernetes-Cluster
- Set of nodes which may be physical or virtual
- on premise or on cloud 
- that host applications in the form of containers

![](https://github.com/codeaprendiz/_assets/blob/master/kubernetes-kitchen/kubernetes-architecture.png)
 
### Worker-Nodes
- Host Application as containers

### Master-Node
- Manage, Plan, Schedule, Monitor Nodes

### ETCD-Cluster
- A database that stores information in key value format 
- It is a simple, reliable, key-value store that is simple, secure and fast.
- You can download the binary of etcd and run it using `./etcd`. Its starts service on port 2379 by default.
  You can attach clients to the service to store and retrieve the data.
- The default client that comes with etcd is etcd control client  `./etcdctl set key1 value1`. And we can retrieve 
  the data using `./etcdctl get key1`
- The ETCD datastore stores information about the cluster like
    - Nodes, Pods, Configs, Secrets, Accounts, Roles, Bindings
- Every change we make to the cluster are updated in the etcd server. 
- Installing ETCD service
    - Manual : Install cluster from scratch
        - Download the binary and install in the master node yourself.
        - `--advertise-client-urls https://${{INTERNAL_IP}}:2379`: The address on which etcd listens. This should be configured in the `kube-api` server
          when it tries to contact the `etcd` service.
    - Install using `kube-adm`      
        - This deploys the `etcd` server for you as a pod in the `kube-system` namespace
- Kubernetes stores data in specific directory structure. The `root` directory is `/registry` and under that
  we have variour kubernetes contructs like minions, pods, replicasets, roles etc
- In highly available environment you will have multiple master nodes in a cluster and then you would also have 
  multiple etcd instances spread across the master nodes. In that case make sure that the etcd instances know 
  about each other by setting the right parameter in the `etcd` service configuration.
    - The `--initial-cluster controller-0=https://${CONTROLLER0_IP}:2380,controller-1=https://$}CONTROLLER1_IP}:2380 `    
- ETCDCTL is the CLI tool used to interact with ETCD.
  
    - ETCDCTL can interact with ETCD Server using 2 API versions - Version 2 and Version 3.  By default its set to use Version 2. Each version has different sets of commands.
      For example ETCDCTL version 2 supports the following commands:
    ```bash
    etcdctl backup
    etcdctl cluster-health
    etcdctl mk
    etcdctl mkdir
    etcdctl set
    ```
    - Whereas the commands are different in version 3
    ```bash
    etcdctl snapshot save 
    etcdctl endpoint health
    etcdctl get
    etcdctl put
    ```
    - To set the right version of API set the environment variable ETCDCTL_API command
    ```bash
    export ETCDCTL_API=3
    ```
    - Apart from that, you must also specify path to certificate files so that ETCDCTL can authenticate to the ETCD API Server. The certificate files are available in the etcd-master at the following path
    ```bash
    --cacert /etc/kubernetes/pki/etcd/ca.crt     
    --cert /etc/kubernetes/pki/etcd/server.crt     
    --key /etc/kubernetes/pki/etcd/server.key
    ```
  - To get all the keys stored by kubernetes
    ```bash
    kubectl exec etcd-master -n kube-system -- sh -c "ETCDCTL_API=3 etcdctl get / --prefix --keys-only --limit=10 --cacert /etc/kubernetes/pki/etcd/ca.crt --cert /etc/kubernetes/pki/etcd/server.crt  --key /etc/kubernetes/pki/etcd/server.key" 
    ```

### kube-scheduler
- Identifies the right node to place the container on
- based on container's resource requirements, worker node capacity etc
- The scheduler continously monitors the api-server. When ever there is a new node created, it realizes and assigns it to appropriate node and communicates back to the 
  `kube-api` server. 
- It is only responsible for deciding which pods goes on which node. It does actually places the pods on the nodes.
  - It first filters the nodes which cannot accomodate the request
  - Then it runs functions which decide which node will be the best fit for the placement of the pod on the node. It ranks the nodes based on this.
  - You can write your own scheduler as well.
- How to install the kube-scheduler
  - Download the kube-scheduler binary from the kubernetes release page and install it as service.
  ```bash
     wget https://../kube-scheduler
  ```
 - Where you can view the kube-scheduler server options
   - If you set it up using the kube-adm tool which  deploys the kube-scheduler as a pod in the kube-system namespace on the master node, you can login into the pod
     and view the options at the following locations
     ```bash
     cat /etc/kubernetes/manifests/kube-scheduler.yaml
     ```
   - You can also see the running process by listing the processes running on the master node and then searching for the kube-scheduler process
   ```bash
     ps -aux | grep kube-scheduler
   ```
     

![](https://github.com/codeaprendiz/_assets/blob/master/kubernetes-kitchen/kube-scheduler.png)

### Node-Controller
- Takes care of nodes, responsible for onboarding new nodes to the cluster, handlying
  situations when nodes become unavailable or gets destroyed
  
### Replication-Controller
- If desired number of containers are running at any point in time in a replication group.
- The replication controller helps us run multiple instances of a single pod in a kubernetes cluster
  thus providing high availability.
Load Balancing And Scaling
- The replication controller spans across multiple nodes in a cluster and helps to balance the load across
  multiple pods (in same or different nodes) in a cluster

![](https://github.com/codeaprendiz/_assets/blob/master/kubernetes-kitchen/replication-controller-load-balancing-scaling.png) 

- creating a `rc-definition.yml`
```yaml
apiVersion: v1
kind: ReplicationController
metadata:         # for replication controller
  name: myapp-rc
  labels:
    app: myapp
    type: front-end
spec:        # for the replication controller
  replicas: 3
  template:     # define a pod template here
    metadata:   # for the pod
      name: myapp-pod
      labels:
        app: myapp
        type: frontend
    spec:            # for the pod
      containers:
        - name: nginx-container
          image: nginx
```

- To view the replicationController resources
```bash
$ kubectl get replicationcontroller
```

- Now to view the pods created, you can use `kubectl get pods`

### Replicaset
Similar to replication controller
- Difference between replicationController and replicaSet is the `selector` defination. This helps the replicaSet
  identify what pods fall under it.
- It can also manage pods that were not created as a part of replicaset creation 
- To create a `replicaset-definition.yml`
```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: myapp-replicaset
  labels:
    app: myapp
    type: front-end

spec:
  replicas: 3
  selector:
    matchLabels:
      tier: frontend
  template:
    metadata:
      name: myapp-pod
      labels:
        app: myapp
       type: front-end
    spec:
      containers:
        - name: nginx-container
          image: nginx
```

- To create `replicationController` run the following command
```bash
kubectl create -f replicaset-definition.yml
```
- Now to view the pods you can use `kubectl get pods`

- To increase the number of `replicasets` you can use the following scale command
```bash
kubectl scale --replicas=6 -f replicaset-definition.yml
# OR
kubectl scale --replicas=6 replicaset myapp-replicaset
```

- To get the replicaset resources use
```bash
kubectl get replicaset
```
- To delete the replicaset object
```bash
kubectl delete replicaset myapp-replicaset
```

- How replicaset monitors `pods` with specific `matchlabels`

![](https://github.com/codeaprendiz/_assets/blob/master/kubernetes-kitchen/replicaset-monitor-pods-matchlabels.png)


### kube-apiserver
- Primary management component of kubernetes
- orchestrating all operations in the cluster
- it exposes the kubernetes api which is used by external users to perform
  management operations on the cluster
- When you run a kubectl (kube control) command the kube-control utility reaches to the kube-api server. The kube-api server then authenticates and validates the
 request. It then retrieves the data from the etcd cluster and then responds back with the required information.
- We don't need to use the kube-control command line always, instead we can also invoke the api's directly by sending HTTP requests.
- kube-api server is available as a binary in kubernetes release page. If not already present on the master node then you  need
  to download and configure it on the master node.

![](https://github.com/codeaprendiz/_assets/blob/master/kubernetes-kitchen/flow-user-kube-api-server-etcd-cluster-and-back.png)
```bash
kubectl get nodes
curl -X POST /api/v1/namespaces/defaults/pods/...[other]
```
- The kube-api server is responsible for 
  - Authenticate User
  - Validate Request
  - Retrieve data and Update data on ETCD cluster
  - Scheduler uses the api server to perform updates in the cluster
  - Kubelet uses the api server to perform updates in the cluster
  
- run time arguments worth knowing
  - `--etcd-servers=https://127.0.0.1:2379` - how the kubeapi server connects to the etcd server
- view kube-api server options in existing cluster
  - If you deploy the cluster using kubeadm which deploys the `kube-api` server as a pod in the namespace `kube-system`
        - `kubectl get pods -n kube-system` - Login into this pod and see the options at 
          - `cat /etc/kubernetes/manifests/kube-apiserver.yaml`
  - In non kubeadm set you can view the options by following command
        - `cat /etc/systemd/system/kube-apiserver.service`
        - You can also search for the kube-apiserver process on the master node and list the corresponding options
          `ps -aux | grep kube-apiserver`
  
### Container-Runtime-Engine
- We need a software that can run the containers i.e. container runtime engine (eg docker).
- We need docker or its equivalent to be installed on all nodes of the cluster including the master nodes
- kubernetes supports other runtime engines as well like containerd

### kubelet
- Its an agent that runs on each node in the cluster
- It listens for instructions from the kube-api server and deploys or destroys the 
  containers as required
- kube-api server periodically fetches status reports from the kubelet to monitor the 
  status of the nodes on them 
- The kubelet in the kubernetes worker node registers the node with the kuernetes cluster. When it receives an instruction to load a container or a pod on the node
  it requests the container runtime engine (like docker) to pull the required image and run an instance and then continues to monitor the state of the pod and containers
  in it and reports to the kube-api server on timely basis.
- Install kubelet
  - Installing using kubeadm (kubeadm does not automatically deploy the kubelet). You can download the binary, install and run it as a service
  ```bash
  wget https://../kubelet
  ```
  You can view the running process and effective options by listing the process on the worker nodes
  ```bash
  ps -aux | grep kubelet
  ```
![](https://github.com/codeaprendiz/_assets/blob/master/kubernetes-kitchen/kubelet-kube-api-server.png)  

  
### Kube-proxy-service
- enables the communication between the worker nodes
- ensures that the necessary rules are in place on the worker nodes to allow the
  containers running on them to reach each other
- within a kubenetes cluster every pod can reach every other pod. This is accomplished by deploying a pod-networking solution to the cluster.
  **Pod Network**
![](https://github.com/codeaprendiz/_assets/blob/master/kubernetes-kitchen/kube-proxy-pod-network.png)    
  - It is an internal virtual network that expands across all the nodes within the cluster through which all the pods are conntected.
  - If we have a web-application deployed on one node and a database application deployed on another node. Then the web-application can reach
    the database application using the IP of the database. But there is not guarante that the IP of the database would remain the same. That is why
    we expose the database application by using a service.
  - The service does not join the same POD network because the service is not an actual thing. It does not have a container like PODs so it doesn't have any interface
    or an actively listening process. It is a virtual component that only lives in kubernetes memory
- Kube-proxy is a process that run on each node in the kubernetes cluster. Its job is to look for new services and everytime a new service is created it creates appropriate 
  rule on each node to forward traffic to those services to the backend pods.
- It creates IP table rules on each node in the cluster to forward traffic heading to the IP of the service.   
  - In the following case it has created rules [1.2.3.6|1.2.3.5] in each of the nodes saying that traffic trying to reach the IP of the service 1.2.3.6 should
    be forwarded to 1.2.3.5

![](https://github.com/codeaprendiz/_assets/blob/master/kubernetes-kitchen/kube-proxy.png)

- Installing `kube-proxy`
  - download the kube-proxy from the kubernetes release page, install it and run it as a service    
  ```bash
  wget https://.../kube-proxy
  ```
- In kubeadm, the kube-proxy is deployed as a daemonset and therefor on each node in the cluster.
  
  
### Kube-controller-Manager
-  Manager various controllers in kubernetes
- A controller is a process which continuously monitors the state of various components within the system and works towards 
  bringing the whole system towards the desired functioning state.
- For Example 
  - The *Node controller* is responsible for monitoring the status of the nodes and take the necessary action to keep the application running.
    It does that through the kube-api server.
  - The node controller checks the status of the nodes every 5 seconds, in this way the node controller can monitor the status of the nodes.
  - If it stops receiving heartbeat from a node, the node is marked as unreachable. But it waits for 40s before marking it as 
    unreachable. After a node is marked as unreachable it waits for 5 minutes for the node to come backup. If it doesn't it removes
    the pod assigned to that node and provisions them on the healthy ones if the pods are part of the replica set.
> Node Monitor Period = 5s

> Node Monitor Grace Period = 40s

> Pod Eviction Timeout = 5m

```bash
$ kubectl get nodes          
NAME       STATUS       ROLES   AGE    VERSION
worker-1   Ready       <none>   10d    v1.19.4
worker-2   NotReady    <none>   10d    v1.19.4
```   

![](https://github.com/codeaprendiz/_assets/blob/master/kubernetes-kitchen/Controllers-node-controller.png)
  
  - The *Replication Controller* is responsible to monitoring the status of the replicasets and ensuring that the desired 
    number of pods are always available within the set. If a pod dies it creates another one.
    
  - In the same way there are many such controllers within kubernetes like deployment-controller,
    namespace-controller, job-controller etc
- All these controllers are packaged in a single process know as `Kube-Controller-Manager`. 
- How to install the kube-controller-manager
  - Download the `kube-controller-manager` binary from the kubernetes release page.
    `wget https://../kube-controller-manager`
  - Extract it and run it as a service.
  - Options worth noting down
  ```bash
    --node-monitor-period=5s
    --node-monitor-grace-period=40s
    --pod-eviction-timeout=5m0s
    --controllers stringSlice  Default:[*]
  ``` 
  - The last option you saw is to enable which all controllers you want to enable. By default
    all of them are enabled. 
- So how do you view the kube-controller-manager's server options
  - If installed using `kubeadm`. The kubeadm deploys the kube-controller-manager as a pod in the 
    namespace kube-system on the master node. You can see these options indside the pod at the following
    location
    ```bash
    cat /etc/kubernetes/manifests/kube-controller-manager.yaml
    ```   
  - In non kubeadm set up you can view those options at the following location
    ```bash
    cat /etc/systemd/system/kube-controller-manager.service
    ```   
  - You can also see the running process and the effective options by listing the processes on the master
    node and searching for the kube-controller-manager
    ```bash
    ps -aux | grep kube-controller-manager
    ```

### pod

- A `pod` is the smallest object that you can create in kubernetes
- pods **usually** have one-to-one relationship while scaling your application. When you scale your app, you 
  add more pods (not more containers in the same pod)
- A pod can have multiple containers as well
- The containers in a pod by default would have access to the same storage, same network namespace. The are created together
  and destroyed together.
- How to deploy pod with an image of nginx
```bash
kubectl run nginx --image nginx
```
- How to get the pods
```bash
kubectl get pods
```
- pod-defination.yml 
```yaml
# The kubernetes-api version we are using to create the object, 
apiVersion : v1      # String
# The type of object we are trying to create String
kind : Pod
metadata:  
  name : myapp-pod  # dictionary of objects
  labels:
    app: myapp
spec:
  containers:     # List/Array, as pods can have multiple containers
    - name: nginx-container   # again a dictionary
      image: nginx
```
- finally create object
```bash
kubectl create -f pod-defination.yml
```

### deployment
Gives us capabilities like
- webserver you need to deploy in production environment, you need many such instances of the
  webserver running
- whenever newer version of the webapp becomes available in the docker registry, you would want to 
  upgrade the webapp in all the instances
- while upgrading the instances you would like to upgrade gradually (not all at once), rolling update
- you would also like to be alble to rollback the changes that were recently carried out. 

- So how can we create a deployment. The contents would be same as that of replicaset except for the kind
  which would now become deployment
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp-replicaset
  labels:
    app: myapp
    type: front-end

spec:
  replicas: 3
  selector:
    matchLabels:
      tier: frontend
  template:
    metadata:
      name: myapp-pod
      labels:
        app: myapp
       type: front-end
    spec:
      containers:
        - name: nginx-container
          image: nginx
```

- You can create deployment resource using
```bash
kubectl create -f deployment-definition.yaml 
```

- You can get the deployments using
```bash
kubectl get deployments
```

> Note: The deployment automatically creates a replicaset so when you do the following (replicaset in the name of the deployment).
> The replicaset ultimately creates pods so if you check the pods you would see them as well.
```bash
kubectl get replicaset
```

- To get `all` the objects created
```bash
kubectl get all
```

![](https://github.com/codeaprendiz/_assets/blob/master/kubernetes-kitchen/kubernetes-deployment.png)


### namespaces
- all the resources we create get created in the `default` namespace unless explicitly specified.
- kubernetes creates some pods and services for its internal purpose such as those required by networking solution,
  dns solution, to isolate these from the user in another namespace created at cluster startup `kube-system`
- third namespace created by kubernetes is called `kube-public`. This is where resources that should be available to all users
  created. 
- Each of the namespaces can have its own set of policies telling who can do what and you can also assign quota of resources
  to each of the namespaces  
- The resources within a namespace can refer to each other simply by their names. For example the `web-app` pod can reach the 
  `db-service` simply by using the hostname `db-service`. If required the `web-app` pod can reach the `db-service` in another 
  namespace as well. For this it must append the namespace name before i.e. `db-service.dev.svc.cluster.local`. We are able to do this
  because when the service is created the dns entry is automatically added in this format.
- `db-service.dev.svc.cluster.local`
    - Here 
        - cluster.local: Default domain name of the kubernetes cluster
        - svc: the subdomain for the service
        - dev: namespace
        - db-service: the name of the service
  
![](https://github.com/codeaprendiz/_assets/blob/master/kubernetes-kitchen/kubernetes-namespcaes.png)  

- Create a namespace
```bash
kubectl create namespace dev
```
- Using yaml file
```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: dev
```

- By default our commands are executed in `default` namespace. However when we want to switch the namespace, we can use
```bash
kubectl config set-context $(kubectl config current-context) --namespace=kube-system
```

- To view pods in all namespaces, use the following command
```bash
kubectl get pods --all-namespaces
```
### resource-quota
- To limit resources in a namespace, you need to create a resource type ResourceQuota
  `compute-quota.yaml`
```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: compute-quota
  namespace: dev

spec:
  hard:
    pods: "10"
    requests.cpu: "4"
    requests.memory: 5Gi
    limits.cpu: "10"
    limits.memory: 10Gi
```

```bash
kubectl create -f compute-quota.yaml
```

### services

Kubernetes services enable communication between components within and outside of application.
For example we have set of pods serving the frontend, set of pods serving the backend. Kubernetes services
enable the frontend pods to be available to the end users. It helps in communication between backend and frontend pods
and also helps in establishing connectivity to external datasource.
 
![](https://github.com/codeaprendiz/_assets/blob/master/kubernetes-kitchen/kubernetes-services.png) 

Consider the following scenario
  - Laptop has the IP address 192.168.1.10
  - K8S node is on the same network and has the IP address 192.168.1.2
  - Internal POD network is in the range 10.244.0.0
  - POD IP is 10.244.0.2
  - If you can SSH into the node then you would be able to access the web-app running 
    in the POD using
    ```bash
    curl http://10.244.0.2
    Hello World!
    ```
  - But how do we access this application from the laptop? This is where the kubernetes service comes into play
  - Kubernetes Service is an object (like Pod or replica set). One of its use case is to `LISTEN` to a `PORT` on the 
    `NODE` and `forward` the request on that port, to the PORT on the POD running the web-application. This type of service
    is called *NODE PORT* service as it listens to a port on the node and forward the requests to the pod.
    
![](https://github.com/codeaprendiz/_assets/blob/master/kubernetes-kitchen/node-port-service.png)    

Service Types
![](https://github.com/codeaprendiz/_assets/blob/master/kubernetes-kitchen/k8s-service-types.png) 

- Node Port : Where the service makes an internal POD accessible by a port on the node.

![](https://github.com/codeaprendiz/_assets/blob/master/kubernetes-kitchen/service-node-port.png)

- Cluster IP : The service creates a virtual IP inside the cluster to enable communication between
               different services such as a set of frontend servers and a set of backend servers. 
- Load Balancer : Where it provisions a load balancer for our application in supported cloud providers               

#### nodeport-service

service-defination.yaml 
```yaml
apiVersion: v1
kind: Service
metadata:
  name: myapp-service

spec:
  type: NodePort
  ports:
    - targetPort: 80  ## Note this is an array and we can have multiple such definations
      port: 80
      nodePort: 30008
  selector: ## This is what tells the service which Pod to hit, you can find them in pod defiation, metadata: labels: 
    app: myapp
    type: front-end
```
- To create the service
```bash
kubectl create -f service-defination.yml
```
- To view the service
```bash
$ kubectl get svc                                                              
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   79d
myapp-service NodePort   10.106.123.123 <none>      80:30008/TCP 5m
```

Now if the IP of the Node is `192.168.1.2` then you can access the application via
```bash
curl http://192.168.1.2:30008
```

- Also note that the Service also does the Load Balancing. The same service is able to balance the load between many pods that have the 
  same `labels` which is same as the `selector` on the service.
  Also the same is true even if the pods span across multiple pods.
  The same service spans across multiple nodes and is able to balance the load 
  between multiple pods. You can access the web-application by using the `IP:PORT` of any of the nodes (in case the service is of
  type NodePort)
  
#### clusterip-service
Consider the following example
- help us group the pods together and provide a single interface to access the pods in a group .
- A service created to the backend pods allows the frontend pods to access the backend pods randomly
- Similarly, the service created for redis pods allows the backend pods to access the redis pods randomly.
- So now each layer (backend/ frontend) scale independent of each other without impacting the communication between the services
- Each service gets an IP and name assigned to it inside the cluster and that is the name that should be used by other pods to access the service 
- This type of service is called Cluster IP

![](https://github.com/codeaprendiz/_assets/blob/master/kubernetes-kitchen/k8s-service-cluster-ip.png)

service-defination.yaml
```yaml
apiVersion: v1
kind: Service
metadata:
  name: back-end

spec:
    type: ClusterIP   #default
    ports:
      - port: 80
        targetPort: 80
    selector:
      app: myapp
      type: back-end
- To create the service
```bash
kubectl create -f service-defination.yml
```

- To access the service.  Other pods can access the service using `ClusterIP` or `service name`
```bash
kubectl get services
```
#### load-balancer-service
- We can access the application by using the IP of the Nodes. However since there are many nodes and many apps (like in below example we have 4 nodes and 
  two applications) we will need to remember many IPs to access the application. We will need to configure our own load balancer to forward the 
  requests to all the nodes.
- Load balancer sevice does this job for us. It creates a public IP which we can map to a domain name and then users can access all the applications
  using the same domainname.

![](https://github.com/codeaprendiz/_assets/blob/master/kubernetes-kitchen/k8s-service-loadbalancer.png)  

```yaml
apiVersion: v1
kind: Service
metadata:
  name: myapp-service
spec:
    type: LoadBalancer
    ports:
      - targetPort: 80
        port: 80
        nodePort: 30008
      
```



### daemonsets

It runs one copy of your pod on each node in your cluster.
When ever a new node is added to the cluster, a replica of the pod is automatically added to that node.
When a node is removed, the pod is automatically removed.

Usage Cases
- Monitoring Solution
- Logging Solution
- Kube-Proxy can be deployed as a daemon set as well.
- networking solutions like `weave-net` requires an agent to be deployed on each node in the cluster

daemonset-resource.yaml
```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: fluentd-elasticsearch
spec:
  selector:
    matchLabels:
      name: fluentd-elasticsearch
  template:
    metadata:
      labels:
        name: fluentd-elasticsearch
    spec:
      containers:
      - name: fluentd-elasticsearch
        image: quay.io/fluentd_elasticsearch/fluentd:v2.5.2
```

- To create a daemonset you can run the following command
```bash
kubectl apply -f daemonset-resource.yaml
```

- To get the daemon set you can use the following command
```bash
kubectl get daemonset
```

- To get more details information you can use
```bash
kubectl describe daemonset monitoring-daemon
```

- So how does it work?
  - The daemonset uses NodeAffinity rules and default scheduler to schedule pods on nodes.



## how-scheduling-works

- Every pods has a field called `nodeName` that by default is not set. Kubernetes adds it automatically.
  The scheduler goes through all the pods and looks for those which do not have this
  property set, those are the candidates for scheduling. It then identifies the the right node for the pod
  by running the right scheduling algorithm. Once identified it then schedules the pod for the node by setting
  the `nodeName` property for the pod equal to the name of the node. 
  
- If there is no scheduler for the pods, then the pods remain in Pending state. You can also manually assing pods to the 
  nodes itself. If you set the `nodeName` property to the name of the node. You can only specify the nodeName at the
  pod creation time. It will not work if you try to do the same to already existing pod. So you might need to delete the pod and create it again
  with the nodeName
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx
    image: nginx
  nodeName: kube-01
```
  If you want to assing a node to existing pod without deleting then create a pod-binding object
```yaml
apiVersion: v1
kind: Binding
metadata:
  name: nginx
target:
  apiVersion: v1
  kind: Node
  name: node2
```
  And send a POST request to the pod-binding api with the above data.


## labels-and-selectors

- You can group and select objects using labels-and-selectors
- You can attach labels to each object as per your needs

- How to specifiy lables to filter the objects, in the pod-defination.yaml file.
```yaml
metadata:
    name: app
    labels:
      app: App1
      function: Front-end
```
We can add as many labels as well like. You can also view the pod with a given label 
```bash
kubectl get pods --selector app=App1
```

- Similarly labels are also used in `replica-set.yaml` as well to group the selected pods
```yaml
spec:
  replicas: 3
  selector: 
    matchLabels:
      app: App1
      function: Front-end
```

- Similarly, a `service.yaml` uses the labels to match the labels on the pods
```yaml
spec:
  selector:
    app: App1
```

Now `annotations` are used to record other details for information purpose. For example buildVersion
```yaml
metadata:
  name: simple-webapp
  labels:
    app: App1
    function: Front-end
  annotations:
    buildversion: 1.34
```

## taints-and-tolerations

They are used to set up the restrictions on what pods can be scheduled on a node.

`Taints` are set on Nodes and `Tolerations` are set on pods. `taint-effect` defines what will happen to the pod if they do not
tolerate the taint. There are three taint-effects
  - NoSchedule: which means the pods will not be scheduled on the node
  - PreferNoSchedule: which means that the system will avoid placing a pod
                       on the node but that's not guaranteed
  - NoExecute: which means no new pods will not be scheduled on the node and existing 
               pods on the node if any will be evicted if they do not tolerate the taint
```bash
kubectl taint nodes <node-name>  <key>=<value>:[NoSchedule|PreferNoSchedule|NoExecute]

kubectl taint nodes node1 app=blue:NoSchedule
```

![](https://github.com/codeaprendiz/_assets/blob/master/kubernetes-kitchen/taints-and-tolerations.png)

Now how can we add the tolerations to the pods.
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  containers:
    - name: nginx-container
      image: nginx
  tolerations:
    - key: "app"
    - operator: "Equal"
    - value: "blue"
    - effect: "NoSchedule"
```

When the new pods are created with above `tolerations`, they are either not scheduled on the nodes or evicted from
the existing nodes depending on the `effect` set

Note:
  - NoExecute ensures that a pod with a toleration to a given taint will be accepted on the node with that particular taint. But the pod can 
    still be scheduled on other nodes as well. It also ensures that any other pods that do not have the toleration to the taint and had already been
    scheduled before, would be removed from the node.
  - Also note that the scheduler does not schedule any pods on the master node, this is because the a taint is already created on the master node upon cluster creation.
  
You can check the taints using following command
```bash
$ kubectl describe node docker-desktop | grep Taints
Taints:             <none>
```

## node-selectors
This is used to limit the pod on a particular node
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: myapp-pod
spec:
  containers:
    - name: data-processor
      image: data-processor
  nodeSelector:
    size: Large
```

This also requires labelling the nodes correspondingly. This ensures
that the pod is placed on the right node.
```bash
kubectl label nodes <node-name> <label-key>=<label-value> 
kubectl label nodes node-1 size=Large
```

## node-affinity

- Primary feature of node-affinity is to ensure that the pods are hosted on particular nodes. For example we would want the large data processing pod 
  should end up on node1
  
```yaml
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: size
            operator: In
            values:
            - Large
            - Medium
```

This tells that the `pod` would be placed on any node whose label size has any value in the 
list of values specified here. In this case we are using the `In` operator. Similarly we can also use
`Exists` and `NotIn` and other operators as well.  

The type of node affinity defines the behaviour of the scheduler w.r.t to the node affinity and the stages on the lifecycle of a
pod. Two types are available now
- requiredDuringSchedulingIgnoredDuringExecution
- preferredDuringSchedulingIgnoredDuringExecution

Following are two states in the lifecycle of a pod while considering node affinity

- DuringScheduling 
  - When the pod does not exist and is created for the first time 
  - Now if the `type` is `Required` then it mandates that the pod has to be placed on a node with 
    given affinity, if that node is not present then the pod would not be scheduled
  - If the `type` is `Preferred` then if the node with given affinity is not found then the scheduler
    woudld simply place the pod on any other available node.
- DuringExecution
  - The pod has been running and a change has been made in the environment that affects node affinity such as 
    change in the label of a node. 
  - If the type is `Ignored` then any changes in node affinity would not impact the pods once they are scheduled.
  - If the type is `Required` here then then the existing pods would be evicted if there are any chages in the node affinity of a node i.e. if the 
    label of a node `large` is removed, then the pod with this label `large` would also be evicted.
    
    
## resource-requirement-and-limits

When a pod is placed on a node. It consumes resources available to that node.
It is the kubernetes-scheduler that decides which node a pod goes to. It takes into consideration,
- amount of resources required by a pod
- amount of resources available on the node   

The following table shows the amount of resources that a container in a pod requires to be scheduled. 

**POD**

| CPU  | Memory | Disk |
| ------------- | ------------- |------------ |
| 0.5 | 256 Mi | 2 |

**NODE*

| CPU  | Memory | Disk  |
| ------------- | ------------- |  ------------- |
| ------------- | ------------- |------------- |
|   |   | |
| ------------- | ------------- |------------- |
|  |   |  |
| ------------- | ------------- | ------------- |
| 10 | 10 | 10 |

You can also set the default values for a namespace by using the following
```yaml
apiVersion: v1
kind: LimitRange
metadata:
  name: mem-limit-range
spec:
  limits:
  - default:
      memory: 512Mi
    defaultRequest:
      memory: 256Mi
    type: Container
```

> NOTE: 1 CPU = 1000 m = 1 AWS vCPU = 1 GCP Core = 1 Azure Core

> NOTE: 256 Mi = 256 Mebibyte

> NOTE: 1 Gi = 1 Gibibyte

** In the docker-world ( :) ) a docker container has no limit on the resources it can consume on a node. Say a container starts with 1 vCPU on a node. It can go up and consume
as much resources as required suffocating the native processes on the node or other containers of resources. **

Kubernetes sets a resource limit of 1 vCPU to containers if you do not specify explicitly.
Kubernetes sets a resource limit of 512 Mi to containers if you do not specify explicitly.

You can modify these values in pod defination file

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: frontend
spec:
  containers:
  - name: app
    image: images.my-company.example/app:v4
    resources:
      requests:
        memory: "64Mi"    ## Minimum memory for each container
        cpu: "250m"       ## Minimum cpu for each container
      limits:
        memory: "128Mi"   ## Maximum memory for each container
        cpu: "500m"       # Maximum cpu for each container
```

What happens if a pod tries to go beyond the resource limit
- w.r.t to CPU kubernetes throttles the CPU so a container cannot use more CPU than it has been assigned
- however if a container tries to use more memory than its limit, it is allowed but if it tries to do it constantly
  then the pod would be terminated
  
  
## static-pods

The kubelet can manage the node independently as well.
On the hosts we have `kubelet` as well as `docker` installed to run containers

Suppose if there is not kubernetes cluster (so there is not kube-api-server). The one thing that
the kubelet knows to do is to create pods but we don't have the kube-api-server here to provide 
the pod details

To create a pod we need the details of a pod in the pod defination file. But how do you provide the 
- You can configure the `kubelet` to read the pod defination file from a directory on the server designated to 
store information about pods and place the pods-defination files in this directory.
- the kubelet periodically checks this directory for files, reads these files and creates pods on the host
- it can also ensure that the pod stays alive. If the application crashes, the kubelet attempts to restart it
- if you make any changes in any of the files in this directory, the kubelet then recreates the pods for those changes
  to take effect
- if you remove a pod from this directory then the pod is automatically deleted
So these pods which are created by the kubelet on its own without the intervention of the api server
or rest of the kubernetes componenets are known as static pods. Remember that you can only create pods in this way
and not other kubernetes resources.

So what is that designated folder and how do you configure it?
Path can be any directory on the host and the location of that directory is passed in to the kubelet as an 
option while running the service. The option is in `kubelet.service` file
```bash
ExecStat=/usr/local/bin/kubelet \
--pod-manifest-path=/etc/kubernetes/manifests
```

Similarly, you can also do it using --config option to give path to a file
```bash
ExecStat=/usr/local/bin/kubelet \
--config=kubeconfig.yaml
```

kubeconfig.yaml
```yaml
staticPodPath: /etc/kubernetes/manifests
```

Once the static pods are created you can view them using command
```bash
docker ps 
```

The way the kubelet works is that it can take requests for creating pods from different inputs.
- The first is throught the pod defination file from the static pods folder
- the second is through an http endpoint and that is how the kube-api-server provides input to the kubelet

The kubelet can create both kind of pods: the static pods and the pods requested by the kube-api-server both at the same time.
The kube-api-server is also aware of the static pods created by the kubelet. So if you run the command
```bash
$ kubectl get pods               
NAME                      READY   STATUS    RESTARTS   AGE
static-web-node-0123455     1/1     Running   1          6d20h
```
command then the static pod would also be listed. You can view the static pod in the list(it is actually a *mirror object*)
but you can edit this object like the usual pods. You can only delete them by modifying the files from the 
manifests folder.

Why do we need to deploy the static pods?
Since static pods are not part of the kubernetes-controle-plane (i.e. kube-api-server, etcd.. etc) you can use static pods to deploy the control-plane
componenets itself as pods on a node
- Start by installing kubelet on all the master nodes
- then create pod defination files that uses docker-images of various control-plane components such as
  the `api-server.yaml, controller-manager.yaml, etcd.yaml`
- Then place these defination files in the designated manifest folder
Then the kubelet takes cares of deploying the control-plane-components as pods on a cluster.
That's how a kube-admin tool sets up a kubernetes cluster


## multiple-schedulers

[configure-multiple-schedulers](https://kubernetes.io/docs/tasks/extend-kubernetes/configure-multiple-schedulers/)

When you decide to have your own scheduling algorithm to place pods on the nodes so that you can 
add your own custom conditions and checks in it.

You can write your own kubernetes scheduler program, package it and deploy it as your default scheduler or as an 
additional scheduler in the kubernetes cluster.

When deployed as a additional scheduler, all the other applications can be scheduler by the default scheduler and 
you specific application can use the custom scheduler

While creating a pod or a deployemnt you can instruct kubernetes to have the pod scheduled by 
a specific scheduler.

To deploy an additional scheduler you can use the same kubescheduler binary or a custom binary and set the name parameter
as a custom name `my-custom-scheduler`
```bash
ExecStart=/usr/local/bin/kube-scheduler \\
  --config=/etc/kubernetes/config/kube-scheduler.yaml \\
  --scheduler-name=my-custom-scheduler
```

There is one more option you should be aware about `--leader-elect=[true|false]`
This is used when you have multiple copies of your scheduler running on different master nodes then only one can be
active at a time, that's when this option is used to elect a leader who  will lead the scheduling activity.
To get multiple schedulers working you must either set this option to `false` if you don't have multiple masters. But in case you do 
have multiple masters you can pass in an additional parameter  `--lock-object-name=my-custom-scheduler`, this is to
differentiate the custom scheduler from the default during the leader election process.

Now how to configure a pod to use the new my-custom-scheduler
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
    - name: nginx-container
      image: nginx
  schedulerName: my-custom-scheduler
```

This way when the pod is created the right scheduler picks it up for scheduling.
You can check if your pod was scheduled by the right scheduler by:
```bash
kubectl get events
```

