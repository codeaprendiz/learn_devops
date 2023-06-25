## Role Usage Example

- Check if playbook exists
```bash
$ cd ../../; ls playbook-install-commons.yaml
playbook-install-commons.yaml
```

- Run the playbook
```bash
$ ansible-playbook playbook-install-commons.yaml
```

- To install all packages
```bash
$ sudo ansible-playbook  playbook-install-commons.yaml --tags="all"
```

- To install only vm-related packages
```bash
$ sudo ansible-playbook  playbook-install-commons.yaml --tags="vm-required"
```

- To install only atom packages
```bash
$ sudo ansible-playbook  playbook-install-commons.yaml --tags="install-atom"
```
