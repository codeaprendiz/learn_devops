
# Automatically Rotating Control Plane TLS Credentials

[linkerd.io » Automatically Rotating Control Plane TLS Credentials](https://linkerd.io/2.14/tasks/automatically-rotating-control-plane-tls-credentials)

<br>

## Pre-Requisite

In Linkerd's architecture:

- **Trust Anchor Certificate**: Serves as the root certificate, establishing the fundamental trust level for the entire service mesh. It's the base against which all other certificates are validated.

- **Issuer Certificate**: Specific to each cluster, this certificate issues and manages the per-proxy TLS certificates. It plays a key role in automating certificate management and ensuring security within the mesh.

- **Per-Proxy TLS Certificates**: Individual certificates for each proxy, essential for secure, authenticated mTLS communication between services within the mesh. They enable each service to verify the identity of others.

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

<br>

## [Save the signing key pair as a Secret](https://linkerd.io/2.14/tasks/automatically-rotating-control-plane-tls-credentials/#save-the-signing-key-pair-as-a-secret)

```bash
step certificate create root.linkerd.cluster.local ca.crt ca.key \
--profile root-ca \
--not-after=87600h \
--no-password \
--insecure &&
  kubectl create secret tls \
    linkerd-trust-anchor \
    --cert=ca.crt \
    --key=ca.key \
    --namespace=linkerd
```

Validate that secret is created

```bash
kubectl get secret -n linkerd                                                                                 
NAME                   TYPE                DATA   AGE
linkerd-trust-anchor   kubernetes.io/tls   2      41s
```

<br>

## [Create an Issuer referencing the secret](https://linkerd.io/2.14/tasks/automatically-rotating-control-plane-tls-credentials/#create-an-issuer-referencing-the-secret)

```bash
kubectl apply -f issuer.yaml 
```

<br>

## [Create a Certificate resource referencing the Issuer](https://linkerd.io/2.14/tasks/automatically-rotating-control-plane-tls-credentials/#create-a-certificate-resource-referencing-the-issuer)

```bash
kubectl apply -f certificate.yaml
```

Validate the secret created

```bash
kubectl get secret linkerd-identity-issuer -o yaml -n linkerd
```

<br>

## [Using these credentials with a Helm installation](https://linkerd.io/2.14/tasks/automatically-rotating-control-plane-tls-credentials/#using-these-credentials-with-a-helm-installation)

Install CRDs first

```bash
helm install linkerd-crds linkerd/linkerd-crds \
-n linkerd \
--create-namespace
```

```bash
helm install linkerd-control-plane -n linkerd \
  --set-file identityTrustAnchorsPEM=ca.crt \
  --set identity.issuer.scheme=kubernetes.io/tls \
  linkerd/linkerd-control-plane
```

<br>

## [Observing the update process](https://linkerd.io/2.14/tasks/automatically-rotating-control-plane-tls-credentials/#observing-the-update-process)

```bash
kubectl get events --field-selector reason=IssuerUpdated -n linkerd
```

- After 4 hours and 12 mins

```bash
$ kubectl get events --field-selector reason=IssuerUpdated -n linkerd
LAST SEEN   TYPE     REASON          OBJECT                        MESSAGE
4h12m       Normal   IssuerUpdated   deployment/linkerd-identity   Updated identity issuer

$ kubectl describe certificate linkerd-identity-issuer -n linkerd
Name:         linkerd-identity-issuer
Namespace:    linkerd
API Version:  cert-manager.io/v1
Kind:         Certificate
.
Spec:
  Common Name:  identity.linkerd.cluster.local
  Dns Names:
    identity.linkerd.cluster.local
  Duration:  1h0m0s
  Is CA:     true
  Issuer Ref:
    Kind:  Issuer
    Name:  linkerd-trust-anchor
  Private Key:
    Algorithm:   ECDSA
  Renew Before:  5m0s
  Secret Name:   linkerd-identity-issuer
  Usages:
    cert sign
    crl sign
    server auth
    client auth
Status:
  Conditions:
    Last Transition Time:  2024-01-16T16:09:50Z
    Message:               Certificate is up to date and has not expired
    Observed Generation:   1
    Reason:                Ready
    Status:                True
    Type:                  Ready
  Not After:               2024-01-16T17:09:50Z
  Not Before:              2024-01-16T16:09:50Z
  Renewal Time:            2024-01-16T17:04:50Z
  Revision:                3

$ kubectl get certificate -n linkerd                                 
NAME                      READY   SECRET                    AGE
linkerd-identity-issuer   True    linkerd-identity-issuer   6h1m


$ kubectl describe certificate linkerd-identity-issuer -n linkerd
Name:         linkerd-identity-issuer
Namespace:    linkerd
API Version:  cert-manager.io/v1
Kind:         Certificate
.
Spec:
  Common Name:  identity.linkerd.cluster.local
  Dns Names:
    identity.linkerd.cluster.local
  Duration:  1h0m0s
  Is CA:     true
  Issuer Ref:
    Kind:  Issuer
    Name:  linkerd-trust-anchor
  Private Key:
    Algorithm:   ECDSA
  Renew Before:  5m0s
  Secret Name:   linkerd-identity-issuer
  Usages:
    cert sign
    crl sign
    server auth
    client auth
Status:
  Conditions:
    Message:               Certificate is up to date and has not expired
    Observed Generation:   1
    Reason:                Ready
    Status:                True
    Type:                  Ready
  Not After:               2024-01-16T18:04:50Z
  Not Before:              2024-01-16T17:04:50Z
  Renewal Time:            2024-01-16T17:59:50Z
  Revision:                4
.
Events:
  Type    Reason     Age                    From                                       Message
  ----    ------     ----                   ----                                       -------
  Normal  Issuing    9m15s (x4 over 6h6m)   cert-manager-certificates-issuing          The certificate has been successfully issued
  Normal  Reused     9m15s (x3 over 5h11m)  cert-manager-certificates-key-manager      Reusing private key stored in existing Secret resource "linkerd-identity-issuer"
  Normal  Issuing    9m15s                  cert-manager-certificates-trigger          Renewing certificate as renewal was scheduled at 2024-01-16 17:04:50 +0000 UTC
  Normal  Requested  9m15s                  cert-manager-certificates-request-manager  Created new CertificateRequest resource "linkerd-identity-issuer-4"
```

<br>

## Validate installation

```bash
$ linkerd check
.
Status check results are √

$ linkerd check | grep "‼"         
‼ issuer cert is valid for at least 60 days
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
× issuer cert is within its validity period
    issuer certificate is not valid anymore. Expired on 2024-01-18T01:33:17Z
    see https://linkerd.io/2.14/checks/#l5d-identity-issuer-cert-is-time-valid for hints

Status check results are ×
```

<br>

## Troubleshooting the error

Recreate the issuer certificate

```bash
kubectl delete -f certificate.yaml
```

```bash
kubectl apply -f certificate.yaml
```

Status checks

```bash
$ linkerd -n emojivoto check --proxy
.
.
Status check results are √
```
