[Docs](https://kubernetes.io/docs/concepts/services-networking/ingress/)

-- Create nginx deployment
 
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

- Now expose `port 80` of the deployment 
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

- Lets deploy ingress to access the service. Before deploying the ingress, we need
  ingress-controller to be deployed first
  [ingress-nginx/deploy/#docker-desktop](https://kubernetes.github.io/ingress-nginx/deploy/#docker-desktop)
  
```bash
$ kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.47.0/deploy/static/provider/cloud/deploy.yaml           
namespace/ingress-nginx created
serviceaccount/ingress-nginx created
configmap/ingress-nginx-controller created
clusterrole.rbac.authorization.k8s.io/ingress-nginx created
clusterrolebinding.rbac.authorization.k8s.io/ingress-nginx created
role.rbac.authorization.k8s.io/ingress-nginx created
rolebinding.rbac.authorization.k8s.io/ingress-nginx created
service/ingress-nginx-controller-admission created
service/ingress-nginx-controller created
deployment.apps/ingress-nginx-controller created
validatingwebhookconfiguration.admissionregistration.k8s.io/ingress-nginx-admission created
serviceaccount/ingress-nginx-admission created
clusterrole.rbac.authorization.k8s.io/ingress-nginx-admission created
clusterrolebinding.rbac.authorization.k8s.io/ingress-nginx-admission created
role.rbac.authorization.k8s.io/ingress-nginx-admission created
rolebinding.rbac.authorization.k8s.io/ingress-nginx-admission created
job.batch/ingress-nginx-admission-create created
job.batch/ingress-nginx-admission-patch created
```

- Now deploy the ingress

```bash
$ kubectl apply -f ingress.yaml
ingress.networking.k8s.io/ingress-wildcard-host configured
```


- you can add a host entry to your /etc/hosts file and check

```bash
$ cat /etc/hosts | grep test                                                                                            
127.0.0.1 testingress.com
```

- Now curl

```bash
$ curl http://testingress.com:80/whoami   
Hostname: whoami-dep-69bccbf994-h8j69
IP: 127.0.0.1
IP: 10.1.5.169
RemoteAddr: 10.1.5.165:43228
GET /whoami HTTP/1.1
Host: testingress.com
User-Agent: curl/7.64.1
Accept: */*
X-Forwarded-For: 192.168.65.6
X-Forwarded-Host: testingress.com
X-Forwarded-Port: 80
X-Forwarded-Proto: http
X-Real-Ip: 192.168.65.6
X-Request-Id: b6b70ad80af2752c7eba250b620b18e2
X-Scheme: http
```

- Try any other URL

```bash
$ curl http://testingress.com:80                
<html>
<head><title>404 Not Found</title></head>
<body>
<center><h1>404 Not Found</h1></center>
<hr><center>nginx</center>
</body>
</html>

$ curl http://testingress.com:80/whoami234
<html>
<head><title>404 Not Found</title></head>
<body>
<center><h1>404 Not Found</h1></center>
<hr><center>nginx</center>
</body>
</html>

```