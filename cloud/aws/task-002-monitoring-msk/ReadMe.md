### Monitoring AWS MSK

You can enable monitoring while setting up MSK. Check out their official documentation 
which is more than enough

[AWS Docs](https://docs.aws.amazon.com/msk/latest/developerguide/monitoring.html)

[Official Docs](https://kafka.apache.org/documentation/#monitoring)

[Confluent Docs](https://docs.confluent.io/platform/current/kafka/monitoring.html)

#### What metrics we need to monitor

[](https://docs.aws.amazon.com/msk/latest/developerguide/metrics-details.html#default-metrics)

- Number of active controllers : Should always be one

- Number of UnderReplicatedPartions : Should always be zero

- Number of Offline Partitions : Should always be zero
