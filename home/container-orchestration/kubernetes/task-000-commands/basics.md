
## Documentation Map


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



NOTES:
- Editing a replicaset, don't forget to delete the pods so that the new ones get crated with the new changes.
