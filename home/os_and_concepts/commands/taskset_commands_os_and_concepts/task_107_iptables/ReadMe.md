# iptables

- [iptables](https://man7.org/linux/man-pages/man8/iptables.8.html)

<br>

## Name

- iptables - administration tool for IPv4 packet filtering and NAT

<br>

## Examples

```bash
[root@instance]# cat /etc/os-release 
NAME="Red Hat Enterprise Linux Server"
VERSION="7.9 (Maipo)"
ID="rhel"
ID_LIKE="fedora"
VERSION_ID="7.9"
PRETTY_NAME="Red Hat Enterprise Linux Server 7.9 (Maipo)"

[root@instance]# iptables -L -n -v
Chain INPUT (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination         
37421  634M ACCEPT     all  --  *      *       0.0.0.0/0            0.0.0.0/0            ctstate RELATED,ESTABLISHED
    0     0 ACCEPT     all  --  lo     *       0.0.0.0/0            0.0.0.0/0           
  543 31939 INPUT_direct  all  --  *      *       0.0.0.0/0            0.0.0.0/0           
  543 31939 INPUT_ZONES_SOURCE  all  --  *      *       0.0.0.0/0            0.0.0.0/0           
  543 31939 INPUT_ZONES  all  --  *      *       0.0.0.0/0            0.0.0.0/0           
    0     0 DROP       all  --  *      *       0.0.0.0/0            0.0.0.0/0            ctstate INVALID
    0     0 REJECT     all  --  *      *       0.0.0.0/0            0.0.0.0/0            reject-with icmp-host-prohibited

Chain FORWARD (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination         
    0     0 ACCEPT     all  --  *      *       0.0.0.0/0            0.0.0.0/0            ctstate RELATED,ESTABLISHED
    0     0 ACCEPT     all  --  lo     *       0.0.0.0/0            0.0.0.0/0           
    0     0 FORWARD_direct  all  --  *      *       0.0.0.0/0            0.0.0.0/0           
    0     0 FORWARD_IN_ZONES_SOURCE  all  --  *      *       0.0.0.0/0            0.0.0.0/0           
    0     0 FORWARD_IN_ZONES  all  --  *      *       0.0.0.0/0            0.0.0.0/0           
    0     0 FORWARD_OUT_ZONES_SOURCE  all  --  *      *       0.0.0.0/0            0.0.0.0/0           
    0     0 FORWARD_OUT_ZONES  all  --  *      *       0.0.0.0/0            0.0.0.0/0           
    0     0 DROP       all  --  *      *       0.0.0.0/0            0.0.0.0/0            ctstate INVALID
    0     0 REJECT     all  --  *      *       0.0.0.0/0            0.0.0.0/0            reject-with icmp-host-prohibited

Chain OUTPUT (policy ACCEPT 31151 packets, 3512K bytes)
 pkts bytes target     prot opt in     out     source               destination         
    0     0 ACCEPT     all  --  *      lo      0.0.0.0/0            0.0.0.0/0           
31151 3512K OUTPUT_direct  all  --  *      *       0.0.0.0/0            0.0.0.0/0           

Chain FORWARD_IN_ZONES (1 references)
 pkts bytes target     prot opt in     out     source               destination         
    0     0 FWDI_trusted  all  --  eth0   *       0.0.0.0/0            0.0.0.0/0           [goto] 
    0     0 FWDI_trusted  all  --  +      *       0.0.0.0/0            0.0.0.0/0           [goto] 
...
Chain INPUT_direct (1 references)
 pkts bytes target     prot opt in     out     source               destination 
...
...
```

This is the output of the `iptables -L -n -v` command, which is used to list all the firewall rules in the system in verbose mode.

Here's an explanation of the significant points in the output:

1. **INPUT (policy ACCEPT)**: This is the chain for all packets coming into the machine (incoming traffic). The default policy is to ACCEPT, meaning if a packet doesn't match any rule, it is accepted.

2. **FORWARD (policy ACCEPT)**: This is the chain for packets that are not for this machine and are not originated from this machine. Essentially, if your machine is a router, this chain is used. The default policy here is also ACCEPT.

3. **OUTPUT (policy ACCEPT)**: This is the chain for packets originating from the machine (outgoing traffic). Again, the default policy is ACCEPT.

The other chains like INPUT_direct, OUTPUT_direct, etc., are custom chains created for specific rules. Firewalld uses these to make the management of firewall rules easier.

In each chain, you will see lines like:

```bash
37421  634M ACCEPT     all  --  *      *       0.0.0.0/0            0.0.0.0/0            ctstate RELATED,ESTABLISHED
```

Here is the breakdown for this line:

- **37421**: Number of packets that matched this rule.
- **634M**: The total amount of data that has matched this rule.
- **ACCEPT**: The target of this rule. If a packet matches this rule, it will be accepted.
- **all**: The protocol of this rule. 'All' means it applies to all protocols.
- **\* *:** In and Out network interfaces to which this rule applies. An asterisk means 'any'.
- **0.0.0.0/0 0.0.0.0/0**: The source and destination IP addresses to which this rule applies. '0.0.0.0/0' represents all IP addresses.
- **ctstate RELATED,ESTABLISHED**: A stateful packet inspection (SPI) condition that must be met. It means that this rule only applies to packets that are part of or related to an already established connection.

The rest of the lines are similar rules with different parameters. For example, some lines use the REJECT target instead of ACCEPT, which means that if a packet matches that rule, it will be dropped and the source will be notified of this action.
