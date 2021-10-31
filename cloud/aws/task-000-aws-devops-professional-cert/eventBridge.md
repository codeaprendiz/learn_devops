
### What is event bridge
[What Is Amazon EventBridge?](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-what-is.html)
[Video - Intro to Event Bridge](https://youtu.be/TXh5oU_yo9M)

Amazon EventBridge is a serverless event bus service that you can use to connect your applications with data from a variety of sources. EventBridge delivers a stream of real-time data from your applications, software as a service (SaaS) applications, and AWS services to targets such as AWS Lambda functions, HTTP invocation endpoints using API destinations, or event buses in other AWS accounts.

#### Getting started with Amazon EventBridge

[Getting started with Amazon EventBridge](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-get-started.html)

To create a rule for events, you specify an action to take when EventBridge receives an event that matches the event pattern in the rule. When an event matches, EventBridge sends the event to the specified target and triggers the action defined in the rule.

#### Event buses
[Amazon EventBridge event buses](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-event-bus.html)

An event bus is a pipeline that receives events. Rules associated with the event bus evaluate events as they arrive. Each rule checks whether an event matches the rule's criteria. You associate a rule with a specific event bus, so the rule only applies to events received by that event bus.

[Video - The following video describes what event buses are and explains some of the basics of them](https://youtu.be/LkEBBgWRKkI)

[The following video covers the different event buses and when to use them](https://youtu.be/cB5-GTSJNqc)

#### Receiving events from a SaaS partner
[Receiving events from a SaaS partner with Amazon EventBridge](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-saas.html)

[Video - The following video covers SaaS integrations with EventBridge](https://youtu.be/zxFrM6z8Wdg)

#### Targets

[Sending and receiving Amazon EventBridge events between AWS accounts](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-cross-account.html)

You can configure EventBridge to send and receive events between AWS accounts. When you configure EventBridge to send or receive events between accounts, you can specify which AWS accounts can send events to or receive events from the event bus in your account. 

[Video - The following video covers routing events between accounts](https://youtu.be/pX_xIW_EuCE)


#### Decoupling larger applications with Amazon EventBridge
[Decoupling larger applications with Amazon EventBridge](https://aws.amazon.com/blogs/compute/decoupling-larger-applications-with-amazon-eventbridge/)

- you can use an event-based architecture to decouple services and functional areas of applications.
