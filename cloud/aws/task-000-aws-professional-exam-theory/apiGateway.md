# API Gateway

[CheatSheet - API Gateway](https://tutorialsdojo.com/amazon-api-gateway)
[FAQs - API Gateway](https://aws.amazon.com/api-gateway/faqs)

## Enabling API caching to enhance responsiveness

[Enabling API caching to enhance responsiveness](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-caching.html)

- You can enable API caching in Amazon API Gateway to cache your endpoint's responses. With caching, you can reduce the number of calls made to your endpoint and also improve the latency of requests to your API.
- When you enable caching for a stage, API Gateway caches responses from your endpoint for a specified time-to-live (TTL) period, in seconds. 
- API Gateway then responds to the request by looking up the endpoint response from the cache instead of making a request to your endpoint. 
- The default TTL value for API caching is 300 seconds. The maximum TTL value is 3600 seconds. TTL=0 means caching is disabled.

## Working with WebSocket APIs

[Working with WebSocket APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-websocket-api.html)

- A WebSocket API in API Gateway is a collection of WebSocket routes that are integrated with backend HTTP endpoints, Lambda functions, or other AWS services. 
- API Gateway WebSocket APIs are bidirectional. A client can send messages to a service, and services can independently send messages to clients
- This bidirectional behavior enables richer client/service interactions because services can push data to clients without requiring clients to make an explicit request
- WebSocket APIs are often used in real-time applications such as chat applications, collaboration platforms, multiplayer games, and financial trading platforms.


### Use @connections commands in your backend service

[Use @connections commands in your backend service](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-how-to-call-websocket-api-connections.html)

Your backend service can use the WebSocket connection HTTP requests to send a callback message to a connected client, get connection information, or disconnect the client


## Tutorials

### Tutorial: Create a REST API as an Amazon Kinesis proxy in API Gateway

[Tutorial: Create a REST API as an Amazon Kinesis proxy in API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/integrating-api-with-aws-services-kinesis.html)

