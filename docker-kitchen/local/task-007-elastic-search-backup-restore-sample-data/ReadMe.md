
- Docs Referred
    - [elasticsearch-backup-snapshot-and-restore-on-aws-s3](https://medium.com/@federicopanini/elasticsearch-backup-snapshot-and-restore-on-aws-s3-f1fc32fbca7f)
    - [opendistro](https://opendistro.github.io/for-elasticsearch-docs/docs/elasticsearch/snapshot-restore/#amazon-s3)
    - [elasticsearch](https://www.elastic.co/guide/en/kibana/7.7/tutorial-build-dashboard.html#load-dataset)

### Build image and deploy

- Build new image
```bash
docker build  \
--build-arg ENV_VAR_AWS_ACCESS_KEY_ID=<YOUR_ACCESS_KEY_ID> \
--build-arg ENV_VAR_AWS_SECRET_ACCESS_KEY=<YOUR_SECRET_ACCESS_KEY> \
--tag=codeaprendiz/elasticsearch .
```

- Running the image
```bash
docker run -p 9200:9200 -p 9600:9600  codeaprendiz/elasticsearch
```

### Register
- Register your repo at S3

```bash
$ curl -X PUT -H "Content-Type: application/json" -d @register.json "http://localhost:9200/_snapshot/my-s3-repository"
{"acknowledged":true}
```


### Download data
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




- set up mapping logs index1
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

- set up mapping logs index2

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

- set up mapping logs index3

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
```


- shakespeare.json

```bash
$ ls shakespeare.json
shakespeare.json

$ curl -u elastic -H 'Content-Type: application/x-ndjson' -XPOST 'http://localhost:9200/shakespeare/_bulk?pretty' --data-binary @shakespeare.json
Enter host password for user 'elastic': changeit
```



- logs.jsonl

```bash
$ ls logs.jsonl
logs.jsonl

$ curl -u elastic -H 'Content-Type: application/x-ndjson' -XPOST 'http://localhost:9200/_bulk?pretty' --data-binary @logs.jsonl

Enter host password for user 'elastic': changeit
```


- Verify successful loading 

```bash
$ curl -X GET "localhost:9200/_cat/indices?v&pretty"
health status index               uuid                   pri rep docs.count docs.deleted store.size pri.store.size
yellow open   bank                D3IZamRJTSaMiQalyytz9Q   1   1       1000            0    381.8kb        381.8kb
yellow open   shakespeare         eRGAw6pgRnyScN5kIH6ZzQ   1   1          0            0      5.9mb          5.9mb
yellow open   logstash-2015.05.20 qjAB6tF1Q2azhnE6e_NoxQ   1   1          0            0      5.7mb          5.7mb
yellow open   logstash-2015.05.18 sg3cCzaVQyunHmwDpWK7gQ   1   1          0            0      5.5mb          5.5mb
yellow open   logstash-2015.05.19 BOvYmnU6QB-Wp0ITC0wN1g   1   1          0            0      5.6mb          5.6mb

```

- Check after 15 minutes (CHECK THE STATE HERE. LATER WE WILL RESTORE THE DATA FROM S3 and COMPARE ITS STATE)

```bash
$ curl -X GET "localhost:9200/_cat/indices?v&pretty"
health status index               uuid                   pri rep docs.count docs.deleted store.size pri.store.size
yellow open   bank                D3IZamRJTSaMiQalyytz9Q   1   1       1000            0    381.9kb        381.9kb
yellow open   shakespeare         eRGAw6pgRnyScN5kIH6ZzQ   1   1     111396            0     18.2mb         18.2mb
yellow open   logstash-2015.05.20 qjAB6tF1Q2azhnE6e_NoxQ   1   1       4750            0       14mb           14mb
yellow open   logstash-2015.05.18 sg3cCzaVQyunHmwDpWK7gQ   1   1       4631            0     13.7mb         13.7mb
yellow open   logstash-2015.05.19 BOvYmnU6QB-Wp0ITC0wN1g   1   1       4624            0     13.8mb         13.8mb
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

- Taking a snapshot (this may take some time. be patient!)
```bash
curl -X PUT -H "Content-Type: application/json" -d @snapshotsetting.json "http://localhost:9200/_snapshot/my-s3-repository/finalsnap?wait_for_completion=true"
{"snapshot":{"snapshot":"finalsnap","uuid":"rWvtq0cBQIqFoUDc8pYFNA","version_id":7070099,"version":"7.7.0","indices":["logstash-2015.05.20","logstash-2015.05.19","shakespeare","logstash-2015.05.18","bank"],"include_global_state":false,"state":"SUCCESS","start_time":"2020-05-17T20:16:14.563Z","start_time_in_millis":1589746574563,"end_time":"2020-05-17T20:17:38.094Z","end_time_in_millis":1589746658094,"duration_in_millis":83531,"failures":[],"shards":{"total":5,"failed":0,"successful":5}}}
```


- To check the status of snapshot
```bash
$ curl -X GET "http://localhost:9200/_snapshot/_status"
{"snapshots":[{"snapshot":"finalsnap","repository":"my-s3-repository","uuid":"rWvtq0cBQIqFoUDc8pYFNA","state":"STARTED","include_global_state":false,"shards_stats":{"initializing":0,"started":5,"finalizing":0,"done":0,"failed":0,"total":5},"stats":{"incremental":{"file_count":20,"size_in_bytes":63273242},"processed":{"file_count":4,"size_in_bytes":1704},"total":{"file_count":20,"size_in_bytes":63273242},"start_time_in_millis":1589746574563,"time_in_millis":41848},"indices":{"bank":{"shards_stats":{"initializing":0,"started":1,"finalizing":0,"done":0,"failed":0,"total":1},"stats":{"incremental":{"file_count":4,"size_in_bytes":391085},"processed":{"file_count":0,"size_in_bytes":0},"total":{"file_count":4,"size_in_bytes":391085},"start_time_in_millis":1589746576366,"time_in_millis":0},"shards":{"0":{"stage":"STARTED","stats":{"incremental":{"file_count":4,"size_in_bytes":391085},"processed":{"file_count":0,"size_in_bytes":0},"total":{"file_count":4,"size_in_bytes":391085},"start_time_in_millis":1589746576366,"time_in_millis":0},"node":"vp977yjVTHW5915UCPRBYA"}}},"shakespeare":{"shards_stats":{"initializing":0,"started":1,"finalizing":0,"done":0,"failed":0,"total":1},"stats":{"incremental":{"file_count":4,"size_in_bytes":19179417},"processed":{"file_count":1,"size_in_bytes":426},"total":{"file_count":4,"size_in_bytes":19179417},"start_time_in_millis":1589746576366,"time_in_millis":0},"shards":{"0":{"stage":"STARTED","stats":{"incremental":{"file_count":4,"size_in_bytes":19179417},"processed":{"file_count":1,"size_in_bytes":426},"total":{"file_count":4,"size_in_bytes":19179417},"start_time_in_millis":1589746576366,"time_in_millis":0},"node":"vp977yjVTHW5915UCPRBYA"}}},"logstash-2015.05.20":{"shards_stats":{"initializing":0,"started":1,"finalizing":0,"done":0,"failed":0,"total":1},"stats":{"incremental":{"file_count":4,"size_in_bytes":14772605},"processed":{"file_count":1,"size_in_bytes":426},"total":{"file_count":4,"size_in_bytes":14772605},"start_time_in_millis":1589746576366,"time_in_millis":0},"shards":{"0":{"stage":"STARTED","stats":{"incremental":{"file_count":4,"size_in_bytes":14772605},"processed":{"file_count":1,"size_in_bytes":426},"total":{"file_count":4,"size_in_bytes":14772605},"start_time_in_millis":1589746576366,"time_in_millis":0},"node":"vp977yjVTHW5915UCPRBYA"}}},"logstash-2015.05.18":{"shards_stats":{"initializing":0,"started":1,"finalizing":0,"done":0,"failed":0,"total":1},"stats":{"incremental":{"file_count":4,"size_in_bytes":14394696},"processed":{"file_count":1,"size_in_bytes":426},"total":{"file_count":4,"size_in_bytes":14394696},"start_time_in_millis":1589746576366,"time_in_millis":0},"shards":{"0":{"stage":"STARTED","stats":{"incremental":{"file_count":4,"size_in_bytes":14394696},"processed":{"file_count":1,"size_in_bytes":426},"total":{"file_count":4,"size_in_bytes":14394696},"start_time_in_millis":1589746576366,"time_in_millis":0},"node":"vp977yjVTHW5915UCPRBYA"}}},"logstash-2015.05.19":{"shards_stats":{"initializing":0,"started":1,"finalizing":0,"done":0,"failed":0,"total":1},"stats":{"incremental":{"file_count":4,"size_in_bytes":14535439},"processed":{"file_count":1,"size_in_bytes":426},"total":{"file_count":4,"size_in_bytes":14535439},"start_time_in_millis":1589746576366,"time_in_millis":0},"shards":{"0":{"stage":"STARTED","stats":{"incremental":{"file_count":4,"size_in_bytes":14535439},"processed":{"file_count":1,"size_in_bytes":426},"total":{"file_count":4,"size_in_bytes":14535439},"start_time_in_millis":1589746576366,"time_in_millis":0},"node":"vp977yjVTHW5915UCPRBYA"}}}}}]}

$ curl -X GET "http://localhost:9200/_snapshot/_status"
{"snapshots":[]}
```



- Request your snapshot 
```bash
$ curl -X GET  "http://localhost:9200/_snapshot/my-s3-repository/finalsnap"
curl -X GET  "http://localhost:9200/_snapshot/my-s3-repository/finalsnap"
{"snapshots":[{"snapshot":"finalsnap","uuid":"rWvtq0cBQIqFoUDc8pYFNA","version_id":7070099,"version":"7.7.0","indices":["logstash-2015.05.20","logstash-2015.05.19","shakespeare","logstash-2015.05.18","bank"],"include_global_state":false,"state":"SUCCESS","start_time":"2020-05-17T20:16:14.563Z","start_time_in_millis":1589746574563,"end_time":"2020-05-17T20:17:38.094Z","end_time_in_millis":1589746658094,"duration_in_millis":83531,"failures":[],"shards":{"total":5,"failed":0,"successful":5}}]}
```

- To check all the snapshots
```bash
$ curl -X GET "http://localhost:9200/_snapshot/_all"   
{"my-s3-repository":{"type":"s3","settings":{"bucket":"elk-backup-codeaprendiz"}}}                                                                                                                                                                  
```

- To see all the snapshots in a repository
```bash
$ curl -X GET "http://localhost:9200/_snapshot/my-s3-repository/_all"
{"snapshots":[{"snapshot":"firstsnap","uuid":"VpRaTS-eRr6TLqIOi9Zw2w","version_id":7060299,"version":"7.6.2","indices":[],"include_global_state":false,"state":"SUCCESS","start_time":"2020-05-16T14:13:06.219Z","start_time_in_millis":1589638386219,"end_time":"2020-05-16T14:13:06.624Z","end_time_in_millis":1589638386624,"duration_in_millis":405,"failures":[],"shards":{"total":0,"failed":0,"successful":0}},{"snapshot":"finalsnap","uuid":"rWvtq0cBQIqFoUDc8pYFNA","version_id":7070099,"version":"7.7.0","indices":["logstash-2015.05.20","logstash-2015.05.19","shakespeare","logstash-2015.05.18","bank"],"include_global_state":false,"state":"SUCCESS","start_time":"2020-05-17T20:16:14.563Z","start_time_in_millis":1589746574563,"end_time":"2020-05-17T20:17:38.094Z","end_time_in_millis":1589746658094,"duration_in_millis":83531,"failures":[],"shards":{"total":5,"failed":0,"successful":5}}]}
```


### Restore your snapshot after creating a new docker container

- Kill the previous(ctr+D) docker container and start a new container. You will need to register you S3 bucket again. See the command given at the begining.

- After the new container is started and registered. The state before
```bash
$ curl -X GET "localhost:9200/_cat/indices?v&pretty"
health status index uuid pri rep docs.count docs.deleted store.size pri.store.size
```

- To restore a snapshot
```bash
$ curl -X POST -H "Content-Type: application/json" -d @restoresnapshot.json "http://localhost:9200/_snapshot/my-s3-repository/finalsnap/_restore"
{"accepted":true}
```

- Now check the state after (COMPARE WITH PREVIOUS STATE)
```bash
$ curl -X GET "localhost:9200/_cat/indices?v&pretty"
health status index               uuid                   pri rep docs.count docs.deleted store.size pri.store.size
yellow open   bank                smFJpJJ-S9KiGyw8Ysc5Vw   1   1       1000            0    381.9kb        381.9kb
yellow open   shakespeare         cs8TZUIPStyjL5_92lcPqw   1   1     111396            0     18.2mb         18.2mb
yellow open   logstash-2015.05.20 lOdp-I-wRt-DTK3GxDHbuw   1   1       4750            0       14mb           14mb
yellow open   logstash-2015.05.18 i8P-GUM_S_CYMwBh-nO4pQ   1   1       4631            0     13.7mb         13.7mb
yellow open   logstash-2015.05.19 XStCeqfgRSSxbNEo9Gdy9w   1   1       4624            0     13.8mb         13.8mb

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

