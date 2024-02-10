# curl

## NAME

curl - transfer a URL

## DESCRIPTION

curl  is a tool to transfer data from or to a server, using one of the supported protocols (DICT, FILE, FTP, FTPS, GOPHER, HTTP, HTTPS, IMAP, IMAPS, LDAP, LDAPS, POP3, POP3S, RTMP, RTSP, SCP, SFTP, SMB, SMBS, SMTP, SMTPS, TELNET and TFTP).
The command is designed to work without user interaction.

## OPTIONS

* -H, --header \<header\>
  * (HTTP) Extra header to include in the request when sending HTTP to a server.
* -k, --insecure
  * (TLS)  By default, every SSL connection curl makes is verified to be secure.
      This option allows curl to proceed and operate even for server connections otherwise considered insecure.
      The server connection is verified by making sure the server's certificate contains the right name and verifies successfully using the cert store.
* -o, --output \<file\>
  * Write output to \<file\> instead of stdout.
* -S, --show-error
  * When used with -s it makes curl show error message if it fails.
* -s, --silent
  * Silent  or quiet mode.
      Don't show progress meter or error messages.  
      Makes Curl mute.
      It will still output the data you ask for, potentially even to the terminal/stdout unless you redirect it.
* -T, --upload-file \<file\>
  * This transfers the specified local file to the remote URL. If there is no file part in the specified URL, Curl will append the local file name. NOTE that you must use a  trailing like

```bash
$ curl -T "{file1,file2}" http://www.uploadtothissite.com
.
```

* -u, --user <user:password>
  * Specify the user name and password to use for server authentication.
* -v, --verbose
  * Makes curl verbose during the operation.
      A line starting with '>' means "header data" sent by curl, '<' means "header data" received by curl that is hidden in normal cases, and a line starting with '*' means additional info provided by curl.
* -w, --write-out \<format\>
  * Make curl display information on stdout after a completed transfer.

### EXAMPLES

```bash
$ curl -vkso /dev/null 'https://121.170.212.70/healthcheck/healthcheck.htm' -H'X-test-Debug: 1' -H'Host: test.groceries.org.com'
.
```

* `curl google.com`

```bash
$ curl goole.com
<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
<TITLE>301 Moved</TITLE></HEAD><BODY>
<H1>301 Moved</H1>
The document has moved
<A HREF="http://www.google.com/">here</A>.
</BODY></HTML>
```

Using curl to deploy the artifact in tomcat

```bash
export DEPLOY_SOURCE_DIR=/apps/home/servers/Tomcat/deploy
export TOMCAT_USER=username
export TOMCAT_PASSWORD=userpassword
export TOMCAT_HOST=localhost
export TOMCAT_PORT=9090

curl -v -u $TOMCAT_USER:$TOMCAT_PASSWORD -T $DEPLOY_SOURCE_DIR/artifact.war http://$TOMCAT_HOST:$TOMCAT_PORT/manager/text/deploy?path=/offer
```

* Also you can actually get your public IP by running following command

```bash
# Tested on mac
$ curl ifconfig.me
.
```

To test a request to a server as if it came from the browser with the same Host header

```bash
# let's say you have port-forwarded a service to your local on port 8080 using kubectl port-forward
# This is the actual service responsible for responding to the user's request from browser when user hits http://test.example.com/svc_path_1
# -k is to allow insecure request
curl -H 'Host: test.example.com' http://localhost:svc_path_1 -kv
```

Send an HTTPS request to access the httpbin service through HTTPS:

```bash
## https://istio.io/latest/docs/tasks/traffic-management/ingress/secure-ingress/#configure-a-tls-ingress-gateway-for-a-single-host

# This command uses curl to send a verbose HTTPS request to the httpbin service, specifically to the /status/418 endpoint. It manually sets the Host header to httpbin.example.com to mimic requests to this domain. The --resolve option forces curl to resolve httpbin.example.com to the specified $INGRESS_HOST IP address at the $SECURE_INGRESS_PORT, effectively directing the request to the Istio ingress gateway. The --cacert option specifies the root CA certificate (example.com.crt), allowing curl to trust the self-signed certificate used by the ingress gateway. This command is crucial for testing secure HTTPS access to services managed by Istio, ensuring the routing and SSL/TLS configuration works as expected.

# The --cacert option is used to specify the CA certificate that curl should trust, enabling it to verify the self-signed certificate presented by the server during the SSL/TLS handshake.

# You have the CA certificate locally present

curl -v -HHost:httpbin.example.com --resolve "httpbin.example.com:$SECURE_INGRESS_PORT:$INGRESS_HOST" \
  --cacert example_certs1/example.com.crt "https://httpbin.example.com:$SECURE_INGRESS_PORT/status/418"
```
