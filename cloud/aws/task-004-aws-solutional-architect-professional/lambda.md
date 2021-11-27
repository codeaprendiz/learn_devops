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