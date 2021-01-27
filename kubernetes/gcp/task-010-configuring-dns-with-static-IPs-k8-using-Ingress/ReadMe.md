# Configuring Domain Names with Static IP Addresses

[configuring-domain-name-static-ip](https://cloud.google.com/kubernetes-engine/docs/tutorials/configuring-domain-name-static-ip)

This tutorial demonstrates the following steps:

- Reserve a static external IP address for your application
- Configure either Service or Ingress resources to use the static IP
- Update DNS records of your domain name to point to your application


## Step 0:
GKE Cluster created `us-central1-c	`

![](../task-009-configuring-dns-with-static-IPs-k8-using-Service/.ReadMe_images/GKE_cluster_created.png)

## Step 1: 

Deploy your web application

```bash
$ kubectl apply -f helloweb-deployment.yaml
deployment.apps/helloweb created
```

## Step 2: 

Expose your application

### Using an Ingress
- If you choose to expose your application using an Ingress, 
which creates an HTTP(S) Load Balancer, you must reserve a global static IP address. Regional IP addresses do not work with Ingress.

- To create a global static IP address named helloweb-ip:
  

```bash
$ gcloud compute addresses create helloweb-ip --global
Created [https://www.googleapis.com/compute/v1/projects/gcloud-262311/global/addresses/helloweb-ip].
```
  
- To find the static IP address you created, run the following command:
 
```bash
$ gcloud compute addresses describe helloweb-ip --global
address: 35.190.35.174
addressType: EXTERNAL
creationTimestamp: '2020-04-13T15:52:30.054-07:00'
description: ''
id: '4058631783476450241'
ipVersion: IPV4
kind: compute#address
name: helloweb-ip
networkTier: PREMIUM
selfLink: https://www.googleapis.com/compute/v1/projects/gcloud-262311/global/addresses/helloweb-ip
status: RESERVED
```

- To expose a web application on a static IP using Ingress, you need to deploy two resources:
    - A Service with type:NodePort
    - An Ingress configured with the service name and static IP annotation

- Use the above static IP to create a manifest file named `helloweb-ingress.yaml` describing these two resources:
  

- Apply the helloweb-ingress.yaml manifest file to the cluster:
  

```bash
$ kubectl apply -f helloweb-ingress.yaml
ingress.extensions/helloweb created
service/helloweb-backend created
```

- To see the reserve IP address associated with the load balancer:
  
```bash
$ kubectl get ingress
NAME       HOSTS   ADDRESS         PORTS   AGE
helloweb   *       35.190.35.174   80      49s
```

### Step 3: 

Visit your reserved static IP address

```bash
$ curl http://35.190.35.174
<!DOCTYPE html>
<html lang=en>
  <meta charset=utf-8>
  <meta name=viewport content="initial-scale=1, minimum-scale=1, width=device-width">
  <title>Error 404 (Not Found)!!1</title>
  <style>
    *{margin:0;padding:0}html,code{font:15px/22px arial,sans-serif}html{background:#fff;color:#222;padding:15px}body{margin:7% auto 0;max-width:390px;min-height:180px;padding:30px 0 15px}* > body{background:url(//www.google.com/images/errors/robot.png) 100% 5px no-repeat;padding-right:205px}p{margin:11px 0 22px;overflow:hidden}ins{color:#777;text-decoration:none}a img{border:0}@media screen and (max-width:772px){body{background:none;margin-top:0;max-width:none;padding-right:0}}#logo{background:url(//www.google.com/images/branding/googlelogo/1x/googlelogo_color_150x54dp.png) no-repeat;margin-left:-5px}@media only screen and (min-resolution:192dpi){#logo{background:url(//www.google.com/images/branding/googlelogo/2x/googlelogo_color_150x54dp.png) no-repeat 0% 0%/100% 100%;-moz-border-image:url(//www.google.com/images/branding/googlelogo/2x/googlelogo_color_150x54dp.png) 0}}@media only screen and (-webkit-min-device-pixel-ratio:2){#logo{background:url(//www.google.com/images/branding/googlelogo/2x/googlelogo_color_150x54dp.png) no-repeat;-webkit-background-size:100% 100%}}#logo{display:inline-block;height:54px;width:150px}
  </style>
  <a href=//www.google.com/><span id=logo aria-label=Google></span></a>
  <p><b>404.</b> <ins>That’s an error.</ins>
  <p>The requested URL <code>/</code> was not found on this server.  <ins>That’s all we know.</ins>
```


### TDB:

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
$ gcloud compute addresses delete helloweb-ip --global
The following global addresses will be deleted:
 - [helloweb-ip]

Do you want to continue (Y/n)?  Y

Deleted [https://www.googleapis.com/compute/v1/projects/gcloud-262311/global/addresses/helloweb-ip].
```

- Delete the sample application:
  
```bash
$ kubectl delete -f helloweb-deployment.yaml
deployment.apps "helloweb" deleted
```