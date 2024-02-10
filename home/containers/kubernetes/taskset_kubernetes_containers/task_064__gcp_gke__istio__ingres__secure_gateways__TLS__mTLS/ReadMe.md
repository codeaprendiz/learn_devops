# [Secure Gateways](https://istio.io/latest/docs/tasks/traffic-management/ingress/secure-ingress/)

This task shows how to expose a secure HTTPS service using either simple or mutual TLS.

## [Before you begin](https://istio.io/latest/docs/tasks/traffic-management/ingress/secure-ingress/#before-you-begin)

```bash
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/httpbin/httpbin.yaml
```

For macOS users, verify that you use curl compiled with the LibreSSL library:

```bash
$ curl --version | grep LibreSSL
curl 7.54.0 (x86_64-apple-darwin17.0) libcurl/7.54.0 LibreSSL/2.0.20 zlib/1.2.11 nghttp2/1.24.0
```

## [Generate client and server certificates and keys](https://istio.io/latest/docs/tasks/traffic-management/ingress/secure-ingress/#generate-client-and-server-certificates-and-keys)

Create a root certificate and private key to sign the certificates for your services:

| Option                                   | Description                                                                                                                         |
|------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------|
| `req`                                    | OpenSSL command to create and process certificate signing requests (CSR). In this context, it's used to generate a new certificate. |
| `-x509`                                  | This option outputs a self-signed certificate instead of a certificate request. This is used for generating a root certificate.     |
| `-sha256`                                | Specifies the hash algorithm to use for signing the certificate. SHA-256 is a secure, widely used algorithm.                        |
| `-nodes`                                 | Skips the option to secure the private key with a passphrase. This makes automation easier but is less secure.                      |
| `-days 365`                              | Sets the validity of the certificate to 365 days. Adjust as needed for your use case.                                               |
| `-newkey rsa:2048`                       | Generates a new private key using RSA encryption with a 2048-bit key size. This is a good balance between security and performance. |
| `-subj '/O=example Inc./CN=example.com'` | Sets the subject field of the certificate. Here, `O` stands for Organization, and `CN` stands for Common Name (the domain name).    |
| `-keyout example_certs1/example.com.key` | Specifies the file to write the generated private key to.                                                                           |
| `-out example_certs1/example.com.crt`    | Specifies the file to write the generated certificate to.                                                                           |

```bash
mkdir example_certs1
# Generate Self-Signed Root Certificate
# Creates a self-signed root certificate for example.com using RSA 2048-bit encryption, valid for 365 days. The certificate and its private key are stored without passphrase encryption.
openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -subj '/O=example Inc./CN=example.com' -keyout example_certs1/example.com.key -out example_certs1/example.com.crt
```

Output

```bash
$ ls
example.com.crt example.com.key
```

---

Generate a certificate and a private key for httpbin.example.com:

| Option                                                   | Description                                                                                                                                                                                              |
|----------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `req`                                                    | OpenSSL command to create and process certificate signing requests (CSR). It's used here to generate a new CSR.                                                                                          |
| `-out`                                                   | Specifies the output file for the CSR. In this case, `example_certs1/httpbin.example.com.csr` is the file where the CSR will be saved.                                                                   |
| `-newkey rsa:2048`                                       | Generates a new private key using RSA encryption with a 2048-bit key size. This key size is recommended for good security.                                                                               |
| `-nodes`                                                 | Skips encrypting the private key with a passphrase. This makes automation and server use easier but reduces security because the key is not protected.                                                   |
| `-keyout`                                                | Specifies the file to write the generated private key to. Here, it is `example_certs1/httpbin.example.com.key`.                                                                                          |
| `-subj "/CN=httpbin.example.com/O=httpbin organization"` | Sets the subject field of the CSR. `CN` stands for Common Name, which is the fully qualified domain name (FQDN) of your site. `O` stands for Organization, which is the legal name of your organization. |

```bash
# Generate CSR and Private Key for httpbin.example.com
# Generates an RSA 2048-bit private key and a Certificate Signing Request (CSR) for httpbin.example.com. The command specifies the domain's common name and organization, and stores the key without passphrase protection.
openssl req -out example_certs1/httpbin.example.com.csr -newkey rsa:2048 -nodes -keyout example_certs1/httpbin.example.com.key -subj "/CN=httpbin.example.com/O=httpbin organization"
```

```bash
## Output
$ ls example_certs1      
example.com.crt         example.com.key         httpbin.example.com.csr httpbin.example.com.key
```

---

| Option          | Description                                                                                                                                                                                       |
|-----------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `x509`          | OpenSSL command to create X.509 certificates, certificate signing requests (CSRs), and to manage the public key infrastructure. Used here for certificate generation.                             |
| `-req`          | Indicates that the input is a CSR. This option specifies that the command should process a CSR and generate a certificate.                                                                        |
| `-sha256`       | Specifies the SHA-256 hash algorithm for signing the certificate, ensuring a high level of security.                                                                                              |
| `-days 365`     | Sets the validity period of the certificate to 365 days. Adjust according to how long you want the certificate to be valid.                                                                       |
| `-CA`           | Specifies the CA certificate file. In this case, `example_certs1/example.com.crt` is used to sign the CSR, effectively making it a signed certificate.                                            |
| `-CAkey`        | Specifies the private key file of the CA (`example_certs1/example.com.key`) used to sign the CSR.                                                                                                 |
| `-set_serial 0` | Sets the serial number of the certificate. Serial numbers are used to uniquely identify certificates issued by a CA. It's set to 0 here, but should be unique per certificate in a real scenario. |
| `-in`           | Specifies the input file. Here, it is the CSR file (`example_certs1/httpbin.example.com.csr`) that you want to turn into a certificate.                                                           |
| `-out`          | Specifies the output file for the newly created certificate. In this example, `example_certs1/httpbin.example.com.crt` will store the signed certificate.                                         |


```bash
# Sign httpbin.example.com CSR with Root Certificate
# Signs the CSR for httpbin.example.com with the root certificate, creating a signed certificate valid for 365 days. The -set_serial 0 option assigns a serial number to the certificate.
openssl x509 -req -sha256 -days 365 -CA example_certs1/example.com.crt -CAkey example_certs1/example.com.key -set_serial 0 -in example_certs1/httpbin.example.com.csr -out example_certs1/httpbin.example.com.crt
# Output
# Certificate request self-signature ok
# subject=CN=httpbin.example.com, O=httpbin organization
```

```bash
$ ls example_certs1
example.com.crt         example.com.key         httpbin.example.com.crt httpbin.example.com.csr httpbin.example.com.key
```

---

Create a second set of the same kind of certificates and keys:

```bash
mkdir example_certs2
# Generate Self-Signed Root Certificate
# Generates a self-signed X.509 certificate with RSA 2048-bit encryption for example.com, valid for 365 days. It creates a private key and certificate, stored without passphrase encryption.
openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -subj '/O=example Inc./CN=example.com' -keyout example_certs2/example.com.key -out example_certs2/example.com.crt
# Generate CSR and Private Key for httpbin.example.com
# Generates an RSA 2048-bit private key and a Certificate Signing Request (CSR) for httpbin.example.com. The key and CSR are stored without passphrase protection.
openssl req -out example_certs2/httpbin.example.com.csr -newkey rsa:2048 -nodes -keyout example_certs2/httpbin.example.com.key -subj "/CN=httpbin.example.com/O=httpbin organization"
# Sign httpbin.example.com CSR with Root Certificate
# Signs the httpbin.example.com CSR using the previously generated root certificate and key, issuing a certificate valid for 365 days. The new certificate is stored with a serial number of 0.
openssl x509 -req -sha256 -days 365 -CA example_certs2/example.com.crt -CAkey example_certs2/example.com.key -set_serial 0 -in example_certs2/httpbin.example.com.csr -out example_certs2/httpbin.example.com.crt

```

Generate a certificate and a private key for helloworld.example.com:

```bash
# Generate CSR and Private Key for helloworld.example.com
# Creates an RSA 2048-bit private key and a Certificate Signing Request (CSR) for helloworld.example.com, specifying the common name and organization. The command ensures the key is stored without passphrase encryption.
openssl req -out example_certs1/helloworld.example.com.csr -newkey rsa:2048 -nodes -keyout example_certs1/helloworld.example.com.key -subj "/CN=helloworld.example.com/O=helloworld organization"
# Sign helloworld.example.com CSR with Root Certificate
# Uses the root certificate and private key to sign the CSR for helloworld.example.com, issuing a certificate valid for 365 days. It assigns a serial number of 1 to the new certificate, differentiating it from others.
openssl x509 -req -sha256 -days 365 -CA example_certs1/example.com.crt -CAkey example_certs1/example.com.key -set_serial 1 -in example_certs1/helloworld.example.com.csr -out example_certs1/helloworld.example.com.crt
```

Generate a client certificate and private key:

```bash
# Generate CSR and Private Key for client.example.com
# This command generates a Certificate Signing Request (CSR) and a new 2048-bit RSA private key for client.example.com, indicating the common name and organization. The -nodes option ensures the private key is stored without encryption for easier use.
openssl req -out example_certs1/client.example.com.csr -newkey rsa:2048 -nodes -keyout example_certs1/client.example.com.key -subj "/CN=client.example.com/O=client organization"
# Sign client.example.com CSR with Root Certificate
# This command signs the CSR for client.example.com with the root certificate, creating a client certificate valid for 365 days. The -set_serial 1 assigns a unique serial number to the certificate, ensuring its distinct identity within the CA's issued certificates.
openssl x509 -req -sha256 -days 365 -CA example_certs1/example.com.crt -CAkey example_certs1/example.com.key -set_serial 1 -in example_certs1/client.example.com.csr -out example_certs1/client.example.com.crt
```

## [Configure a TLS ingress gateway for a single host](https://istio.io/latest/docs/tasks/traffic-management/ingress/secure-ingress/#configure-a-tls-ingress-gateway-for-a-single-host)

Create a secret for the ingress gateway:

```bash
# This command uses kubectl to create a new TLS secret named httpbin-credential in the istio-system namespace. The secret includes the private key and certificate for httpbin.example.com, enabling secure HTTPS communication through the Istio ingress gateway. This step is essential for configuring TLS termination or mutual TLS (mTLS) with custom certificates in Istio-enabled Kubernetes clusters
kubectl create -n istio-system secret tls httpbin-credential \
  --key=example_certs1/httpbin.example.com.key \
  --cert=example_certs1/httpbin.example.com.crt
```

Configure the ingress gateway:

First, define a gateway with a servers: section for port 443, and specify values for credentialName to be httpbin-credential. The values are the same as the secret’s name. The TLS mode should have the value of SIMPLE.

```bash
# This command defines an Istio Gateway resource named mygateway and applies it to the Kubernetes cluster. The gateway is configured to use Istio's default ingress gateway for traffic routing. It specifies a server on port 443 (HTTPS) with TLS mode set to SIMPLE, indicating it uses standard TLS rather than mutual TLS. The credentialName is set to httpbin-credential, which matches the name of the secret created earlier, linking the gateway to the TLS credentials. The hosts section limits the gateway to handle traffic for httpbin.example.com. This configuration allows secure HTTPS traffic to httpbin.example.com through Istio's ingress gateway.
cat <<EOF | kubectl apply -f -
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
      mode: SIMPLE
      credentialName: httpbin-credential # must be the same as secret
    hosts:
    - httpbin.example.com
EOF
```

Next, configure the gateway’s ingress traffic routes by defining a corresponding virtual service:

```bash
# This command creates an Istio Virtual Service named httpbin, routing traffic for httpbin.example.com through the mygateway Gateway. It specifically directs traffic for URIs starting with /status and /delay to the httpbin service on port 8000. This configuration is crucial for defining how ingress traffic to httpbin.example.com is handled within the Istio service mesh, ensuring that requests to specified paths are correctly routed to the appropriate internal service.
cat <<EOF | kubectl apply -f -
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: httpbin
spec:
  hosts:
  - "httpbin.example.com"
  gateways:
  - mygateway
  http:
  - match:
    - uri:
        prefix: /status
    - uri:
        prefix: /delay
    route:
    - destination:
        port:
          number: 8000
        host: httpbin
EOF
```

```bash
export INGRESS_NAME=istio-ingressgateway
export INGRESS_NS=istio-system
kubectl get svc "$INGRESS_NAME" -n "$INGRESS_NS"
export INGRESS_HOST=$(kubectl -n "$INGRESS_NS" get service "$INGRESS_NAME" -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export INGRESS_PORT=$(kubectl -n "$INGRESS_NS" get service "$INGRESS_NAME" -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
export SECURE_INGRESS_PORT=$(kubectl -n "$INGRESS_NS" get service "$INGRESS_NAME" -o jsonpath='{.spec.ports[?(@.name=="https")].port}')
export TCP_INGRESS_PORT=$(kubectl -n "$INGRESS_NS" get service "$INGRESS_NAME" -o jsonpath='{.spec.ports[?(@.name=="tcp")].port}')
```

Send an HTTPS request to access the httpbin service through HTTPS:

```bash
# This command uses curl to send a verbose HTTPS request to the httpbin service, specifically to the /status/418 endpoint. It manually sets the Host header to httpbin.example.com to mimic requests to this domain. The --resolve option forces curl to resolve httpbin.example.com to the specified $INGRESS_HOST IP address at the $SECURE_INGRESS_PORT, effectively directing the request to the Istio ingress gateway. The --cacert option specifies the root CA certificate (example.com.crt), allowing curl to trust the self-signed certificate used by the ingress gateway. This command is crucial for testing secure HTTPS access to services managed by Istio, ensuring the routing and SSL/TLS configuration works as expected.
# The --cacert option is used to specify the CA certificate that curl should trust, enabling it to verify the self-signed certificate presented by the server during the SSL/TLS handshake.
curl -v -HHost:httpbin.example.com --resolve "httpbin.example.com:$SECURE_INGRESS_PORT:$INGRESS_HOST" \
  --cacert example_certs1/example.com.crt "https://httpbin.example.com:$SECURE_INGRESS_PORT/status/418"
```

Output

```bash
.
*   Trying a.b.c.d:443...
* Connected to httpbin.example.com (a.b.c.d) port 443 (#0)
. 
* (304) (OUT), TLS handshake, Client hello (1):
*  CAfile: example_certs1/example.com.crt
*  CApath: none
* (304) (IN), TLS handshake, Server hello (2):
* (304) (IN), TLS handshake, Unknown (8):
* (304) (IN), TLS handshake, Certificate (11):
* (304) (IN), TLS handshake, CERT verify (15):
* (304) (IN), TLS handshake, Finished (20):
* (304) (OUT), TLS handshake, Finished (20):
.
* Server certificate:
*  subject: CN=httpbin.example.com; O=httpbin organization
*  start date: Feb 10 07:17:01 2024 GMT
*  expire date: Feb  9 07:17:01 2025 GMT
*  common name: httpbin.example.com (matched)
*  issuer: O=example Inc.; CN=example.com
*  SSL certificate verify ok.
* using HTTP/2
* h2 [:method: GET]
* h2 [:scheme: https]
* h2 [:authority: httpbin.example.com]
* h2 [:path: /status/418]
* h2 [user-agent: curl/8.1.2]
* h2 [accept: */*]
.
> GET /status/418 HTTP/2
> Host:httpbin.example.com
> User-Agent: curl/8.1.2
> Accept: */*
> 
< HTTP/2 418 
< server: istio-envoy
< date: Sat, 10 Feb 2024 07:29:02 GMT
< x-more-info: http://tools.ietf.org/html/rfc2324
< access-control-allow-origin: *
< access-control-allow-credentials: true
< content-length: 135
< x-envoy-upstream-service-time: 20
< 

    -=[ teapot ]=-

       _...._
     .'  _ _ `.
    | ."` ^ `". _,
    \_;`"---"`|//
      |       ;/
      \_     _/
        `"""`
* Connection #0 to host httpbin.example.com left intact
```

**Output Explaination**

Here's the analysis of the `curl` command output, including the corresponding sections of the output enclosed in ```bash``` for clarity:

```bash
* Added httpbin.example.com:443:a.b.c.d to DNS cache
* Hostname httpbin.example.com was found in DNS cache
*   Trying a.b.c.d:443...
* Connected to httpbin.example.com (a.b.c.d) port 443 (#0)
```

- **DNS Resolution Override**: Overrides DNS resolution to direct `httpbin.example.com` to the IP `a.b.c.d`, ensuring requests are sent to the specified ingress.

```bash
* ALPN: offers h2,http/1.1
* (304) (OUT), TLS handshake, Client hello (1):
*  CAfile: example_certs1/example.com.crt
*  CApath: none
* (304) (IN), TLS handshake, Server hello (2):
* (304) (IN), TLS handshake, Unknown (8):
* (304) (IN), TLS handshake, Certificate (11):
* (304) (IN), TLS handshake, CERT verify (15):
* (304) (IN), TLS handshake, Finished (20):
* (304) (OUT), TLS handshake, Finished (20):
* SSL connection using TLSv1.3 / AEAD-CHACHA20-POLY1305-SHA256
* ALPN: server accepted h2
```

- **TLS Handshake**: Details the secure TLSv1.3 handshake process, using the provided CA certificate for verification, and establishes an HTTP/2 connection.

```bash
* Server certificate:
*  subject: CN=httpbin.example.com; O=httpbin organization
*  start date: Feb 10 07:17:01 2024 GMT
*  expire date: Feb  9 07:17:01 2025 GMT
*  common name: httpbin.example.com (matched)
*  issuer: O=example Inc.; CN=example.com
*  SSL certificate verify ok.
```

- **Certificate Details**: Validates the server's SSL certificate, issued by `example Inc.` for `httpbin.example.com`, showing its validity period.

```bash
* using HTTP/2
* h2 [:method: GET]
* h2 [:scheme: https]
* h2 [:authority: httpbin.example.com]
* h2 [:path: /status/418]
* h2 [user-agent: curl/8.1.2]
* h2 [accept: */*]
* Using Stream ID: 1 (easy handle 0x15400bc00)
> GET /status/418 HTTP/2
> Host:httpbin.example.com
> User-Agent: curl/8.1.2
> Accept: */*
```

- **HTTP/2 Protocol**: Shows the request is made using HTTP/2, detailing the headers sent and the specific request for the `/status/418` endpoint.

```bash
< HTTP/2 418 
< server: istio-envoy
< date: Sat, 10 Feb 2024 09:57:07 GMT
< x-more-info: http://tools.ietf.org/html/rfc2324
< access-control-allow-origin: *
< access-control-allow-credentials: true
< content-length: 135
< x-envoy-upstream-service-time: 35
< 
    -=[ teapot ]=-

       _...._
     .'  _ _ `.
    | ."` ^ `". _,
    \_;`"---"`|//
      |       ;/
      \_     _/
        `"""`
```

- **Request and Response**: Demonstrates the successful HTTPS request to `/status/418`, resulting in a `418 I'm a teapot` response, including ASCII art, served by Istio's Envoy proxy.

```bash
* Connection #0 to host httpbin.example.com left intact
```

- **Connection Closure**: Indicates the connection remains open for potential subsequent requests, highlighting the keep-alive functionality of HTTP/2.

---

Change the gateway’s credentials by deleting the gateway’s secret and then recreating it using different certificates and keys:

```bash
kubectl -n istio-system delete secret httpbin-credential
kubectl create -n istio-system secret tls httpbin-credential \
  --key=example_certs2/httpbin.example.com.key \
  --cert=example_certs2/httpbin.example.com.crt

```

Access the httpbin service with curl using the new certificate chain:

```bash
curl -v -HHost:httpbin.example.com --resolve "httpbin.example.com:$SECURE_INGRESS_PORT:$INGRESS_HOST" \
  --cacert example_certs2/example.com.crt "https://httpbin.example.com:$SECURE_INGRESS_PORT/status/418"

```

Output

```bash
...
HTTP/2 418
...
    -=[ teapot ]=-

       _...._
     .'  _ _ `.
    | ."` ^ `". _,
    \_;`"---"`|//
      |       ;/
      \_     _/
        `"""`
```

If you try to access httpbin using the previous certificate chain, the attempt now fails:

```bash
curl -v -HHost:httpbin.example.com --resolve "httpbin.example.com:$SECURE_INGRESS_PORT:$INGRESS_HOST" \
  --cacert example_certs1/example.com.crt "https://httpbin.example.com:$SECURE_INGRESS_PORT/status/418"
```

Output

```bash
* Added httpbin.example.com:443:a.b.c.d to DNS cache
* Hostname httpbin.example.com was found in DNS cache
*   Trying a.b.c.d:443...
* Connected to httpbin.example.com (a.b.c.d) port 443 (#0)
* ALPN: offers h2,http/1.1
* (304) (OUT), TLS handshake, Client hello (1):
*  CAfile: example_certs1/example.com.crt
*  CApath: none
* (304) (IN), TLS handshake, Server hello (2):
* (304) (IN), TLS handshake, Unknown (8):
* (304) (IN), TLS handshake, Certificate (11):
* SSL certificate problem: unable to get local issuer certificate
* Closing connection 0
curl: (60) SSL certificate problem: unable to get local issuer certificate
More details here: https://curl.se/docs/sslcerts.html

curl failed to verify the legitimacy of the server and therefore could not
establish a secure connection to it. To learn more about this situation and
how to fix it, please visit the web page mentioned above.
```

## [Configure a TLS ingress gateway for multiple hosts](https://istio.io/latest/docs/tasks/traffic-management/ingress/secure-ingress/#configure-a-tls-ingress-gateway-for-multiple-hosts)

You can configure an ingress gateway for multiple hosts, httpbin.example.com and helloworld.example.com, for example. The ingress gateway is configured with unique credentials corresponding to each host.

Restore the httpbin credentials from the previous example by deleting and recreating the secret with the original certificates and keys:

```bash
kubectl -n istio-system delete secret httpbin-credential
kubectl create -n istio-system secret tls httpbin-credential \
  --key=example_certs1/httpbin.example.com.key \
  --cert=example_certs1/httpbin.example.com.crt

```

Start the helloworld-v1 sample:

```bash
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/helloworld/helloworld.yaml -l service=helloworld
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/helloworld/helloworld.yaml  -l version=v1
```

Create a helloworld-credential secret:

```bash
kubectl create -n istio-system secret tls helloworld-credential \
  --key=example_certs1/helloworld.example.com.key \
  --cert=example_certs1/helloworld.example.com.crt
```

Configure the ingress gateway with hosts httpbin.example.com and helloworld.example.com:

Define a gateway with two server sections for port 443. Set the value of credentialName on each port to httpbin-credential and helloworld-credential respectively. Set TLS mode to SIMPLE.


```bash
cat <<EOF | kubectl apply -f -
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
      name: https-httpbin
      protocol: HTTPS
    tls:
      mode: SIMPLE
      credentialName: httpbin-credential
    hosts:
    - httpbin.example.com
  - port:
      number: 443
      name: https-helloworld
      protocol: HTTPS
    tls:
      mode: SIMPLE
      credentialName: helloworld-credential
    hosts:
    - helloworld.example.com
EOF
```

Configure the gateway’s traffic routes by defining a corresponding virtual service.

```bash
cat <<EOF | kubectl apply -f -
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: helloworld
spec:
  hosts:
  - helloworld.example.com
  gateways:
  - mygateway
  http:
  - match:
    - uri:
        exact: /hello
    route:
    - destination:
        host: helloworld
        port:
          number: 5000
EOF
```

Send an HTTPS request to helloworld.example.com:

```bash
curl -v -HHost:helloworld.example.com --resolve "helloworld.example.com:$SECURE_INGRESS_PORT:$INGRESS_HOST" \
  --cacert example_certs1/example.com.crt "https://helloworld.example.com:$SECURE_INGRESS_PORT/hello"

# Output
# ...
# HTTP/2 200
# ...
```

Send an HTTPS request to httpbin.example.com and still get a teapot in return:

```bash
curl -v -HHost:httpbin.example.com --resolve "httpbin.example.com:$SECURE_INGRESS_PORT:$INGRESS_HOST" \
  --cacert example_certs1/example.com.crt "https://httpbin.example.com:$SECURE_INGRESS_PORT/status/418"

# Output
# ...
#     -=[ teapot ]=-

#        _...._
#      .'  _ _ `.
#     | ."` ^ `". _,
#     \_;`"---"`|//
#       |       ;/
#       \_     _/
#         `"""`
```

## [Configure a mutual TLS ingress gateway](https://istio.io/latest/docs/tasks/traffic-management/ingress/secure-ingress/#configure-a-mutual-tls-ingress-gateway)

You can extend your gateway’s definition to support mutual TLS.

Change the credentials of the ingress gateway by deleting its secret and creating a new one. The server uses the CA certificate to verify its clients, and we must use the key ca.crt to hold the CA certificate.

```bash
kubectl -n istio-system delete secret httpbin-credential
kubectl create -n istio-system secret generic httpbin-credential \
  --from-file=tls.key=example_certs1/httpbin.example.com.key \
  --from-file=tls.crt=example_certs1/httpbin.example.com.crt \
  --from-file=ca.crt=example_certs1/example.com.crt

```

Configure the ingress gateway:

```bash
# Change the gateway’s definition to set the TLS mode to MUTUAL.
cat <<EOF | kubectl apply -f -
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
      mode: MUTUAL
      credentialName: httpbin-credential # must be the same as secret
    hosts:
    - httpbin.example.com
EOF

```

Attempt to send an HTTPS request using the prior approach and see how it fails:

```bash
curl -v -HHost:httpbin.example.com --resolve "httpbin.example.com:$SECURE_INGRESS_PORT:$INGRESS_HOST" \
--cacert example_certs1/example.com.crt "https://httpbin.example.com:$SECURE_INGRESS_PORT/status/418"
# curl: (56) LibreSSL SSL_read: LibreSSL/3.3.6: error:1404C45C:SSL routines:ST_OK:reason(1116), errno 0
```

Pass a client certificate and private key to curl and resend the request. Pass your client’s certificate with the --cert flag and your private key with the --key flag to curl:

The `curl` command is configured to perform a secure HTTPS request to `httpbin.example.com`, using Mutual TLS (mTLS) for enhanced security through bidirectional authentication:

- `-v`: Enables verbose output to show detailed request and response information, including the mTLS handshake process.
- `-HHost:httpbin.example.com`: Sets the HTTP `Host` header to `httpbin.example.com`, explicitly defining the domain being requested.
- `--resolve "httpbin.example.com:$SECURE_INGRESS_PORT:$INGRESS_HOST"`: Directs `curl` to resolve the domain `httpbin.example.com` to a specific IP address and port, effectively bypassing DNS lookup.
- `--cacert example_certs1/example.com.crt`: Specifies the Certificate Authority (CA) certificate that `curl` uses to verify the server's SSL certificate, establishing trust.
- `--cert example_certs1/client.example.com.crt` and `--key example_certs1/client.example.com.key`: Include the client's certificate and private key, respectively, required for the server to authenticate the client as part of mTLS.
- `"https://httpbin.example.com:$SECURE_INGRESS_PORT/status/418"`: The URL being requested, using HTTPS to ensure encrypted communication, specifying the domain, port, and path.

This configuration demonstrates how to set up a `curl` request that utilizes mTLS, ensuring both the client and the server authenticate each other's certificates for a secure, encrypted communication channel.

```bash
curl -v -HHost:httpbin.example.com --resolve "httpbin.example.com:$SECURE_INGRESS_PORT:$INGRESS_HOST" \
  --cacert example_certs1/example.com.crt --cert example_certs1/client.example.com.crt --key example_certs1/client.example.com.key \
  "https://httpbin.example.com:$SECURE_INGRESS_PORT/status/418"

# ...
#     -=[ teapot ]=-

#        _...._
#      .'  _ _ `.
#     | ."` ^ `". _,
#     \_;`"---"`|//
#       |       ;/
#       \_     _/
#         `"""`
```

## Cleanup

```bash
# Delete the gateway configuration and routes:
kubectl delete gateway mygateway
kubectl delete virtualservice httpbin helloworld

# Delete the secrets, certificates and keys:
kubectl delete -n istio-system secret httpbin-credential helloworld-credential
rm -rf ./example_certs1 ./example_certs2

# Shutdown the httpbin and helloworld services:
kubectl delete -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/httpbin/httpbin.yaml
kubectl delete deployment helloworld-v1
kubectl delete service helloworld
```
