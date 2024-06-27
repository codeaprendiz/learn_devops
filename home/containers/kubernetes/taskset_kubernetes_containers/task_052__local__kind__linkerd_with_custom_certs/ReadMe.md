# Linkerd

[Generating your own mTLS root certificates](https://linkerd.io/2.14/tasks/generate-certificates/)

<br>

## Pre-Requisite

In Linkerd's architecture:

- **Trust Anchor Certificate**: Serves as the root certificate, establishing the fundamental trust level for the entire service mesh. It's the base against which all other certificates are validated.

- **Issuer Certificate**: Specific to each cluster, this certificate issues and manages the per-proxy TLS certificates. It plays a key role in automating certificate management and ensuring security within the mesh.

<br>

## Create cluster

```bash
kind create cluster
```

<br>

## [Generating your own mTLS root certificates](https://linkerd.io/2.14/tasks/generate-certificates/)

[Trust anchor certificate](https://linkerd.io/2.14/tasks/generate-certificates/#trust-anchor-certificate)

```bash
# --not-after 8760h \ # if you need 10 years validity
step certificate create root.linkerd.cluster.local ca.crt ca.key \
--profile root-ca \
--no-password \
--insecure
```

<br>

## [Issuer certificate and key](https://linkerd.io/2.14/tasks/generate-certificates/#issuer-certificate-and-key)

```bash
step certificate create identity.linkerd.cluster.local issuer.crt issuer.key \
--profile intermediate-ca \
--not-after 8760h \
--no-password \
--insecure \
--ca ca.crt \
--ca-key ca.key
```

<br>

## [Passing the certificates to Linkerd](https://linkerd.io/2.14/tasks/generate-certificates/#passing-the-certificates-to-linkerd)

Deploy CRDs

```bash
# first, install the Linkerd CRDs
linkerd install --crds | kubectl apply -f -
```

[Helm install procedure for stable releases](https://linkerd.io/2.14/tasks/install-helm/)

```bash
# To add the repo for Linkerd stable releases:
helm repo add linkerd https://helm.linkerd.io/stable

# To add the repo for Linkerd edge releases:
# helm repo add linkerd-edge https://helm.linkerd.io/edge
```

Create namespace for linkerd

```bash
kubectl create namespace linkerd
```

Then install the linkerd-control-plane chart:

```bash
# Run from .tmp directory where the certificates are stored
helm install linkerd-control-plane -n linkerd \
  --set-file identityTrustAnchorsPEM=ca.crt \
  --set-file identity.issuer.tls.crtPEM=issuer.crt \
  --set-file identity.issuer.tls.keyPEM=issuer.key \
  linkerd/linkerd-control-plane
```

Validation

```bash
$ kubectl get pods -n linkerd  
NAME                                      READY   STATUS    RESTARTS   AGE
linkerd-destination-8c6d849c9-prlv8       4/4     Running   0          98s
linkerd-identity-7f66cb5b5c-sbg5p         2/2     Running   0          98s
linkerd-proxy-injector-5bdfcf77dd-9mhzg   2/2     Running   0          98s
```

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
