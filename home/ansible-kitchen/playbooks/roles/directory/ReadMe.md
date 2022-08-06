## Role Usage Example

- Check if playbook exists
```bash
$ cd ../../; ls playbook-create-directory.yaml
playbook-create-directory.yaml
```

- Run the playbook
```bash
$ ansible-playbook playbook-create-directory.yaml
```

- Run the playbook with required tags
```bash
$ ansible-playbook playbook-create-directory.yaml --tags="set-user,create-dir"
```