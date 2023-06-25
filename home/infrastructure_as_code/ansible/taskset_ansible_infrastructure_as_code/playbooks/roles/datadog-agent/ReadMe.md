## Role Usage Example

- Check if playbook exists
```bash
$ cd ../../; ls playbook-install-datadog.yaml
playbook-install-datadog.yaml
```

- Run the playbook
```bash
$ ansible-playbook playbook-install-datadog.yaml -e "RUNTIME_VAR_DATADOG_API_KEY=2dd894f5******0c73474d48f" -e "RUNTIME_VAR_HOSTS=localhost"
```