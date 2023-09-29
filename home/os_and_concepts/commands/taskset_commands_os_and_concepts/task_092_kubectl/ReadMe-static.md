
# Documentation Map

[Home](https://kubernetes.io/docs/home/)

- [what-is-kubernetes](https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/)
- [components](https://kubernetes.io/docs/concepts/overview/components)
    - Control Plane Components
        - [kube-apiserver](https://kubernetes.io/docs/concepts/overview/components/#kube-apiserver)
        - [etcd](https://kubernetes.io/docs/concepts/overview/components/#etcd)
        - [kube-scheduler](https://kubernetes.io/docs/concepts/overview/components/#kube-scheduler)
        - [kube-controller-manager](https://kubernetes.io/docs/concepts/overview/components/#kube-controller-manager)
        - [cloud-controller-manager](https://kubernetes.io/docs/concepts/overview/components/#cloud-controller-manager)
    - Node Components
        - [kubelet](https://kubernetes.io/docs/concepts/overview/components/#kubelet)
        - [kube-proxy](https://kubernetes.io/docs/concepts/overview/components/#kube-proxy)
        - [Container runtime](https://kubernetes.io/docs/concepts/overview/components/#container-runtime)

- [kubernetes-api](https://kubernetes.io/docs/concepts/overview/kubernetes-api/)
  [Command Line Tools Reference](https://kubernetes.io/docs/reference/command-line-tools-reference/)
    - [kubelet](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/)
    - [kube-apiserver](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/)
    - [kube-controller-manager](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-controller-manager/)
    - [kube-proxy](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/)
    - [kube-scheduler](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-scheduler/)
    - [kubelet-authentication-authorization](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet-authentication-authorization/)
    - [TLS bootstrapping](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet-tls-bootstrapping/)

## Useful Docs

- [docs.openshift.com »  OpenShift Container Platform 4.13 » Managing security context constraints
  ](https://docs.openshift.com/container-platform/4.13/authentication/managing-security-context-constraints.html)
- [cloud.redhat.com » blog » a-guide-to-openshift-and-uids](https://cloud.redhat.com/blog/a-guide-to-openshift-and-uids)
- [developers.redhat.com » blog » adapting-docker-and-kubernetes-containers-to-run-on-red-hat-openshift-container-platform](https://developers.redhat.com/blog/2020/10/26/adapting-docker-and-kubernetes-containers-to-run-on-red-hat-openshift-container-platform)
- [docs.openshift.com » images-create-guide-openshift_create-images](https://docs.openshift.com/container-platform/4.5/openshift_images/create-images.html#images-create-guide-openshift_create-images)
- [developers.redhat.co » OpenShift and the Developer Sandbox](https://developers.redhat.com/learning/learn:openshift:foundations-openshift/resource/resources:openshift-and-developer-sandbox)
- [developers.redhat.co » Overview of the web console](https://developers.redhat.com/learning/learn:openshift:foundations-openshift/resource/resources:overview-web-console)
- [developers.redhat.co » developer-sandbox » activities](https://developers.redhat.com/developer-sandbox/activities)
- [console.redhat.com » Console URL](https://console.redhat.com/openshift)
- [developers.redhat.com » Learn Kubernetes using the Developer Sandbox for Red Hat OpenShift](https://developers.redhat.com/developer-sandbox/activities/learn-kubernetes-using-red-hat-developer-sandbox-openshift)

NOTES:

- Editing a replicaset, don't forget to delete the pods so that the new ones get crated with the new changes.

## Frequently used links

- [https://kubectl.docs.kubernetes.io » kubectl](https://kubectl.docs.kubernetes.io/references/kubectl)
- [kubectl.docs.kubernetes.io » Kustomize](https://kubectl.docs.kubernetes.io/references/kustomize)
