
# diff

[diff](https://man7.org/linux/man-pages/man1/diff.1.html)

<br>

## NAME

diff - compare files line by line

<br>

## SYNOPSIS

> diff [OPTION]... FILES

<br>

## DESCRIPTION

Compare FILES line by line.

<br>

## EXAMPLES

When you want to check the difference in two files in linux system

```bash
$ diff /etc/kubernetes/manifests/kube-apiserver.yaml /var/answers/kube-apiserver.yaml
22c22
<     - --etcd-cafile=/etc/kubernetes/pki/ca.crt
---
>     - --etcd-cafile=/etc/kubernetes/pki/etcd/ca.crt
```
