# Let's Encrypt And Cert-Manager

## Create Cluster

```bash
╰─ kind create cluster
╰─ kubectl get nodes
NAME                 STATUS   ROLES           AGE    VERSION
kind-control-plane   Ready    control-plane   117s   v1.25.3
```

## Cert-Manager Releases

[cert-manager/releases/tag/v1.10.0](https://github.com/cert-manager/cert-manager/releases/tag/v1.10.0)

```bash
## Download the yaml
╰─ wget https://github.com/cert-manager/cert-manager/releases/download/v1.10.0/cert-manager.yaml
╰─ ls
ReadMe.md         cert-manager.yaml
╰─ cat cert-manager.yaml| wc -l                                          
    5518
```

- Create namespace and Deploy

```bash
╰─ kubectl apply -f cert-manager.yaml

## Did it work or what ?
╰─ kubectl get all -n cert-manager
NAME                                          READY   STATUS    RESTARTS   AGE
pod/cert-manager-6dc4964c9-jd6mq              1/1     Running   0          7m57s
pod/cert-manager-cainjector-69d4647c6-mhvvf   1/1     Running   0          7m57s
pod/cert-manager-webhook-75f77865c8-52jk4     1/1     Running   0          7m57s

NAME                           TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
service/cert-manager           ClusterIP   10.96.236.95    <none>        9402/TCP   7m57s
service/cert-manager-webhook   ClusterIP   10.96.250.149   <none>        443/TCP    7m57s

NAME                                      READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/cert-manager              1/1     1            1           7m57s
deployment.apps/cert-manager-cainjector   1/1     1            1           7m57s
deployment.apps/cert-manager-webhook      1/1     1            1           7m57s

NAME                                                DESIRED   CURRENT   READY   AGE
replicaset.apps/cert-manager-6dc4964c9              1         1         1       7m57s
replicaset.apps/cert-manager-cainjector-69d4647c6   1         1         1       7m57s
replicaset.apps/cert-manager-webhook-75f77865c8     1         1         1       7m57s


## Okay it did
```


## Let's deploy ingress-controller

You can download the ingress controller from [ingress-nginx/releases/tag/controller-v1.4.0](https://github.com/kubernetes/ingress-nginx/releases/tag/controller-v1.4.0)

```bash
# Deploy from downloaded dir
╰─ ls 
ReadMe.md                           cert-manager.yaml                   ingress-nginx-controller-v1.4.0     ingress-nginx-controller-v1.4.0.zip

╰─ find . -name deploy.yaml | grep cloud
./ingress-nginx-controller-v1.4.0/deploy/static/provider/cloud/deploy.yaml

# The same file is also available as raw content https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.4.0/deploy/static/provider/cloud/deploy.yaml
╰─ kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.4.0/deploy/static/provider/cloud/deploy.yaml                 


## See if its working
╰─ kubectl get all -n ingress-nginx
NAME                                            READY   STATUS      RESTARTS   AGE
pod/ingress-nginx-admission-create-7blsw        0/1     Completed   0          2m18s
pod/ingress-nginx-admission-patch-58bm7         0/1     Completed   0          2m18s
pod/ingress-nginx-controller-7844b9db77-kptln   1/1     Running     0          2m18s

NAME                                         TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)                      AGE
service/ingress-nginx-controller             LoadBalancer   10.96.54.164   <pending>     80:32367/TCP,443:31957/TCP   2m18s
service/ingress-nginx-controller-admission   ClusterIP      10.96.13.5     <none>        443/TCP                      2m18s

NAME                                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/ingress-nginx-controller   1/1     1            1           2m18s

NAME                                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/ingress-nginx-controller-7844b9db77   1         1         1       2m18s

NAME                                       COMPLETIONS   DURATION   AGE
job.batch/ingress-nginx-admission-create   1/1           18s        2m18s
job.batch/ingress-nginx-admission-patch    1/1           19s        2m18s
```

- The EXTERNAL IP is not binded as we are working locally, so let's bind using port-forward in different terminals

```bash
## Terminal 2
╰─ kubectl -n ingress-nginx --address 0.0.0.0 port-forward svc/ingress-nginx-controller 443
Forwarding from 0.0.0.0:443 -> 443

## Terminal 3
╰─ kubectl -n ingress-nginx --address 0.0.0.0 port-forward svc/ingress-nginx-controller 80
Forwarding from 0.0.0.0:80 -> 80

## Terminal 1
╰─ curl http://localhost -I
HTTP/1.1 404 Not Found

```

- If you can login to your home route, you can set up a port-forwarding rule to your machine 

```bash
╰─ curl http://5.194.32.235/ -I
HTTP/1.1 404 Not Found

## Now using AWS Route53, you can map the public IP with a domain name that you own
╰─ curl http://testcertmanager.mydomain.com -I                     
HTTP/1.1 404 Not Found

```

## Let's add a cluster-isser.yaml

[cert-manager.io/docs/configuration/acme/](https://cert-manager.io/docs/configuration/acme/)



- Apply the changes

```bash
╰─ kubectl apply -f cluster-issuer.yaml                                                                                                  
clusterissuer.cert-manager.io/letsencrypt-staging created

╰─ kubectl get ClusterIssuer              
NAME                  READY   AGE
letsencrypt-staging   False   53s

## Make sure you change with a valid email address
╰─ cat cluster-issuer.yaml| grep email
    # You must replace this email address with your own.
    email: kedesom362@corylan.com

```

- Let's deploy a sample application like [traefik/whoami](https://doc.traefik.io/traefik/getting-started/quick-start-with-kubernetes/)

```bash
╰─ kubectl apply -f dep-whoami.yaml    
deployment.apps/whoami created

╰─ kubectl get pods                
NAME                      READY   STATUS    RESTARTS   AGE
whoami-5dfdf459f4-4nzcd   1/1     Running   0          64s

╰─ kubectl get deployment
NAME     READY   UP-TO-DATE   AVAILABLE   AGE
whoami   1/1     1            1           3m7s

```

- Let's expose the dep using a svc

```bash
╰─ kubectl expose deployment whoami --port=80 --target-port=80 --type=LoadBalancer
service/whoami exposed

╰─ kubectl get svc                                               
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   3h17m
whoami       ClusterIP   10.96.80.3   <none>        80/TCP    11s

## Terminal n
╰─ kubectl port-forward --namespace default pod/whoami-5dfdf459f4-4nzcd 8081:80
Forwarding from 127.0.0.1:8081 -> 80

## Terminal 1
╰─ curl http://localhost:8081 -I                                       
HTTP/1.1 200 OK
```

- Create Ingress

[configuration/ingress-resources/basic-configuration](https://docs.nginx.com/nginx-ingress-controller/configuration/ingress-resources/basic-configuration/)

- Without `tls` section enabled

```bash
╰─ cat ingress.yaml | grep "#"
# https://docs.nginx.com/nginx-ingress-controller/configuration/ingress-resources/basic-configuration/
#  tls:
#    - hosts:
#        - testcertmanager.domainname.com
#      secretName: tls-secret


╰─ kubectl apply -f ingress.yaml
ingress.networking.k8s.io/whoami-ingress configured

╰─ curl http://testcertmanager.domainname.com -I                      
HTTP/1.1 200 OK

╰─ curl https://testcertmanager.domainname.com -I
curl: (60) SSL certificate problem: unable to get local issuer certificate

```

## Let's create a certificate.yaml

[cert-manager.io/docs/concepts/certificate](https://cert-manager.io/docs/concepts/certificate/)

