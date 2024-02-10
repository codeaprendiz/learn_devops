# [Traffic Management](https://istio.io/latest/docs/concepts/traffic-management/)

## [Architecture](https://istio.io/latest/docs/ops/deployment/architecture/)

## Virtual Service

A virtual service lets you configure how requests are routed to a service within an Istio service mesh.

[virtual-service-example](https://istio.io/latest/docs/concepts/traffic-management/#virtual-service-example)

The following virtual service routes requests to different versions of a service depending on whether the request comes from a particular user.

```yaml
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: reviews
spec:
  hosts:
  - reviews
  http:
  - match:
    - headers:
        end-user:
          exact: jason
    route:
    - destination:
        host: reviews
        subset: v2
  - route:
    - destination:
        host: reviews
        subset: v3

```

## [Destination Rule](https://istio.io/latest/docs/concepts/traffic-management/#destination-rules)

You can think of virtual services as how you route your traffic to a given destination, and then you use destination rules to configure what happens to traffic for that destination. Destination rules are applied after virtual service routing rules are evaluated, so they apply to the traffic’s “real” destination.

Destination rule example

The following example destination rule configures three different subsets for the my-svc destination service, with different load balancing policies:

```yaml
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: my-destination-rule
spec:
  host: my-svc
  trafficPolicy:
    loadBalancer:
      simple: RANDOM
  subsets:
  - name: v1
    labels:
      version: v1
  - name: v2
    labels:
      version: v2
    trafficPolicy:
      loadBalancer:
        simple: ROUND_ROBIN
  - name: v3
    labels:
      version: v3
```

Each subset is defined based on one or more labels, which in Kubernetes are key/value pairs that are attached to objects such as Pods. These labels are applied in the Kubernetes service’s deployment as metadata to identify different versions.

As well as defining subsets, this destination rule has both a default traffic policy for all subsets in this destination and a subset-specific policy that overrides it for just that subset. The default policy, defined above the subsets field, sets a simple random load balancer for the v1 and v3 subsets. In the v2 policy, a round-robin load balancer is specified in the corresponding subset’s field.

## [Gateways](https://istio.io/latest/docs/concepts/traffic-management/#gateways)

You use a gateway to manage inbound and outbound traffic for your mesh, letting you specify which traffic you want to enter or leave the mesh. Gateway configurations are applied to standalone Envoy proxies that are running at the edge of the mesh, rather than sidecar Envoy proxies running alongside your service workloads.

[Gateway Example](https://istio.io/latest/docs/concepts/traffic-management/#gateway-example)

The following example shows a possible gateway configuration for external HTTPS ingress traffic:

```yaml
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: ext-host-gwy
spec:
  selector:
    app: my-gateway-controller
  servers:
  - port:
      number: 443
      name: https
      protocol: HTTPS
    hosts:
    - ext-host.example.com
    tls:
      mode: SIMPLE
      credentialName: ext-host-cert
```

This gateway configuration lets HTTPS traffic from ext-host.example.com into the mesh on port 443, but doesn’t specify any routing for the traffic.

To specify routing and for the gateway to work as intended, you must also bind the gateway to a virtual service. You do this using the virtual service’s gateways field, as shown in the following example.

```yaml
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: virtual-svc
spec:
  hosts:
  - ext-host.example.com
  gateways:
  - ext-host-gwy
```

## [Service Entry](https://istio.io/latest/docs/concepts/traffic-management/#service-entries)

You use a service entry to add an entry to the service registry that Istio maintains internally. After you add the service entry, the Envoy proxies can send traffic to the service as if it was a service in your mesh.

