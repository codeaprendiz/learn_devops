- To create the nginx resources

```bash
$ kubectl create deployment nginx-dep --image=dubizzledotcom/demo-nginx --replicas=1 --dry-run=client -o yaml > dep.yaml

$ kubectl apply -f dep.yaml                                                                                             
deployment.apps/nginx-dep created
```

- Now we expose the deployment using the NodePort 

```bash
$ kubectl expose deployment nginx-dep --name=nginx-dep-svc-nodeport --type=NodePort --port=8080 --target-port=80 --dry-run=client -o yaml > nginx-svc-nodeport.yaml

$ kubectl expose deployment nginx-dep --name=nginx-dep-svc-nodeport --type=NodePort --port=8080 --target-port=80 
service/nginx-dep-svc-nodeport exposed

$ kubectl get svc                                                                                               
NAME                     TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
kubernetes               ClusterIP   10.96.0.1        <none>        443/TCP          84d
nginx-dep-svc-nodeport   NodePort    10.107.192.248   <none>        8080:30609/TCP   19s

```

- Now let's access the service via NodePort

```bash
$ curl localhost:30609/403
<html>
<head><title>403 Forbidden</title></head>
<body>
<center><h1>403 Forbidden</h1></center>
<hr><center>nginx/1.20.1</center>
</body>
</html>


$ curl localhost:30609/check.txt
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<body>
  <p>Its working!!!</p>
</div>
</body>
</html>


$ curl localhost:30609/500      
<html>
<head><title>500 Internal Server Error</title></head>
<body>
<center><h1>500 Internal Server Error</h1></center>
<hr><center>nginx/1.20.1</center>
</body>
</html>


$ curl localhost:30609/502
<html>
<head><title>502 Bad Gateway</title></head>
<body>
<center><h1>502 Bad Gateway</h1></center>
<hr><center>nginx/1.20.1</center>
</body>
</html>
```

- Now Deploy horizontal pod autoscaler

```bash
$ kubectl autoscale deployment nginx-dep --cpu-percent=50 --min=1 --max=2 --dry-run=client -o yaml > hpa.yaml

$ kubectl get hpa                                                                                            
NAME        REFERENCE              TARGETS         MINPODS   MAXPODS   REPLICAS   AGE
nginx-dep   Deployment/nginx-dep   <unknown>/50%   1         2         0          21s

$ kubectl get pods                                    
NAME                        READY   STATUS              RESTARTS   AGE
nginx-dep-ff8db6854-4trzl   0/1     ContainerCreating   0          1s
nginx-pod                   1/1     Running             0          29m

```

- Let's deploy [metric-server](https://github.com/kubernetes-sigs/metrics-server) so that pod autoscaler is able to fetch the metrics of pods

```bash
$ kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.5.0/components.yaml
serviceaccount/metrics-server created
clusterrole.rbac.authorization.k8s.io/system:aggregated-metrics-reader created
clusterrole.rbac.authorization.k8s.io/system:metrics-server created
rolebinding.rbac.authorization.k8s.io/metrics-server-auth-reader created
clusterrolebinding.rbac.authorization.k8s.io/metrics-server:system:auth-delegator created
clusterrolebinding.rbac.authorization.k8s.io/system:metrics-server created
service/metrics-server created
deployment.apps/metrics-server created
apiservice.apiregistration.k8s.io/v1beta1.metrics.k8s.io created

```

- Let's deploy ingress to access our service. First we need to deploy ingress controller [ingress controller](https://kubernetes.github.io/ingress-nginx/deploy/#docker-desktop)

```bash
$ kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.47.0/deploy/static/provider/cloud/deploy.yaml             
namespace/ingress-nginx unchanged
serviceaccount/ingress-nginx unchanged
configmap/ingress-nginx-controller configured
clusterrole.rbac.authorization.k8s.io/ingress-nginx unchanged
clusterrolebinding.rbac.authorization.k8s.io/ingress-nginx unchanged
role.rbac.authorization.k8s.io/ingress-nginx unchanged
rolebinding.rbac.authorization.k8s.io/ingress-nginx unchanged
service/ingress-nginx-controller-admission unchanged
service/ingress-nginx-controller unchanged
deployment.apps/ingress-nginx-controller created
validatingwebhookconfiguration.admissionregistration.k8s.io/ingress-nginx-admission configured
serviceaccount/ingress-nginx-admission unchanged
clusterrole.rbac.authorization.k8s.io/ingress-nginx-admission unchanged
clusterrolebinding.rbac.authorization.k8s.io/ingress-nginx-admission unchanged
role.rbac.authorization.k8s.io/ingress-nginx-admission unchanged
rolebinding.rbac.authorization.k8s.io/ingress-nginx-admission unchanged
job.batch/ingress-nginx-admission-create unchanged
job.batch/ingress-nginx-admission-patch unchanged

```

- Deploy the ingress

```bash
$ kubectl apply -f ingress.yaml                                                                                                          
ingress.networking.k8s.io/ingress-wildcard-host configured

$ cat /etc/hosts | grep test
127.0.0.1 testingress.com

$ curl testingress.com/check.txt
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<body>
  <p>Its working!!!</p>
</div>
</body>
</html>

$ curl testingress.com/403      
<html>
<head><title>404 Not Found</title></head>
<body>
<center><h1>404 Not Found</h1></center>
<hr><center>nginx</center>
</body>
</html>

<br>

## which is expected as the ingress does not know about this path.
```