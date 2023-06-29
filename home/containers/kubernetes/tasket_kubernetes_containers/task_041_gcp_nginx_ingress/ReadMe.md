# Nginx Ingress Setup

## High Level Objectives

- Create a GKE cluster using console
- Set up nginx ingress controller
- Use kustomize to deploy nginx ingress controller

## Set up GKE access on local machine

```bash
$ gcloud auth login
.

# Once access is allowed

# Get access to cluster and generate kubeconfig
$ gcloud container clusters get-credentials dev --zone us-central1-c --project devops-391009
Fetching cluster endpoint and auth data.
kubeconfig entry generated for dev.

# Validate
$ kubectl get nodes   
NAME                                 STATUS   ROLES    AGE   VERSION
gke-dev-default-pool-deac09b6-n853   Ready    <none>   20m   v1.27.2-gke.120
```

## Ingress Nginx Deployment

- [kubernetes/ingress-nginx/releases](https://github.com/kubernetes/ingress-nginx/releases)
- [check supported nginx version](https://github.com/kubernetes/ingress-nginx)

```bash
# Rotating Arrows Symbol (🔄): The rotating arrows symbol (🔄) in the first column indicates that there is a new release or update for Ingress-NGINX available. It suggests that there is a newer version of Ingress-NGINX available for use, and you may consider upgrading to the latest version to benefit from bug fixes, new features, and improvements. The rotating arrows symbol serves as a visual indicator for an update or release.
v1.8.0 - Ingress-NGINX version
1.27,1.26, 1.25, 1.24 - 1.27,1.26, 1.25, 1.24 - k8s supported version
1.21.6 - Nginx Version - 
4.7.* - Helm Chart Version  # Star (): The star symbol () in the "Helm Chart Version" column indicates that the specific version of the Helm chart for Ingress-NGINX is the latest stable version available. It implies that it is recommended to use the latest stable Helm chart version for deploying Ingress-NGINX in your Kubernetes cluster. The star denotes the most up-to-date and recommended version.
```

- [helm install](https://github.com/kubernetes/ingress-nginx/blob/main/docs/deploy/index.md)

```bash
$ helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
$ helm repo update

$ helm repo list | grep nginx
ingress-nginx   https://kubernetes.github.io/ingress-nginx

# Generate yaml using template , output to ingress-nginx.yaml, also create namespace ingress-nginx
$ helm template ingress-nginx-ext \
    --namespace ingress-nginx-ext \
    --create-namespace \
    --version v4.7 \
    --repo https://kubernetes.github.io/ingress-nginx \
    ingress-nginx > ingress-nginx-ext.yaml
```

- Create required files and folders

```bash
$ tree -L 3
.
├── ReadMe.md
├── base
│   └── ingress-nginx
│       ├── configmap_patch.yaml
│       ├── deployment.yaml
│       ├── ingressclass.yaml
│       ├── kustomization.yaml
│       ├── namespace.yaml
│       └── service.yaml
├── build
│   └── ingress_nginx_ext_all.yaml
├── overlays
└── vendor
    └── ingress-nginx
        ├── ingress-nginx-ext-vendor.yaml
        └── kustomization.yaml
```

- Build using

```bash
$ kustomize build base/ingress-nginx -o build/ingress_nginx_ext_all.yaml
.
```

- Apply

```bash
$ kubectl apply -f build/ingress_nginx_ext_all.yaml
.
```

- Validate

```bash
$ kubectl get pods -n ingress-nginx-ext    
NAME                                            READY   STATUS      RESTARTS   AGE
ingress-nginx-ext-admission-create-dw2f9        0/1     Completed   0          62m
ingress-nginx-ext-admission-patch-7w4hj         0/1     Completed   1          62m
ingress-nginx-ext-controller-5c8d78c9cc-ztdzv   1/1     Running     0          62m

$ kubectl get svc -n ingress-nginx-ext
NAME                                     TYPE           CLUSTER-IP     EXTERNAL-IP    PORT(S)                      AGE
ingress-nginx-ext-controller             LoadBalancer   10.112.3.156   35.232.7.154   80:31870/TCP,443:32046/TCP   62m
ingress-nginx-ext-controller-admission   ClusterIP      10.112.9.171   <none>         443/TCP                      62m
```

- Deploy the whoami app

```bash
$ kubectl apply -f base/app/.
.
```

- You can check the headers for the configmap [ingress-nginx/user-guide/nginx-configuration/configmap](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/configmap)

- [Access Logs not showing up?](https://github.com/kubernetes/ingress-nginx/issues/3163)
  - Access log is disabled for default server (the 404 server) (you can see that by inspecting the generated Nginx configuration, search for access_log off;)

```bash
# Logs of nginx pod
...
124.253.250.102 - - [29/Jun/2023:07:23:40 +0000] "GET /whoami HTTP/2.0" 200 1051 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36" 472 0.002 [default-whoami-service-80] [] 10.108.0.49:80 1051 0.001 200 f33404630d88104c8a703ee597bcff2a
124.253.250.102 - - [29/Jun/2023:07:23:58 +0000] "GET /whoami HTTP/2.0" 200 1008 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36" 450 0.001 [default-whoami-service-80] [] 10.108.0.49:80 1008 0.001 200 23bcd9d1533e4fd243a6d914ba2354d1
I0629 07:24:10.382175    
... 
```
