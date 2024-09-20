# curl

- [curl](#curl)
  - [NAME](#name)
  - [EXAMPLES](#examples)
    - [vkso | -H options | verbose | insecure | silent | output | headers](#vkso---h-options--verbose--insecure--silent--output--headers)
    - [-u -T | user | upload](#-u--t--user--upload)
    - [Get your public IP](#get-your-public-ip)
    - [To test a request to a server as if it came from the browser with the same Host header | -H | -k](#to-test-a-request-to-a-server-as-if-it-came-from-the-browser-with-the-same-host-header---h---k)
    - [--resolve | force resolve to IP | -H | --cacert | Root CA | --cert | --key](#--resolve--force-resolve-to-ip---h----cacert--root-ca----cert----key)
    - [To get only the status code using curl | -s | silent | -o | output | -w | write out | http\_code](#to-get-only-the-status-code-using-curl---s--silent---o--output---w--write-out--http_code)
    - [-L | --location | follow redirect | -I | --head | Fetch headers only](#-l----location--follow-redirect---i----head--fetch-headers-only)
    - [-o | output | download](#-o--output--download)
    - [-f | --fail | fail silently](#-f----fail--fail-silently)

## NAME

curl - transfer a URL

## EXAMPLES

### vkso | -H options | verbose | insecure | silent | output | headers

```bash
$ curl -vkso /dev/null 'https://121.170.212.70/healthcheck/healthcheck.htm' -H'X-test-Debug: 1' -H'Host: test.groceries.org.com'
.
```

### -u -T | user | upload

Using curl to deploy the artifact in tomcat

```bash
export DEPLOY_SOURCE_DIR=/apps/home/servers/Tomcat/deploy
export TOMCAT_USER=username
export TOMCAT_PASSWORD=userpassword
export TOMCAT_HOST=localhost
export TOMCAT_PORT=9090

curl -v -u $TOMCAT_USER:$TOMCAT_PASSWORD -T $DEPLOY_SOURCE_DIR/artifact.war http://$TOMCAT_HOST:$TOMCAT_PORT/manager/text/deploy?path=/offer
```

### Get your public IP

Also you can actually get your public IP by running following command

```bash
# Tested on mac
curl ifconfig.me
```

### To test a request to a server as if it came from the browser with the same Host header | -H | -k

To test a request to a server as if it came from the browser with the same Host header

```bash
# let's say you have port-forwarded a service to your local on port 8080 using kubectl port-forward
# This is the actual service responsible for responding to the user's request from browser when user hits http://test.example.com/svc_path_1
# -k is to allow insecure request
curl -H 'Host: test.example.com' http://localhost:svc_path_1 -kv
```

### --resolve | force resolve to IP | -H | --cacert | Root CA | --cert | --key

Send an HTTPS request to access the httpbin service through HTTPS:

```bash
## https://istio.io/latest/docs/tasks/traffic-management/ingress/secure-ingress/#configure-a-tls-ingress-gateway-for-a-single-host

# This command uses curl to send a verbose HTTPS request to the httpbin service, specifically to the /status/418 endpoint. It manually sets the Host header to httpbin.example.com to mimic requests to this domain. The --resolve option forces curl to resolve httpbin.example.com to the specified $INGRESS_HOST IP address at the $SECURE_INGRESS_PORT, effectively directing the request to the Istio ingress gateway. The --cacert option specifies the root CA certificate (example.com.crt), allowing curl to trust the self-signed certificate used by the ingress gateway. This command is crucial for testing secure HTTPS access to services managed by Istio, ensuring the routing and SSL/TLS configuration works as expected.

# The --cacert option is used to specify the CA certificate that curl should trust, enabling it to verify the self-signed certificate presented by the server during the SSL/TLS handshake.

# You have the CA certificate locally present

curl -v -HHost:httpbin.example.com --resolve "httpbin.example.com:$SECURE_INGRESS_PORT:$INGRESS_HOST" \
  --cacert example_certs1/example.com.crt "https://httpbin.example.com:$SECURE_INGRESS_PORT/status/418"
```

Pass a client certificate and private key to curl. Pass your client’s certificate with the --cert flag and your private key with the --key flag to curl:

```bash
# https://istio.io/latest/docs/tasks/traffic-management/ingress/secure-ingress/
curl -v -HHost:httpbin.example.com --resolve "httpbin.example.com:$SECURE_INGRESS_PORT:$INGRESS_HOST" \
  --cacert example_certs1/example.com.crt --cert example_certs1/client.example.com.crt --key example_certs1/client.example.com.key \
  "https://httpbin.example.com:$SECURE_INGRESS_PORT/status/418"
```

### To get only the status code using curl | -s | silent | -o | output | -w | write out | http_code

```bash
curl -s -o /dev/null -w "%{http_code}" http://google.com
```

Output

```bash
301
```

### -L | --location | follow redirect | -I | --head | Fetch headers only

```bash
curl http://google.com -L -I
```

Output

```bash
HTTP/1.1 301 Moved Permanently
..
..
HTTP/1.1 200 OK
```

### -o | output | download

```bash
curl -Lo /usr/local/bin/kubectl https://dl.k8s.io/release/v1.25.0/bin/linux/amd64/kubectl
```

### -f | --fail | fail silently

```bash
curl -f https://example.com/nonexistent-page
```

Output

```bash
curl: (22) The requested URL returned error: 404
```

