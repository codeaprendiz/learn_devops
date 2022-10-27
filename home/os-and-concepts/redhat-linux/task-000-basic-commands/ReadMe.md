# Basic Commands

## Update your system

Update your base system with the latest available packages.

[Update System](https://access.redhat.com/articles/11258)

```bash
$ sudo dnf update -y
```


## To check the status of a service like docker

```bash
$ systemctl status docker
```


## To check the CPU architecture

[stackoverflow](https://stackoverflow.com/questions/48678152/how-to-detect-386-amd64-arm-or-arm64-os-architecture-via-shell-bash)

```bash
$ arch
x86_64

$ lscpu | awk '/Architecture:/{print $2}'
x86_64

$ uname -m
x86_64
```