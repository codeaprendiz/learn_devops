# Lambda

[Cheat Sheet - AWS Lambda](https://tutorialsdojo.com/aws-lambda)

[What is AWS Lambda?](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html)

- Lambda is a compute service that lets you run code without provisioning or managing servers. 
- Lambda runs your code on a high-availability compute infrastructure and performs all of the administration of the compute resources, including server and operating system maintenance, capacity provisioning and automatic scaling, code monitoring and logging. 
- With Lambda, you can run code for virtually any type of application or backend service. 
- All you need to do is supply your code in one of the languages that Lambda supports.


## Using AWS Lambda with CloudFront Lambda@Edge

[Using AWS Lambda with CloudFront Lambda@Edge](https://docs.aws.amazon.com/lambda/latest/dg/lambda-edge.html)

- Lambda@Edge lets you run Node.js and Python Lambda functions to customize content that CloudFront delivers, executing the functions in AWS locations closer to the viewer. 
- The functions run in response to CloudFront events, without provisioning or managing servers. You can use Lambda functions to change CloudFront requests and responses at the following points:
  - After CloudFront receives a request from a viewer (viewer request)
  - Before CloudFront forwards the request to the origin (origin request)
  - After CloudFront receives the response from the origin (origin response)
  - Before CloudFront forwards the response to the viewer (viewer respo


## AWS Lambda Pricing

[AWS Lambda Pricing](https://aws.amazon.com/lambda/pricing)

- Lambda counts a request each time it starts executing in response to an event notification trigger, such as from Amazon Simple Notification Service (SNS) or Amazon EventBridge, or an invoke call, such as from Amazon API Gateway, or via the AWS SDK, including test invokes from the AWS Console.
- Duration is calculated from the time your code begins executing until it returns or otherwise terminates, rounded up to the nearest 1 ms*. The price depends on the amount of memory you allocate to your function.

## Lambda function scaling

[Lambda function scaling](https://docs.aws.amazon.com/lambda/latest/dg/invocation-scaling.html#concurrent-execution-safety-limit)

- The first time you invoke your function, AWS Lambda creates an instance of the function and runs its handler method to process the event.
- When the function returns a response, it stays active and waits to process additional events.
- If you invoke the function again while the first event is being processed, Lambda initializes another instance, and the function processes the two events concurrently
- As more events come in, Lambda routes them to available instances and creates new instances as needed. 
- When the number of requests decreases, Lambda stops unused instances to free up scaling capacity for other functions.
- The default regional concurrency limit starts at 1,000

## Managing function

### Managing Lambda reserved concurrency

[Managing Lambda reserved concurrency](https://docs.aws.amazon.com/lambda/latest/dg/configuration-concurrency.html)

- Concurrency is the number of requests that your function is serving at any given time. 
- When your function is invoked, Lambda allocates an instance of it to process the event. 
- When the function code finishes running, it can handle another request. 
- If the function is invoked again while a request is still being processed, another instance is allocated, which increases the function's concurrency. 
- The total concurrency for all of the functions in your account is subject to a per-region quota.

There are two types of concurrency controls available:
- Reserved concurrency – Reserved concurrency guarantees the maximum number of concurrent instances for the function. When a function has reserved concurrency, no other function can use that concurrency. No charge for this
- Provisioned concurrency – Provisioned concurrency initializes a requested number of execution environments so that they are prepared to respond immediately to your function's invocations. Note that configuring provisioned concurrency incurs charges to your AWS account.

## Blogs

[How do I troubleshoot Lambda function throttling with "Rate exceeded" and 429 "TooManyRequestsException" errors?](https://aws.amazon.com/premiumsupport/knowledge-center/lambda-troubleshoot-throttling)

- Lambda functions are sometimes throttled to protect your resources and downstream applications. Even though Lambda automatically scales to accommodate incoming traffic, your function can still be throttled for various reasons


[Understanding and Managing AWS Lambda Function Concurrency](https://aws.amazon.com/blogs/compute/managing-aws-lambda-function-concurrency)
