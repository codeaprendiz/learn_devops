# Simple Notification Service

## What is Amazon SNS?

[What is Amazon SNS?](https://docs.aws.amazon.com/sns/latest/dg/welcome.html)

- Amazon Simple Notification Service (Amazon SNS) is a managed service that provides message delivery from publishers to subscribers (also known as producers and consumers). Publishers communicate asynchronously with subscribers by sending messages to a topic, which is a logical access point and communication channel. Clients can subscribe to the SNS topic and receive published messages using a supported endpoint type, such as Amazon Kinesis Data Firehose, Amazon SQS, AWS Lambda, HTTP, email, mobile push notifications, and mobile text messages (SMS).

## Message Filtering

[SNS message filtering](https://docs.aws.amazon.com/sns/latest/dg/sns-message-filtering.html)

- By default, an Amazon SNS topic subscriber receives every message published to the topic. To receive a subset of the messages, a subscriber must assign a filter policy to the topic subscription.
- A filter policy is a simple JSON object containing attributes that define which messages the subscriber receives. When you publish a message to a topic, Amazon SNS compares the message attributes to the attributes in the filter policy for each of the topic's subscriptions. If any of the attributes match, Amazon SNS sends the message to the subscriber

### Subscription Filter Policies

[Amazon SNS subscription filter policies](https://docs.aws.amazon.com/sns/latest/dg/sns-subscription-filter-policies.html)

[Enriching Event-Driven Architectures with AWS Event Fork Pipelines](https://aws.amazon.com/blogs/compute/enriching-event-driven-architectures-with-aws-event-fork-pipelines/)

- A subscription filter policy allows you to specify attribute names and assign a list of values to each attribute name. For more information, see Amazon SNS message filtering.

