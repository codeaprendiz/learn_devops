## sysctl

[sysctl](https://man7.org/linux/man-pages/man8/sysctl.8.html)


### NAME

sysctl - configure kernel parameters at runtime

### SYNOPSIS

> sysctl [options] [variable[=value]] [...]

> sysctl -p [file or regexp] [...]


### DESCRIPTION

sysctl is used to modify kernel parameters at runtime.  The
parameters available are those listed under /proc/sys/.  Procfs
is required for sysctl support in Linux.  You can use sysctl to
both read and write sysctl data.


### OPTIONS

- -n 
  - Use this option to disable printing of the key name when
    printing values.
    
- --system

  - Load settings from all system configuration files. Files
    are read from directories in the following list in given
    order from top to bottom
    
### EXAMPLES

- To view the sysctl variables.

```bash
$ sysctl -a | egrep -i ip_forward 
net.ipv4.ip_forward = 1
net.ipv4.ip_forward_update_priority = 1
net.ipv4.ip_forward_use_pmtu = 0
```

- To reload the sysctl configuration.

```bash
$ sysctl --system
```