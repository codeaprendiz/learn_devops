[bitnami.com/stack/kafka/helm](https://bitnami.com/stack/kafka/helm)

- Add repo

```bash
$ helm repo add bitnami https://charts.bitnami.com/bitnami
"bitnami" already exists with the same configuration, skipping
```

- Pull to local

```bash
$ helm pull bitnami/kafka
$ helm template kafka-template ./kafka/ -f kafka/values.yaml > kafka-manifests.yaml
```

- Start 

```bash
$ helm upgrade --install -f values.yaml kafka-release .
Release "kafka-release" does not exist. Installing it now.
NAME: kafka-release
LAST DEPLOYED: Wed Sep 15 22:33:52 2021
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
** Please be patient while the chart is being deployed **

Kafka can be accessed by consumers via port 9092 on the following DNS name from within your cluster:

    kafka-release.default.svc.cluster.local

Each Kafka broker can be accessed by producers via port 9092 on the following DNS name(s) from within your cluster:

    kafka-release-0.kafka-release-headless.default.svc.cluster.local:9092

To create a pod that you can use as a Kafka client run the following commands:

    kubectl run kafka-release-client --restart='Never' --image docker.io/bitnami/kafka:2.8.0-debian-10-r84 --namespace default --command -- sleep infinity
    kubectl exec --tty -i kafka-release-client --namespace default -- bash

    PRODUCER:
        kafka-console-producer.sh \
            
            --broker-list kafka-release-0.kafka-release-headless.default.svc.cluster.local:9092 \
            --topic test

    CONSUMER:
        kafka-console-consumer.sh \
            
            --bootstrap-server kafka-release.default.svc.cluster.local:9092 \
            --topic test \
            --from-beginning
```

- Check the pods

```bash
$ kubectl get pods
NAME                        READY   STATUS    RESTARTS   AGE
kafka-release-0             1/1     Running   5          11m
kafka-release-zookeeper-0   1/1     Running   0          11m
```
