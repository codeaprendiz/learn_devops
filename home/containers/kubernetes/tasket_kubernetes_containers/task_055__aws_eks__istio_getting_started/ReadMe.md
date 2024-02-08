# [Getting Started with Istio and Kubernetes Gateway API](https://istio.io/latest/docs/setup/additional-setup/getting-started/)

## Objective

Follow these steps to get started with Istio on AWS EKS cluster:

- Download and install Istio
- Deploy the sample application
- Open the application to outside traffic
- View the dashboard

## PRE-REQUISITES

```bash
brew install eksctl
```

## [Download](https://istio.io/latest/docs/setup/getting-started/#download)

```bash
curl -L https://istio.io/downloadIstio | sh -
```

```bash
$ ls istio-1.20.2                 
LICENSE       README.md     bin           manifest.yaml manifests     samples       tools

$ cat ~/.zshrc | grep istio         
## For istioctl
export PATH="$PATH:$HOME/Downloads/istio-1.20.2/bin"

$ istioctl version  
client version: 1.20.2
control plane version: 1.20.2
data plane version: 1.20.2 (2 proxies)
```

## [Install istio](https://istio.io/latest/docs/setup/getting-started/#install)

```bash
istioctl install --set profile=demo -y

```

Add a namespace label to instruct Istio to automatically inject Envoy sidecar proxies when you deploy your application later:

```bash
kubectl label namespace default istio-injection=enabled
```

## [Deploy sample application](https://istio.io/latest/docs/setup/getting-started/#bookinfo)

```bash
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/bookinfo/platform/kube/bookinfo.yaml
```

The application will start. As each pod becomes ready, the Istio sidecar will be deployed along with it.

```bash
$ kubectl get services
NAME          TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
details       ClusterIP   10.96.32.194    <none>        9080/TCP   6m26s
kubernetes    ClusterIP   10.96.0.1       <none>        443/TCP    15m
productpage   ClusterIP   10.96.224.100   <none>        9080/TCP   6m26s
ratings       ClusterIP   10.96.44.70     <none>        9080/TCP   6m26s
reviews       ClusterIP   10.96.181.121   <none>        9080/TCP   6m26s
```

```bash
$ kubectl get pods
NAME                             READY   STATUS    RESTARTS   AGE
details-v1-698d88b-fm857         2/2     Running   0          8m4s
productpage-v1-675fc69cf-vc7f7   2/2     Running   0          8m4s
ratings-v1-6484c4d9bb-sns9h      2/2     Running   0          8m4s
reviews-v1-5b5d6494f4-4l6xv      2/2     Running   0          8m4s
reviews-v2-5b667bcbf8-pnjf8      2/2     Running   0          8m4s
reviews-v3-5b9bd44f4-k7rmx       2/2     Running   0          8m4s
```

Verify everything is working correctly up to this point. Run this command to see if the app is running inside the cluster and serving HTML pages by checking for the page title in the response:

```bash
$ kubectl exec "$(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}')" -c ratings -- curl -sS productpage:9080/productpage | grep -o "<title>.*</title>"
<title>Simple Bookstore App</title>
```

## [Open the application to outside traffic](https://istio.io/latest/docs/setup/getting-started/#ip)

```bash
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/bookinfo/networking/bookinfo-gateway.yaml
```

```bash
$ istioctl analyze

✔ No validation issues found when analyzing namespace: default.
```

## [Determining the ingress IP and ports](https://istio.io/latest/docs/setup/getting-started/#determining-the-ingress-ip-and-ports)

Follow these instructions to set the INGRESS_HOST and INGRESS_PORT variables for accessing the gateway

```bash
kubectl get svc istio-ingressgateway -n istio-system
```

Set the ingress IP and ports:

```bash
export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
# export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].port}')
```

Set GATEWAY_URL:

```bash
export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
echo "$GATEWAY_URL"
```

[Verify external access](https://istio.io/latest/docs/setup/getting-started/#confirm)

Run the following command to retrieve the external address of the Bookinfo application.

```bash
echo "http://$GATEWAY_URL/productpage"
```

Validation

```bash
$ curl -I "http://$GATEWAY_URL/productpage"
HTTP/1.1 200 OK
server: istio-envoy
date: Tue, 06 Feb 2024 12:55:56 GMT
content-type: text/html; charset=utf-8
content-length: 5289
x-envoy-upstream-service-time: 122
```

## [View the dashboard](https://istio.io/latest/docs/setup/getting-started/#dashboard)

```bash
# https://stackoverflow.com/questions/75758115/persistentvolumeclaim-is-stuck-waiting-for-a-volume-to-be-created-either-by-ex
kubectl apply -f $HOME/Downloads/istio-1.20.2/samples/addons
```

```bash
 eksctl utils associate-iam-oidc-provider --region=<region_code> --cluster=eks --approve 

2024-02-06 17:36:06 [ℹ]  will create IAM Open ID Connect provider for cluster "eks" in "<region_code>"
2024-02-06 17:36:07 [✔]  created IAM Open ID Connect provider for cluster "eks" in "<region_code>"

---

eksctl create iamserviceaccount \
  --region <region_code> \
  --name ebs-csi-controller-sa \
  --namespace kube-system \
  --cluster eks \
  --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
  --approve \
  --role-only \
  --role-name AmazonEKS_EBS_CSI_DriverRole

---

eksctl create addon --name aws-ebs-csi-driver --cluster eks --service-account-role-arn arn:aws:iam::$(aws sts get-caller-identity --query Account --output text):role/AmazonEKS_EBS_CSI_DriverRole --force

```

Access the Kiali dashboard.

```bash
# To see trace data, you must send requests to your service
for i in $(seq 1 100); do curl -s -o /dev/null "http://$GATEWAY_URL/productpage"; done

```

```bash
istioctl dashboard kiali
```
