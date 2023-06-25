## To install elastic search cluster using docker-compose on ubuntu 16.04 LTS

### Docs referred
- [elastic-search](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html)


- Check if playbook exists
```bash
$ cd ../../; ls playbook-install-elastic-search-cluster-docker.yaml
playbook-install-elastic-search-cluster-docker.yaml
```

- Run the playbook
```bash
$ ansible-playbook playbook-install-elastic-search-cluster-docker.yaml --tags="vm-required,docker,set-user,create-dir,elastic-search-cluster"
```

- Login to the instance and check the containers

```bash
root@instance-1:/home/visionary# docker ps
CONTAINER ID        IMAGE                                                 COMMAND                  CREATED             STATUS              PORTS                              NAMES
9fd688faca31        docker.elastic.co/elasticsearch/elasticsearch:7.8.0   "/tini -- /usr/local…"   12 minutes ago      Up 12 minutes       9200/tcp, 9300/tcp                 es03
3489db596982        docker.elastic.co/elasticsearch/elasticsearch:7.8.0   "/tini -- /usr/local…"   12 minutes ago      Up 12 minutes       0.0.0.0:9200->9200/tcp, 9300/tcp   es01_dev
21607926c595        docker.elastic.co/elasticsearch/elasticsearch:7.8.0   "/tini -- /usr/local…"   12 minutes ago      Up 12 minutes       9200/tcp, 9300/tcp                 es02_dev

```


```bash
root@instance-1:/home/visionary# curl -X GET "localhost:9200/_cat/nodes?v&pretty"
ip         heap.percent ram.percent cpu load_1m load_5m load_15m node.role master name
172.18.0.3           24          96   7    0.56    0.39     0.49 dilmrt    -      es03
172.18.0.4           60          96   7    0.56    0.39     0.49 dilmrt    -      es02
172.18.0.2           50          96   7    0.56    0.39     0.49 dilmrt    *      es01
```

- Open the port 9200 in GCP (or any other cloud) where the elastic search is running
```bash
$ curl -X GET "35.226.68.74:9200/_cat/nodes?v&pretty"
ip         heap.percent ram.percent cpu load_1m load_5m load_15m node.role master name
172.18.0.4           26          97   1    0.00    0.00     0.00 dilmrt    *      es03
172.18.0.2           69          97   1    0.00    0.00     0.00 dilmrt    -      es02
172.18.0.3           13          97   1    0.00    0.00     0.00 dilmrt    -      es01
```

