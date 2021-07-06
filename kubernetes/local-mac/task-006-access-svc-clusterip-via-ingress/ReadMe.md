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
whoami-dep-69bccbf994-2c5wb   1/1     Running   0          13s
 ```

- Create service

```bash
$ kubectl expose deployment whoami-dep --name=whoami-dep-svc --port=80 --target-port=80
service/whoami-dep-svc exposed
```

- Get the service

```bash
$ kubectl get svc                                                                      
NAME             TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
kubernetes       ClusterIP   10.96.0.1       <none>        443/TCP   34d
whoami-dep-svc   ClusterIP   10.96.153.224   <none>        80/TCP    44s
```

- Now deploy the ingress

```bash
$ kubectl apply -f ingress.yaml 
ingress.networking.k8s.io/ingress-wildcard-host created
```

- Test the URL

```bash
$ curl http://testingress.com:80/whoami
Hostname: whoami-dep-69bccbf994-2c5wb
IP: 127.0.0.1
IP: 10.1.5.170
RemoteAddr: 10.1.5.165:44774
GET /whoami HTTP/1.1
Host: testingress.com
User-Agent: curl/7.64.1
Accept: */*
X-Forwarded-For: 192.168.65.6
X-Forwarded-Host: testingress.com
X-Forwarded-Port: 80
X-Forwarded-Proto: http
X-Real-Ip: 192.168.65.6
X-Request-Id: db7be3da05b1d37d13e733d31fa2ecde
X-Scheme: http
```

- Testing wrong URLs

```bash
$ curl http://testingress.com:80/whoami32
<html>
<head><title>404 Not Found</title></head>
<body>
<center><h1>404 Not Found</h1></center>
<hr><center>nginx</center>
</body>
</html>
```