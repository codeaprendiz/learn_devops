## Objective : To create a user DAVE and give access to DAVE to create only specific resources in specific namespace

Docs referred - https://medium.com/better-programming/k8s-tips-give-access-to-your-clusterwith-a-client-certificate-dfb3b71a76fe

- Generating the dave.key and dave.csr
```bash
$ ./client-run.sh
Generating RSA private key, 4096 bit long modulus
..........................................................++++
......................................................................................................................................................................................................................................++++
e is 65537 (0x010001)
```

- Generating the kubeconfig
```bash
$ ./admin-run.sh
certificatesigningrequest.certificates.k8s.io/mycsr created
NAME    AGE   REQUESTOR                CONDITION
mycsr   0s    user@gmail.com   Pending
certificatesigningrequest.certificates.k8s.io/mycsr approved
NAME    AGE   REQUESTOR                CONDITION
mycsr   1s    user@gmail.com   Approved,Issued
namespace/development created
role.rbac.authorization.k8s.io/dev created
rolebinding.rbac.authorization.k8s.io/dev created
```

- At the client workstation copy the dave.key and kubeconfig and execute the following

```bash
$ ls kubeconfig dave.key
dave.key   kubeconfig

$ export KUBECONFIG=$PWD/kubeconfig

$ kubectl config set-credentials dave \
  --client-key=$PWD/dave.key \
  --embed-certs=true
User "dave" set.

$ kubectl version
Client Version: version.Info{Major:"1", Minor:"15", GitVersion:"v1.15.5", GitCommit:"20c265fef0741dd71a66480e35bd69f18351daea", GitTreeState:"clean", BuildDate:"2019-10-15T19:16:51Z", GoVersion:"go1.12.10", Compiler:"gc", Platform:"darwin/amd64"}
Server Version: version.Info{Major:"1", Minor:"14+", GitVersion:"v1.14.10-gke.27", GitCommit:"145f9e21a4515947d6fb10819e5a336aff1b6959", GitTreeState:"clean", BuildDate:"2020-02-21T18:01:40Z", GoVersion:"go1.12.12b4", Compiler:"gc", Platform:"linux/amd64"}
```

- Try creating a resource in namespace development

```bash
$ kubectl apply -f www.yaml
deployment.apps/www created
service/www created

$ kubectl get pods
Error from server (Forbidden): pods is forbidden: User "dave" cannot list resource "pods" in API group "" in the namespace "default"

$ kubectl get pods -n development
NAME                   READY   STATUS    RESTARTS   AGE
www-66fd899d46-8sr97   1/1     Running   0          15s
www-66fd899d46-hzgr6   1/1     Running   0          15s
www-66fd899d46-pb7fm   1/1     Running   0          15s
```
