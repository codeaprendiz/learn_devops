## setenforce

[setenforce](https://man7.org/linux/man-pages/man8/setenforce.8.html)

### NAME

setenforce - modify the mode SELinux is running in

### SYNOPSIS         

> setenforce [Enforcing|Permissive|1|0]

### DESCRIPTION         
Use Enforcing or 1 to put SELinux in enforcing mode.
Use Permissive or 0 to put SELinux in permissive mode.

If SELinux is disabled and you want to enable it, or SELinux is
enabled and you want to disable it, please see selinux(8).

### EXAMPLES

- Tested on Fedora CoreOS

```bash
[root@ip-172-16-6-197 core]# cat /etc/os-release  | egrep "PRETTY_NAME" 
PRETTY_NAME="Fedora CoreOS 33.20210104.3.1"
```

- 0 to put SELinux in permissive mode.

```bash
setenforce 0


```