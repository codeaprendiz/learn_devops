-- Create nginx deployment
 
 ```bash
 $ kubectl create deployment nginx-dep --image=nginx --replicas=2
 ```
 
 - Get the pods
 
 ```bash
 $ kubectl get pods
 NAME                        READY   STATUS    RESTARTS   AGE
 nginx-dep-5c5477cb4-76t9q   1/1     Running   0          7h5m
 nginx-dep-5c5477cb4-9g84j   1/1     Running   0          7h5m
 ```

- Now expose `port 80` of the deployment (where the application is runnin i.e. nginx port)
  via a NodePort
  
```bash
$ kubectl expose deployment nginx-dep --name=nginx-dep-svc --type=NodePort --port=80
```

- Get the service

```bash
$ kubectl get svc 
NAME            TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
kubernetes      ClusterIP   10.96.0.1      <none>        443/TCP        31d
nginx-dep-svc   NodePort    10.110.80.21   <none>        80:31239/TCP   21m
```

- Access the deployment using hte NodePort

```bash
$ curl http://localhost:31239  
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```