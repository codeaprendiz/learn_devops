# K8S using Openshift

- [developers.redhat.co » OpenShift and the Developer Sandbox](https://developers.redhat.com/learning/learn:openshift:foundations-openshift/resource/resources:openshift-and-developer-sandbox)
- [developers.redhat.co » Overview of the web console](https://developers.redhat.com/learning/learn:openshift:foundations-openshift/resource/resources:overview-web-console)
- [developers.redhat.co » developer-sandbox » activities](https://developers.redhat.com/developer-sandbox/activities)
- [console.redhat.com » Console URL](https://console.redhat.com/openshift)
- [developers.redhat.com » Learn Kubernetes using the Developer Sandbox for Red Hat OpenShift](https://developers.redhat.com/developer-sandbox/activities/learn-kubernetes-using-red-hat-developer-sandbox-openshift)

<br>

## Useful documentation

- [docs.openshift.com »  OpenShift Container Platform 4.13 » Managing security context constraints
](https://docs.openshift.com/container-platform/4.13/authentication/managing-security-context-constraints.html)
- [cloud.redhat.com » blog » a-guide-to-openshift-and-uids](https://cloud.redhat.com/blog/a-guide-to-openshift-and-uids)
- [developers.redhat.com » blog » adapting-docker-and-kubernetes-containers-to-run-on-red-hat-openshift-container-platform](https://developers.redhat.com/blog/2020/10/26/adapting-docker-and-kubernetes-containers-to-run-on-red-hat-openshift-container-platform)
- [docs.openshift.com » images-create-guide-openshift_create-images](https://docs.openshift.com/container-platform/4.5/openshift_images/create-images.html#images-create-guide-openshift_create-images)

<br>

## What is Openshift

OpenShift is a layer of Red Hat components that sit on top of a Kubernetes cluster. Using OpenShift makes it easier to install, configure, network and manage applications composed of containers.

- Clone Repos

```bash
$ git clone https://github.com/redhat-developer-demos/quotesweb.git
.
$ git clone https://github.com/redhat-developer-demos/quotemysql.git
.
$ git clone https://github.com/redhat-developer-demos/qotd-python.git
.
```

OpenShift has its own built-in Ingress-like object, the Route. For this tutorial, we're going to cheat and use the Route object

```bash
$ cd qotd-python/k8s
.
$ kubectl create -f quotes-deployment.yaml
.
$ kubectl create -f service.yaml
.
$ kubectl create -f route.yaml
.
```

At this point, we have the back-end quotes application running in a pod. It's exposed within Kubernetes as a Service, and the Route allows anyone to access it over the internet

```bash
$ kubectl get routes
NAME     HOST/PORT                                                           PATH   SERVICES   PORT        TERMINATION   WILDCARD
quotes   quotes-codeaprendiz-dev.apps.sandbox-m2.ll9k.p1.openshiftapps.com          quotes     10000-tcp                 None

# Note the protocl is http
$ curl http://quotes-codeaprendiz-dev.apps.sandbox-m2.ll9k.p1.openshiftapps.com/quotes -I  
HTTP/1.1 200 OK
server: gunicorn/20.0.4
date: Fri, 18 Aug 2023 18:41:42 GMT
content-type: application/json
content-length: 1061
access-control-allow-origin: *
set-cookie: 4c9f10407721e2736469d359e77060a6=3555786c72fd7a85a15fa4c42233655d; path=/; HttpOnly
cache-control: private

$ curl http://quotes-codeaprendiz-dev.apps.sandbox-m2.ll9k.p1.openshiftapps.com/quotes/random
{
  "author": "Don Schenck", 
  "hostname": "quotes-6f89fc4455-tbgr7", 
  "id": 0, 
  "quotation": "It is not only what you do, but also the attitude you bring to it, that makes you a success."
}
```