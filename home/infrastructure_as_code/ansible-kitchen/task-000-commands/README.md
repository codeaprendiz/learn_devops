# ansible-kitchen
Lets bake some good Infra code here

Version at the time of making this ReadMe.md
```bash
$ ansible --version
ansible 2.9.4
```

# Installation 

- Ubuntu 18.04
```bash
$ sudo apt-add-repository ppa:ansible/ansible -y
$ sudo apt update
$ sudo apt -y install ansible
```

## list inventory
Reference Docs
https://docs.ansible.com/ansible/latest/user_guide/intro_patterns.html

To convert from *.ini format for *.yml format you can use the following command
```bash
ansible-inventory -i inventory.ini -y --list > inventory.yaml
```

Default output without setting ansible.cfg
```bash
## will give output of /etc/ansible/hosts
$ ansible --list-hosts all
[WARNING]: provided hosts list is empty, only localhost is available. Note that the implicit localhost does not match 'all'
  hosts (0):
```

using custom file ansible.cfg
```buildoutcfg
[defaults]
inventory=inventory.yml
```

The following is the inventory.yml
```yaml
all:
  hosts:
    mail.example.com:
  children:
    local:
      hosts:
        127.0.0.1:
          ansible_connection: local
    webservers:
      hosts:
        foo.example.com:
        bar.example.com:
    dbservers:
      hosts:
        one.example.com:
        two.example.com:
        three.example.com:
    east:
      hosts:
        foo.example.com:
        one.example.com:
        two.example.com:
    west:
      hosts:
        bar.example.com:
        three.example.com:
    prod:
      hosts:
        foo.example.com:
        one.example.com:
        two.example.com:
    test:
      hosts:
        bar.example.com:
        three.example.com:
```

```bash
$ ansible -i inventory.yml --list-host all
  hosts (7):
    mail.example.com
    foo.example.com
    two.example.com
    one.example.com
    bar.example.com
    three.example.com
    127.0.0.1
```

after setting ansible.cfg file
```bash
$ ansible --list-host all
  hosts (7):
    mail.example.com
    foo.example.com
    two.example.com
    one.example.com
    bar.example.com
    three.example.com
    127.0.0.1
```

using group names "webservers" is a group
```bash
$ ansible --list-host "webservers"
  hosts (2):
    bar.example.com
    foo.example.com
```

using wild cards
```bash
$ ansible --list-host "*.com"
  hosts (6):
    two.example.com
    one.example.com
    foo.example.com
    bar.example.com
    mail.example.com
    three.example.com
```

giving multiple groups
```bash
$ ansible --list-host "prod:test"
  hosts (5):
    foo.example.com
    two.example.com
    one.example.com
    bar.example.com
    three.example.com
```

using as an array
```bash
$ ansible --list-host "prod[0]"
  hosts (1):
    foo.example.com
```

using negation
```bash
$ ansible --list-host "\!prod"
  hosts (4):
    mail.example.com
    bar.example.com
    three.example.com
    127.0.0.1
```

## Modules

Reference Docs
https://docs.ansible.com/ansible/latest/modules/modules_by_category.html

### ping

To check the connectivity of all hosts
```bash
$ ansible -m ping localhost
127.0.0.1 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
```

### command (the default module)
```bash
$ ansible -m command -a "ls" local
127.0.0.1 | CHANGED | rc=0 >>
README.md
ansible.cfg
inventory.ini
inventory.yaml
inventory.yml

# since it is default
$ ansible -a "ls" local
127.0.0.1 | CHANGED | rc=0 >>
README.md
ansible.cfg
inventory.ini
inventory.yaml
inventory.yml
```



