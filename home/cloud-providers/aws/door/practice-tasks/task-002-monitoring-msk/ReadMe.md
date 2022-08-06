### Monitoring AWS MSK
You cannot know what you cannot see.

You can enable monitoring while setting up MSK. Check out their official documentation 
which is more than enough

[AWS Docs](https://docs.aws.amazon.com/msk/latest/developerguide/monitoring.html)

[Official Docs](https://kafka.apache.org/documentation/#monitoring)

[Confluent Docs](https://docs.confluent.io/platform/current/kafka/monitoring.html)

[kafka-lag-monitoring-and-metrics-at-appsflyer](https://www.confluent.io/blog/kafka-lag-monitoring-and-metrics-at-appsflyer/)

#### What metrics we need to monitor

[metrics-details.html#default-metric](https://docs.aws.amazon.com/msk/latest/developerguide/metrics-details.html#default-metrics)

- Number of active controllers : Should always be one

- Number of UnderReplicatedPartions : Should always be zero

- Number of Offline Partitions : Should always be zero



#### Why does lag matter?
Why does lag matter and why does it need to be treated differently than other metrics in the system?
Lag is a key performance indicator (KPI) for Kafka. When building an event streaming platform, the consumer group lag is one of the crucial metrics to monitor.
As mentioned earlier, when an application consumes messages from Kafka, it commits its offset in order to keep its position in the partition. When a consumer gets stuck for any reason—for example, an error, rebalance, or even a complete stop—it can resume from the last committed offset and continue from the same point in time.
Therefore, lag is the delta between the last committed message to the last produced message. In other words, lag indicates how far behind your application is in processing up-to-date information.
To make matters worse, remember that Kafka persistence is based on retention, meaning that if your lag persists, you will lose data at some point in time. The goal is to keep lag to a minimum.

