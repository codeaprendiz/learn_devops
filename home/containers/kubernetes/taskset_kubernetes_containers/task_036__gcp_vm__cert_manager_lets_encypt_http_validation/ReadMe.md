# Let's Encrypt And Cert-Manager

<br>

## Create Cluster

```bash
╰─ kind create cluster
╰─ kubectl get nodes
NAME                 STATUS   ROLES           AGE    VERSION
kind-control-plane   Ready    control-plane   117s   v1.25.3
```

<br>

## Cert-Manager Releases

[cert-manager/releases/tag/v1.10.0](https://github.com/cert-manager/cert-manager/releases/tag/v1.10.0)

```bash
<br>

## Download the yaml
╰─ wget https://github.com/cert-manager/cert-manager/releases/download/v1.10.0/cert-manager.yaml
╰─ ls
ReadMe.md         cert-manager.yaml
╰─ cat cert-manager.yaml| wc -l                                          
    5518
```

- Deploy cert-manager

```bash
╰─ kubectl apply -f cert-manager.yaml

<br>

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


<br>

## Okay it did
```


<br>

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


<br>

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
<br>

## Terminal 2
╰─ nohup kubectl -n ingress-nginx --address 0.0.0.0 port-forward svc/ingress-nginx-controller 443 > 443.log &
Forwarding from 0.0.0.0:443 -> 443

<br>

## Terminal 3
╰─ nohup kubectl -n ingress-nginx --address 0.0.0.0 port-forward svc/ingress-nginx-controller 80 > 80.log &
Forwarding from 0.0.0.0:80 -> 80

<br>

## Terminal 1
╰─ curl http://localhost -I
HTTP/1.1 404 Not Found

```

- If you can login to your home route, you can set up a port-forwarding rule to your machine 

```bash
╰─ curl http://5.194.32.235/ -I
HTTP/1.1 404 Not Found

<br>

## Now using AWS Route53, you can map the public IP with a domain name that you own
╰─ curl http://testcertmanager.mydomain.com -I                     
HTTP/1.1 404 Not Found

```

<br>

## Let's add a cluster-isser.yaml

[cert-manager.io/docs/configuration/acme/](https://cert-manager.io/docs/configuration/acme/)



- Apply the changes

```bash
╰─ kubectl apply -f cluster-issuer.yaml                                                                                                  
clusterissuer.cert-manager.io/letsencrypt-staging created

╰─ kubectl get ClusterIssuer              
NAME                  READY   AGE
letsencrypt-staging   False   53s

<br>

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

<br>

## Terminal n
╰─ kubectl port-forward --namespace default pod/whoami-5dfdf459f4-4nzcd 8081:80
Forwarding from 127.0.0.1:8081 -> 80

<br>

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

<br>

## Let's create a certificate.yaml

[cert-manager.io/docs/concepts/certificate](https://cert-manager.io/docs/concepts/certificate/)



```bash
$ kubectl apply -f certificate.yaml 
```

<br>

## Seeing what actually happens

- Certificate Initial State
```bash
# kubectl get certificate
NAME       READY   SECRET       AGE
acme-crt   False   tls-secret   4s
root@cert-manager-k8s:/home/testgcply01# 
```


- New pods are spun up

```bash
# kubectl get pods
NAME                        READY   STATUS    RESTARTS   AGE
cm-acme-http-solver-v42r4   1/1     Running   0          10s
whoami-5dfdf459f4-f29lk     1/1     Running   0          4m45s
```

- New ingress is created automatically

```bash
# kubectl get ingress
NAME                        CLASS    HOSTS                             ADDRESS   PORTS     AGE
cm-acme-http-solver-kj4j9   <none>   testcertmanager.ankitrathi.info             80        13s
whoami-ingress              <none>   testcertmanager.ankitrathi.info             80, 443   3m25s

# kubectl describe ingress cm-acme-http-solver-kj4j9
Name:             cm-acme-http-solver-kj4j9
Labels:           acme.cert-manager.io/http-domain=3409775745
                  acme.cert-manager.io/http-token=1372262173
                  acme.cert-manager.io/http01-solver=true
Namespace:        default
Address:          
Ingress Class:    <none>
Default backend:  <default>
Rules:
  Host                             Path  Backends
  ----                             ----  --------
  testcertmanager.ankitrathi.info  
                                   /.well-known/acme-challenge/4fy9_vs7wbjaonBUWeLtPmQ-vJ9Tzm6KbBV-ynffGIc   cm-acme-http-solver-crkb7:8089 (10.244.0.12:8089)
Annotations:                       kubernetes.io/ingress.class: nginx
                                   nginx.ingress.kubernetes.io/whitelist-source-range: 0.0.0.0/0,::/0
Events:
  Type    Reason  Age   From                      Message
  ----    ------  ----  ----                      -------
  Normal  Sync    21s   nginx-ingress-controller  Scheduled for sync
```

- Certificate is created

```bash
# kubectl get certificate
NAME       READY   SECRET       AGE
acme-crt   True    tls-secret   37s
```

- Logs of cert-manager

```bash
# kubectl logs -f cert-manager-6dc4964c9-z25w8 -n cert-manager
I1106 09:19:02.642755       1 start.go:75] cert-manager "msg"="starting controller" "git-commit"="da3265115bfd8be5780801cc6105fa857ef71965" "version"="v1.10.0"
.
# kubectl logs -f cert-manager-6dc4964c9-z25w8 -n cert-manager
I1106 09:19:02.642755       1 start.go:75] cert-manager "msg"="starting controller" "git-commit"="da3265115bfd8be5780801cc6105fa857ef71965" "version"="v1.10.0"
.
E1106 09:29:15.914530       1 sync.go:190] cert-manager/challenges "msg"="propagation check failed" "error"="wrong status code '404', expected '200'" "dnsName"="testcertmanager.ankitrathi.info" "resource_kind"="Challenge" "resource_name"="acme-crt-kfcpn-1234527781-2621229076" "resource_namespace"="default" "resource_version"="v1" "type"="HTTP-01"
.
I1106 09:29:39.009660       1 acme.go:233] cert-manager/certificaterequests-issuer-acme/sign "msg"="certificate issued" "related_resource_kind"="Order" "related_resource_name"="acme-crt-kfcpn-1234527781" "related_resource_namespace"="default" "related_resource_version"="v1" "resource_kind"="CertificateRequest" "resource_name"="acme-crt-kfcpn" "resource_namespace"="default" "resource_version"="v1"
I1106 09:29:39.010105       1 conditions.go:252] Found status change for CertificateRequest "acme-crt-kfcpn" condition "Ready": "False" -> "True"; setting lastTransitionTime to 2022-11-06 09:29:39.010090609 +0000 UTC m=+636.445050370
.
```

- Logs of nginx ingress

```bash
# 
root@cert-manager-k8s:/home/testgcply01# kubectl logs -f ingress-nginx-controller-7844b9db77-s4qtq -n ingress-nginx | grep 200
127.0.0.1 - - [06/Nov/2022:09:29:25 +0000] "GET /.well-known/acme-challenge/4fy9_vs7wbjaonBUWeLtPmQ-vJ9Tzm6KbBV-ynffGIc HTTP/1.1" 200 87 "-" "cert-manager-challenges/v1.10.0 (linux/amd64) cert-manager/da3265115bfd8be5780801cc6105fa857ef71965" 282 0.001 [default-cm-acme-http-solver-crkb7-8089] [] 10.244.0.12:8089 87 0.000 200 18c602063aa066c5027887d945e0249c
127.0.0.1 - - [06/Nov/2022:09:29:27 +0000] "GET /.well-known/acme-challenge/4fy9_vs7wbjaonBUWeLtPmQ-vJ9Tzm6KbBV-ynffGIc HTTP/1.1" 200 87 "-" "cert-manager-challenges/v1.10.0 (linux/amd64) cert-manager/da3265115bfd8be5780801cc6105fa857ef71965" 282 0.001 [default-cm-acme-http-solver-crkb7-8089] [] 10.244.0.12:8089 87 0.000 200 f7d684b918a576ffa8cd14c3b83497a5
127.0.0.1 - - [06/Nov/2022:09:29:29 +0000] "GET /.well-known/acme-challenge/4fy9_vs7wbjaonBUWeLtPmQ-vJ9Tzm6KbBV-ynffGIc HTTP/1.1" 200 87 "-" "cert-manager-challenges/v1.10.0 (linux/amd64) cert-manager/da3265115bfd8be5780801cc6105fa857ef71965" 282 0.002 [default-cm-acme-http-solver-crkb7-8089] [] 10.244.0.12:8089 87 0.000 200 a0bd92fff72bcecc12dfa11c8910c040
127.0.0.1 - - [06/Nov/2022:09:29:31 +0000] "GET /.well-known/acme-challenge/4fy9_vs7wbjaonBUWeLtPmQ-vJ9Tzm6KbBV-ynffGIc HTTP/1.1" 200 87 "-" "cert-manager-challenges/v1.10.0 (linux/amd64) cert-manager/da3265115bfd8be5780801cc6105fa857ef71965" 282 0.001 [default-cm-acme-http-solver-crkb7-8089] [] 10.244.0.12:8089 87 0.004 200 af3c2725eff812ff4b44a2f66b288965
127.0.0.1 - - [06/Nov/2022:09:29:34 +0000] "GET /.well-known/acme-challenge/4fy9_vs7wbjaonBUWeLtPmQ-vJ9Tzm6KbBV-ynffGIc HTTP/1.1" 200 87 "-" "cert-manager-challenges/v1.10.0 (linux/amd64) cert-manager/da3265115bfd8be5780801cc6105fa857ef71965" 282 0.001 [default-cm-acme-http-solver-crkb7-8089] [] 10.244.0.12:8089 87 0.000 200 f7ec6504a2b63222ea9d14f7e553aa13
127.0.0.1 - - [06/Nov/2022:09:29:36 +0000] "GET /.well-known/acme-challenge/4fy9_vs7wbjaonBUWeLtPmQ-vJ9Tzm6KbBV-ynffGIc HTTP/1.1" 200 87 "-" "Mozilla/5.0 (compatible; Let's Encrypt validation server; +https://www.letsencrypt.org)" 283 0.001 [default-cm-acme-http-solver-crkb7-8089] [] 10.244.0.12:8089 87 0.000 200 c4a44688d1f388557e62142c9a696dc3
127.0.0.1 - - [06/Nov/2022:09:29:36 +0000] "GET /.well-known/acme-challenge/4fy9_vs7wbjaonBUWeLtPmQ-vJ9Tzm6KbBV-ynffGIc HTTP/1.1" 200 87 "-" "Mozilla/5.0 (compatible; Let's Encrypt validation server; +https://www.letsencrypt.org)" 283 0.001 [default-cm-acme-http-solver-crkb7-8089] [] 10.244.0.12:8089 87 0.000 200 73fa114eff269a592148414a4aa51563
127.0.0.1 - - [06/Nov/2022:09:29:36 +0000] "GET /.well-known/acme-challenge/4fy9_vs7wbjaonBUWeLtPmQ-vJ9Tzm6KbBV-ynffGIc HTTP/1.1" 200 87 "-" "Mozilla/5.0 (compatible; Let's Encrypt validation server; +https://www.letsencrypt.org)" 283 0.001 [default-cm-acme-http-solver-crkb7-8089] [] 10.244.0.12:8089 87 0.000 200 2ca56c91ba45fd54d7a64126c110c257
127.0.0.1 - - [06/Nov/2022:09:29:59 +0000] "GET /test HTTP/1.1" 200 814 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36" 468 0.002 [default-whoami-80] [] 10.244.0.11:80 814 0.000 200 3c125fa5c91bfaaea33f903efb834305
127.0.0.1 - - [06/Nov/2022:09:30:05 +0000] "GET /test HTTP/2.0" 200 1045 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36" 460 0.002 [default-whoami-80] [] 10.244.0.11:80 1045 0.000 200 79d26974d442bb5c89db7ef4c19aab4b
```


<br>

## Let's test the certificate


```bash
# curl -v https://testcertmanager.ankitrathi.info/test
*   Trying 34.66.238.103:443...
* Connected to testcertmanager.ankitrathi.info (34.66.238.103) port 443 (#0)
* ALPN, offering h2
* ALPN, offering http/1.1
*  CAfile: /etc/ssl/certs/ca-certificates.crt
*  CApath: /etc/ssl/certs
* TLSv1.0 (OUT), TLS header, Certificate Status (22):
* TLSv1.3 (OUT), TLS handshake, Client hello (1):
* TLSv1.2 (IN), TLS header, Certificate Status (22):
* TLSv1.3 (IN), TLS handshake, Server hello (2):
* TLSv1.2 (IN), TLS header, Finished (20):
* TLSv1.2 (IN), TLS header, Supplemental data (23):
* TLSv1.3 (IN), TLS handshake, Encrypted Extensions (8):
* TLSv1.2 (IN), TLS header, Supplemental data (23):
* TLSv1.3 (IN), TLS handshake, Certificate (11):
* TLSv1.2 (IN), TLS header, Supplemental data (23):
* TLSv1.3 (IN), TLS handshake, CERT verify (15):
* TLSv1.2 (IN), TLS header, Supplemental data (23):
* TLSv1.3 (IN), TLS handshake, Finished (20):
* TLSv1.2 (OUT), TLS header, Finished (20):
* TLSv1.3 (OUT), TLS change cipher, Change cipher spec (1):
* TLSv1.2 (OUT), TLS header, Supplemental data (23):
* TLSv1.3 (OUT), TLS handshake, Finished (20):
* SSL connection using TLSv1.3 / TLS_AES_256_GCM_SHA384
* ALPN, server accepted to use h2
* Server certificate:
*  subject: CN=testcertmanager.ankitrathi.info
*  start date: Nov  6 08:29:37 2022 GMT
*  expire date: Feb  4 08:29:36 2023 GMT
*  subjectAltName: host "testcertmanager.ankitrathi.info" matched cert's "testcertmanager.ankitrathi.info"
*  issuer: C=US; O=Let's Encrypt; CN=R3
*  SSL certificate verify ok.
* Using HTTP2, server supports multiplexing
* Connection state changed (HTTP/2 confirmed)
* Copying HTTP/2 data in stream buffer to connection buffer after upgrade: len=0
* TLSv1.2 (OUT), TLS header, Supplemental data (23):
* TLSv1.2 (OUT), TLS header, Supplemental data (23):
* TLSv1.2 (OUT), TLS header, Supplemental data (23):
* Using Stream ID: 1 (easy handle 0x55890a699550)
* TLSv1.2 (OUT), TLS header, Supplemental data (23):
> GET /test HTTP/2
> Host: testcertmanager.ankitrathi.info
> user-agent: curl/7.81.0
> accept: */*
> 
* TLSv1.2 (IN), TLS header, Supplemental data (23):
* TLSv1.3 (IN), TLS handshake, Newsession Ticket (4):
* TLSv1.2 (IN), TLS header, Supplemental data (23):
* TLSv1.3 (IN), TLS handshake, Newsession Ticket (4):
* old SSL session ID is stale, removing
* TLSv1.2 (IN), TLS header, Supplemental data (23):
* Connection state changed (MAX_CONCURRENT_STREAMS == 128)!
* TLSv1.2 (OUT), TLS header, Supplemental data (23):
* TLSv1.2 (IN), TLS header, Supplemental data (23):
< HTTP/2 200 
< date: Sun, 06 Nov 2022 09:55:02 GMT
< content-type: text/plain; charset=utf-8
< content-length: 473
< strict-transport-security: max-age=15724800; includeSubDomains
< 
Hostname: whoami-5dfdf459f4-f29lk
IP: 127.0.0.1
IP: ::1
IP: 10.244.0.11
IP: fe80::105e:45ff:fe3d:e2bf
RemoteAddr: 10.244.0.10:50496
GET /test HTTP/1.1
Host: testcertmanager.ankitrathi.info
User-Agent: curl/7.81.0
Accept: */*
X-Forwarded-For: 127.0.0.1
X-Forwarded-Host: testcertmanager.ankitrathi.info
X-Forwarded-Port: 443
X-Forwarded-Proto: https
X-Forwarded-Scheme: https
X-Real-Ip: 127.0.0.1
X-Request-Id: 3a31fae37d9ba88dc4afdd07319141f3
X-Scheme: https

* TLSv1.2 (IN), TLS header, Supplemental data (23):
* Connection #0 to host testcertmanager.ankitrathi.info left intact
```


- From the browser

![successfull-lets-encrypt-http.png](.images/successfull-lets-encrypt-http.png)