
- Docs Referred
    - [elasticsearch-backup-snapshot-and-restore-on-aws-s3](https://medium.com/@federicopanini/elasticsearch-backup-snapshot-and-restore-on-aws-s3-f1fc32fbca7f)
    - [opendistro](https://opendistro.github.io/for-elasticsearch-docs/docs/elasticsearch/snapshot-restore/#amazon-s3)


### Build image and deploy


- Build new image
```bash
docker build  \
--build-arg ENV_VAR_AWS_ACCESS_KEY_ID=<YOUR_ACCESS_KEY_ID> \
--build-arg ENV_VAR_AWS_SECRET_ACCESS_KEY=<YOUR_SECRET_ACCESS_KEY> \
--tag=codeaprendiz/elasticsearch .
```

- Check the images present
```bash
$ docker images | grep "codeaprendiz/elasticsearch"
codeaprendiz/elasticsearch                      latest              f06a06d5fd8a        36 seconds ago      796MB
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


### Taking Snapshots

- Taking a snapshot
```bash
$ curl -X PUT -H "Content-Type: application/json" -d @snapshotsetting.json "http://localhost:9200/_snapshot/my-s3-repository/firstsnap?wait_for_completion=true"
{"snapshot":{"snapshot":"firstsnap","uuid":"VpRaTS-eRr6TLqIOi9Zw2w","version_id":7060299,"version":"7.6.2","indices":[],"include_global_state":false,"state":"SUCCESS","start_time":"2020-05-16T14:13:06.219Z","start_time_in_millis":1589638386219,"end_time":"2020-05-16T14:13:06.624Z","end_time_in_millis":1589638386624,"duration_in_millis":405,"failures":[],"shards":{"total":0,"failed":0,"successful":0}}}
```

- Corresponding docker logs

```bash
$ docker logs -f friendly_fermi
{"type": "server", "timestamp": "2020-05-16T14:13:06,646Z", "level": "INFO", "component": "o.e.s.SnapshotsService", "cluster.name": "docker-cluster", "node.name": "676c35dac6af", "message": "snapshot [my-s3-repository:firstsnap/VpRaTS-eRr6TLqIOi9Zw2w] started", "cluster.uuid": "Crq-wvoIQmuzm920sZr8MA", "node.id": "Q_xnc6qyRxy-BbvRLQNwlg"  }
{"type": "server", "timestamp": "2020-05-16T14:13:08,852Z", "level": "INFO", "component": "o.e.s.SnapshotsService", "cluster.name": "docker-cluster", "node.name": "676c35dac6af", "message": "snapshot [my-s3-repository:firstsnap/VpRaTS-eRr6TLqIOi9Zw2w] completed with state [SUCCESS]", "cluster.uuid": "Crq-wvoIQmuzm920sZr8MA", "node.id": "Q_xnc6qyRxy-BbvRLQNwlg"  }
```


- Request your snapshot 
```bash
$ curl -X GET  "http://localhost:9200/_snapshot/my-s3-repository/firstsnap"
{"snapshots":[{"snapshot":"firstsnap","uuid":"VpRaTS-eRr6TLqIOi9Zw2w","version_id":7060299,"version":"7.6.2","indices":[],"include_global_state":false,"state":"SUCCESS","start_time":"2020-05-16T14:13:06.219Z","start_time_in_millis":1589638386219,"end_time":"2020-05-16T14:13:06.624Z","end_time_in_millis":1589638386624,"duration_in_millis":405,"failures":[],"shards":{"total":0,"failed":0,"successful":0}}]}
```


- To check the status of snapshot
```bash
$ curl -X GET "http://localhost:9200/_snapshot/_status"                
{"snapshots":[]}
```

- To check all the snapshots
```bash
$ curl -X GET "http://localhost:9200/_snapshot/_all"
{"my-s3-repository":{"type":"s3","settings":{"bucket":"elk-backup-codeaprendiz"}}}
```

- To see all the snapshots in a repository
```bash
$ curl -X GET "http://localhost:9200/_snapshot/my-s3-repository/_all"
{"snapshots":[{"snapshot":"firstsnap","uuid":"VwFvTv3nSKOD5K8J3EBE2A","version_id":7060299,"version":"7.6.2","indices":[],"include_global_state":false,"state":"SUCCESS","start_time":"2020-05-14T14:45:46.358Z","start_time_in_millis":1589467546358,"end_time":"2020-05-14T14:45:46.561Z","end_time_in_millis":1589467546561,"duration_in_millis":203,"failures":[],"shards":{"total":0,"failed":0,"successful":0}}]}
```


### Restore your snapshot

- To restore a snapshot
```bash
$ curl -X POST -H "Content-Type: application/json" -d @restoresnapshot.json "http://localhost:9200/_snapshot/my-s3-repository/firstsnap/_restore"
{"snapshot":{"snapshot":"firstsnap","indices":[],"shards":{"total":0,"failed":0,"successful":0}}}
```
