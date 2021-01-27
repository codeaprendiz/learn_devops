# Exposing an External IP Address to Access an Application in a Cluster

[Referred Doc](https://kubernetes.io/docs/tutorials/stateless-application/expose-external-ip-address/)

- Run a Hello World application in your cluster:

```bash
$ kubectl apply -f service/load-balancer-example.yaml
deployment.apps/hello-world created
```

- Display information about the Deployment:

```bash
$ kubectl get deployments hello-world
NAME          READY   UP-TO-DATE   AVAILABLE   AGE
hello-world   5/5     5            5           46s

$ kubectl describe deployments hello-world
Name:                   hello-world
Namespace:              default
CreationTimestamp:      Mon, 13 Apr 2020 17:37:05 +0400
Labels:                 app.kubernetes.io/name=load-balancer-example
Annotations:            deployment.kubernetes.io/revision: 1
                        kubectl.kubernetes.io/last-applied-configuration:
                          {"apiVersion":"apps/v1","kind":"Deployment","metadata":{"annotations":{},"labels":{"app.kubernetes.io/name":"load-balancer-example"},"name...
Selector:               app.kubernetes.io/name=load-balancer-example
Replicas:               5 desired | 5 updated | 5 total | 5 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  app.kubernetes.io/name=load-balancer-example
  Containers:
   hello-world:
    Image:        gcr.io/google-samples/node-hello:1.0
    Port:         8080/TCP
    Host Port:    0/TCP
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   hello-world-7dc74ff97c (5/5 replicas created)
Events:
  Type    Reason             Age   From                   Message
  ----    ------             ----  ----                   -------
  Normal  ScalingReplicaSet  68s   deployment-controller  Scaled up replica set hello-world-7dc74ff97c to 5
```

- Display information about your ReplicaSet objects:
```bash
$ kubectl get replicasets
NAME                     DESIRED   CURRENT   READY   AGE
hello-world-7dc74ff97c   5         5         5       2m20s

$ kubectl describe replicasets
Name:           hello-world-7dc74ff97c
Namespace:      default
Selector:       app.kubernetes.io/name=load-balancer-example,pod-template-hash=7dc74ff97c
Labels:         app.kubernetes.io/name=load-balancer-example
                pod-template-hash=7dc74ff97c
Annotations:    deployment.kubernetes.io/desired-replicas: 5
                deployment.kubernetes.io/max-replicas: 7
                deployment.kubernetes.io/revision: 1
Controlled By:  Deployment/hello-world
Replicas:       5 current / 5 desired
Pods Status:    5 Running / 0 Waiting / 0 Succeeded / 0 Failed
Pod Template:
  Labels:  app.kubernetes.io/name=load-balancer-example
           pod-template-hash=7dc74ff97c
  Containers:
   hello-world:
    Image:        gcr.io/google-samples/node-hello:1.0
    Port:         8080/TCP
    Host Port:    0/TCP
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Events:
  Type    Reason            Age    From                   Message
  ----    ------            ----   ----                   -------
  Normal  SuccessfulCreate  2m36s  replicaset-controller  Created pod: hello-world-7dc74ff97c-cbhj9
  Normal  SuccessfulCreate  2m35s  replicaset-controller  Created pod: hello-world-7dc74ff97c-2t8rh
  Normal  SuccessfulCreate  2m35s  replicaset-controller  Created pod: hello-world-7dc74ff97c-rzrgz
  Normal  SuccessfulCreate  2m35s  replicaset-controller  Created pod: hello-world-7dc74ff97c-gcrrx
  Normal  SuccessfulCreate  2m35s  replicaset-controller  Created pod: hello-world-7dc74ff97c-hzght
```

- Create a Service object that exposes the deployment:

```bash
$ kubectl expose deployment hello-world --type=LoadBalancer --name=my-service
service/my-service exposed
```

- Display information about the Service:
```bash
$ kubectl get services my-service
NAME         TYPE           CLUSTER-IP   EXTERNAL-IP   PORT(S)          AGE
my-service   LoadBalancer   10.8.7.223   <pending>     8080:32136/TCP   26s

$ kubectl get services my-service
NAME         TYPE           CLUSTER-IP   EXTERNAL-IP   PORT(S)          AGE
my-service   LoadBalancer   10.8.7.223   34.71.6.149   8080:32136/TCP   58s
```

- Display detailed information about the Service:
```bash
$ kubectl describe services my-service
Name:                     my-service
Namespace:                default
Labels:                   app.kubernetes.io/name=load-balancer-example
Annotations:              <none>
Selector:                 app.kubernetes.io/name=load-balancer-example
Type:                     LoadBalancer
IP:                       10.8.7.223
LoadBalancer Ingress:     34.71.6.149
Port:                     <unset>  8080/TCP
TargetPort:               8080/TCP
NodePort:                 <unset>  32136/TCP
Endpoints:                10.4.0.4:8080,10.4.0.5:8080,10.4.1.5:8080 + 2 more...
Session Affinity:         None
External Traffic Policy:  Cluster
Events:
  Type    Reason                Age    From                Message
  ----    ------                ----   ----                -------
  Normal  EnsuringLoadBalancer  2m33s  service-controller  Ensuring load balancer
  Normal  EnsuredLoadBalancer   108s   service-controller  Ensured load balancer
```

- In the preceding output, you can see that the service has several endpoints: 
10.4.0.4:8080,10.4.0.5:8080,10.4.1.5:8080 + 2 more.... These are internal addresses of the pods that are running the Hello World application.
To verify these are pod addresses, enter this command:

```bash
$ kubectl get pods --output=wide
NAME                           READY   STATUS    RESTARTS   AGE     IP         NODE                                       NOMINATED NODE   READINESS GATES
hello-world-7dc74ff97c-2t8rh   1/1     Running   0          7m30s   10.4.1.6   gke-cluster-1-default-pool-2cacae53-j8nh   <none>           <none>
hello-world-7dc74ff97c-cbhj9   1/1     Running   0          7m30s   10.4.1.5   gke-cluster-1-default-pool-2cacae53-j8nh   <none>           <none>
hello-world-7dc74ff97c-gcrrx   1/1     Running   0          7m29s   10.4.2.9   gke-cluster-1-default-pool-2cacae53-cmwk   <none>           <none>
hello-world-7dc74ff97c-hzght   1/1     Running   0          7m29s   10.4.0.5   gke-cluster-1-default-pool-2cacae53-f5kg   <none>           <none>
hello-world-7dc74ff97c-rzrgz   1/1     Running   0          7m30s   10.4.0.4   gke-cluster-1-default-pool-2cacae53-f5kg   <none>           <none>
```

- You can get more details by output-ing the resource in yaml format
```bash
$ kubectl get service
NAME         TYPE           CLUSTER-IP   EXTERNAL-IP   PORT(S)          AGE
kubernetes   ClusterIP      10.8.0.1     <none>        443/TCP          33m
my-service   LoadBalancer   10.8.7.223   34.71.6.149   8080:32136/TCP   14m

$ kubectl get service my-service -o yaml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: "2020-04-13T13:40:36Z"
  labels:
    app.kubernetes.io/name: load-balancer-example
  name: my-service
  namespace: default
  resourceVersion: "4763"
  selfLink: /api/v1/namespaces/default/services/my-service
  uid: 5af8c7e6-7d8c-11ea-b1b6-42010a800fcd
spec:
  clusterIP: 10.8.7.223
  externalTrafficPolicy: Cluster
  ports:
  - nodePort: 32136
    port: 8080
    protocol: TCP
    targetPort: 8080
  selector:
    app.kubernetes.io/name: load-balancer-example
  sessionAffinity: None
  type: LoadBalancer
status:
  loadBalancer:
    ingress:
    - ip: 34.71.6.149
```

- Use the external IP address (LoadBalancer Ingress) to access the Hello World application:
```bash
$ curl -v http://34.71.6.149:8080/     
*   Trying 34.71.6.149...
* TCP_NODELAY set
* Connected to 34.71.6.149 (34.71.6.149) port 8080 (#0)
> GET / HTTP/1.1
> Host: 34.71.6.149:8080
> User-Agent: curl/7.64.1
> Accept: */*
> 
< HTTP/1.1 200 OK
< Date: Mon, 13 Apr 2020 13:46:33 GMT
< Connection: keep-alive
< Transfer-Encoding: chunked
< 
* Connection #0 to host 34.71.6.149 left intact
Hello Kubernetes!* Closing connection 0
```


- Cleaning up
```bash
$ kubectl delete services my-service
service "my-service" deleted
$ kubectl delete deployment hello-world
deployment.extensions "hello-world" deleted
```