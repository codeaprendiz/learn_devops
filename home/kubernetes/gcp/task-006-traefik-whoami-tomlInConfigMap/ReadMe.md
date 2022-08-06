## To deploy traefik on GKE with whoami service when toml file is passed as configMap mounted to deployment of Traefik


- Run the following command (you may run it again if you get error for the first time as some
custom resources take some time to get created)

```bash
kubectl apply -f .
```

- Get the public IP of Treafik-Service
```bash
$ kubectl get service
NAME         TYPE           CLUSTER-IP      EXTERNAL-IP    PORT(S)                                     AGE
kubernetes   ClusterIP      10.109.0.1      <none>         443/TCP                                     179m
traefik      LoadBalancer   10.109.4.20     34.66.233.93   80:30521/TCP,443:32062/TCP,8080:30299/TCP   2m26s
whoami       ClusterIP      10.109.12.195   <none>         80/TCP                                      2m25s                      84s
```



- Features enabled

![](./../../../images/kubernetes/gcp/task-006-traefik-whoami-tomlInConfigMap/features-enabled-in-toml-inside-configMap.png)


- whoami
    
![](./../../../images/kubernetes/gcp/task-006-traefik-whoami-tomlInConfigMap/whoami-service.png)