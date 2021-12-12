# API Gateway

[CheatSheet - API Gateway](https://tutorialsdojo.com/amazon-api-gateway)
[FAQs - API Gateway](https://aws.amazon.com/api-gateway/faqs)

## Enabling API caching to enhance responsiveness

[Enabling API caching to enhance responsiveness](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-caching.html)

- enable API caching to cache your endpoint's responses. 
- therefor reduce the number of calls made to your endpoint 
- and also improve the latency of requests to your API.
- it responses from your endpoint for a specified time-to-live (TTL) period, in seconds. 
- The default TTL value for API caching is 300 seconds. 
- The maximum TTL value is 3600 seconds. TTL=0 means caching is disabled.

## Working with WebSocket APIs

[Working with WebSocket APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-websocket-api.html)

- A WebSocket API in API Gateway is a collection of WebSocket routes.
- These that are integrated with backend HTTP endpoints, Lambda functions, or other AWS services. 
- API Gateway WebSocket APIs are bidirectional. A client can send messages to a service, and services can independently send messages to clients
- This bidirectional behavior enables richer client/service interactions because services can push data to clients without requiring clients to make an explicit request
- WebSocket APIs are often used in real-time applications such as chat applications, collaboration platforms, multiplayer games, and financial trading platforms.


### Use @connections commands in your backend service

[Use @connections commands in your backend service](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-how-to-call-websocket-api-connections.html)

Your backend service can use the following WebSocket connection HTTP requests to send a callback message to a connected client, get connection information, or disconnect the client

```bash
POST https://{api-id}.execute-api.us-east-1.amazonaws.com/{stage}/@connections/{connection_id}
```

### Lambda Integration

#### Understand API Gateway Lambda proxy integration

[Understand API Gateway Lambda proxy integration](https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html)

- mechanism to build an API with a setup of a single API method. 
- The Lambda proxy integration allows the client to call a single Lambda function in the backend. 
- The function accesses many resources or features of other AWS services, including calling other Lambda functions.


## Tutorials

### Tutorial: Create a REST API as an Amazon Kinesis proxy in API Gateway

[Tutorial: Create a REST API as an Amazon Kinesis proxy in API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/integrating-api-with-aws-services-kinesis.html)

