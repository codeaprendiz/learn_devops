## ip

[ip](https://linux.die.net/man/8/ip)

### NAME

ip - show / manipulate routing, devices, policy routing and tunnels


### SYNOPSIS

> ip [ OPTIONS ] OBJECT { COMMAND | help }

> OBJECT := { link | addr | addrlabel | route | rule | neigh | tunnel | maddr | mroute | monitor }

> OPTIONS := { -V[ersion] | -s[tatistics] | -r[esolve] | -f[amily] { inet | inet6 | ipx | dnet | link } | -o[neline] }

### OBJECT



#### address or addr

protocol (IP or IPv6) address on a device.

protocol (IP or IPv6) address on a device.
  
##### address add

add new protocol address.
      
#### link

network device

#### netns

network namespace

#### route 

Manipulate route entries in the kernel routing tables keep information about paths to other networked nodes.
 
  


### EXAMPLES

- Two hosts A and B
  - host A has interface (eth0) 
  - host B has interface (etho0)
  - We want to connect the two hosts A and B using the switch.
  - Let's assume it has the IP address 192.168.1.0
    
  - To see the interfaces on the host we use the following command
    ```bash
    $ $ ip link
      1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
          link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
      2: ens4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1460 qdisc mq state UP mode DEFAULT group default qlen 1000
          link/ether 42:01:0a:80:00:26 brd ff:ff:ff:ff:ff:ff
    ```

  - To see the IP Address interfaces.
    ```bash
    $ ip address
    1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
        link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
        inet 127.0.0.1/8 scope host lo
           valid_lft forever preferred_lft forever
        inet6 ::1/128 scope host 
           valid_lft forever preferred_lft forever
    2: ens4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1460 qdisc mq state UP group default qlen 1000
        link/ether 42:01:0a:80:00:26 brd ff:ff:ff:ff:ff:ff
        inet 10.128.0.38/32 scope global dynamic ens4
           valid_lft 3020sec preferred_lft 3020sec
        inet6 fe80::4001:aff:fe80:26/64 scope link 
           valid_lft forever preferred_lft forever
    ```

 - We then assign the systems with IP addresses on the same network. 
   For this, we use the command ip addr. 
   - On host A
   ```bash
   $ ip addr add 192.168.1.10/24 dev eth0
   ```
   - On host B
   ```bash
   $ ip addr add 192.168.1.10/24 dev eth0
   ```
 
![](../../images/linux-commands/ip/net14.PNG)   
   
   Once the links are up, and the IP addresses are assigned,
   The computers can now communicate with each other through the switch. 
   The switch can only enable communication within the network which means 
   it can receive packets from a host on the network and deliver it to other
   systems within the same network.
   - So now the ping command from host A should work
   ```bash
    ping 192.168.1.11
   ```

- How does System B with the IP 192.168.1.11 reach system C with the IP 2.10 on the
  other network. That’s where a Router comes in. A Router helps connect two networks together. 
  Since it connects to the two separate networks, it gets two IPs assigned. One on each network. 
  In the first network we assign it an IP address 192.168.1.1 and in the second we assign it an 
  IP 192.168.2.1. Now we have a router connected to the two networks that can enable communication 
  between them.
  
![](../../images/linux-commands/ip/net15.PNG)  

- Now, when system B tries to send a packet to system C, how does it know where the router is on the network
  to send the packet through the router is just another device on the network.
  there could be many other such devices. That’s where we configure the systems with a gateway or a route.
  If the network was a room, the gateway is a door to the outside world to other networks or to the internet
  The systems need to know where that door is to go through that to see the existing routing configuration
  on a system run the [route](../route/route.md) command. It displays the kernels routing table

- To configure a gateway on system B to reach the systems on network 192.168.2.0, 
  run the ip route add command, and specify that you can reach the
  192.168.2.0 network through the door or gateway at 192.168.1.11. Running the route
  command again shows that we have a route added to reach the 192.168.2.0 series network through the
  router. 
  - So we run the folloiwng command on system B
  ```bash
  $ ip route add 192.168.2.0/24 via 192.168.1.1
  ```
  - So when we run the `route` command on system B again we get
  ```bash
  $ route
  Kernel IP routing table
  Destination  Gateway      Genmask         Flags     Metric  Ref  Use   Iface
  192.168.2.0  192.168.1.1  255.255.255.0   UG        0       0    0     eth0   
  ```
  - Similarly we can add a route to the internet as well.
  ```bash
  $ ip route add default via 192.168.1.1  
  ## OR 
  $ ip route add 0.0.0.0 via 192.168.1.1  
  ```
  
- To view the routes in a host

```bash
$ ip route
default via 10.128.0.1 dev ens4 proto dhcp src 10.128.0.38 metric 100 
10.128.0.1 dev ens4 proto dhcp scope link src 10.128.0.38 metric 100 
```


- Create a network namespace

```bash
$ ip netns add red

$ ip netns add blue
```

- List the network namespace

```bash
# ip netns
red
```

- List the network interfaces on the host

```bash
$ ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: ens4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1460 qdisc mq state UP mode DEFAULT group default qlen 1000
    link/ether 42:01:0a:80:00:26 brd ff:ff:ff:ff:ff:ff
```

- Exec inside the network namespace. Note that you cannot see the
  `ens4` interface inside the network namepace.
```bash
$ ip netns exec red ip link
1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00

### OR

$ ip -n red  link
1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
```

- Similarly you can run the arp command on the host and inside the network namespace


```bash
### On the host
$ arp
Address                  HWtype  HWaddress           Flags Mask            Iface
_gateway                 ether   42:01:0a:80:00:01   C                     ens4

## inside the namespace
$ ip netns exec red arp

```