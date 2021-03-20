

[Docs](https://medium.com/avmconsulting-blog/encrypting-the-certificate-for-kubernetes-lets-encrypt-805d2bf88b2a)

[Docs](https://medium.com/flant-com/cert-manager-lets-encrypt-ssl-certs-for-kubernetes-7642e463bbce)

Check the latest release at [https://github.com/jetstack/cert-manager/releases](https://github.com/jetstack/cert-manager/releases)

```bash
kubectl apply --validate=false \
-f https://github.com/jetstack/cert-manager/releases/download/v1.1.1/cert-manager.yaml
```

Create namespace `cert-manager` if not already exists

```bash
$ kubectl create ns cert-manager
```

Add the Jetstack Helm repository and update your local Helm chart repo cache.

```bash
$ helm version                       
version.BuildInfo{Version:"v3.5.2", GitCommit:"167aac70832d3a384f65f9745335e9fb40169dc2", GitTreeState:"dirty", GoVersion:"go1.15.7"}

$ helm repo add jetstack https://charts.jetstack.io
"jetstack" has been added to your repositories

$  helm repo update
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "jetstack" chart repository
Update Complete. ⎈Happy Helming!⎈
```


Get the cert-manager Helm chart (latest stable release version)

```bash
$ helm pull jetstack/cert-manager --version=1.1.1
$ ls
ReadMe.md               cert-manager-v1.1.1.tgz
$ tar -xvf cert-manager-v1.1.1.tgz 
```

Install the helm chart by creating the k8s files

```bash
helm template mongo1 -f mongodb-values.yaml bitnami/mongodb > resources-db.yaml
```

```bash
$ helm template cert-manager-name -f cert-manager/values.yaml cert-manager > k8s-resources.yaml

$ kubectl apply -f k8s-resources.yaml                                                                                  
serviceaccount/cert-manager-name-cainjector created
serviceaccount/cert-manager-name created
serviceaccount/cert-manager-name-webhook created
clusterrole.rbac.authorization.k8s.io/cert-manager-name-cainjector created
clusterrole.rbac.authorization.k8s.io/cert-manager-name-controller-issuers created
clusterrole.rbac.authorization.k8s.io/cert-manager-name-controller-clusterissuers created
clusterrole.rbac.authorization.k8s.io/cert-manager-name-controller-certificates created
clusterrole.rbac.authorization.k8s.io/cert-manager-name-controller-orders created
clusterrole.rbac.authorization.k8s.io/cert-manager-name-controller-challenges created
clusterrole.rbac.authorization.k8s.io/cert-manager-name-controller-ingress-shim created
clusterrole.rbac.authorization.k8s.io/cert-manager-name-view created
clusterrole.rbac.authorization.k8s.io/cert-manager-name-edit created
clusterrolebinding.rbac.authorization.k8s.io/cert-manager-name-cainjector created
clusterrolebinding.rbac.authorization.k8s.io/cert-manager-name-controller-issuers created
clusterrolebinding.rbac.authorization.k8s.io/cert-manager-name-controller-clusterissuers created
clusterrolebinding.rbac.authorization.k8s.io/cert-manager-name-controller-certificates created
clusterrolebinding.rbac.authorization.k8s.io/cert-manager-name-controller-orders created
clusterrolebinding.rbac.authorization.k8s.io/cert-manager-name-controller-challenges created
clusterrolebinding.rbac.authorization.k8s.io/cert-manager-name-controller-ingress-shim created
role.rbac.authorization.k8s.io/cert-manager-name-cainjector:leaderelection created
role.rbac.authorization.k8s.io/cert-manager-name:leaderelection created
role.rbac.authorization.k8s.io/cert-manager-name-webhook:dynamic-serving created
rolebinding.rbac.authorization.k8s.io/cert-manager-name-cainjector:leaderelection created
rolebinding.rbac.authorization.k8s.io/cert-manager-name:leaderelection created
rolebinding.rbac.authorization.k8s.io/cert-manager-name-webhook:dynamic-serving created
service/cert-manager-name created
service/cert-manager-name-webhook created
deployment.apps/cert-manager-name-cainjector created
deployment.apps/cert-manager-name created
deployment.apps/cert-manager-name-webhook created
mutatingwebhookconfiguration.admissionregistration.k8s.io/cert-manager-name-webhook created
validatingwebhookconfiguration.admissionregistration.k8s.io/cert-manager-name-webhook created
```

Now verify the installation

```bash
$ kubectl get pods --namespace cert-manager
NAME                                       READY   STATUS    RESTARTS   AGE
cert-manager-68ff46b886-qxjns              1/1     Running   0          23m
cert-manager-cainjector-7cdbb9c945-5wq9z   1/1     Running   0          23m
cert-manager-webhook-67584ff488-rdphq      1/1     Running   0          23m
```

Create whomai service

```bash
$ kubectl apply -f whoami.yaml 
deployment.apps/whoami created
service/whoami created
```

Create a ClusterIssuer resource for Let’s Encrypt certificates:

Apply the changes

```bash
$ kubectl apply -f cluster-issuer.yaml 
issuer.cert-manager.io/letsencrypt created
certificate.cert-manager.io/le-crt created

$ kubectl get Issuer                        
NAME          READY   AGE
letsencrypt   True    57s

$ kubectl get certificate   
NAME     READY   SECRET       AGE
le-crt   False   tls-secret   69s

$ kubectl describe certificate le-crt
.
.
  Normal  Issuing    3m30s  cert-manager  Issuing certificate as Secret does not exist
  Normal  Generated  3m30s  cert-manager  Stored new private key in temporary Secret resource "le-crt-4zbf6"
  Normal  Requested  3m30s  cert-manager  Created new CertificateRequest resource "le-crt-wtz89"

```

