# Managing Traffic Flow with Anthos Service Mesh



[https://www.cloudskillsboost.google](https://www.cloudskillsboost.google)

[Select - Cloud Operations and Service Mesh with Anthos Course](https://www.cloudskillsboost.google)

**High Level Objectives**
- Configure and use Istio Gateways
- Apply default destination rules, for all available versions
- Apply virtual services to route by default to only one version
- Route to a specific version of a service based on user identity
- Shift traffic gradually from one version of a microservice to another
- Use the Anthos Service Mesh dashboard to view routing to multiple versions
- Setup networking best practices such as retries, circuit breakers and timeouts

**Skills**
- gcp
- gke
- kubernetes
- istio
- service mesh
- anthos
- destination rules
- virtual services
- traffic management
- retries
- circuit breakers
- timeouts

Anthos Service Mesh’s traffic management model relies on the following two components:
- Control plane: manages and configures the Envoy proxies to route traffic and enforce polices.
- Data plane: encompasses all network communication between microservices performed at runtime by the Envoy proxies.

![img.png](.images/img.png)


## Review Traffic Management use cases

> In Istio, when an incoming request arrives at a Kubernetes cluster, it first reaches the Gateway resource,
> and then the VirtualService resource. The Gateway resource receives the incoming traffic and is responsible
> for routing the traffic to the correct VirtualService based on the specified rules. The VirtualService resource
> then applies additional routing rules to further direct the traffic to the appropriate destination service or pod.

- Example: traffic splitting
- Example: timeouts
- Example: retries
- Example: fault injection: inserting delays
- Example: fault injection: inserting aborts
- Example: conditional routing: based on request headers


## Setup

```bash
# In Cloud Shell, set environment variables for the zone and cluster name:
export CLUSTER_NAME=gke
export CLUSTER_ZONE=us-central1-b

# Configure kubectl command line access by running:
export GCLOUD_PROJECT=$(gcloud config get-value project)
gcloud container clusters get-credentials $CLUSTER_NAME \
    --zone $CLUSTER_ZONE --project $GCLOUD_PROJECT
    
# Check that your cluster is up and running:
gcloud container clusters list


# Ensure the Kubernetes pods for the Anthos Service Mesh control plane are deployed:
kubectl get pods -n istio-system


# Ensure corresponding Kubernetes services for the Anthos Service Mesh control plane are deployed:
kubectl get service -n istio-system

# Ensure corresponding Kubernetes pods for the Anthos Service Mesh control plane are deployed, so that telemetry data is displayed in the ASM Dashboard:
kubectl get pods -n asm-system

   
```

- Verify the Bookinfo deployment

```bash
kubectl get pods

# Review running application services:
kubectl get services

```


## Install Gateways to enable ingress

In a Kubernetes environment, the Kubernetes Ingress Resource is used to specify services that should be exposed outside the cluster. In Anthos Service Mesh, a better approach, which also works in Kubernetes and other environments, is to use a Gateway resource. A Gateway allows mesh features such as monitoring, mTLS, and advanced routing capabilities rules to be applied to traffic entering the cluster.

![img.png](.images/img2.png)


- Install an ingress gateway in your cluster

```bash
kubectl create namespace ingress

# Label the gateway namespace with a revision label for auto-injection:
kubectl label namespace ingress \
  istio.io/rev=$(kubectl -n istio-system get pods -l app=istiod -o json | jq -r '.items[0].metadata.labels["istio.io/rev"]') \
  --overwrite
```

- Download and apply the gateway configuration files. 
- These include the pods and services that will first receive the incoming requests from outside the cluster:

```bash
git clone https://github.com/GoogleCloudPlatform/anthos-service-mesh-packages
kubectl apply -n ingress -f anthos-service-mesh-packages/samples/gateways/istio-ingressgateway
```

- After you create the deployment, verify that the new services are working:

```bash
kubectl get pod,service -n ingress

# Notice the resource is a LoadBalancer. This ingress gateway uses an external TCP load balancer in GCP.
```

- Deploy the Gateway to specify the port and protocol to be used. In this case, the gateway enables HTTP traffic over port 80:
- The Gateway resource must be located in the same namespace as the gateway deployment.

```yaml
cat <<EOF | kubectl apply -f -
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: bookinfo-gateway
  namespace: ingress
spec:
  selector:
    istio: ingressgateway
  servers:
  - port:
      number: 80
      name: http
      protocol: HTTP
    hosts:
    - "*"
EOF
```

- Deploy the VirtualService to route traffic from the gateway pods and service that you just created into the BookInfo application:
- The VirtualService resource must be located in the same namespace as the application. Notice that it establishes the productpage service as the default destination
```bash
cat <<EOF | kubectl apply -f -
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: bookinfo
spec:
  hosts:
  - "*"
  gateways:
  - bookinfo-gateway
  http:
  - match:
    - uri:
        exact: /productpage
    - uri:
        prefix: /static
    - uri:
        exact: /login
    - uri:
        exact: /logout
    - uri:
        prefix: /api/v1/products
    route:
    - destination:
        host: productpage
        port:
          number: 9080
EOF
```


> In Istio, when an incoming request arrives at a Kubernetes cluster, it first reaches the Gateway resource, 
> and then the VirtualService resource. The Gateway resource receives the incoming traffic and is responsible 
> for routing the traffic to the correct VirtualService based on the specified rules. The VirtualService resource 
> then applies additional routing rules to further direct the traffic to the appropriate destination service or pod. 
> So in the example manifest, the incoming traffic will first reach the bookinfo-gateway Gateway resource and then 
> it will be directed to the bookinfo VirtualService based on the specified matching rules. The VirtualService 
> will then route the traffic to the appropriate destination based on the defined routing rules.

- Verify that the Gateway and VirtualService have been created and notice that the VirtualService is pointing to the Gateway:

```bash
kubectl get gateway,virtualservice

# Save this external IP in your Cloud Shell environment:
export GATEWAY_URL=$(kubectl get svc -n ingress istio-ingressgateway \
-o=jsonpath='{.status.loadBalancer.ingress[0].ip}')
echo The gateway address is $GATEWAY_URL
```

- Generate some background traffic

```bash
sudo apt install siege

# Use siege to create traffic against your services:
siege http://${GATEWAY_URL}/productpage

```

- Access the BookInfo application

```bash
# Initialize the new Cloud Shell tab:
export CLUSTER_NAME=gke
export CLUSTER_ZONE=us-central1-b
export GCLOUD_PROJECT=$(gcloud config get-value project)
gcloud container clusters get-credentials $CLUSTER_NAME \
    --zone $CLUSTER_ZONE --project $GCLOUD_PROJECT
export GATEWAY_URL=$(kubectl get svc istio-ingressgateway \
-o=jsonpath='{.status.loadBalancer.ingress[0].ip}' -n ingress)


# Confirm that the Bookinfo application responds by sending a curl request to it from some pod, within the cluster, for example from ratings:
kubectl exec -it \
$(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}') \
-c ratings -- curl productpage:9080/productpage \
| grep -o "<title>.*</title>"

# Check that the Bookinfo app responds to a curl request sent to it from outside the cluster, using the external IP saved earlier:
curl -I http://${GATEWAY_URL}/productpage

# Open the Bookinfo application in your browser. Run this command in the Cloud Shell to get the full URL:
echo http://${GATEWAY_URL}/productpage


```

## Use the Anthos Service Mesh dashboard view routing to multiple versions

- Navigation > Anthos > Service Mesh.
- Click on the productpage service, then select Connected Services on the left.
- Select the OUTBOUND tab and note the two services called by the productpage pods.
- Click on the reviews service.
- Note the service statistics, then select the Infrastructure link on the left-hand menu.
- You can see that there are multiple pods, running different versions of the reviews logic, that receive traffic sent to the reviews service.
- Click on Traffic in the left-hand menu to see another view of traffic distribution.
- You can see that there is relatively even distribution of traffic across the three backend pods running the different versions of the application logic.
- Click on the Anthos Service Mesh logo in the upper left corner to return to the main dashboard page.
- Click on the TOPOLOGY link in the upper-right corner
- Rearrange the mesh graph so that you can easily view:
   - The productpage service going to productpage deployment
   - The productpage deployment going to reviews service
   - The reviews service going to three version of reviews

## Apply default destination rules, for all available versions

- Review the configuration found in [Github](https://github.com/istio/istio/blob/master/samples/bookinfo/networking/destination-rule-all.yaml) . This configuration defines 4 DestinationRule resources, 1 for each servic
- Apply the configuration with the following command in Cloud Shell:

DestinationRule is an Istio resource that is used to configure traffic routing and policy rules for network traffic between Kubernetes services. It allows you to specify rules for how traffic should be routed to different versions of a service based on various criteria such as headers, URL paths, and user agents.

Here are some common use cases for DestinationRules:

- Traffic splitting: You can use DestinationRule to distribute traffic to different versions of a service based on the percentage of traffic you want to send to each version.
- Fault injection: DestinationRule can be used to inject errors or faults into the traffic to a specific version of a service for testing purposes.
- Circuit breaking: You can configure DestinationRule to apply circuit breaking rules to prevent cascading failures in your service mesh.
- Traffic shaping: DestinationRule can be used to limit the amount of traffic that can be sent to a particular version of a service or to specific instances of a service.
- Security: You can use DestinationRule to enforce mutual TLS authentication and other security policies for traffic between services. 

DestinationRule is a powerful tool for controlling how traffic flows between services in your Kubernetes cluster, and can help you improve the reliability, performance, and security of your applications.

```bash
kubectl apply -f https://raw.githubusercontent.com/istio/istio/master/samples/bookinfo/networking/destination-rule-all.yaml

# Check that 4 DestinationRule resources were defined.
kubectl get destinationrules

# Review the details of the destination rules:
kubectl get destinationrules -o yaml


```

- Wait for 1-2 minutes, then return to the Anthos Service Mesh dashboard.
- Look in both the table and topology views and confirm that the traffic continues to be evenly distributed across the three backend versions.

## Apply virtual services to route by default to only one version

- Review the configuration found in [Github](https://github.com/istio/istio/blob/master/samples/bookinfo/networking/virtual-service-all-v1.yaml). This configuration defines 4 VirtualService resources, 1 for each service.
- Apply the configuration with the following command in Cloud Shell:

```bash
kubectl apply -f https://raw.githubusercontent.com/istio/istio/master/samples/bookinfo/networking/virtual-service-all-v1.yaml

# Check that 4 routes, VirtualService resources, were defined:
kubectl get virtualservices

# In Cloud Shell, get the external IP address of the ingress gateway:
echo $GATEWAY_URL
```

- Open the Bookinfo site in your browser. The URL is http://[GATEWAY_URL]/productpage, where GATEWAY_URL is the External IP address of the ingress.
- Notice that the Book Reviews part of the page displays with no rating stars, no matter how many times you refresh. This is because you configured the mesh to route all traffic for the reviews service to the version reviews:v1 and this version of the service does not access the star ratings service.
- Wait for 1-2 minutes, then return to the Anthos Service Mesh dashboard by selecting Navigation > Anthos > Service Mesh > reviews > Infrastructure.
- Select SHOW TIMELINE and focus the chart on the last 5 minutes of traffic. You should see that the traffic goes from being evenly distributed to being routed to the version 1 workload 100% of the time.
- You can also see the new traffic distribution by looking at the Traffic tab or the topology view - though these both take a couple extra minutes before the data is shown.


## Route to a specific version of a service based on user identity

- Review the configuration found in [Github](https://github.com/istio/istio/blob/master/samples/bookinfo/networking/virtual-service-reviews-test-v2.yaml). This configuration defines 1 VirtualService resource.
- Apply the configuration with the following command in Cloud Shell:

```bash
kubectl apply -f https://raw.githubusercontent.com/istio/istio/master/samples/bookinfo/networking/virtual-service-reviews-test-v2.yaml

# Confirm the rule is created:
kubectl get virtualservice reviews
```

- Browse again to /productpage of the Bookinfo application.
- This time, click Sign in, and use User Name of jason with no password.
- Notice the UI shows stars from the rating service.

- To better visualize the effect of the new traffic routing, you can create a new background load of authenticated requests to the service
- Start a new siege session, generating only 20% of the traffic of the first, but with all requests being authenticated as jason:

```bash
curl -c cookies.txt -F "username=jason" -L -X \
    POST http://$GATEWAY_URL/login
cookie_info=$(grep -Eo "session.*" ./cookies.txt)
cookie_name=$(echo $cookie_info | cut -d' ' -f1)
cookie_value=$(echo $cookie_info | cut -d' ' -f2)
siege -c 5 http://$GATEWAY_URL/productpage \
    --header "Cookie: $cookie_name=$cookie_value"
```

- Wait for 1-2 minutes, refresh the page showing the Infrastructure telemetry, adjust the timeline to show the current time, and then check in the Anthos Dashboard and you should see that roughly 85% of requests over the last few minutes have gone to version 1 because they are unathenticated. About 15% have gone to version two because they are made as jason.
- In Cloud Shell, cancel the siege session by typing Ctrl+c.
- Clean up from this task by removing the application virtual services:

```bash
kubectl delete -f https://raw.githubusercontent.com/istio/istio/master/samples/bookinfo/networking/virtual-service-all-v1.yaml
```

- You can wait for 1-2 minutes, refresh the Anthos Service Mesh dashboard, adjust the timeline to show the current time, and confirm that traffic is once again evenly balanced across versions.


## Shift traffic gradually from one version of a microservice to another


- In Cloud Shell, route all traffic to the v1 version of each service:

```bash
kubectl apply -f https://raw.githubusercontent.com/istio/istio/master/samples/bookinfo/networking/virtual-service-all-v1.yaml 
```

- Browse again to /productpage of the Bookinfo application and confirm that you do not see stars with reviews
- Wait 1 minute, then refresh the Anthos Service Mesh dashboard, adjust the timeline to show the current time, and confirm that all traffic has been routed to the v1 backend.
- Transfer 50% of the traffic from reviews:v1 to reviews:v3.

```bash
kubectl apply -f \
    https://raw.githubusercontent.com/istio/istio/master/samples/bookinfo/networking/virtual-service-reviews-50-v3.yaml
    
    
```

- Browse again to /productpage of the Bookinfo application.

- Notice a roughly even distribution of reviews with no stars, from v1, and reviews with red stars, from v3, that accesses the ratings service.
- Wait 1 minute, then refresh the page, adjust the timeline to show the, current time, and confirm in the Anthos Service Mesh dashboard that traffic to the reviews service is split 50/50 between v1 and v3.
- Transfer the remaining 50% of traffic to reviews:v3.
- Assuming you decide that the reviews:v3 service is stable, route 100% of the traffic to reviews:v3 by applying this virtual service:

```bash
kubectl apply -f https://raw.githubusercontent.com/istio/istio/master/samples/bookinfo/networking//virtual-service-reviews-v3.yaml
```

- Test the new routing configuration using the Bookinfo UI.
- Browse again to /productpage of the Bookinfo application.

- Refresh the /productpage; you will always see book reviews with red colored star ratings for each review.

- Wait 1 minute, refresh the page, then confirm in the Anthos Service Mesh dashboard that all traffic to the reviews service is sent to v3.

- Clean up from this exercise, by removing the application virtual services.

```bash
kubectl delete -f https://raw.githubusercontent.com/istio/istio/master/samples/bookinfo/networking/virtual-service-all-v1.yaml
```

## Add timeouts to avoid waiting indefinitelly for service replies

- In Cloud Shell, route all traffic to the v1 version of each service:

```bash
kubectl apply -f https://raw.githubusercontent.com/istio/istio/master/samples/bookinfo/networking/virtual-service-all-v1.yaml
```

- Route requests to v2 of the reviews service, i.e., a version that calls the ratings service:

```bash
kubectl apply -f - <<EOF
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: reviews
spec:
  hosts:
  - reviews
  http:
  - route:
    - destination:
        host: reviews
        subset: v2
EOF
```

- Add a 2 second delay to calls to the ratings service:

```bash
kubectl apply -f - <<EOF
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: ratings
spec:
  hosts:
  - ratings
  http:
  - fault:
      delay:
        percent: 100
        fixedDelay: 2s
    route:
    - destination:
        host: ratings
        subset: v1
EOF
```

- Open the Bookinfo URL http://$GATEWAY_URL/productpage in your browser. You should see the Bookinfo application working normally (with ratings stars displayed), but there is a 2 second delay whenever you refresh the page. 
- Navigate to reviews / metrics to see that the latency is spiking to 2 seconds
- Now add a half second request timeout for calls to the reviews service:

```bash
kubectl apply -f - <<EOF
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: reviews
spec:
  hosts:
  - reviews
  http:
  - route:
    - destination:
        host: reviews
        subset: v2
    timeout: 0.5s
EOF
```

- You should now see that it returns in about 1 second, instead of 2, and the reviews are unavailable.

```bash
kubectl apply -f - <<EOF
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: productpage
spec:
  hosts:
  - productpage
  http:
  - route:
    - destination:
        host: productpage
        subset: v1
    retries:
      attempts: 1
      perTryTimeout: 2s
EOF
```

- Clean up from this exercise, by removing the application virtual services.

```bash
kubectl delete -f https://raw.githubusercontent.com/istio/istio/master/samples/bookinfo/networking/virtual-service-all-v1.yaml 
```

## Add circuit breakers to enhance your microservices' resiliency

- In Cloud Shell, route all traffic to the v1 version of each service:

```bash
kubectl apply -f https://raw.githubusercontent.com/istio/istio/master/samples/bookinfo/networking/virtual-service-all-v1.yaml
```

- Create a destination rule to apply circuit breaking settings when calling the productpage service:

```bash
kubectl apply -f - <<EOF
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: productpage
spec:
  host: productpage
  subsets:
  - name: v1
    labels:
      version: v1
  trafficPolicy:
    connectionPool:
      tcp:
        maxConnections: 1
      http:
        http1MaxPendingRequests: 1
        maxRequestsPerConnection: 1
    outlierDetection:
      consecutive5xxErrors: 1
      interval: 1s
      baseEjectionTime: 3m
      maxEjectionPercent: 100
EOF
```

- In Cloud Shell, go to the first tab and run Ctl+c to stop the siege.

- Create a client to send traffic to the productpage service.

- The client is a simple load-testing client called fortio. Fortio lets you control the number of connections, concurrency, and delays for outgoing HTTP calls. You will use this client to “trip” the circuit breaker policies you set in the DestinationRule

```bash
  kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.9/samples/httpbin/sample-client/fortio-deploy.yaml
```

- Log in to the client pod and use the fortio tool to call the productpage. Pass in curl to indicate that you just want to make one call:

```bash
export FORTIO_POD=$(kubectl get pods -lapp=fortio -o 'jsonpath={.items[0].metadata.name}')
kubectl exec "$FORTIO_POD" -c fortio -- /usr/bin/fortio curl -quiet http://${GATEWAY_URL}/productpage
```

- Call the service with two concurrent connections (-c 2) and send 20 requests (-n 20):

```bash
kubectl exec "$FORTIO_POD" -c fortio -- /usr/bin/fortio load -c 2 -qps 0 -n 20 -loglevel Warning http://${GATEWAY_URL}/productpage

```

- Bring the number of concurrent connections up to 3:

```bash
kubectl exec "$FORTIO_POD" -c fortio -- /usr/bin/fortio load -c 3 -qps 0 -n 30 -loglevel Warning http://${GATEWAY_URL}/productpage
```