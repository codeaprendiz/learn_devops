### Pull the repo

[jenkinsci/helm-charts](https://github.com/jenkinsci/helm-charts/tree/main/charts/jenkins)

[https://charts.jenkins.io](https://charts.jenkins.io/)

Search for the latest repo and pull to local

```bash
$ helm search repo jenkins
NAME            CHART VERSION   APP VERSION     DESCRIPTION                                       
bitnami/jenkins 8.0.5           2.289.2         The leading open source automation server         
stable/jenkins  2.5.4           lts             DEPRECATED - Open source continuous integration...

$ helm pull bitnami/jenkins          
```

But let's go with the repository version

```bash
$ git clone https://github.com/jenkinsci/helm-charts.git                                    
$ rm -rf CODE_OF_CONDUCT.md CONTRIBUTING.md LICENSE PROCESSES.md .github                     
```

Checkout the values.yaml file. For the controller it uses `jenkins/jenkins` image. Let's 
create our own locally by adding some more plugins.

```bash
$ docker build --file jenkins-controller.Dockerfile -t codeaprendiz/jenkins-controller-base .

$ docker images | grep codeaprendiz
codeaprendiz/jenkins-controller-base   latest                                                  74e37c305eec   5 minutes ago   739MB
```

Change the image name and tag name of the jenkins-controller in the values.yaml file.
And create the kubernetes manifests file using helm

```bash
$ helm template -f helm-charts/charts/jenkins/values.yaml helm-charts/charts/jenkins > jenkins-k8s-manifests.yaml

$ kubectl apply -f jenkins-k8s-manifests.yaml 
role.rbac.authorization.k8s.io/RELEASE-NAME-jenkins-schedule-agents unchanged
role.rbac.authorization.k8s.io/RELEASE-NAME-jenkins-casc-reload unchanged
Error from server (Invalid): error when creating "jenkins-k8s-manifests.yaml": ServiceAccount "RELEASE-NAME-jenkins" is invalid: metadata.name: Invalid value: "RELEASE-NAME-jenkins": a DNS-1123 subdomain must consist of lower case alphanumeric characters, '-' or '.', and must start and end with an alphanumeric character (e.g. 'example.com', regex used for validation is '[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*')
```

What ? 
I think we need to replace all occurances of `RELEASE-NAME-` in the file with lower case characters
or remove it completely. 
Let's try after removing.


```bash
$ kubectl apply -f jenkins-k8s-manifests.yaml 
serviceaccount/jenkins created
secret/jenkins created
configmap/jenkins created
configmap/jenkins-jenkins-jcasc-config created
persistentvolumeclaim/jenkins created
role.rbac.authorization.k8s.io/jenkins-schedule-agents created
role.rbac.authorization.k8s.io/jenkins-casc-reload created
rolebinding.rbac.authorization.k8s.io/jenkins-schedule-agents created
rolebinding.rbac.authorization.k8s.io/jenkins-watch-configmaps created
service/jenkins-agent created
service/jenkins created
statefulset.apps/jenkins created
configmap/jenkins-tests created
pod/ui-test-8ep3t created
```

Okay it works.

```bash
$ kubectl get pods                           
NAME            READY   STATUS                  RESTARTS   AGE
jenkins-0       0/2     Init:ImagePullBackOff   0          20s
ui-test-8ep3t   0/1     ErrImagePull            0          20s
```

We need to push our image to dockerhub repository.

```bash
$ docker login -u codeaprendiz  
Password: 
Login Succeeded

$ docker push codeaprendiz/jenkins-controller-base:latest
```

And run again. Ignore the UI test. It tests the UI so not required.

```bash
$ kubectl get pods
NAME            READY   STATUS    RESTARTS   AGE
jenkins-0       2/2     Running   0          2m30s
ui-test-8ep3t   0/1     Error     0          2m30s

$ kubectl get pv                                                                                                   
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                            STORAGECLASS   REASON   AGE
pvc-5ca935b0-4cd2-4f5a-a7c6-8844230026f2   50Mi       RWO            Delete           Bound    default/storage-alertmanager-0   hostpath                10d
pvc-df64cec3-1972-44c3-83b7-f1495e831e4e   8Gi        RWO            Delete           Bound    default/jenkins                  hostpath                20m

$ kubectl get pvc
NAME                     STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
jenkins                  Bound    pvc-df64cec3-1972-44c3-83b7-f1495e831e4e   8Gi        RWO            hostpath       20m
storage-alertmanager-0   Bound    pvc-5ca935b0-4cd2-4f5a-a7c6-8844230026f2   50Mi       RWO            hostpath       10d

$ kubectl get svc                                                           
NAME             TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)     AGE
jenkins          ClusterIP   10.107.80.151    <none>        8080/TCP    21m
jenkins-agent    ClusterIP   10.106.219.157   <none>        50000/TCP   21m

```


Let's access the application using the port-forward

```bash
$ kubectl get svc                         
NAME             TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)     AGE
jenkins          ClusterIP   10.107.80.151    <none>        8080/TCP    12m
jenkins-agent    ClusterIP   10.106.219.157   <none>        50000/TCP   12m

$ kubectl port-forward jenkins-0 8080:8080
Forwarding from 127.0.0.1:8080 -> 8080
Forwarding from [::1]:8080 -> 8080
```

Now let's try to get the admin password

```bash
$ kubectl exec --namespace default -it svc/jenkins -c jenkins -- /bin/cat /run/secrets/chart-admin-password && echo
QWaGfBkvTSLCoBaGSfWjBu

#### How I  know this ? Actually if we install via helm it gives this information
$ helm install jenkins helm-charts/charts/jenkins                                                                
NAME: jenkins
LAST DEPLOYED: Fri Aug  6 09:48:12 2021
NAMESPACE: default
STATUS: deployed
REVISION: 1
NOTES:
1. Get your 'admin' user password by running:
  kubectl exec --namespace default -it svc/jenkins -c jenkins -- /bin/cat /run/secrets/chart-admin-password && echo
2. Get the Jenkins URL to visit by running these commands in the same shell:
  echo http://127.0.0.1:8080
  kubectl --namespace default port-forward svc/jenkins 8080:8080

3. Login with the password from step 1 and the username: admin
4. Configure security realm and authorization strategy
5. Use Jenkins Configuration as Code by specifying configScripts in your values.yaml file, see documentation: http:///configuration-as-code and examples: https://github.com/jenkinsci/configuration-as-code-plugin/tree/master/demos

For more information on running Jenkins on Kubernetes, visit:
https://cloud.google.com/solutions/jenkins-on-container-engine

For more information about Jenkins Configuration as Code, visit:
https://jenkins.io/projects/jcasc/
```

So let's try logging in with `admin` and `QWaGfBkvTSLCoBaGSfWjBu` at [http://localhost:8080/](http://localhost:8080/)


Login is successful now.


Lets try creating our first job which should execute some shell command by launching
another pod in the cluster as a jenkins agent.

```bash
$ kubectl get pods
NAME            READY   STATUS              RESTARTS   AGE
default-j5g66   0/1     ContainerCreating   0          3s
jenkins-0       2/2     Running             0          23m


$ kubectl get pods
NAME            READY   STATUS    RESTARTS   AGE
default-j5g66   1/1     Running   0          15s
jenkins-0       2/2     Running   0          23m

$ kubectl get pods
NAME            READY   STATUS        RESTARTS   AGE
default-j5g66   0/1     Terminating   0          35s
jenkins-0       2/2     Running       0          23m
```

Amazing! It works :)

- Next steps, you have add your custom agent file with all the requirements installed
- You can add an ingress like treafik use classic load balancer in AWS
- You can assign the alias record in AWS route53 and point it to the classic load balancer so 
  that your jenkins server is accessable on your custom domain name.
- The load balancer PROTOCOLs you might need to change. What worked for me
- You can assign your domain ACM Certificate (Created using AWS Certificate Manager) to your load balancer
  so that Jenkins server is accessable on the public domain over https.
```bash
HTTPS 443 HTTP <instanceport> cipher SSL-Cert
TCP   80  TCP  <instanceport> NA     NA 
``` 




