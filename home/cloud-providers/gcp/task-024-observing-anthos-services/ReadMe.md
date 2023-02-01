# Observing Anthos Services

[https://www.cloudskillsboost.google](https://www.cloudskillsboost.google)

[Select - Cloud Operations and Service Mesh with Anthos Course](https://www.cloudskillsboost.google)

## High Level Objectives

- Install Anthos Service Mesh, with tracing enabled and configured to use Cloud Trace as the backend.
- Deploy Bookinfo, an Istio-enabled multi-service application.
- Enable external access using an Istio Ingress Gateway.
- Use the Bookinfo application.
- Evaluate service performance using Cloud Trace features within Google Cloud.
- Create and monitor service-level objectives (SLOs).
- Leverage the Anthos Service Mesh Dashboard to understand service performance.


Anthos Service Mesh (ASM) on Google Kubernetes Engine. Anthos Service Mesh is a managed service based on Istio, the leading open source service mesh

### Install Anthos Service Mesh with tracing enabled

- Set ENV

```bash
CLUSTER_NAME=gke
CLUSTER_ZONE=us-central1-b
PROJECT_ID=$(gcloud config get-value project)
PROJECT_NUMBER=$(gcloud projects describe ${PROJECT_ID} \
  --format="value(projectNumber)")
FLEET_PROJECT_ID=${FLEET_PROJECT_ID:-$PROJECT_ID}
IDNS=${PROJECT_ID}.svc.id.goog
DIR_PATH=.
```

- Configure kubectl to manage your GKE cluster:

```bash
gcloud container clusters get-credentials $CLUSTER_NAME \
    --zone $CLUSTER_ZONE --project $PROJECT_ID
    
# Review your kubectl configuration:
kubectl config view

# Check that your cluster is running:
gcloud container clusters list

```

- Install Anthos Service Mesh

```bash
# Download the Anthos Service Mesh installation script:
curl https://storage.googleapis.com/csm-artifacts/asm/asmcli_1.15 > asmcli

chmod +x asmcli

# Use asmcli to install Anthos Service Mesh:
./asmcli install \
--project_id $PROJECT_ID \
--cluster_name $CLUSTER_NAME \
--cluster_location $CLUSTER_ZONE \
--fleet_id $FLEET_PROJECT_ID \
--output_dir $DIR_PATH \
--managed \
--enable_all \
--ca mesh_ca


# Enable Anthos Service Mesh to send telemetry to Cloud Trace:
cat <<EOF | kubectl apply -f -
apiVersion: v1
data:
  mesh: |-
    defaultConfig:
      tracing:
        stackdriver: {}
kind: ConfigMap
metadata:
  name: istio-asm-managed
  namespace: istio-system
EOF
```

### Install the microservices-demo application on the cluster

- Online Boutique is a cloud-native microservices demo application. Online Boutique consists of a 10-tier microservices application. The application is a web-based ecommerce app where users can browse items, add them to the cart, and purchase them.
- Google uses this application to demonstrate use of technologies like Kubernetes/GKE, Istio/ASM, Google Operations Suite, gRPC and OpenCensus. This application works on any Kubernetes cluster (such as a local one) and on Google Kubernetes Engine. It’s easy to deploy with little to no configuration.

- Configure the mesh data plane
- Enable Istio sidecar injection:

```bash
kubectl label namespace default istio.io/rev=asm-managed --overwrite
```

- To enable Google to manage your data plane so that the sidecar proxies will be automatically updated for you, annotate the namespace:

```bash
kubectl annotate --overwrite namespace default \
  mesh.cloud.google.com/proxy='{"managed":"true"}'
```

- Install the Online Boutique application on the GKE cluster

```bash
kubectl apply -f https://raw.githubusercontent.com/GoogleCloudPlatform/microservices-demo/master/release/kubernetes-manifests.yaml
kubectl patch deployments/productcatalogservice -p '{"spec":{"template":{"metadata":{"labels":{"version":"v1"}}}}}'
```

- To be able to access the application from outside the cluster, install the ingress Gateway:

```bash
git clone https://github.com/GoogleCloudPlatform/anthos-service-mesh-packages
kubectl apply -f anthos-service-mesh-packages/samples/gateways/istio-ingressgateway
```

- Configure the Gateway:

```bash
kubectl apply -f https://raw.githubusercontent.com/GoogleCloudPlatform/microservices-demo/master/release/istio-manifests.yaml
```

- Return to the Workloads and Services & Ingress pages, and verify that the new deployments and services have been created on the gke cluster.

- Look on the Services & Ingress page within the console.

### Review Google Cloud's operations suite functionality

- On the Navigation menu, click Trace > Trace List.

### Deploy a canary release that has high latency

```bash
# In Cloud Shell, clone the repository that has the configuration files you need for this part of the lab:
git clone https://github.com/GoogleCloudPlatform/istio-samples.git \
  ~/istio-samples
  
# Create the new resources on the gke cluster:
kubectl apply -f ~/istio-samples/istio-canary-gke/canary/destinationrule.yaml
kubectl apply -f ~/istio-samples/istio-canary-gke/canary/productcatalog-v2.yaml
kubectl apply -f ~/istio-samples/istio-canary-gke/canary/vs-split-traffic.yaml  
```

### Define your service level objective

- Navigation menu, click Anthos
- In the Services list, click productcatalogservice -> Health
- Click Create SLO.
- In the Set your SLI slideout, for metric, select Latency.
- Select Request-based as the method of evaluation.
- Click Continue.
- Set Latency Threshold to 1000, and click Continue.
- Set Period type to Calendar.
- Set Period length to Calendar day.
- Performance goal to 99.5%.

### Diagnose the problem

- Click on your SLO entry in the SLO list.
- From the Breakdown By dropdown, select Source service.

- Use Cloud Trace to better understand where the delay is
- In the Google Cloud Console, on the Navigation menu, click Trace > Trace List.
- Click on a dot that charts at around 3000ms; it should represent one of the requests to the product catalog service.


### Roll back the release and verify an improvement

- In Cloud Shell, back out the canary release:

```bash
kubectl delete -f ~/istio-samples/istio-canary-gke/canary/destinationrule.yaml
kubectl delete -f ~/istio-samples/istio-canary-gke/canary/productcatalog-v2.yaml
kubectl delete -f ~/istio-samples/istio-canary-gke/canary/vs-split-traffic.yaml
```

- Click on productcatalogservice, and then in the menu pane, click Health.
- Compare the current compliance metric with the one you saw earlier. It should be higher now, reflecting the fact that you are no longer seeing high-latency requests.

### Visualize your mesh with the Anthos Service Mesh dashboard

- On the Navigation menu, click Anthos > Service Mesh.
- Click Topology. A chart representing your service mesh is displayed.