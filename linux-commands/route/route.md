## route

[route](https://linux.die.net/man/8/route)

### NAME

route - show / manipulate the IP routing table


### SYNOPSIS

>  route [-CFvnee]


### OPTIONS

- n 

  - show numerical addresses instead of trying to determine symbolic host names. This is useful if you are trying to determine why the route to your nameserver has vanished.
  
```bash
$ route -n      
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         192.168.1.1     0.0.0.0         UG    100    0        0 ens5
172.20.0.0      0.0.0.0         255.255.0.0     U     0      0        0 docker0
172.28.0.0      0.0.0.0         255.255.0.0     U     0      0        0 br-54008b2d3118
172.29.0.0      0.0.0.0         255.255.0.0     U     0      0        0 br-62ebaead3613
192.169.1.0     0.0.0.0         255.255.255.0   U     0      0        0 ens5
192.170.1.1     0.0.0.0         255.255.255.255 UH    100    0        0 ens5
```