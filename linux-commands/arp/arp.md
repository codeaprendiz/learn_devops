## arp

[arp](https://man7.org/linux/man-pages/man8/arp.8.html)

### NAME

arp - manipulate the system ARP cache



### DESCRIPTION

Arp manipulates or displays the kernel's IPv4 network neighbour
cache. It can add entries to the table, delete one or display the
current content.

ARP stands for Address Resolution Protocol, which is used to find
the media access control address of a network neighbour for a
given IPv4 Address.


### MODES

arp
 -  arp with no mode specifier will print the current content of the
    table. It is possible to limit the number of entries printed, by
    specifying an hardware address type, interface name or host
    address.
    
    
 ### EXAMPLES   
    
```bash
$ arp
Address                  HWtype  HWaddress           Flags Mask            Iface
_gateway                 ether   42:01:0a:80:00:01   C                     ens4
```