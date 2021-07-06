-- Create whoami deployment
 
```bash
$ kubectl create deployment whoami-dep --image=containous/whoami:latest --replicas=1
deployment.apps/whoami-dep created
```
 
 - Get the pods
 
 ```bash
$ kubectl get pods                                                                  
NAME                          READY   STATUS    RESTARTS   AGE
whoami-dep-69bccbf994-h8j69   1/1     Running   0          13s
 ```

- Now expose `port 80` of the deployment [docker whoami](https://hub.docker.com/r/containous/whoami/tags?page=1&ordering=last_updated)
  via a NodePort
  
```bash
$ kubectl expose deployment whoami-dep --name=whoami-dep-svc --type=NodePort --port=80 --target-port=80  
service/whoami-dep-svc exposed
```

- Get the service

```bash
$ kubectl get svc                                                                                      
NAME             TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
kubernetes       ClusterIP   10.96.0.1      <none>        443/TCP        34d
whoami-dep-svc   NodePort    10.101.89.89   <none>        80:31773/TCP   14s
```

- Access the deployment using the NodePort

```bash
$ curl http://localhost:31773
Hostname: whoami-dep-69bccbf994-h8j69
IP: 127.0.0.1
IP: 10.1.5.169
RemoteAddr: 192.168.65.6:59354
GET / HTTP/1.1
Host: localhost:31773
User-Agent: curl/7.64.1
Accept: */*
```