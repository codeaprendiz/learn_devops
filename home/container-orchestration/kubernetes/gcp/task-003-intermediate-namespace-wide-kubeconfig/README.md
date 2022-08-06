## Objective : 
### 1) To create user DAVE in group 'groupQA' in namespace default and give only Read access to this user.

- Running the run-all.sh
```bash
$ ./run-all.sh
Dev cluster
Usage: ./run-all.sh <namespace> <user-group> <access-type>
Values for <namespace> : default|kube-system
Values for <user-group> : groupQA|groupDEV
Values for <access-type> : R|RW

$ ./run-all.sh default groupQA R
Dev cluster
-------------------------------
          Resetting previous changes
-------------------------------
certificatesigningrequest.certificates.k8s.io "default-csr" deleted
role.rbac.authorization.k8s.io "role-default" deleted
rolebinding.rbac.authorization.k8s.io "rolebinding-monitoring-ns" deleted
-------------------------------
          Client Cert Generation
-------------------------------
Generating RSA private key, 4096 bit long modulus
..............................++++
...............++++
e is 65537 (0x010001)
-------------------------------
          kubeconfig & dave.key generation
-------------------------------
certificatesigningrequest.certificates.k8s.io/default-csr created
NAME          AGE   REQUESTOR                CONDITION
default-csr   1s    user@gmail.com   Pending
mycsr         61m   user@gmail.com   Approved,Issued
certificatesigningrequest.certificates.k8s.io/default-csr approved
NAME          AGE   REQUESTOR                CONDITION
default-csr   2s    user@gmail.com   Approved,Issued
mycsr         61m   user@gmail.com   Approved,Issued
role.rbac.authorization.k8s.io/role-default created
rolebinding.rbac.authorization.k8s.io/rolebinding-monitoring-ns created
-------------------------------
          Share the following files with the groupQA
          ./dev/default/groupQA/kubeconfig
          ./dev/default/groupQA/dave.key

          Initialization Steps
          $ export KUBECONFIG=$PWD/kubeconfig

          $ kubectl config set-credentials dave \
            --client-key=$PWD/dave.key \
            --embed-certs=true

-------------------------------
```

- At the client workstation
```bash
$ ls dave.key kubeconfig
dave.key   kubeconfig

$ export KUBECONFIG=$PWD/kubeconfig

$ kubectl config set-credentials dave \
>             --client-key=$PWD/dave.key \
>             --embed-certs=true
User "dave" set.

$ kubectl version                                                                  
Client Version: version.Info{Major:"1", Minor:"15", GitVersion:"v1.15.5", GitCommit:"20c265fef0741dd71a66480e35bd69f18351daea", GitTreeState:"clean", BuildDate:"2019-10-15T19:16:51Z", GoVersion:"go1.12.10", Compiler:"gc", Platform:"darwin/amd64"}
Server Version: version.Info{Major:"1", Minor:"14+", GitVersion:"v1.14.10-gke.27", GitCommit:"145f9e21a4515947d6fb10819e5a336aff1b6959", GitTreeState:"clean", BuildDate:"2020-02-21T18:01:40Z", GoVersion:"go1.12.12b4", Compiler:"gc", Platform:"linux/amd64"}

$ kubectl get pods -n default    
No resources found.

$ kubectl get pods -n kube-system
Error from server (Forbidden): pods is forbidden: User "dave" cannot list resource "pods" in API group "" in the namespace "kube-system"

$ kubectl apply -f www.yaml      
Error from server (Forbidden): error when creating "www.yaml": deployments.apps is forbidden: User "dave" cannot create resource "deployments" in API group "apps" in the namespace "default"
Error from server (Forbidden): error when creating "www.yaml": services is forbidden: User "dave" cannot create resource "services" in API group "" in the namespace "default"
```

### 1) To create user DAVE in group 'groupDEV' in namespace 'kube-system' and give  ReadWrite access to this user.

- Running run-all.sh
```bash
$ ./run-all.sh kube-system groupDEV RW
Dev cluster
-------------------------------
          Resetting previous changes
-------------------------------
certificatesigningrequest.certificates.k8s.io "kube-system-csr" deleted
role.rbac.authorization.k8s.io "role-kube-system" deleted
rolebinding.rbac.authorization.k8s.io "rolebinding-monitoring-ns" deleted
-------------------------------
          Client Cert Generation
-------------------------------
Generating RSA private key, 4096 bit long modulus
.................................................................................++++
............................................++++
e is 65537 (0x010001)
-------------------------------
          kubeconfig & dave.key generation
-------------------------------
certificatesigningrequest.certificates.k8s.io/kube-system-csr created
NAME              AGE   REQUESTOR                CONDITION
default-csr       23m   user@gmail.com   Approved,Issued
kube-system-csr   1s    user@gmail.com   Pending
certificatesigningrequest.certificates.k8s.io/kube-system-csr approved
NAME              AGE   REQUESTOR                CONDITION
default-csr       23m   user@gmail.com   Approved,Issued
kube-system-csr   2s    user@gmail.com   Approved,Issued
role.rbac.authorization.k8s.io/role-kube-system created
rolebinding.rbac.authorization.k8s.io/rolebinding-monitoring-ns created
-------------------------------
          Share the following files with the groupDEV
          ./dev/kube-system/groupDEV/kubeconfig
          ./dev/kube-system/groupDEV/dave.key

          Initialization Steps
          $ export KUBECONFIG=$PWD/kubeconfig

          $ kubectl config set-credentials dave \
            --client-key=$PWD/dave.key \
            --embed-certs=true

-------------------------------
```

- At the client workstation

```bash
$ ls dave.key kubeconfig
dave.key   kubeconfig

$ export KUBECONFIG=$PWD/kubeconfig

$ kubectl config set-credentials dave \
>             --client-key=$PWD/dave.key \
>             --embed-certs=true
User "dave" set.

$ kubectl version                                                                  
Client Version: version.Info{Major:"1", Minor:"15", GitVersion:"v1.15.5", GitCommit:"20c265fef0741dd71a66480e35bd69f18351daea", GitTreeState:"clean", BuildDate:"2019-10-15T19:16:51Z", GoVersion:"go1.12.10", Compiler:"gc", Platform:"darwin/amd64"}
Server Version: version.Info{Major:"1", Minor:"14+", GitVersion:"v1.14.10-gke.27", GitCommit:"145f9e21a4515947d6fb10819e5a336aff1b6959", GitTreeState:"clean", BuildDate:"2020-02-21T18:01:40Z", GoVersion:"go1.12.12b4", Compiler:"gc", Platform:"linux/amd64"}

$ kubectl get pods               
Error from server (Forbidden): pods is forbidden: User "dave" cannot list resource "pods" in API group "" in the namespace "default"

$ kubectl get pods -n kube-system
NAME                                                        READY   STATUS    RESTARTS   AGE
metrics-server-v0.3.1-5c6fbf777-7gm6j                       2/2     Running   0          6h23m

$ kubectl delete pod metrics-server-v0.3.1-5c6fbf777-7gm6j -n kube-system
pod "metrics-server-v0.3.1-5c6fbf777-7gm6j" deleted

$ kubectl apply -f www.yaml     
deployment.apps/www created
service/www created

$ kubectl delete -f www.yaml
deployment.apps "www" deleted
service "www" deleted
```