# sysctl.conf

## /etc/sysctl.conf

[sysctl.conf](https://man7.org/linux/man-pages/man5/sysctl.conf.5.html)

Enable packet forwarding for IPv4.

```bash
$ cat /etc/sysctl.conf

# Uncomment the line
net.ipv4.ip_forward=1
```