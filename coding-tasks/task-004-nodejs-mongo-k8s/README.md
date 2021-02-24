
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

- Create resources

```bash
$ kubectl apply -f .
deployment.apps/db created
service/db created
persistentvolumeclaim/dbdata created
deployment.apps/nodejs created
configmap/nodejs-env created
service/nodejs created
secret/mongo-secret created
$ kubectl get svc
NAME         TYPE           CLUSTER-IP   EXTERNAL-IP   PORT(S)        AGE
db           ClusterIP      10.8.8.236   <none>        27017/TCP      17s
kubernetes   ClusterIP      10.8.0.1     <none>        443/TCP        7m24s
nodejs       LoadBalancer   10.8.2.150   <pending>     80:30075/TCP   16s
$ kubectl get pods
NAME                      READY   STATUS              RESTARTS   AGE
db-78d59f4dd6-fhjfj       0/1     ContainerCreating   0          24s
nodejs-6b55db9445-gglbf   0/1     Init:0/1            0          23s
$ kubectl get pods
NAME                      READY   STATUS              RESTARTS   AGE
db-78d59f4dd6-fhjfj       0/1     ContainerCreating   0          29s
nodejs-6b55db9445-gglbf   0/1     Init:0/1            0          28s
$ kubectl get pods
NAME                      READY   STATUS    RESTARTS   AGE
db-78d59f4dd6-fhjfj       1/1     Running   1          74s
nodejs-6b55db9445-gglbf   1/1     Running   0          73s
$ kubectl get svc                                                                                                       
NAME         TYPE           CLUSTER-IP   EXTERNAL-IP     PORT(S)        AGE
db           ClusterIP      10.8.8.236   <none>          27017/TCP      84s
kubernetes   ClusterIP      10.8.0.1     <none>          443/TCP        8m31s
nodejs       LoadBalancer   10.8.2.150   35.239.116.72   80:30075/TCP   83s
```