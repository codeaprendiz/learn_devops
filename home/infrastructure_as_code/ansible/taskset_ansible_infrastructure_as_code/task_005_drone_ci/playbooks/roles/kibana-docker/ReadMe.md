## To install docker-kibana

[Docs](https://www.elastic.co/guide/en/elastic-stack-get-started/current/get-started-docker.html)

[elastic-search](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html)

## To install docker-kibana using docker-compose on ubuntu 16.04 LTS

- Ensure that elastic-search-cluster is installed already and accessible. You can use the [elastic-search-cluster](../elastic-search-cluster-docker)
  for the same.

- Check if playbook exists
```bash
$ cd ../../; ls playbook-install-kibana-docker.yaml
playbook-install-kibana-docker.yaml
```

- Run the playbook
```bash
$ ansible-playbook playbook-install-kibana-docker.yaml --tags="vm-required,docker,set-user,create-dir,kibana" -v
```


- Open the port 5601 in GCP (or any other cloud) where the kibana is running

- Now access the kibana dashboard on the console. In my case it was at [http://23.236.48.129:5601/app/kibana](http://23.236.48.129:5601/app/kibana) :)