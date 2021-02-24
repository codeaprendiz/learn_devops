
### Nodejs Mongo Application on kubernetes

- Build Project

```bash
$ docker build -t codeaprendiz/node-kubernetes .  
```

- Docker Login

```bash
$ docker login -u codeaprendiz                  
Password: 
Login Succeeded
```

- Push the image

```bash
$ docker push codeaprendiz/node-kubernetes                                    
```


- Create secets

 - username
```bash
$ echo "admin" | base64
YWRtaW4K
```

 - password
 
```bash
$ echo "password" | base64
cGFzc3dvcmQK
```



- Set up a k8s cluster on GCP

```bash
$ kubectl get storageclass
NAME                 PROVISIONER             RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
premium-rwo          pd.csi.storage.gke.io   Delete          WaitForFirstConsumer   true                   3m6s
standard (default)   kubernetes.io/gce-pd    Delete          Immediate              true                   3m6s
standard-rwo         pd.csi.storage.gke.io   Delete          WaitForFirstConsumer   true                   3m6s
```