## To deploy journalbeat on k8s to ship logs to elastic-search

#### Pre-requisites

- elastic-search-docker: 
    - You can install elastic-search docker by visiting [elastic-search-docker](https://github.com/codeaprendiz/ansible-kitchen/tree/master/playbooks/roles/elastic-search-cluster-docker) and 
- kibana-docker: 
    - You can install kibana docker by using this link [kibana-docker](https://github.com/codeaprendiz/ansible-kitchen/tree/master/playbooks/roles/kibana-docker)

- Docs referred

    - [journalbeat-reference.yaml](https://www.elastic.co/guide/en/beats/journalbeat/master/journalbeat-reference-yml.html)

    - [gits](https://gist.github.com/kvaps/b08c77f297c5cab21c237fd821310653)
    
    - [journalbeat](https://www.elastic.co/guide/en/beats/journalbeat/master/index.html)
    
  
- Change the IP of elastic-search in `08-configmap.yaml` (or `12-daemonset.yaml`) where you have set with the public IP you get.
    
- Apply the k8s resources by following command

```bash
$ kubectl apply -f .
```

- You can check the logs of journal-beat pods 
```bash
"pid": 1, "ppid": 0, "seccomp": {"mode":"filter","no_new_privs":true}, "start_time": "2020-08-07T12:00:56.240Z"}}}
2020-08-07T12:00:57.098Z        INFO    instance/beat.go:310    Setup Beat: journalbeat; Version: 7.8.0
2020-08-07T12:00:57.098Z        INFO    eslegclient/connection.go:97    elasticsearch url: http://34.68.27.112:9200
2020-08-07T12:00:57.099Z        INFO    [publisher]     pipeline/module.go:113  Beat name: gke-cluster-1-default-pool-2e1137d2-xprr
2020-08-07T12:00:57.099Z        WARN    [cfgwarn]       beater/journalbeat.go:53        EXPERIMENTAL: Journalbeat is experimental.
.
2020-08-07T12:00:59.242Z        INFO    [publisher_pipeline_output]     pipeline/output.go:152  Connection to backoff(elasticsearch(http://34.68.27.112:9200)) established
2020-08-07T12:00:59.340Z        INFO    [input] input/input.go:141      journalbeat successfully published 2 events     {"id": "8c7ad622-1fe3-4679-93eb-5747cb51062f"}
2020-08-07T12:01:27.109Z        INFO    [monitoring]    log/log.go:145  Non-zero metrics in the last 30s        {"monitoring": {"metrics": {"beat":{"cpu":{"system":{"ticks":40,"time":{"ms":48}},"total":{"ticks":120,"time":{"ms":132},"value":120},"user":{"ticks":80,"time":{"ms":84}}},"handles":{"limit":{"hard":1048576,"soft":1048576},"open":12},"info":{"ephemeral_id":"c86a8e34-49c0-4b36-9748-3451c8133a8a","uptime":{"ms":30037}},"memstats":{"gc_next":9621216,"memory_alloc":8296424,"memory_total":14484160,"rss":51892224},"runtime":{"goroutines":30}},"journalbeat":{"journals":{"journal_0":{"path":"LOCAL_SYSTEM_JOURNAL","size_in_bytes":8392704}},"libbeat":{"output":{"events":{"acked":2,"batches":1,"total":2},"type":"elasticsearch"},"pipeline":{"clients":1,"events":{"published":2,"retry":2,"total":2},"queue":{"acked":2}}},"system":{"cpu":{"cores":2},"load":{"1":0.17,"15":0.28,"5":0.45,"norm":{"1":0.085,"15":0.14,"5":0.225}}}}}}}
2020-08-07T12:01:30.750Z        INFO    [input] input/input.go:141      journalbeat successfully published 1 events     {"id": "8c7ad622-1fe3-4679-93eb-5747cb51062f"}
.
```

- Now create one `index-patters` in kibana console

![](../../../images/kubernetes/gcp/task-016-journalbeat/creating-index-pattern.png)

- Now navigate to `Discover` on the console and you will be able to see the logs

![](../../../images/kubernetes/gcp/task-016-journalbeat/logs-dashboard.png)