## Kubernetes

What is kubernetes?

<details>

- open-source

- container-orchestration system for automating computer application deployment, scaling, and management.

- originally designed by Google and is now maintained by the Cloud Native Computing Foundation

</details>


What are the components on master (Control Plane Components)

<details>

[concepts/overview/components](https://kubernetes.io/docs/concepts/overview/components/)

- kube-api-server : exposes the kubernetes api
- etcd : key-value store for the cluster data
- kube-scheduler : watches for newly created Pods with no assigned node, and selects a node for them to run on
- kube-controller-manager : runs controller processes.
- cloud-controller-manager 

</details>

What are the Node Components

<details>

[concepts/overview/components](https://kubernetes.io/docs/concepts/overview/components/)

- kubelet : An agent that runs on each node in the cluster. It makes sure that containers are running in a Pod.
- kube-proxy : kube-proxy is a network proxy that runs on each node in your cluster, implementing part of the Kubernetes Service concept.
- Container runtime : The container runtime is the software that is responsible for running containers.

</details>


We have NODES A,B,C and PODS A,B,C how will you ensure that pod A goes to A node, B goes to B and C goes to C node and no other case happens

<details>

</details>


What is the difference between a deployment and stateful set?

<details>

</details>


How can we do blue green deployment in kubernetes ?

<details>

</details>


Can you explain the end-to-end workflow of accessing microservice in PRODUCTION in kubernetes from any of your past experiences? 

<details>

</details>
