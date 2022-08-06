## Datadog Log Collection from docker-container using docker-compose

[docker-log-collection](https://docs.datadoghq.com/agent/docker/log/?tab=dockerfile)


- The following is the `docker-compose`file
```yaml
version: '3'
services:
  redis:
    image: redis
  datadog:
    links:
      - redis # Connect the Datadog Agent container to the Redis container
    image: datadog/agent:latest
    environment:
      - DD_API_KEY=${ENV_VAR_DD_API_KEY}
      - DD_SITE=datadoghq.eu
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - /proc/:/host/proc/:ro
      - /sys/fs/cgroup:/host/sys/fs/cgroup:ro
```


- Run the following command

```bash
ENV_VAR_DD_API_KEY=2dd894f5*********73474d48f docker-compose up -d
```

