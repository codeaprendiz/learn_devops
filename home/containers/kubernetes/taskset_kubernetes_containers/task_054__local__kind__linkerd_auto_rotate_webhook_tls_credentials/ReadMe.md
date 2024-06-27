# [Automatically Rotating Webhook TLS Credentials](https://linkerd.io/2.14/tasks/automatically-rotating-webhook-tls-credentials)

<br>

## Create cluster using kind

- Create cluster using kind

```bash
kind create cluster
```

<br>

## [Install cert-manager](https://cert-manager.io/docs/installation/)

```bash
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.3/cert-manager.yaml
```

<br>

## Create namespace for linkerd

```bash
kubectl create namespace linkerd
```

```bash
# control plane core
kubectl create namespace linkerd
kubectl label namespace linkerd \
  linkerd.io/is-control-plane=true \
  config.linkerd.io/admission-webhooks=disabled \
  linkerd.io/control-plane-ns=linkerd
kubectl annotate namespace linkerd linkerd.io/inject=disabled

# viz (ignore if not using the viz extension)
kubectl create namespace linkerd-viz
kubectl label namespace linkerd-viz linkerd.io/extension=viz
```

<br>

## [Save the signing key pair as a Secret](https://linkerd.io/2.14/tasks/automatically-rotating-webhook-tls-credentials/index.html#save-the-signing-key-pair-as-a-secret)

```bash
step certificate create webhook.linkerd.cluster.local ca.crt ca.key \
  --profile root-ca --no-password --insecure --san webhook.linkerd.cluster.local

kubectl create secret tls webhook-issuer-tls --cert=ca.crt --key=ca.key --namespace=linkerd

# ignore if not using the viz extension
kubectl create secret tls webhook-issuer-tls --cert=ca.crt --key=ca.key --namespace=linkerd-viz
```

<br>

## [Create Issuers referencing the secrets](https://linkerd.io/2.14/tasks/automatically-rotating-webhook-tls-credentials/index.html#create-issuers-referencing-the-secrets)

```bash
kubectl apply -f webhook-issuer.yaml 
kubectl apply -f webhook-issuer-viz.yaml 
```

<br>

## [Issuing certificates and writing them to secrets](https://linkerd.io/2.14/tasks/automatically-rotating-webhook-tls-credentials/index.html#issuing-certificates-and-writing-them-to-secrets)

```bash
kubectl apply -f certificate-linkerd-proxy-injector.yaml
kubectl apply -f certificate-linkerd-sp-validator.yaml
kubectl apply -f certificate-tap.yaml
kubectl apply -f certificate-linkerd-proxy-validator.yaml
kubectl apply -f certificate-linkerd-tap-injector.yaml
```

<br>

## [Using these credentials with CLI installation](https://linkerd.io/2.14/tasks/automatically-rotating-webhook-tls-credentials/index.html#using-these-credentials-with-cli-installation)

```bash
# first, install the Linkerd CRDs
linkerd install --crds | kubectl apply -f -

# install the Linkerd control plane, using the credentials
# from cert-manager
linkerd install \
  --set policyValidator.externalSecret=true \
  --set-file policyValidator.caBundle=ca.crt \
  --set proxyInjector.externalSecret=true \
  --set-file proxyInjector.caBundle=ca.crt \
  --set profileValidator.externalSecret=true \
  --set-file profileValidator.caBundle=ca.crt \
  | kubectl apply -f -

# ignore if not using the viz extension
linkerd viz install \
  --set tap.externalSecret=true \
  --set-file tap.caBundle=ca.crt \
  --set tapInjector.externalSecret=true \
  --set-file tapInjector.caBundle=ca.crt \
  | kubectl apply -f -
```

<br>

## Validation

```bash
$ linkerd check
.
.
Status check results are √
```

<br>

## Install Demo App

Install the demo app

```bash
# curl --proto '=https' --tlsv1.2 -sSfL https://run.linkerd.io/emojivoto.yml > emojivoto.yaml
curl --proto '=https' --tlsv1.2 -sSfL https://run.linkerd.io/emojivoto.yml \
  | kubectl apply -f -
```

Validate

```bash
$ kubectl get pods -n emojivoto
NAME                        READY   STATUS    RESTARTS   AGE
emoji-68cdd48fc7-kvg6f      1/1     Running   0          54s
vote-bot-85c88b944d-chzkz   1/1     Running   0          54s
voting-5b7f854444-v2vgh     1/1     Running   0          54s
web-679ccff67b-wdxs8        1/1     Running   0          54s

# Port forward
$ kubectl -n emojivoto port-forward svc/web-svc 8080:80

$ curl -I localhost:8080                 
HTTP/1.1 200 OK
Content-Type: text/html
Date: Sat, 13 Jan 2024 13:34:44 GMT
Content-Length: 560
```

With Emoji installed and running, we’re ready to mesh it

```bash
kubectl get -n emojivoto deploy -o yaml \
  | linkerd inject - \
  | kubectl apply -f -
```

Validate everything is working as expected. Note the two containers per pod.

```bash
$ kubectl get pods -n emojivoto
NAME                       READY   STATUS    RESTARTS   AGE
emoji-9f6758b4d-z5h6v      2/2     Running   0          2m45s
vote-bot-db7d9c4d9-sspcl   2/2     Running   0          2m45s
voting-5d66f899b7-fvb8q    2/2     Running   0          2m45s
web-8559b97f7c-sbfw2       2/2     Running   0          2m45s

# Validate everything is working as expected
# After a day
$ linkerd -n emojivoto check --proxy
.
.
Status check results are √
```

Check the dashboard

```bash
linkerd viz dashboard &
```
