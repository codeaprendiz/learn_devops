# [Ingress Gateway without TLS Termination](https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-sni-passthrough/)

The Securing Gateways with HTTPS task describes how to configure HTTPS ingress access to an HTTP service. This example describes how to configure HTTPS ingress access to an HTTPS service, i.e., configure an ingress gateway to perform SNI passthrough, instead of TLS termination on incoming requests.

The example HTTPS service used for this task is a simple NGINX server. In the following steps you first deploy the NGINX service in your Kubernetes cluster. Then you configure a gateway to provide ingress access to the service via host nginx.example.com.

<br>

## [Generate client and server certificates and keys](https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-sni-passthrough/#generate-client-and-server-certificates-and-keys)

Create a root certificate and private key to sign the certificate for your services:

```bash
mkdir example_certs
openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -subj '/O=example Inc./CN=example.com' -keyout example_certs/example.com.key -out example_certs/example.com.crt
```

Create a certificate and a private key for nginx.example.com:

```bash
openssl req -out example_certs/nginx.example.com.csr -newkey rsa:2048 -nodes -keyout example_certs/nginx.example.com.key -subj "/CN=nginx.example.com/O=some organization"
openssl x509 -req -sha256 -days 365 -CA example_certs/example.com.crt -CAkey example_certs/example.com.key -set_serial 0 -in example_certs/nginx.example.com.csr -out example_certs/nginx.example.com.crt
```

<br>

## [Deploy nginx server](https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-sni-passthrough/#deploy-an-nginx-server)

Create a Kubernetes Secret to hold the server’s certificate.

```bash
kubectl create secret tls nginx-server-certs \
  --key example_certs/nginx.example.com.key \
  --cert example_certs/nginx.example.com.crt

```

Create a configuration file for the NGINX server:

```bash
cat <<\EOF > ./nginx.conf
events {
}

http {
  log_format main '$remote_addr - $remote_user [$time_local]  $status '
  '"$request" $body_bytes_sent "$http_referer" '
  '"$http_user_agent" "$http_x_forwarded_for"';
  access_log /var/log/nginx/access.log main;
  error_log  /var/log/nginx/error.log;

  server {
    listen 443 ssl;

    root /usr/share/nginx/html;
    index index.html;

    server_name nginx.example.com;
    ssl_certificate /etc/nginx-server-certs/tls.crt;
    ssl_certificate_key /etc/nginx-server-certs/tls.key;
  }
}
EOF

```

Create a Kubernetes ConfigMap to hold the configuration of the NGINX server:

```bash
kubectl create configmap nginx-configmap --from-file=nginx.conf=./nginx.conf

```

Deploy the NGINX server:

```bash
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: my-nginx
  labels:
    run: my-nginx
spec:
  ports:
  - port: 443
    protocol: TCP
  selector:
    run: my-nginx
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-nginx
spec:
  selector:
    matchLabels:
      run: my-nginx
  replicas: 1
  template:
    metadata:
      labels:
        run: my-nginx
        sidecar.istio.io/inject: "true"
    spec:
      containers:
      - name: my-nginx
        image: nginx
        ports:
        - containerPort: 443
        volumeMounts:
        - name: nginx-config
          mountPath: /etc/nginx
          readOnly: true
        - name: nginx-server-certs
          mountPath: /etc/nginx-server-certs
          readOnly: true
      volumes:
      - name: nginx-config
        configMap:
          name: nginx-configmap
      - name: nginx-server-certs
        secret:
          secretName: nginx-server-certs
EOF

```

To test that the NGINX server was deployed successfully, send a request to the server from its sidecar proxy without checking the server’s certificate (use the -k option of curl). Ensure that the server’s certificate is printed correctly, i.e., common name (CN) is equal to nginx.example.com.

```bash
kubectl exec "$(kubectl get pod  -l run=my-nginx -o jsonpath={.items..metadata.name})" -c istio-proxy -- curl -sS -v -k --resolve nginx.example.com:443:127.0.0.1 https://nginx.example.com

```

<br>

## [Configure an ingress gateway](https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-sni-passthrough/#configure-an-ingress-gateway)

Define a Gateway exposing port 443 with passthrough TLS mode. This instructs the gateway to pass the ingress traffic “as is”, without terminating TLS:

```bash
kubectl apply -f - <<EOF
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: mygateway
spec:
  selector:
    istio: ingressgateway # use istio default ingress gateway
  servers:
  - port:
      number: 443
      name: https
      protocol: HTTPS
    tls:
      mode: PASSTHROUGH
    hosts:
    - nginx.example.com
EOF
```

Configure routes for traffic entering via the Gateway:

```bash
kubectl apply -f - <<EOF
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: nginx
spec:
  hosts:
  - nginx.example.com
  gateways:
  - mygateway
  tls:
  - match:
    - port: 443
      sniHosts:
      - nginx.example.com
    route:
    - destination:
        host: my-nginx
        port:
          number: 443
EOF

```

```bash
export INGRESS_HOST=$(kubectl -n "$INGRESS_NS" get service "$INGRESS_NAME" -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export INGRESS_PORT=$(kubectl -n "$INGRESS_NS" get service "$INGRESS_NAME" -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
export SECURE_INGRESS_PORT=$(kubectl -n "$INGRESS_NS" get service "$INGRESS_NAME" -o jsonpath='{.spec.ports[?(@.name=="https")].port}')
export TCP_INGRESS_PORT=$(kubectl -n "$INGRESS_NS" get service "$INGRESS_NAME" -o jsonpath='{.spec.ports[?(@.name=="tcp")].port}')

```

Access the NGINX service from outside the cluster. Note that the correct certificate is returned by the server and it is successfully verified (SSL certificate verify ok is printed).

```bash
curl -v --resolve "nginx.example.com:$SECURE_INGRESS_PORT:$INGRESS_HOST" --cacert example_certs/example.com.crt "https://nginx.example.com:$SECURE_INGRESS_PORT"

```

Output

```bash
* Server certificate:
*  subject: CN=nginx.example.com; O=some organization
*  start date: Feb 11 10:59:38 2024 GMT
*  expire date: Feb 10 10:59:38 2025 GMT
*  common name: nginx.example.com (matched)
*  issuer: O=example Inc.; CN=example.com
*  SSL certificate verify ok.
...
< HTTP/1.1 200 OK
< Server: nginx/1.25.3
...
<html>
<head>
<title>Welcome to nginx!</title>
```

<br>

## Cleanup

```bash
# Delete the gateway configuration and route:
kubectl delete gateway mygateway
kubectl delete virtualservice nginx
# Remove the NGINX resources and configuration file:
kubectl delete secret nginx-server-certs
kubectl delete configmap nginx-configmap
kubectl delete service my-nginx
kubectl delete deployment my-nginx
# rm ./nginx.conf
# Delete the certificates and keys:
rm -rf ./example_certs

```