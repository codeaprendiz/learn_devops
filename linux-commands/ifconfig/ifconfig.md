## ifconfig

[ifconfig](https://www.man7.org/linux/man-pages/man8/ifconfig.8.html)

### NAME

ifconfig - configure a network interface

### SYNOPSIS

> ifconfig [-v] [-a] [-s] [interface]

> ifconfig [-v] interface [aftype] options | address ...


### OPTIONS

- -a
  - display all interfaces which are currently available, even
    if down
    
### EXAMPLES

- To display all the interfaces present 
  - Consider ens4 here
    - has internal IP 10.128.0.38
    - has mac address 42:01:0a:80:00:26  (identified by ether)

```bash
# ifconfig -a
docker0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 172.17.0.1  netmask 255.255.0.0  broadcast 172.17.255.255
        inet6 fe80::42:4eff:fed8:4d48  prefixlen 64  scopeid 0x20<link>
        ether 02:42:4e:d8:4d:48  txqueuelen 0  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 5  bytes 526 (526.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

ens4: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1460
        inet 10.128.0.38  netmask 255.255.255.255  broadcast 0.0.0.0
        inet6 fe80::4001:aff:fe80:26  prefixlen 64  scopeid 0x20<link>
        ether 42:01:0a:80:00:26  txqueuelen 1000  (Ethernet)
        RX packets 80646  bytes 225065878 (225.0 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 36695  bytes 4095570 (4.0 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```