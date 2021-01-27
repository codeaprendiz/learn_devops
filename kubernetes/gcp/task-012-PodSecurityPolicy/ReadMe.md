## Docs Referred

- [pod-security-policy](https://kubernetes.io/docs/concepts/policy/pod-security-policy/)
- [how-to/pod-security-policy](https://cloud.google.com/kubernetes-engine/docs/how-to/pod-security-policies)


### Enabling PodSecurityPolicy controller
To use the PodSecurityPolicy admission controller, you must create a new cluster or update an existing cluster with the --enable-pod-security-policy flag

- To update an existing cluster:

> gcloud beta container clusters update <cluster-name> --enable-pod-security-policy --zone <specify-zone>

```bash
gcloud beta container clusters update cluster-2 --enable-pod-security-policy --zone us-central1-c
Updating cluster-2...done.
```


### Set up
- Set up a namespace and a service account to act as for this example. We’ll use this service account to mock a non-admin user.
```bash
$ kubectl create namespace psp-example
namespace/psp-example created

$ kubectl get namespace psp-example
NAME          STATUS   AGE
psp-example   Active   13s
```

- Set up a service-account
```bash
$ kubectl create serviceaccount -n psp-example fake-user
serviceaccount/fake-user created

$ kubectl get serviceaccount -n psp-example
NAME        SECRETS   AGE
default     1         8m48s
fake-user   1         30s
```

- Role Binding
```bash
$ kubectl create rolebinding -n psp-example fake-editor --clusterrole=edit --serviceaccount=psp-example:fake-user
rolebinding.rbac.authorization.k8s.io/fake-editor created

$ kubectl get clusterrole | grep edit
edit                                                                   23m

$ kubectl get rolebinding fake-editor -n psp-example
NAME          AGE
fake-editor   109s
```


- To make it clear which user we’re acting as and save some typing, create 2 aliases:
```bash
alias kubectl-admin='kubectl -n psp-example'
alias kubectl-user='kubectl --as=system:serviceaccount:psp-example:fake-user -n psp-example'
```

- Create a policy and a pod with kubectl-admin
```bash
$ kubectl-admin create -f example-psp.yaml
podsecuritypolicy.policy/example created
```

- Now, as the unprivileged user, try to create a simple pod:
```bash
$ kubectl-user create -f- <<EOF
apiVersion: v1
kind: Pod
metadata:
  name:      pause
spec:
  containers:
    - name:  pause
      image: k8s.gcr.io/pause
EOF
Error from server (Forbidden): error when creating "STDIN": pods "pause" is forbidden: unable to validate against any pod security policy: []
```

- What happened? Although the PodSecurityPolicy was created, neither the pod’s service account nor fake-user have permission to use the new policy:
```bash
$ kubectl-user auth can-i use podsecuritypolicy/example
Warning: resource 'podsecuritypolicies' is not namespace scoped in group 'extensions'
no
```

- Create the rolebinding to grant fake-user the use verb on the example policy:

```bash
$ kubectl-admin create role psp:unprivileged \
      --verb=use \
      --resource=podsecuritypolicy \
      --resource-name=example
role.rbac.authorization.k8s.io/psp:unprivileged created

$ kubectl get role -n psp-example
NAME               AGE
psp:unprivileged   72s

$ kubectl-admin create rolebinding fake-user:psp:unprivileged \
      --role=psp:unprivileged \
      --serviceaccount=psp-example:fake-user
rolebinding.rbac.authorization.k8s.io/fake-user:psp:unprivileged created

$ kubectl get rolebinding -n psp-example
NAME                         AGE
fake-editor                  16m
fake-user:psp:unprivileged   25s
```

- Now retry creating the pod:
```bash
$ kubectl-user create -f- <<EOF
apiVersion: v1
kind: Pod
metadata:
  name:      pause
spec:
  containers:
    - name:  pause
      image: k8s.gcr.io/pause
EOF
pod/pause created
```

- It works as expected! But any attempts to create a privileged pod should still be denied:
```bash
$ kubectl-user create -f- <<EOF
apiVersion: v1
kind: Pod
metadata:
  name:      privileged
spec:
  containers:
    - name:  pause
      image: k8s.gcr.io/pause
      securityContext:
        privileged: true
EOF
Error from server (Forbidden): error when creating "STDIN": pods "privileged" is forbidden: unable to validate against any pod security policy: [spec.containers[0].securityContext.privileged: Invalid value: true: Privileged containers are not allowed]
```

- Delete the pod before moving on:
  
```bash
$ kubectl-user delete pod pause
pod "pause" deleted
```


