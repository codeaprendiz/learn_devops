To start docker-elastic-search on single node

[Docs](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html)

- Start docker-elastic-search

```bash
$ $ docker run -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:7.8.1

```

- Check the health

```bash
$ curl -X GET "localhost:9200/_cat/nodes?v&pretty"
ip         heap.percent ram.percent cpu load_1m load_5m load_15m node.role master name
172.17.0.3           49          96   6    0.56    0.38     0.40 dilmrt    *      7fc9a4e5361c
```


