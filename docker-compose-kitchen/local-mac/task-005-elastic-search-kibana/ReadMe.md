## To start elastic-search and kibana using one docker-compose

- docker-compose.yaml

```yaml
version: '3.7'
services:
  elasticsearch_service:
    image: docker.elastic.co/elasticsearch/elasticsearch:7.8.0
    container_name: es01
    environment:
      node.name: 'es01'
      discovery.type: 'single-node'
      bootstrap.memory_lock: 'true'
      ES_JAVA_OPTS: '-Xms512m -Xmx512m'
    ulimits:
      memlock:
        soft: -1
        hard: -1
    volumes:
      - ./.data:/usr/share/elasticsearch/data
    ports:
      - 9200:9200
    networks:
      - host

  kibana:
    image: docker.elastic.co/kibana/kibana:7.8.0
    container_name: kibana-sandbox
    links:
      - elasticsearch_service
    environment:
      SERVER_NAME: elasticsearch_service
      ELASTICSEARCH_HOSTS: http://elasticsearch_service:9200
    ports:
      - 5601:5601
    networks:
      - host

volumes:
  data:
    driver: local

networks:
  host:
```


```bash
$ docker-compose up

```

- Visit [http://0.0.0.0:5601/app/kibana](http://0.0.0.0:5601/app/kibana)