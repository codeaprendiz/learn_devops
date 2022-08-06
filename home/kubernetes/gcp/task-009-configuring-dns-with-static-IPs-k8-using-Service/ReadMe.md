# Configuring Domain Names with Static IP Addresses

[configuring-domain-name-static-ip](https://cloud.google.com/kubernetes-engine/docs/tutorials/configuring-domain-name-static-ip)

This tutorial demonstrates the following steps:

- Reserve a static external IP address for your application
- Configure either Service or Ingress resources to use the static IP
- Update DNS records of your domain name to point to your application


## Step 0:
GKE Cluster created `us-central1-c	`


![](../../../images/kubernetes/gcp/task-009-configuring-dns-with-static-IPs-k8-using-Service/GKE_cluster_created.png)

## Step 1: 

Deploy your web application

```bash
$ kubectl apply -f helloweb-deployment.yaml
deployment.apps/helloweb created
```

## Step 2: 

Expose your application

### Use a Service
- Use a Service, which creates a TCP Network Load Balancer that works with regional IP addresses.

- To use a Service, create a static IP address named helloweb-ip in the region us-central1:

```bash
$ gcloud compute addresses create helloweb-ip --region us-central1
Created [https://www.googleapis.com/compute/v1/projects/gcloud-262311/regions/us-central1/addresses/helloweb-ip].
```
  
- To find the static IP address you created, run the following command:
 
```bash
$ gcloud compute addresses describe helloweb-ip --region us-central1
address: 34.67.51.160
addressType: EXTERNAL
creationTimestamp: '2020-04-13T15:17:53.083-07:00'
description: ''
id: '1347105937512029182'
kind: compute#address
name: helloweb-ip
networkTier: PREMIUM
region: https://www.googleapis.com/compute/v1/projects/gcloud-262311/regions/us-central1
selfLink: https://www.googleapis.com/compute/v1/projects/gcloud-262311/regions/us-central1/addresses/helloweb-ip
status: RESERVED
```

- Use the above static IP  to create a manifest file named `helloweb-service.yaml` describing a Service

- Create the service

```bash
$ kubectl apply -f helloweb-service.yaml
service/helloweb created
```

- To see the reserved IP address associated with the load balancer:
  
```bash
$ kubectl get service
NAME         TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
helloweb     LoadBalancer   10.127.11.151   <pending>     80:30354/TCP   36s
kubernetes   ClusterIP      10.127.0.1      <none>        443/TCP        73m

$ kubectl get service
NAME         TYPE           CLUSTER-IP      EXTERNAL-IP    PORT(S)        AGE
helloweb     LoadBalancer   10.127.11.151   34.67.51.160   80:30354/TCP   99s
kubernetes   ClusterIP      10.127.0.1      <none>         443/TCP        74m
```

### Step 3: 

Visit your reserved static IP address

```bash
$ curl http://34.67.51.160           
Hello, world!
Version: 1.0.0
Hostname: helloweb-7f7f7474fc-ghncd
```

### Step 4:

Configure your domain name records
```bash
$ nslookup testservicek8s.gotdns.ch                       
Server:         192.168.1.1
Address:        192.168.1.1#53

Non-authoritative answer:
Name:   testservicek8s.gotdns.ch
Address: 34.67.51.160
```

### Step 5:
Visit the domain

```bash
$ curl http://testservicek8s.gotdns.ch                       
Hello, world!
Version: 1.0.0
Hostname: helloweb-7f7f7474fc-ghncd
```

## Cleaning up

- Delete the load balancing resources:
  
```bash
$ kubectl delete ingress,service -l app=hello
service "helloweb" deleted
```

- Release the reserved static IP

```bash
$ gcloud compute addresses delete helloweb-ip --region us-central1
The following addresses will be deleted:
 - [helloweb-ip] in [us-central1]

Do you want to continue (Y/n)?  Y

Deleted [https://www.googleapis.com/compute/v1/projects/gcloud-262311/regions/us-central1/addresses/helloweb-ip].
```

- Delete the sample application:
  
```bash
$ kubectl delete -f helloweb-deployment.yaml
deployment.apps "helloweb" deleted
```