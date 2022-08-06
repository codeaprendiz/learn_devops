## Objective : 
### 1) To create user DAVE in group 'groupQA' for kubernetes cluster 'dev' and give only Read access to this user.

- Running run-all.sh

```bash
$ ./run-all.sh groupQA R
Dev cluster
-------------------------------
          Resetting previous changes
-------------------------------
certificatesigningrequest.certificates.k8s.io "dev-groupQA-R-csr" deleted
clusterrole.rbac.authorization.k8s.io "role-dev-groupQA-R" deleted
clusterrolebinding.rbac.authorization.k8s.io "rolebinding-dev-groupQA-R" deleted
-------------------------------
          Client Cert Generation
-------------------------------
Generating RSA private key, 4096 bit long modulus
...................................++++
..................................................................................................++++
e is 65537 (0x010001)
-------------------------------
          kubeconfig & dave.key generation
-------------------------------
certificatesigningrequest.certificates.k8s.io/dev-groupQA-R-csr created
NAME                 AGE   REQUESTOR                CONDITION
dev-groupQA-R-csr    1s    user@gmail.com   Pending
dev-groupQA-RW-csr   29m   user@gmail.com   Approved,Issued
certificatesigningrequest.certificates.k8s.io/dev-groupQA-R-csr approved
NAME                 AGE   REQUESTOR                CONDITION
dev-groupQA-R-csr    2s    user@gmail.com   Approved,Issued
dev-groupQA-RW-csr   29m   user@gmail.com   Approved,Issued
clusterrole.rbac.authorization.k8s.io/role-dev-groupQA-R created
clusterrolebinding.rbac.authorization.k8s.io/rolebinding-dev-groupQA-R created
-------------------------------
          Share the following files with the groupQA
          ./dev/groupQA/kubeconfig
          ./dev/groupQA/dave.key

          Initialization Steps
          $ export KUBECONFIG=$PWD/kubeconfig

          $ kubectl config set-credentials dave \
            --client-key=$PWD/dave.key \
            --embed-certs=true

-------------------------------
```

- At the client workstation
```bash
$ ls kubeconfig dave.key
dave.key   kubeconfig

$ export KUBECONFIG=$PWD/kubeconfig

$ kubectl config set-credentials dave \
>             --client-key=$PWD/dave.key \
>             --embed-certs=true
User "dave" set.

$ kubectl get pods -n kube-system                                                  
NAME                                                        READY   STATUS    RESTARTS   AGE
prometheus-to-sd-xx9nx                                      2/2     Running   0          14h

$ kubectl get pods -n default    
No resources found.

$ kubectl get namespace      
Error from server (Forbidden): namespaces is forbidden: User "dave" cannot list resource "namespaces" in API group "" at the cluster scope

$ kubectl delete pod prometheus-to-sd-xx9nx -n kube-system
Error from server (Forbidden): pods "prometheus-to-sd-xx9nx" is forbidden: User "dave" cannot delete resource "pods" in API group "" in the namespace "kube-system"

$ kubectl apply -f www.yaml
Error from server (Forbidden): error when creating "www.yaml": deployments.apps is forbidden: User "dave" cannot create resource "deployments" in API group "apps" in the namespace "kube-system"
Error from server (Forbidden): error when creating "www.yaml": services is forbidden: User "dave" cannot create resource "services" in API group "" in the namespace "kube-system"
```

### 2) To create user DAVE in group 'groupDEV' for kubernetes cluster 'dev' and give only ReadWrite access to this user.

- Running run-all.sh

```bash
$ ./run-all.sh groupDEV RW
Dev cluster
-------------------------------
          Resetting previous changes
-------------------------------
certificatesigningrequest.certificates.k8s.io "dev-groupDEV-RW-csr" deleted
clusterrole.rbac.authorization.k8s.io "role-dev-groupDEV-RW" deleted
clusterrolebinding.rbac.authorization.k8s.io "rolebinding-dev-groupDEV-RW" deleted
-------------------------------
          Client Cert Generation
-------------------------------
Generating RSA private key, 4096 bit long modulus
..........++++
...................................................................................................................................................................................................................................
..................................++++
e is 65537 (0x010001)
-------------------------------
          kubeconfig & dave.key generation
-------------------------------
certificatesigningrequest.certificates.k8s.io/dev-groupDEV-RW-csr created
NAME                  AGE     REQUESTOR                CONDITION
dev-groupDEV-RW-csr   0s      user@gmail.com   Pending
dev-groupQA-R-csr     7m57s   user@gmail.com   Approved,Issued
dev-groupQA-RW-csr    37m     user@gmail.com   Approved,Issued
certificatesigningrequest.certificates.k8s.io/dev-groupDEV-RW-csr approved
NAME                  AGE     REQUESTOR                CONDITION
dev-groupDEV-RW-csr   1s      user@gmail.com   Approved,Issued
dev-groupQA-R-csr     7m58s   user@gmail.com   Approved,Issued
dev-groupQA-RW-csr    37m     user@gmail.com   Approved,Issued
clusterrole.rbac.authorization.k8s.io/role-dev-groupDEV-RW created
clusterrolebinding.rbac.authorization.k8s.io/rolebinding-dev-groupDEV-RW created
-------------------------------
          Share the following files with the groupDEV
          ./dev/groupDEV/kubeconfig
          ./dev/groupDEV/dave.key
          Initialization Steps
          $ export KUBECONFIG=$PWD/kubeconfig
          $ kubectl config set-credentials dave \
            --client-key=$PWD/dave.key \
            --embed-certs=true
-------------------------------
```

- At client workstation

```bash
$ ls kubeconfig dave.key
dave.key   kubeconfig

$ export KUBECONFIG=$PWD/kubeconfig

$ kubectl config set-credentials dave \
    --client-key=$PWD/dave.key \
    --embed-certs=true
  User "dave" set.

$ kubectl get pods -n kube-system                                                  
NAME                                                        READY   STATUS    RESTARTS   AGE
prometheus-to-sd-xx9nx                                      2/2     Running   0          14h

$ kubectl get pods -n default    
No resources found.

$ kubectl get namespace      
Error from server (Forbidden): namespaces is forbidden: User "dave" cannot list resource "namespaces" in API group "" at the cluster scope

$ kubectl delete pod prometheus-to-sd-dkczv -n kube-system                     
pod "prometheus-to-sd-dkczv" deleted

$ kubectl apply -f www.yaml
deployment.apps/www created
service/www created

```