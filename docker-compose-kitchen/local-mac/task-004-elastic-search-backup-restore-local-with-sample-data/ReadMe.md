## Objective
- To be able to backup elastic search indexes on locally mounted folder.

### Docs Referred

- [ELK docs](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-register-repository.html)
    - Check out the next pages as well
- [Load Data](https://www.elastic.co/guide/en/kibana/7.7/tutorial-build-dashboard.html#load-dataset)


### Dir structure

```bash
$ tree local-mac/task-004-elastic-search-backup-restore-local-with-sample-data 
local-mac/task-004-elastic-search-backup-restore-local-with-sample-data
├── ReadMe.md
├── docker-compose.yml
├── elasticsearch.yml
├── restoresnapshot.json
└── snapshotsetting.json
```

- docker-compose.yaml

```yaml
version: "3.7"
services:
  elasticsearch_service:
    restart: unless-stopped
    image: docker.elastic.co/elasticsearch/elasticsearch:7.7.0
    container_name: elasticsearch_local
    environment:
      xpack.security.enabled: 'false'
      xpack.monitoring.enabled: 'false'
      xpack.graph.enabled: 'false'
      xpack.watcher.enabled: 'false'
      discovery.type: 'single-node'
      bootstrap.memory_lock: 'true'
      indices.memory.index_buffer_size: '30%'
    volumes:
      - ./elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml
      - ./data:/usr/share/elasticsearch/data
      - ./elasticsearch-backup:/var/elasticsearch-backup
    ports:
      - 9200:9200
      - 9300:9300
#    network_mode: host
```

- elasticsearch.yaml

```yaml
cluster.name: "docker-cluster"
network.host: 0.0.0.0
path.repo: ["/var/elasticsearch-backup"]
```

- restoresnapshot.json

```json
{
  "indices": "bank*,shakespeare*,logstash*",
  "ignore_unavailable": true,
  "include_global_state": false,
  "include_aliases": false,
  "partial": false,
  "rename_pattern": "kibana(.+)",
  "rename_replacement": "restored-kibana$1",
  "index_settings": {
    "index.blocks.read_only": false
  },
  "ignore_index_settings": [
    "index.refresh_interval"
  ]
}
```

- snapshotsetting.json

```json
{
  "indices": "bank*,shakespeare*,logstash*",
  "ignore_unavailable": true,
  "include_global_state": false,
  "partial": false
}
```

### Thought Process

- Create `data` and `elasticsearch-backup` dirs. 
- Start ELK docker-container
- Load sample data to ELK container and index that data
- Take a snapshot of ELK. Check if the snapshot is present in locally mounted `elasticsearch-backup` dir
- Stop the container. Remove the contents of `data` dir.
- Start the container again
- Restore the data from the snapshot on locally available `elasticsearch-backup`
- Check the consistency of this data restored.

### Directory creation 

- Empty the data and elasticsearch-backup dirs. Create if not present

```bash
$ rm -rf data/*
$ rm -rf elasticsearch-backup/*
$ mkdir data
$ mkdir elasticsearch-backup
```


### Start the Elastic Search

- start elastic search container

```bash
$ docker-compose up -d
```

### Register 

- Register your repository

```bash
$ curl -X PUT "http://localhost:9200/_snapshot/my_backup?pretty" -H 'Content-Type: application/json' -d'
{
  "type": "fs",
  "settings": {
    "location": "/var/elasticsearch-backup",
    "compress": true
  }
}'

```

### Get Info

- Get info about indices

```bash
$ curl -X GET "localhost:9200/_cat/indices?v&pretty"
```

- Get info about repo

```bash
$ curl -X GET "http://localhost:9200/_snapshot/my_backup"
{"my_backup":{"type":"fs","settings":{"location":"/var/elasticsearch-backup"}}}
```


### Download data and unzip accordingly

```bash
curl -O https://download.elastic.co/demos/kibana/gettingstarted/8.x/shakespeare.json
curl -O https://download.elastic.co/demos/kibana/gettingstarted/8.x/accounts.zip
curl -O https://download.elastic.co/demos/kibana/gettingstarted/8.x/logs.jsonl.gz
```


### Set Up Mapping


- Set up mapping shakespeare

```bash
curl -X PUT "localhost:9200/shakespeare?pretty" -H 'Content-Type: application/json' -d'
{
  "mappings": {
    "properties": {
    "speaker": {"type": "keyword"},
    "play_name": {"type": "keyword"},
    "line_id": {"type": "integer"},
    "speech_number": {"type": "integer"}
    }
  }
}
'

```




- set up mapping logs

```
curl -X PUT "localhost:9200/logstash-2015.05.18?pretty" -H 'Content-Type: application/json' -d'
{
  "mappings": {
    "properties": {
      "geo": {
        "properties": {
          "coordinates": {
            "type": "geo_point"
          }
        }
      }
    }
  }
}
'

```

```bash
curl -X PUT "localhost:9200/logstash-2015.05.19?pretty" -H 'Content-Type: application/json' -d'
{
  "mappings": {
    "properties": {
      "geo": {
        "properties": {
          "coordinates": {
            "type": "geo_point"
          }
        }
      }
    }
  }
}
'

```

```bash
curl -X PUT "localhost:9200/logstash-2015.05.20?pretty" -H 'Content-Type: application/json' -d'
{
  "mappings": {
    "properties": {
      "geo": {
        "properties": {
          "coordinates": {
            "type": "geo_point"
          }
        }
      }
    }
  }
}
'

```


### Load the dataset

- accounts.json

```bash
$ ls accounts.json
accounts.json

curl -u elastic -H 'Content-Type: application/x-ndjson' -XPOST 'http://localhost:9200/bank/_bulk?pretty' --data-binary @accounts.json
Enter host password for user 'elastic': changeit

rm -rf accounts.json
```


- shakespeare.json

```bash
$ ls shakespeare.json
shakespeare.json

$ curl -u elastic -H 'Content-Type: application/x-ndjson' -XPOST 'http://localhost:9200/shakespeare/_bulk?pretty' --data-binary @shakespeare.json


rm -rf shakespeare.json
```



- logs.jsonl

```bash
$ ls logs.jsonl
logs.jsonl

$ curl -u elastic -H 'Content-Type: application/x-ndjson' -XPOST 'http://localhost:9200/_bulk?pretty' --data-binary @logs.jsonl


```


- Verify successful loading (wait for 15 mins)

```bash
$ curl -X GET "localhost:9200/_cat/indices?v&pretty"
health status index               uuid                   pri rep docs.count docs.deleted store.size pri.store.size
yellow open   bank                GXb5t_unTCe3Y2SQAO2IPw   1   1       1000            0    381.9kb        381.9kb
yellow open   shakespeare         fb-gykVjT6uqmvHTKTVglQ   1   1     111396            0     18.2mb         18.2mb
yellow open   logstash-2015.05.20 -ajsxxrYT5KGOak5edt6OQ   1   1       4750            0       14mb           14mb
yellow open   logstash-2015.05.18 nBTkQ8EZShigl41aaHTyGA   1   1       4631            0     13.7mb         13.7mb
yellow open   logstash-2015.05.19 JvLJJPm0R0GKbwkKeiLxPw   1   1       4624            0     13.8mb         13.8mb

```

### Index Mapping before restore

```bash
$ curl -X GET "http://localhost:9200/bank/_mapping"
{"bank":{"mappings":{"properties":{"account_number":{"type":"long"},"address":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}},"age":{"type":"long"},"balance":{"type":"long"},"city":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}},"email":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}},"employer":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}},"firstname":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}},"gender":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}},"lastname":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}},"state":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}}}}}}
```

```bash
$ curl -X GET "http://localhost:9200/shakespeare/_mapping"
{"shakespeare":{"mappings":{"properties":{"line_id":{"type":"integer"},"line_number":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}},"play_name":{"type":"keyword"},"speaker":{"type":"keyword"},"speech_number":{"type":"integer"},"text_entry":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}},"type":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}}}}}}
```


### Taking Snapshots

- Taking a snapshot

```bash
curl -X PUT -H "Content-Type: application/json" -d @snapshotsetting.json "http://localhost:9200/_snapshot/my_backup/finalsnap?wait_for_completion=true"
{"snapshot":{"snapshot":"finalsnap","uuid":"2xntfpUJSACZDZlf2zmgFg","version_id":7070099,"version":"7.7.0","indices":["logstash-2015.05.20","logstash-2015.05.19","logstash-2015.05.18","bank","shakespeare"],"include_global_state":false,"state":"SUCCESS","start_time":"2020-05-18T13:38:01.870Z","start_time_in_millis":1589809081870,"end_time":"2020-05-18T13:38:03.875Z","end_time_in_millis":1589809083875,"duration_in_millis":2005,"failures":[],"shards":{"total":5,"failed":0,"successful":5}}}
```



- Request your snapshot 

```bash
$ curl -X GET  "http://localhost:9200/_snapshot/my_backup/finalsnap"
{"snapshots":[{"snapshot":"finalsnap","uuid":"2xntfpUJSACZDZlf2zmgFg","version_id":7070099,"version":"7.7.0","indices":["logstash-2015.05.20","logstash-2015.05.19","logstash-2015.05.18","bank","shakespeare"],"include_global_state":false,"state":"SUCCESS","start_time":"2020-05-18T13:38:01.870Z","start_time_in_millis":1589809081870,"end_time":"2020-05-18T13:38:03.875Z","end_time_in_millis":1589809083875,"duration_in_millis":2005,"failures":[],"shards":{"total":5,"failed":0,"successful":5}}]}
```


- To check the status of snapshot

```bash
$ curl -X GET "http://localhost:9200/_snapshot/_status"                
{"snapshots":[]}
```

- To check all the snapshots

```bash
$ curl -X GET "http://localhost:9200/_snapshot/_all"   
{"my_backup":{"type":"fs","settings":{"compress":"true","location":"/var/elasticsearch-backup"}}}
```

- To see all the snapshots in a repository
```bash
$ curl -X GET "http://localhost:9200/_snapshot/my_backup/_all"
{"snapshots":[{"snapshot":"finalsnap","uuid":"2xntfpUJSACZDZlf2zmgFg","version_id":7070099,"version":"7.7.0","indices":["logstash-2015.05.20","logstash-2015.05.19","logstash-2015.05.18","bank","shakespeare"],"include_global_state":false,"state":"SUCCESS","start_time":"2020-05-18T13:38:01.870Z","start_time_in_millis":1589809081870,"end_time":"2020-05-18T13:38:03.875Z","end_time_in_millis":1589809083875,"duration_in_millis":2005,"failures":[],"shards":{"total":5,"failed":0,"successful":5}}]}
```




### Restore your snapshot after creating a new docker container

- Stop the previous container using `docker-compose down`

- Remove the contents of only data dir `rm -rf data/*`

- Start the container again

- state before

```bash
$ curl -X GET "localhost:9200/_cat/indices?v&pretty"
health status index uuid pri rep docs.count docs.deleted store.size pri.store.size
```

- register the repo again

- To restore a snapshot

```bash
$ curl -X POST -H "Content-Type: application/json" -d @restoresnapshot.json "http://localhost:9200/_snapshot/my_backup/finalsnap/_restore"
{"accepted":true}
```

```bash
$ curl -X GET "localhost:9200/_cat/indices?v&pretty"
health status index               uuid                   pri rep docs.count docs.deleted store.size pri.store.size
yellow open   bank                np5lUCosR9K8GQIYRWFbxw   1   1       1000            0    381.9kb        381.9kb
yellow open   shakespeare         IsCQevQMTVuDj4LPhCZBhg   1   1     111396            0     18.2mb         18.2mb
yellow open   logstash-2015.05.20 _5mcgCNbQ0mpx1YwSBOlgA   1   1       4750            0       14mb           14mb
yellow open   logstash-2015.05.18 UENDZ4XYRXGK9uOA9jQkdg   1   1       4631            0     13.7mb         13.7mb
yellow open   logstash-2015.05.19 ytH8HF_GRnuu6vV3B4apnw   1   1       4624            0     13.8mb         13.8mb

```

### Index Mapping after restore

```bash
$ curl -X GET "http://localhost:9200/bank/_mapping"
{"bank":{"mappings":{"properties":{"account_number":{"type":"long"},"address":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}},"age":{"type":"long"},"balance":{"type":"long"},"city":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}},"email":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}},"employer":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}},"firstname":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}},"gender":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}},"lastname":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}},"state":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}}}}}}
```

```bash
$ curl -X GET "http://localhost:9200/shakespeare/_mapping"
{"shakespeare":{"mappings":{"properties":{"line_id":{"type":"integer"},"line_number":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}},"play_name":{"type":"keyword"},"speaker":{"type":"keyword"},"speech_number":{"type":"integer"},"text_entry":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}},"type":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}}}}}}
```
