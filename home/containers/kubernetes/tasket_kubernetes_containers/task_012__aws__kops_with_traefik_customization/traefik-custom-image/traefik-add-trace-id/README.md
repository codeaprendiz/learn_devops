# About

This plugin will append a custom header for tracing with a random value if one is not found already in the incoming request.

You can optionally customise this by specifying a custom header name that the plugin will look for in the incoming request (defaults to `X-Trace-Id`) and you can also specify a custom prefix to be added to that header (defaults to `""`).

# Configuration
Enable the plugin in your Traefik configuration:
```
[experimental.plugins.traceid]
  modulename = "github.com/trinnylondon/traefik-add-trace-id"
  version = "v0.1.3"
```

Create a Middleware. Note that this plugin does not need any configuration, however, values must be passed in for it to be accepted within Traefik.

```
---
apiVersion: traefik.containo.us/v1alpha1
kind: Middleware
metadata:
  name: traceid
spec:
  plugin:
    traceid:
      headerPrefix: ''
      headerName: 'X-Trace-Id'
```
