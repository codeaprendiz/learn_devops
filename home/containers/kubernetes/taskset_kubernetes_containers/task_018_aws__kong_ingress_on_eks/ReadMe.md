
[helm kong](https://github.com/Kong/charts)

- Pull kong repo to local

```bash
$ helm pull kong/kong                                                                           
$ tar -xvf kong-2.3.0.tgz
$ rm -rf kong-2.3.0.tgz 
```

- Install kong

```bash
$ helm upgrade --install -f values.yaml --set ingressController.installCRDs=false kong-release .
$ kubectl get svc                  
NAME                      TYPE           CLUSTER-IP       EXTERNAL-IP                                                               PORT(S)                      AGE
kong-release-kong-proxy   LoadBalancer   172.20.12.77     bf3ad6d307c3858239565d757ae733636-111947221.us-east-1.elb.amazonaws.com   80:30791/TCP,443:32126/TCP   20h
```

- Testing basic validations

```bash
$ curl -i bf3ad6d307c3858239565d757ae733636-111947221.us-east-1.elb.amazonaws.com:80
HTTP/1.1 404 Not Found
Date: Sat, 11 Sep 2021 08:44:32 GMT
Content-Type: application/json; charset=utf-8
Connection: keep-alive
Content-Length: 48
X-Kong-Response-Latency: 1
Server: kong/2.5.0

{"message":"no Route matched with those values"}%
```

- Following the getting started [guide](https://docs.konghq.com/kubernetes-ingress-controller/1.3.x/guides/getting-started/)

```bash
$ kubectl apply -f dep.yaml,svc.yaml
```

- Create an Ingress rule to proxy the echo-server created previously:

```bash
$ kubectl apply -f ingress.yaml     
ingress.extensions/demo configured

$ curl -i bf3ad6d307c3858239565d757ae733636-111947221.us-east-1.elb.amazonaws.com:80/foo
HTTP/1.1 200 OK
Content-Type: text/plain; charset=UTF-8
Transfer-Encoding: chunked
Connection: keep-alive
RateLimit-Reset: 44
X-RateLimit-Limit-Minute: 5
X-RateLimit-Remaining-Minute: 4
RateLimit-Limit: 5
RateLimit-Remaining: 4
Date: Sat, 11 Sep 2021 08:58:16 GMT
Server: echoserver
X-Kong-Upstream-Latency: 0
X-Kong-Proxy-Latency: 1
Via: kong/2.5.0



Hostname: echo-5fc5b5bc84-sf7pq

Pod Information:
        node name:      ip-172-0-2-39.us-east-1.compute.internal
        pod name:       echo-5fc5b5bc84-sf7pq
        pod namespace:  default
        pod IP: 172.0.2.144

Server values:
        server_version=nginx: 1.12.2 - lua: 1720172

Request Information:
        client_address=172.0.2.74
        method=GET
        real path=/foo
        query=
        request_version=1.1
        request_scheme=http
        request_uri=http://bf3ad6d307c3858239565d757ae733636-111947221.us-east-1.elb.amazonaws.com:8080/foo

Request Headers:
        accept=*/*  
        connection=keep-alive  
        host=bf3ad6d307c3858239565d757ae733636-111947221.us-east-1.elb.amazonaws.com  
        user-agent=curl/7.64.1  
        x-forwarded-for=172.0.1.137  
        x-forwarded-host=bf3ad6d307c3858239565d757ae733636-111947221.us-east-1.elb.amazonaws.com  
        x-forwarded-path=/foo  
        x-forwarded-port=80  
        x-forwarded-proto=http  
        x-real-ip=172.0.1.137  

Request Body:
        -no body in request-

```

- Using plugins

```bash
$ kubectl apply -f plugin.yaml 
```

- Create new ingress resource which uses this plugin. 
  The my-request-id can be seen in the request received by echo-server. It is injected by Kong as the request matches one of the Ingress rules defined in demo-example-com resource.

```bash
$ kubectl apply -f ingress-with-plugin.yaml          

$ curl -i bf3ad6d307c3858239565d757ae733636-111947221.us-east-1.elb.amazonaws.com:80/bar/sample
HTTP/1.1 404 Not Found
Date: Sat, 11 Sep 2021 09:17:09 GMT
Content-Type: application/json; charset=utf-8
Connection: keep-alive
Content-Length: 48
X-Kong-Response-Latency: 0
Server: kong/2.5.0

{"message":"no Route matched with those values"}

$ curl -i -H "Host: example.com" bf3ad6d307c3858239565d757ae733636-111947221.us-east-1.elb.amazonaws.com:80/bar/sample
HTTP/1.1 200 OK
Content-Type: text/plain; charset=UTF-8
Transfer-Encoding: chunked
Connection: keep-alive
RateLimit-Reset: 33
X-RateLimit-Limit-Minute: 5
X-RateLimit-Remaining-Minute: 4
RateLimit-Limit: 5
RateLimit-Remaining: 4
Date: Sat, 11 Sep 2021 09:17:27 GMT
Server: echoserver
X-Kong-Upstream-Latency: 0
X-Kong-Proxy-Latency: 1
Via: kong/2.5.0



Hostname: echo-5fc5b5bc84-sf7pq

Pod Information:
        node name:      ip-172-0-2-39.us-east-1.compute.internal
        pod name:       echo-5fc5b5bc84-sf7pq
        pod namespace:  default
        pod IP: 172.0.2.144

Server values:
        server_version=nginx: 1.12.2 - lua: 1720172

Request Information:
        client_address=172.0.2.74
        method=GET
        real path=/bar/sample
        query=
        request_version=1.1
        request_scheme=http
        request_uri=http://example.com:8080/bar/sample

Request Headers:
        accept=*/*  
        connection=keep-alive  
        host=example.com  
        my-request-id=94495283-19b7-4624-b4a7-becf14ecfd92#1  
        user-agent=curl/7.64.1  
        x-forwarded-for=172.0.2.39  
        x-forwarded-host=example.com  
        x-forwarded-path=/bar/sample  
        x-forwarded-port=80  
        x-forwarded-proto=http  
        x-real-ip=172.0.2.39  

Request Body:
        -no body in request-
```

- Using plugins on services

```bash
$ kubectl apply -f ratelimitplugin.yaml    
```

- Apply this plugin to the `echo` service

```bash
$ kubectl patch svc echo \
>   -p '{"metadata":{"annotations":{"konghq.com/plugins": "rl-by-ip\n"}}}'
```

- After 5 consecutive requests, you would get the following

```bash
$ curl -i bf3ad6d307c3858239565d757ae733636-111947221.us-east-1.elb.amazonaws.com:80/foo
HTTP/1.1 429 Too Many Requests
Date: Sat, 11 Sep 2021 09:30:08 GMT
Content-Type: application/json; charset=utf-8
Connection: keep-alive
RateLimit-Reset: 52
Retry-After: 52
X-RateLimit-Limit-Minute: 5
X-RateLimit-Remaining-Minute: 0
RateLimit-Limit: 5
RateLimit-Remaining: 0
Content-Length: 41
X-Kong-Response-Latency: 0
Server: kong/2.5.0

{
  "message":"API rate limit exceeded"
}%
```

- Using kong plugin resource
- First deploy the httpbin app
```bash
$ kubectl apply -f dep.yaml,svc.yaml
deployment.apps/httpbin created
service/httpbin created
```


- Deploy the ingress

```bash
$ kubectl apply -f ingress.yaml     
ingress.extensions/demo configured
ingress.extensions/demo-2 created

$ curl -i bf3ad6d307c3858239565d757ae733636-111947221.us-east-1.elb.amazonaws.com:80/foo/status/200
HTTP/1.1 200 OK
Content-Type: text/html; charset=utf-8
Content-Length: 0
Connection: keep-alive
Server: gunicorn/19.9.0
Date: Sat, 11 Sep 2021 10:52:11 GMT
Access-Control-Allow-Origin: *
Access-Control-Allow-Credentials: true
X-Kong-Upstream-Latency: 1
X-Kong-Proxy-Latency: 0
Via: kong/2.5.0

```

- Apply the plugin

```bash
$ kubectl apply -f add-response-header-plugin.yaml           
kongplugin.configuration.konghq.com/add-response-header created

```

- Now patch the demo ingress with this plugin

```bash
$ kubectl patch ingress demo -p '{"metadata":{"annotations":{"konghq.com/plugins":"add-response-header"}}}'
ingress.networking.k8s.io/demo patched
```

- Now test

```bash
$ curl -i bf3ad6d307c3858239565d757ae733636-111947221.us-east-1.elb.amazonaws.com:80/foo/status/200
HTTP/1.1 200 OK
Content-Type: text/html; charset=utf-8
Content-Length: 0
Connection: keep-alive
Server: gunicorn/19.9.0
Date: Sat, 11 Sep 2021 10:58:30 GMT
Access-Control-Allow-Origin: *
Access-Control-Allow-Credentials: true
demo:  injected-by-kong
X-Kong-Upstream-Latency: 1
X-Kong-Proxy-Latency: 0
Via: kong/2.5.0
```

- The following does not inject the header as expected

```bash
$ curl -i bf3ad6d307c3858239565d757ae733636-111947221.us-east-1.elb.amazonaws.com:80/baz/status/200
HTTP/1.1 200 OK
Content-Type: text/html; charset=utf-8
Content-Length: 0
Connection: keep-alive
Server: gunicorn/19.9.0
Date: Sat, 11 Sep 2021 11:00:07 GMT
Access-Control-Allow-Origin: *
Access-Control-Allow-Credentials: true
X-Kong-Upstream-Latency: 1
X-Kong-Proxy-Latency: 1
Via: kong/2.5.0
```

- Apply the plugin to only service

```bash
$ kubectl apply -f plugin-svc-http-auth.yaml                                                               
kongplugin.configuration.konghq.com/httpbin-auth created
```

- Now we patch the service with this plugin

```bash
kubectl patch service httpbin -p '{"metadata":{"annotations":{"konghq.com/plugins":"httpbin-auth"}}}'
```

- Now, any request sent to the service will require authentication, no matter which Ingress rule it matched:
  
```bash
$ curl -i bf3ad6d307c3858239565d757ae733636-111947221.us-east-1.elb.amazonaws.com:80/baz           
HTTP/1.1 401 Unauthorized
Date: Sat, 11 Sep 2021 11:30:11 GMT
Content-Type: application/json; charset=utf-8
Connection: keep-alive
WWW-Authenticate: Key realm="kong"
Content-Length: 45
X-Kong-Response-Latency: 0
Server: kong/2.5.0

{
  "message":"No API key found in request"
}

$ curl -i bf3ad6d307c3858239565d757ae733636-111947221.us-east-1.elb.amazonaws.com:80/foo
HTTP/1.1 401 Unauthorized
Date: Sat, 11 Sep 2021 11:30:28 GMT
Content-Type: application/json; charset=utf-8
Connection: keep-alive
WWW-Authenticate: Key realm="kong"
Content-Length: 45
demo:  injected-by-kong
X-Kong-Response-Latency: 0
Server: kong/2.5.0

{
  "message":"No API key found in request"
}
```

- Next, we will create a Secret resource with an API-key inside it:

```bash
kubectl create secret generic harry-apikey  \
>   --from-literal=kongCredType=key-auth  \
>   --from-literal=key=my-sooper-secret-key
secret/harry-apikey created
```

- Let's create one consumer with this key

```bash
$ kubectl apply -f consumer.yaml                                                        
kongconsumer.configuration.konghq.com/harry created
```


- Now again we try accessing the resource

```bash
curl -i -H 'apikey: my-sooper-secret-key' bf3ad6d307c3858239565d757ae733636-111947221.us-east-1.elb.amazonaws.com:80/foo/status/200
HTTP/1.1 200 OK
Content-Type: text/html; charset=utf-8
Content-Length: 0
Connection: keep-alive
Server: gunicorn/19.9.0
Date: Sat, 11 Sep 2021 11:58:12 GMT
Access-Control-Allow-Origin: *
Access-Control-Allow-Credentials: true
demo:  injected-by-kong
X-Kong-Upstream-Latency: 1
X-Kong-Proxy-Latency: 1
Via: kong/2.5.0

```

- Now we create a global plugin.

> With this plugin (please note the global label), every request through the Kubernetes Ingress Controller will be rate-limited:
  

```bash
$ kubectl apply -f ratelimitplugin.yaml
kongclusterplugin.configuration.konghq.com/global-rate-limit created
```


- After 5 successful requests we get the following

```bash
$ curl -i -H 'apikey: my-sooper-secret-key' bf3ad6d307c3858239565d757ae733636-111947221.us-east-1.elb.amazonaws.com:80/foo/status/200
HTTP/1.1 429 Too Many Requests
Date: Sat, 11 Sep 2021 12:25:15 GMT
Content-Type: application/json; charset=utf-8
Connection: keep-alive
RateLimit-Reset: 45
Retry-After: 45
X-RateLimit-Limit-Minute: 5
X-RateLimit-Remaining-Minute: 0
RateLimit-Limit: 5
RateLimit-Remaining: 0
Content-Length: 41
demo:  injected-by-kong
X-Kong-Response-Latency: 1
Server: kong/2.5.0

{
  "message":"API rate limit exceeded"
}                                                                                                                                                                                                                    
```


- Now we try applying the rate limit to a specific consumer

```bash
$ kubectl apply -f specific-consumer-plugin.yaml                   
kongplugin.configuration.konghq.com/harry-rate-limit created
```

- Reconfigure the consumer

```bash
$ kubectl apply -f consumer.yaml                
kongconsumer.configuration.konghq.com/harry configured
```

- Now if you consume the api with harry's credentials after 10 successful requests you would get

```bash
$ curl -i -H 'apikey: my-sooper-secret-key' bf3ad6d307c3858239565d757ae733636-111947221.us-east-1.elb.amazonaws.com:80/foo/status/200
HTTP/1.1 429 Too Many Requests
Date: Sat, 11 Sep 2021 12:38:23 GMT
Content-Type: application/json; charset=utf-8
Connection: keep-alive
RateLimit-Reset: 37
Retry-After: 37
X-RateLimit-Limit-Minute: 10
X-RateLimit-Remaining-Minute: 0
RateLimit-Limit: 10
RateLimit-Remaining: 0
Content-Length: 41
demo:  injected-by-kong
X-Kong-Response-Latency: 0
Server: kong/2.5.0

{
  "message":"API rate limit exceeded"
}              
```

#### Using KongIngress Resource

- Creating customized KongIngress

```bash
$ kubectl apply -f customizedKongIngress.yaml
kongingress.configuration.konghq.com/sample-customization created
```

- Now we will patch the demo ingress with this customization

```bash
$ kubectl patch ingress demo -p '{"metadata":{"annotations":{"konghq.com/override":"sample-customization"}}}'
ingress.networking.k8s.io/demo patched
```

- Now, Kong will proxy only GET requests on /foo path and strip away /foo:
  
```bash
$ curl -i -H 'apikey: my-sooper-secret-key' bf3ad6d307c3858239565d757ae733636-111947221.us-east-1.elb.amazonaws.com:80/foo -X POST
HTTP/1.1 404 Not Found
Date: Sat, 11 Sep 2021 13:00:35 GMT
Content-Type: application/json; charset=utf-8
Connection: keep-alive
Content-Length: 48
X-Kong-Response-Latency: 1
Server: kong/2.5.0

{"message":"no Route matched with those values"}
```