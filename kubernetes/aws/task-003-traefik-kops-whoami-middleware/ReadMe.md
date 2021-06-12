[docs](https://github.com/traefik/traefik-helm-chart)


- Version

```bash
$ helm version                
version.BuildInfo{Version:"v3.5.4", GitCommit:"1b5edb69df3d3a08df77c9902dc17af864ff05d1", GitTreeState:"dirty", GoVersion:"go1.16.3"}
```

- Pull the repo

```bash
$ git clone https://github.com/traefik/traefik-helm-chart.git
$ ls                      
ReadMe.md          traefik-helm-chart

## Create the CRDs
$ kubectl apply -f traefik-helm-chart/traefik/crds/.                     
Warning: apiextensions.k8s.io/v1beta1 CustomResourceDefinition is deprecated in v1.16+, unavailable in v1.22+; use apiextensions.k8s.io/v1 CustomResourceDefinition
customresourcedefinition.apiextensions.k8s.io/ingressroutes.traefik.containo.us created
customresourcedefinition.apiextensions.k8s.io/ingressroutetcps.traefik.containo.us created
customresourcedefinition.apiextensions.k8s.io/ingressrouteudps.traefik.containo.us created
customresourcedefinition.apiextensions.k8s.io/middlewares.traefik.containo.us created
customresourcedefinition.apiextensions.k8s.io/serverstransports.traefik.containo.us created
customresourcedefinition.apiextensions.k8s.io/tlsoptions.traefik.containo.us created
customresourcedefinition.apiextensions.k8s.io/tlsstores.traefik.containo.us created
customresourcedefinition.apiextensions.k8s.io/traefikservices.traefik.containo.us created


$ cd traefik-helm-chart
$ helm repo update                                                                                         
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "jetstack" chart repository
...Successfully got an update from the "traefik" chart repository
...Successfully got an update from the "datadog" chart repository
...Successfully got an update from the "stable" chart repository
...Successfully got an update from the "bitnami" chart repository
Update Complete. ⎈Happy Helming!⎈

$ helm template treafik-helm-template -f traefik/values.yaml traefik/traefik > ../treafik-resources.yaml
$ cp -rfp traefik/values.yaml ../                         
$ cd ..
$ rm -rf traefik-helm-chart    
```

- Get nodes

```bash
$ kubectl get nodes           
NAME                            STATUS   ROLES    AGE   VERSION
ip-172-20-38-163.ec2.internal   Ready    master   30m   v1.19.11
ip-172-20-62-14.ec2.internal    Ready    node     27m   v1.19.11
```

- Try deploying traefik. Looks like CRDs didn't get installed. 
```
$ kubectl apply -f treafik-resources.yaml
serviceaccount/treafik-helm-template-traefik unchanged
clusterrole.rbac.authorization.k8s.io/treafik-helm-template-traefik unchanged
clusterrolebinding.rbac.authorization.k8s.io/treafik-helm-template-traefik unchanged
deployment.apps/treafik-helm-template-traefik configured
service/treafik-helm-template-traefik unchanged
error: unable to recognize "treafik-resources.yaml": no matches for kind "IngressRoute" in version "traefik.containo.us/v1alpha1"

$ git clone https://github.com/traefik/traefik-helm-chart.git
$ ls                      
ReadMe.md          traefik-helm-chart

## Create the CRDs
$ kubectl apply -f traefik-helm-chart/traefik/crds/.                     
Warning: apiextensions.k8s.io/v1beta1 CustomResourceDefinition is deprecated in v1.16+, unavailable in v1.22+; use apiextensions.k8s.io/v1 CustomResourceDefinition
customresourcedefinition.apiextensions.k8s.io/ingressroutes.traefik.containo.us created
customresourcedefinition.apiextensions.k8s.io/ingressroutetcps.traefik.containo.us created
customresourcedefinition.apiextensions.k8s.io/ingressrouteudps.traefik.containo.us created
customresourcedefinition.apiextensions.k8s.io/middlewares.traefik.containo.us created
customresourcedefinition.apiextensions.k8s.io/serverstransports.traefik.containo.us created
customresourcedefinition.apiextensions.k8s.io/tlsoptions.traefik.containo.us created
customresourcedefinition.apiextensions.k8s.io/tlsstores.traefik.containo.us created
customresourcedefinition.apiextensions.k8s.io/traefikservices.traefik.containo.us created

$ rm -rf traefik-helm-chart                 


$ kubectl apply -f treafik-resources.yaml            
serviceaccount/treafik-helm-template-traefik unchanged
clusterrole.rbac.authorization.k8s.io/treafik-helm-template-traefik unchanged
clusterrolebinding.rbac.authorization.k8s.io/treafik-helm-template-traefik unchanged
deployment.apps/treafik-helm-template-traefik configured
service/treafik-helm-template-traefik unchanged
ingressroute.traefik.containo.us/treafik-helm-template-traefik-dashboard created


$ kubectl get svc                        
NAME                            TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)                      AGE
kubernetes                      ClusterIP      100.64.0.1      <none>        443/TCP                      37m
treafik-helm-template-traefik   LoadBalancer   100.66.189.36   <pending>     80:32127/TCP,443:30552/TCP   6m44s
```

- Its in Pending state duo to the following error

```bash
$ kubectl describe svc treafik-helm-template-traefik                            
.
.
Error syncing load balancer: failed to ensure load balancer: AccessDenied
```

- Trying again with correct permissions.

```bash
$ kubectl get svc
NAME                            TYPE           CLUSTER-IP      EXTERNAL-IP                                                              PORT(S)                      AGE
kubernetes                      ClusterIP      100.64.0.1      <none>                                                                   443/TCP                      16m
treafik-helm-template-traefik   LoadBalancer   100.65.168.87   a93259cfe3e6840489e86a2b80b5f26d-546301547.us-east-1.elb.amazonaws.com   80:32444/TCP,443:32481/TCP   7m38s
```

You will get the following Load Balancer on AWS

![](../../../images/kubernetes/aws/task-001-deploy-treafik-kops-k8s-helm/aws_load_balancer.png)


Now we are getting 404 when we hit the load balancer.

```bash
$ curl -v a93259cfe3e6840489e86a2b80b5f26d-546301547.us-east-1.elb.amazonaws.com                                                                                                                                  
*   Trying 54.175.76.116...
* TCP_NODELAY set
* Connected to a93259cfe3e6840489e86a2b80b5f26d-546301547.us-east-1.elb.amazonaws.com (54.175.76.116) port 80 (#0)
> GET / HTTP/1.1
> Host: a93259cfe3e6840489e86a2b80b5f26d-546301547.us-east-1.elb.amazonaws.com
> User-Agent: curl/7.64.1
> Accept: */*
> 
< HTTP/1.1 404 Not Found
< Content-Type: text/plain; charset=utf-8
< X-Content-Type-Options: nosniff
< Date: Thu, 10 Jun 2021 05:35:38 GMT
< Content-Length: 19
< 
404 page not found
* Connection #0 to host a93259cfe3e6840489e86a2b80b5f26d-546301547.us-east-1.elb.amazonaws.com left intact
* Closing connection 0
```

In the next tasks we will try deploying some app behind load balancer and test routes.

```bash
$ kubectl apply -f whoami.yaml 
deployment.apps/whoami unchanged
service/whoami unchanged
ingressroute.traefik.containo.us/whoami-whoami unchanged


$ curl http://ad639fc8779704f558f7f3132f112d96-330009778.us-east-1.elb.amazonaws.com/whoami-app-api
Hostname: whoami-658d568b94-gwvcl
IP: 127.0.0.1
IP: 100.96.1.7
RemoteAddr: 100.96.1.5:58624
GET /whoami-app-api HTTP/1.1
Host: ad639fc8779704f558f7f3132f112d96-330009778.us-east-1.elb.amazonaws.com
User-Agent: curl/7.64.1
Accept: */*
Accept-Encoding: gzip
X-Forwarded-For: 100.96.1.1
X-Forwarded-Host: ad639fc8779704f558f7f3132f112d96-330009778.us-east-1.elb.amazonaws.com
X-Forwarded-Port: 80
X-Forwarded-Proto: http
X-Forwarded-Server: treafik-helm-template-traefik-bf8f77bfc-jznxx
X-Real-Ip: 100.96.1.1
```


- Let's deploy the dashboard

```bash
$ kubectl port-forward $(kubectl get pods --selector "app.kubernetes.io/name=traefik" --output=name) 9000:9000

Forwarding from 127.0.0.1:9000 -> 9000
Forwarding from [::1]:9000 -> 9000
Handling connection for 9000
Handling connection for 9000
Handling connection for 9000
Handling connection for 9000
```

![](../../../images/kubernetes/aws/task-002-treafik-kops-whoami/treafik-dashboard.png)



- Let's try to deploy some middlewares. Ensure that the middleware.yaml is deployed

```bash
kubectl apply -f middleware.yaml
```

- Also the route in IngressRoute should contain the middleware reference as show in the example
- When the changes are deployed with the following part commented. See the response we get
```bash
$ cat whoami.yaml| grep -A 4 middleware          
#      middlewares:
#        - name: test-stripprefix
#          namespace: default

$ curl http://ad639fc8779704f558f7f3132f112d96-330009778.us-east-1.elb.amazonaws.com/api/whoami-app-api/
Hostname: whoami-658d568b94-k8v8d
IP: 127.0.0.1
IP: 100.96.1.18
RemoteAddr: 100.96.1.5:55748
GET /api/whoami-app-api/ HTTP/1.1
Host: ad639fc8779704f558f7f3132f112d96-330009778.us-east-1.elb.amazonaws.com
User-Agent: curl/7.64.1
Accept: */*
Accept-Encoding: gzip
X-Forwarded-For: 100.96.1.1
X-Forwarded-Host: ad639fc8779704f558f7f3132f112d96-330009778.us-east-1.elb.amazonaws.com
X-Forwarded-Port: 80
X-Forwarded-Proto: http
X-Forwarded-Server: treafik-helm-template-traefik-bf8f77bfc-jznxx
X-Real-Ip: 100.96.1.1
```

> Note: the GET /api/whoami-app-api/ HTTP/1.1 and there is not X-Forwarded-Prefix

- Now when the middleware part above is uncommented and deployed again

```bash
$ curl http://ad639fc8779704f558f7f3132f112d96-330009778.us-east-1.elb.amazonaws.com/api/whoami-app-api/
Hostname: whoami-658d568b94-k8v8d
IP: 127.0.0.1
IP: 100.96.1.18
RemoteAddr: 100.96.1.5:57574
GET /whoami-app-api/ HTTP/1.1
Host: ad639fc8779704f558f7f3132f112d96-330009778.us-east-1.elb.amazonaws.com
User-Agent: curl/7.64.1
Accept: */*
Accept-Encoding: gzip
X-Forwarded-For: 100.96.1.1
X-Forwarded-Host: ad639fc8779704f558f7f3132f112d96-330009778.us-east-1.elb.amazonaws.com
X-Forwarded-Port: 80
X-Forwarded-Prefix: /api/
X-Forwarded-Proto: http
X-Forwarded-Server: treafik-helm-template-traefik-bf8f77bfc-jznxx
X-Real-Ip: 100.96.1.1
```

> Note: GET /whoami-app-api/ HTTP/1.1 and X-Forwarded-Prefix: /api/     which says that the middleware is working.
    
    
    