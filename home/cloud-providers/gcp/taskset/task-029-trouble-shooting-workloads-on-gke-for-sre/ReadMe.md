# Troubleshooting Workloads on GKE for Site Reliability Engineers

[https://www.cloudskillsboost.google](https://www.cloudskillsboost.google)

[Select - Quest -  DevOps Essentials](https://www.cloudskillsboost.google/paths)


**High Level Objectives**
- Access operational data through GKE Dashboards
- Proactive monitoring with logs-based metrics
- Create a SLO
- Define an alert on the SLO



**Skills**
- gcp
- log based metrics
- sre
- gke
- monitoring
- slo
- alerting
- troubleshooting





## Navigating Google Kubernetes Engine (GKE) resource pages

- In Cloud Console, from the Navigation menu go to Kubernetes Engine > Clusters.
- Confirm that you see the following Kubernetes cluster available: cloud-ops-sandbox. Validate that each cluster has a green checkbox next to it to indicate it is up and running.
- Click on the cloud-ops-sandbox link under the Name column to navigate to the cluster's Details tab.

## Accessing operational data through GKE Dashboards

- Navigate to Navigation menu > Kubernetes Engine > Services & Ingress. Click on the Endpoint (an IP address) for the frontend-external service.
- Click on any product displayed on the landing page to reproduce the error reported.


- Navigate to Cloud Monitoring from Cloud Console, from the Navigation Menu go to Monitoring > Dashboards.
- When the Dashboards landing page opens, click GKE.
- Click on the Add Filter button at the top of the GKE Dashboard page.
- From the available filters, select Workloads > recommendationservice.

- You will re-deploy the recommendationservice microservice to ensure that the error is no longer present.

```bash
git clone --depth 1 --branch csb_1220 https://github.com/GoogleCloudPlatform/cloud-ops-sandbox.git


cd cloud-ops-sandbox/sre-recipes

## Connect to cluster

./sandboxctl sre-recipes restore "recipe3"


## Check the service back again
```

## Proactive monitoring with logs-based metrics

- From Cloud Console, click on the Navigation Menu > Logging > Logs Explorer.
- In the Query results section click on +Create metric. This will open a new tab to create a logs based metric.
- Enter the following options on the Create logs metric page:

- Metric Type: Counter
- Log metric name: Error_Rate_SLI
- Filter Selection: (Copy and paste the filter below)

```bash
resource.labels.cluster_name="cloud-ops-sandbox" AND resource.labels.namespace_name="default" AND resource.type="k8s_container" AND labels.k8s-pod/app="recommendationservice" AND severity>=ERROR
```

## Creating a SLO

- Navigate to Navigation menu > Monitoring > Services. The resulting page will display a list of all services deployed to GKE for the application workload.

- Choose a metric: Other

- Request-based or windows-based: Request Based
- the Performance Metric must be set to the following value: custom.googleapis.com/opencensus/grpc.io/client/roundtrip_latency. This will show the roundtrip latency of requests made by the client to the recommendation service.
- Set the Performance metric to Less than -∞ to 100 ms.

- Period type: Calendar
- Period length: Calendar month
- Performance Goal: 99%


## Define an alert on the SLO

- Navigate to Navigation menu > Monitoring > Services.


