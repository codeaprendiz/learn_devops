# ip_forward

<br>

## /proc/sys/net/ipv4/ip_forward

- if IP forwarding is enabled on a host
  - 1 indicates Yes
  - 0 indicates No

```bash
$ cat /proc/sys/net/ipv4/ip_forward
0

$ echo 1 > /proc/sys/net/ipv4/ip_forward
```
