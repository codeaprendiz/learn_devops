# Securing Traffic with Anthos Service Mesh



[https://www.cloudskillsboost.google](https://www.cloudskillsboost.google)

[Select - Cloud Operations and Service Mesh with Anthos Course](https://www.cloudskillsboost.google)

**High Level Objectives**
- Enforce STRICT mTLS mode across the service mesh
- Enforce STRICT mTLS mode on a single namespace
- Explore the security configurations in the Anthos Service Mesh Dashboard
- Add authorization policies to enforce access based on a JSON Web Token (JWT)
- Add authorization policies for HTTP traffic in an Istio mesh

**Skills**
- anthos
- gcp
- Strict mTLS
- authorization policies
- JWT
- Istio
- Service Mesh

## Confirm Anthos Service Mesh setup

### Configure cluster access for kubectl

```bash
# Set environment variables for the zone and cluster name:
export CLUSTER_NAME=gke
export CLUSTER_ZONE=us-central1-b

# In Cloud Shell, configure kubectl command line access by running:
# get the project id
export GCLOUD_PROJECT=$(gcloud config get-value project)
# configure kubectl
gcloud container clusters get-credentials $CLUSTER_NAME \
    --zone $CLUSTER_ZONE --project $GCLOUD_PROJECT
```

- Verify cluster and Anthos Service Mesh installation

```bash
# Check that your cluster is up and running:
gcloud container clusters list

# Ensure the following Kubernetes istiod services are deployed:
kubectl get service -n istio-system

# Ensure the corresponding Kubernetes istiod-* pods are deployed and all containers are up and running:
kubectl get pods -n istio-system

 
```


### Deploy sleep and httpbin services

- The sleep service acts as the client and will call the httpbin service, which acts as a server.

![img.png](.images/mTLS-initial-setup.png)


- In Cloud Shell, create namespaces for the example clients and services. Traffic in the legacy-* namespaces takes place over plain text, while traffic in the mtls-* namespaces happens over mTLS:

```bash
kubectl create ns mtls-client
kubectl create ns mtls-service
kubectl create ns legacy-client
kubectl create ns legacy-service
kubectl get namespaces
```

- Deploy the legacy services in the legacy-* namespaces. You call them legacy because they are not part of the mesh:

```bash
#configurations are stored in Github
kubectl apply -f \
https://raw.githubusercontent.com/istio/istio/release-1.6/samples/sleep/sleep.yaml \
-n legacy-client
kubectl apply -f \
https://raw.githubusercontent.com/istio/istio/release-1.6/samples/httpbin/httpbin.yaml \
-n legacy-service
```

- Enable auto-injection of the Istio sidecar proxy on the mtls-* namespaces:

> We are auto-injecting the Istio sidecar proxy into the pods deployed in the mtls-client and mtls-service namespaces.
> The Istio sidecar proxy is a container that runs alongside the application container in the same pod, 
> and it intercepts all inbound and outbound traffic to the pod. It is responsible for implementing the 
> mTLS encryption between services in the Istio service mesh, and enforcing Istio policies such as traffic management, 
> routing, and security.

> By auto-injecting the sidecar proxy, we can ensure that all traffic between services in the mtls-client 
> and mtls-service namespaces is automatically encrypted and secured by Istio. This eliminates the need to 
> modify the application code or configuration, and makes it easy to deploy and manage services in a secure and scalable manner.

> The labels added to the namespaces (istio.io/rev=${VERSION}) are used by Istio's automatic sidecar 
> injection feature to determine which pods should have the sidecar proxy injected into them. 
> The ${VERSION} variable is set based on the revision label of the istiod deployment in the istio-system namespace, 
> and it ensures that the correct version of the Istio sidecar proxy is injected into the pods.







```bash
# get the revision label
export DEPLOYMENT=$(kubectl get deployments -n istio-system | grep istiod)
export VERSION=asm-$(echo $DEPLOYMENT | cut -d'-' -f 3)-$(echo $DEPLOYMENT \
    | cut -d'-' -f 4 | cut -d' ' -f 1)
# enable auto-injection on the namespaces
kubectl label namespace mtls-client istio.io/rev=${VERSION} --overwrite
kubectl label namespace mtls-service istio.io/rev=${VERSION} --overwrite
```

- Deploy the services in the mtls-* namespaces:

```bash
kubectl apply -f \
https://raw.githubusercontent.com/istio/istio/release-1.6/samples/sleep/sleep.yaml \
-n mtls-client
kubectl apply -f \
https://raw.githubusercontent.com/istio/istio/release-1.6/samples/httpbin/httpbin.yaml \
-n mtls-service
```

- Verify that the sleep service and the httpbin service are each deployed in both the mtls-service and legacy-service namespaces:

```bash
kubectl get services --all-namespaces
```

- Verify that a sleep pod is running in the mtls-client and legacy-client namespaces and that an httpbin pod is running in the mtls-service and legacy-service namespaces:

```bash
kubectl get pods --all-namespaces
```

- Verify that the two sleep clients can communicate with the two httpbin services

```bash
for from in "mtls-client" "legacy-client"; do
  for to in "mtls-service" "legacy-service"; do
    kubectl exec $(kubectl get pod -l app=sleep -n ${from} -o jsonpath={.items..metadata.name}) -c sleep -n ${from} -- curl "http://httpbin.${to}:8000/ip" -s -o /dev/null -w "sleep.${from} to httpbin.${to}: %{http_code}\n"
  done
done

## Output
sleep.mtls-client to httpbin.mtls-service: 200
sleep.mtls-client to httpbin.legacy-service: 200
sleep.legacy-client to httpbin.mtls-service: 200
sleep.legacy-client to httpbin.legacy-service: 200
```

### Understand authentication and enable service to service authentication with mTLS

- In the console, go to Navigation Menu > Anthos > Service Mesh.
- Under Namespace dropdown select mtls-service namespace and then click on the httpbin service located below.
- In the left side panel, go to Connected Services.
- Use your mouse to hover over the lock symbol in the Request port column, and verify that green means mTLS and red means plain text.
- Now check out the Security tab in the left side panel. It shows you that the httpbin service has received both plaintext and mTLS traffic.


- Test auto mutual TLS
- By default, Istio configures destination workloads in PERMISSIVE mode. When PERMISSIVE mode is enabled a service can accept both plaintext and mTLS traffic. mTLS is used when the request contains the X-Forwarded-Client-Cert header.

- Use the Cloud Shell to send a request from the sleep service in the mtls-client namespace to the httpbin service in the mtls-service namespace:

```bash
kubectl exec $(kubectl get pod -l app=sleep -n mtls-client -o jsonpath={.items..metadata.name}) -c sleep -n mtls-client -- curl http://httpbin.mtls-service:8000/headers -s | grep X-Forwarded-Client-Cert
# The traffic included the X-Forwarded-Client-Cert header and therefore was mutually authenticated and encrypted
```

- Now send a request from the sleep service in the mtls-client namespace to the httpbin service in the legacy-service namespace:

```bash
kubectl exec $(kubectl get pod -l app=sleep -n mtls-client -o jsonpath={.items..metadata.name}) -c sleep -n mtls-client -- curl http://httpbin.legacy-service:8000/headers -s | grep X-Forwarded-Client-Cert
# The X-Forwarded-Client-Cert header isn't present so the traffic was sent and received in plaintext.
```

- Finally, send a request from the sleep service in the legacy-client namespace to the httpbin service in the mtls-service namespace:

```bash
kubectl exec $(kubectl get pod -l app=sleep -n legacy-client -o jsonpath={.items..metadata.name}) -c sleep -n legacy-client -- curl http://httpbin.mtls-service:8000/headers -s | grep X-Forwarded-Client-Cert
# The X-Forwarded-Client-Cert header isn't present so the traffic was sent and received in plaintext
```

> Note: The httpbin service in the mtls-service namespace accepted mTLS traffic from the sleep service in the mtls-client namespace and plaintext from the sleep service in the legacy-client namespace.


- Enforce STRICT mTLS mode across the service mesh

- In STRICT mode, services injected with the Istio proxy will not accept plaintext traffic and will mutually authenticate with their clients.

- You can enforce STRICT mTLS mode across the whole mesh or on a per-namespace basis by creating PeerAuthentication resources.

![img.png](.images/mTLS-strict-mode.png)

- Create a Peer Authentication resources for the entire Service Mesh:

```bash
kubectl apply -n istio-system -f - <<EOF
apiVersion: "security.istio.io/v1beta1"
kind: "PeerAuthentication"
metadata:
  name: "mesh-wide-mtls"
spec:
    mtls:
        mode: STRICT
EOF
```

- Run this nested command loop:

```bash
for from in "mtls-client" "legacy-client"; do
  for to in "mtls-service" "legacy-service"; do
    kubectl exec $(kubectl get pod -l app=sleep -n ${from} -o jsonpath={.items..metadata.name}) -c sleep -n ${from} -- curl "http://httpbin.${to}:8000/ip" -s -o /dev/null -w "sleep.${from} to httpbin.${to}: %{http_code}\n"
  done
done

## Output
sleep.mtls-client to httpbin.mtls-service: 200
sleep.mtls-client to httpbin.legacy-service: 200
sleep.legacy-client to httpbin.mtls-service: 000
command terminated with exit code 56
sleep.legacy-client to httpbin.legacy-service: 200
```

> Note: The httpbin service in the mtls-service namespace now rejects the plaintext traffic it 
> receives from the sleep client in the legacy-client namespace.

- Remove the mesh wide mTLS PeerAuthentication resource by running this command in Cloud Shell:

```bash
kubectl delete pa mesh-wide-mtls -n istio-system
```

- Enforce STRICT mTLS mode on a single namespace

- In Cloud Shell create a namespace for STRICT mTLS:

```bash
kubectl create ns strict-mtls-service

# Enable auto-injection of the Istio sidecar proxy on the new namespace:
# get the revision label
export DEPLOYMENT=$(kubectl get deployments -n istio-system | grep istiod)
export VERSION=asm-$(echo $DEPLOYMENT | cut -d'-' -f 3)-$(echo $DEPLOYMENT \
    | cut -d'-' -f 4 | cut -d' ' -f 1)
# enable auto-injection on the namespaces
kubectl label namespace strict-mtls-service istio.io/rev=${VERSION} --overwrite

# Use Cloud Shell to deploy another instance of the httpbin service in the strict-mtls-service namespace:
kubectl apply -f \
https://raw.githubusercontent.com/istio/istio/release-1.6/samples/httpbin/httpbin.yaml \
-n strict-mtls-service


# Create a PeerAuthentication resource for the strict-mtls-service namespace:
kubectl apply -n strict-mtls-service -f - <<EOF
apiVersion: "security.istio.io/v1beta1"
kind: "PeerAuthentication"
metadata:
    name: "restricted-mtls"
    namespace: strict-mtls-service
spec:
    mtls:
        mode: STRICT
EOF

# Verify that the httpbin service in the mtls-service namespace still accepts plaintext traffic:
kubectl exec $(kubectl get pod -l app=sleep -n legacy-client -o jsonpath={.items..metadata.name}) -c sleep -n legacy-client -- curl "http://httpbin.mtls-service:8000/ip" -s -o /dev/null -w "sleep.legacy-client to httpbin.mtls-service: %{http_code}\n"

## Output
sleep.legacy-client to httpbin.mtls-service: 200

# Now check to see that the strict-mtls-service namespace httpbin service does not accept plaintext traffic:
kubectl exec $(kubectl get pod -l app=sleep -n legacy-client -o jsonpath={.items..metadata.name}) -c sleep -n legacy-client -- curl "http://httpbin.strict-mtls-service:8000/ip" -s -o /dev/null -w "sleep.legacy-client to httpbin.strict-mtls-service: %{http_code}\n"

## Output
sleep.legacy-client to httpbin.strict-mtls-service: 000
command terminated with exit code 56

## Verify that the httpbin service in the strict-mtls-service namespace does accept mTLS traffic:
kubectl exec $(kubectl get pod -l app=sleep -n mtls-client -o jsonpath={.items..metadata.name}) -c sleep -n mtls-client -- curl "http://httpbin.strict-mtls-service:8000/ip" -s -o /dev/null -w "sleep.mtls-client to httpbin.strict-mtls-service: %{http_code}\n"


## Output
sleep.mtls-client to httpbin.strict-mtls-service: 200

```


- In the Google Cloud console, select Navigation Menu > Anthos > Service Mesh.

- Under Namespace dropdown select strict-mtls-service namespace and then click on the httpbin service located below.

- In the left side panel, click on Connected Services.

- Use your mouse to hover over the lock symbol in the Request Port column to see that only mTLS traffic has been received.
- Remove the strict-mtls-service peer authentication policy by running this command in Cloud Shell:

```bash
kubectl delete pa restricted-mtls -n strict-mtls-service
```

### Leverage RequestAuthentication and AuthorizationPolicy resources

- This task shows you how to set up and use RequestAuthentication and AuthorizationPolicy resources. Ultimately, you will allow requests that have an approved JWT, and deny requests that don't.

- A RequestAuthentication resource defines the request authentication methods that are supported by a workload. Requests with invalid authentication information will be rejected. Requests with no authentication credentials will be accepted but will not have any authenticated identity.

- Create a RequestAuthentication resource for the httpbin workload in the mtls-service namespace. This policy allows the workload to accept requests with a JWT issued by testing@secure.istio.io.

```bash
kubectl apply -f - <<EOF
apiVersion: "security.istio.io/v1beta1"
kind: "RequestAuthentication"
metadata:
  name: "jwt-example"
  namespace: mtls-service
spec:
  selector:
    matchLabels:
      app: httpbin
  jwtRules:
  - issuer: "testing@secure.istio.io"
    jwksUri: "https://raw.githubusercontent.com/istio/istio/release-1.8/security/tools/jwt/samples/jwks.json"
EOF

## Verify that a request with an invalid JWT is denied:
kubectl exec "$(kubectl get pod -l app=sleep -n mtls-client -o jsonpath={.items..metadata.name})" -c sleep -n mtls-client -- curl "http://httpbin.mtls-service:8000/headers" -s -o /dev/null -H "Authorization: Bearer invalidToken" -w "%{http_code}\n"

## Output
401

# Verify that a request without any JWT is allowed:
kubectl exec "$(kubectl get pod -l app=sleep -n mtls-client -o jsonpath={.items..metadata.name})" -c sleep -n mtls-client -- curl "http://httpbin.mtls-service:8000/headers" -s -o /dev/null -w "%{http_code}\n"

# Output
200
```

- AuthorizationPolicy
- Create an AuthorizationPolicy resource for the httpbin workload in the mtls-service namespace:

```bash
kubectl apply -f - <<EOF
apiVersion: security.istio.io/v1beta1
kind: AuthorizationPolicy
metadata:
  name: require-jwt
  namespace: mtls-service
spec:
  selector:
    matchLabels:
      app: httpbin
  action: ALLOW
  rules:
  - from:
    - source:
       requestPrincipals: ["testing@secure.istio.io/testing@secure.istio.io"]
EOF
```

- The policy requires all requests to the httpbin workload to have a valid JWT with requestPrincipal set to testing@secure.istio.io/testing@secure.istio.io. Istio constructs the requestPrincipal by combining the iss and sub of the JWT token with a / separator as shown:

- Download a legitimate JWT that can be used to send accepted requests:

```bash
TOKEN=$(curl https://raw.githubusercontent.com/istio/istio/release-1.8/security/tools/jwt/samples/demo.jwt -s) && echo "$TOKEN" | cut -d '.' -f2 - | base64 --decode -

## Output
{"exp":4685989700,"foo":"bar","iat":1532389700,"iss":"testing@secure.istio.io","sub":"testing@secure.istio.io"}

# Note that the iss and sub keys are set to testing@secure.istio.io. This causes Istio to generate the attribute requestPrincipal with the value testing@secure.istio.io/testing@secure.istio.io:


```


- Verify that a request with a valid JWT is allowed:

```bash
kubectl exec "$(kubectl get pod -l app=sleep -n mtls-client -o jsonpath={.items..metadata.name})" -c sleep -n mtls-client -- curl "http://httpbin.mtls-service:8000/headers" -s -o /dev/null -H "Authorization: Bearer $TOKEN" -w "%{http_code}\n"

## Output
200

## Verify that a request without a JWT is denied:
kubectl exec "$(kubectl get pod -l app=sleep -n mtls-client -o jsonpath={.items..metadata.name})" -c sleep -n mtls-client -- curl "http://httpbin.mtls-service:8000/headers" -s -o /dev/null -w "%{http_code}\n"

## Output
403
```



### Authorizing requests based on method and path

- This task shows you how to control access to workloads by using an AuthorizationPolicy that evaluates the request type and URL.

- Update the require-jwt authorization policy for the httpbin workload in the mtls-service namespace. The new policy will still have the JWT requirement that you set up in the previous task. In addition, you are going to limit the type of HTTP requests, so that clients can only perform GET requests to the /ip endpoint:

```bash
kubectl apply -f - <<EOF
apiVersion: security.istio.io/v1beta1
kind: AuthorizationPolicy
metadata:
  name: require-jwt
  namespace: mtls-service
spec:
  selector:
    matchLabels:
      app: httpbin
  action: ALLOW
  rules:
  - from:
    - source:
        requestPrincipals: ["testing@secure.istio.io/testing@secure.istio.io"]
    to:
    - operation:
        methods: ["GET"]
        paths: ["/ip"]
EOF
```

- Verify that a request to the httpbin's /ip endpoint works:

```bash
kubectl exec "$(kubectl get pod -l app=sleep -n mtls-client -o jsonpath={.items..metadata.name})" -c sleep -n mtls-client -- curl "http://httpbin.mtls-service:8000/ip" -s -o /dev/null -H "Authorization: Bearer $TOKEN" -w "%{http_code}\n"

## Output
200

# Verify that a request to the httpbin's /headers endpoint is denied:
kubectl exec "$(kubectl get pod -l app=sleep -n mtls-client -o jsonpath={.items..metadata.name})" -c sleep -n mtls-client -- curl "http://httpbin.mtls-service:8000/headers" -s -o /dev/null -H "Authorization: Bearer $TOKEN" -w "%{http_code}\n"

## Output
403

# Remove the require-jwt authorization policy by running this command:
kubectl delete AuthorizationPolicy require-jwt -n mtls-service
```