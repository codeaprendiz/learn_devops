# Compute Logging And Monitoring

[https://www.cloudskillsboost.google](https://www.cloudskillsboost.google)

[Select - DevOps Engineer, SRE Learning Path](https://www.cloudskillsboost.google/paths)

## High Level Objectives

- Set up a VM and a GKE cluster.
- Install and use the logging and monitoring agents for Compute Engine.
- Add a service to the GKE cluster and examine its logs and metrics.


### Set up a VM and a GKE cluster

Create VM

- Name : `web-server-vm`
- Boot Disk : `Debian GNU/Linux 10 (buster)`
- `Allow HTTP traffic`
- SSH

```bash
sudo apt-get update
sudo apt-get install nginx
sudo nginx -v

URL=URL_to_your_server

while true; do curl -s $URL | grep -oP "<title>.*</title>"; \
sleep .1s;done

## Check to make sure you have the requisite scopes to perform logging and monitoring.
## We need logging.write and monitoring.write
curl --silent --connect-timeout 1 -f -H "Metadata-Flavor: Google" \
http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/scopes

## Download the script, add the monitoring agent repo to apt, and install the agent.
curl -sSO https://dl.google.com/cloudagents/add-monitoring-agent-repo.sh
sudo bash add-monitoring-agent-repo.sh --also-install

## Start the monitoring agent:
sudo service stackdriver-agent start

## Install the logging agent:
curl -sSO https://dl.google.com/cloudagents/add-logging-agent-repo.sh
sudo bash add-logging-agent-repo.sh --also-install

## Check status of both
sudo service google-fluentd status
sudo service stackdriver-agent status

## To fully integrate the server, you enable the status information handler in 
## Nginx by adding a configuration file to the Nginx configuration directory:
(cd /etc/nginx/conf.d/ && sudo curl -O https://raw.githubusercontent.com/Stackdriver/stackdriver-agent-service-configs/master/etc/nginx/conf.d/status.conf)

## Reload nginx service
sudo service nginx reload

## Enable the Nginx monitoring plugin:
(cd /opt/stackdriver/collectd/etc/collectd.d/ && sudo curl -O https://raw.githubusercontent.com/Stackdriver/stackdriver-agent-service-configs/master/etc/collectd.d/nginx.conf)

## Restart the monitoring agent
sudo service stackdriver-agent restart

```

Create GKE Cluster

- Name : `gke-cluster`


### Use the logging and monitoring agents for Compute Engine

- Monitoring > Metrics Explorer
- Resource & Metric : VM Instance > Instance > CPU utilization
    - Filter instance_name = web-server-vm       : Apply

- Resource & Metric : VM Instance > nginx > Requests : Apply

### Add a service to the GKE cluster and examine its logs and metrics

- Cloud Shell

```bash
# Enable the Cloud Build API as it is needed in a few steps
gcloud services enable cloudbuild.googleapis.com

git clone https://github.com/haggman/HelloLoggingNodeJS.git

# Take a few mins to check the code

# Submit the Dockerfile to Google's Cloud Build to generate a container and store it in your Container Registry:
gcloud builds submit --tag gcr.io/$DEVSHELL_PROJECT_ID/hello-logging-js .

# Edit k8sapp.yaml and replace the $GCLOUD_PROJECT with actual ID

# Connect to cluster and
kubectl apply -f k8sapp.yaml

kubectl get services

URL=url_to_k8s_app
while true; do curl -s $URL -w "\n"; sleep .1s;done
```


- Monitoring > Dashboards > GKE > VIEW ALL and enable Sparklines and click Apply
- Switch to the Workloads tab. This is focused on the deployed workloads, grouped by namespace
- Finally, scroll to the Kubernetes Services tab and expand hello-logging-service

