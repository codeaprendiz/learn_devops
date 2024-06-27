# Kind Linkerd

<br>

## [linkerd.io » Getting Started](https://linkerd.io/2.14/getting-started/)

<br>

### Create Cluster Create cluster

```bash
kind create cluster
```

<br>

### Install CLI

```bash
curl --proto '=https' --tlsv1.2 -sSfL https://run.linkerd.io/install | sh
```

- validate that Linkerd can be installed

```bash
linkerd check --pre                     # validate that Linkerd can be installed
```

<br>

### Install Linkerd

- install linkerd-crds

```bash
# linkerd install --crds > linkerd-crds.yaml
linkerd install --crds | kubectl apply -f -
```

- install linkerd

```bash
# linkerd install > linkerd.yaml
linkerd install | kubectl apply -f -
```

- Validate

```bash
linkerd check
```

<br>

### Install Demo App

- Install the demo app

```bash
# curl --proto '=https' --tlsv1.2 -sSfL https://run.linkerd.io/emojivoto.yml > emojivoto.yaml
curl --proto '=https' --tlsv1.2 -sSfL https://run.linkerd.io/emojivoto.yml \
  | kubectl apply -f -
```

- Validate

```bash
$ kubectl get pods -n emojivoto                   
NAME                        READY   STATUS    RESTARTS   AGE
emoji-68cdd48fc7-kbclk      1/1     Running   0          9m48s
vote-bot-85c88b944d-nm5qp   1/1     Running   0          9m48s
voting-5b7f854444-p55hb     1/1     Running   0          9m48s
web-679ccff67b-ncrdh        1/1     Running   0          9m48s

$ curl -I localhost:8080                 
HTTP/1.1 200 OK
Content-Type: text/html
Date: Sat, 13 Jan 2024 13:34:44 GMT
Content-Length: 560
```

- With Emoji installed and running, we’re ready to mesh it

```bash
kubectl get -n emojivoto deploy -o yaml \
  | linkerd inject - \
  | kubectl apply -f -
```

- Validate everything is working as expected

```bash
$ kubectl get pods -n emojivoto
NAME                       READY   STATUS    RESTARTS   AGE
emoji-9f6758b4d-z5h6v      2/2     Running   0          2m45s
vote-bot-db7d9c4d9-sspcl   2/2     Running   0          2m45s
voting-5d66f899b7-fvb8q    2/2     Running   0          2m45s
web-8559b97f7c-sbfw2       2/2     Running   0          2m45s

# Validate everything is working as expected
$ linkerd -n emojivoto check --proxy
.
.
Status check results are √
```

<br>

### Explore more

Let’s install the viz extension, which will install an on-cluster metric stack and dashboard.

```bash
# linkerd viz install > linkerd-viz.yaml
linkerd viz install | kubectl apply -f - # install the on-cluster metrics stack
```

- Validate

```bash
linkerd check
```

- Access dashboard

```bash
linkerd viz dashboard &
```
