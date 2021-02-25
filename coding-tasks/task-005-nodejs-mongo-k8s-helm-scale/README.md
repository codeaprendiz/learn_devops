### Objectives

Tasks |   Exit Criteria | Status |
---    | --- | --- | 
Nodejs Mongo App | Create an application with Nodejs with Mongo as database | Done
Clean Dockerfile | Try to optimize the Dockerfile by removing all unnecessary cache/files to reduce the image size. | Done
Docker Image Size | Remove caches | Done
Security | Removing unnecessary binaries/permissions to improve container security is a huge plus. |  
docker-compose up  | docker-compose up runs the app locally | Done | 
kubernetes resources | You should have all k8s resources | Done | 
Health checks on pods | Health check probes like /healthz or any other | Done
Automatic Scaling | No of pods should increase if load increases | Done
Use Config Maps for environments vars | Use config maps for env vars | Done
Use Secrets for passwords | Use secrets for passwords | Done
Have declarative resource limits in pods | Define resource limits in pods | Done
Use Helm to create template | Use helm charts for node and mongo | Done


[doc](https://www.digitalocean.com/community/tutorials/how-to-scale-a-node-js-application-with-mongodb-on-kubernetes-using-helm)




- build image using

```bash
$ docker build -t codeaprendiz/node-replicas .  
```

- login to dockerhub

```bash
$ docker login -u codeaprendiz                
Password: 
Login Succeeded
```

- push the image

```bash
$ docker push codeaprendiz/node-replicas  
```



- create secret for mongo

```bash
$ kubectl create secret generic mongo-secret --from-literal=MONGO_USERNAME=admin --from-literal=MONGO_PASSWORD=password --dry-run=client -o yaml > secret.yaml
```

- Ensure that you have a storage class in your k8s cluster

- Create the values file mongodb-values.yaml

- Add stable version of the mongodb-replicaset chart [Referred stackoverflow](https://stackoverflow.com/questions/57970255/helm-v3-cannot-find-the-official-repo)

[bitnami/mongodb](https://github.com/bitnami/charts/tree/master/bitnami/mongodb)
[values.yam](https://github.com/bitnami/charts/blob/master/bitnami/mongodb/values.yaml)
```bash
$ helm version                  
version.BuildInfo{Version:"v3.5.2", GitCommit:"167aac70832d3a384f65f9745335e9fb40169dc2", GitTreeState:"dirty", GoVersion:"go1.15.7"}

$ helm repo add stable https://charts.helm.sh/stable
"stable" has been added to your repositories

$ helm repo add bitnami https://charts.bitnami.com/bitnami
"bitnami" has been added to your repositories

$ helm repo update                                                                                   
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "bitnami" chart repository
...Successfully got an update from the "stable" chart repository
Update Complete. ⎈Happy Helming!⎈


$ helm install mongo -f mongodb-values.yaml bitnami/mongodb --dry-run --debug > helm-output.txt
install.go:173: [debug] Original chart version: ""
install.go:190: [debug] CHART PATH: /Users/ankitsinghrathi/Library/Caches/helm/repository/mongodb-10.7.1.tgz

## OR
## Lets create the templates
$ helm template mongo -f mongodb-values.yaml bitnami/mongodb > resources.yaml

```



- Creating Custom Application Chart and Configuring parameters

```bash
$ helm create nodeapp
Creating nodeapp
```


- Create the nodeapp resources

```bash

```