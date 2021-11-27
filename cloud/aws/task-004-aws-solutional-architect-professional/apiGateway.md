# API Gateway

[CheatSheet - API Gateway](https://tutorialsdojo.com/amazon-api-gateway)
[FAQs - API Gateway](https://aws.amazon.com/api-gateway/faqs)

## Enabling API caching to enhance responsiveness

[Enabling API caching to enhance responsiveness](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-caching.html)

- You can enable API caching in Amazon API Gateway to cache your endpoint's responses. With caching, you can reduce the number of calls made to your endpoint and also improve the latency of requests to your API.
- When you enable caching for a stage, API Gateway caches responses from your endpoint for a specified time-to-live (TTL) period, in seconds. 
- API Gateway then responds to the request by looking up the endpoint response from the cache instead of making a request to your endpoint. 
- The default TTL value for API caching is 300 seconds. The maximum TTL value is 3600 seconds. TTL=0 means caching is disabled.