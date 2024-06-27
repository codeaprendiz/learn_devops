# firewall-cmd

- [firewall-cmd](https://firewalld.org/documentation/man-pages/firewall-cmd.html)

firewall-cmd is the command line client of the firewalld daemon. It provides an interface to manage the runtime and permanent configurations.

<br>

## Examples

- To list all the configuration settings for the public zone in your firewall. This can be useful to see what rules are currently in place and to help troubleshoot any issues with your firewall configuration.

```bash
$ cat /etc/os-release 
NAME="Red Hat Enterprise Linux Server"
VERSION="7.9 (Maipo)"
ID="rhel"
ID_LIKE="fedora"
VERSION_ID="7.9"

$ firewall-cmd --zone=public --list-all
public
  target: default
  icmp-block-inversion: no
  interfaces: 
  sources: 
  services: dhcpv6-client ssh
  ports: 
  protocols: 
  masquerade: no
  forward-ports: 
  source-ports: 
  icmp-blocks: 
  rich rules: 
```

- To list the ports that are currently configured in the firewall settings of your system.
  
```bash
$ firewall-cmd --list-ports
80/tcp 4589/udp
```

- lists the ports that are open or allowed for incoming connections in the "public" zone of your firewall configuration.

```bash
$ firewall-cmd --zone=public --list-ports
80/tcp 4589/udp
```

- To add a permanent firewall rule to the "public" zone, allowing incoming connections on port 3002 TCP and on 3003 UDP. The --permanent option ensures that the rule persists across firewall reloads or system reboots.

```bash
$ firewall-cmd --zone=public --list-all
public
  target: default
  icmp-block-inversion: no
  interfaces: 
  sources: 
  services: dhcpv6-client ssh
  ports: 
  protocols: 
  masquerade: no
  forward-ports: 
  source-ports: 
  icmp-blocks: 
  rich rules: 

# To add a permanent firewall rule to the "public" zone, allowing incoming TCP (Transmission Control Protocol) connections on port 3002 and UDP (User Datagram Protocol) connections on port 3003. The --permanent option ensures that the rule persists across firewall reloads or system reboots.
$ firewall-cmd --zone=public --permanent --add-port=3002/tcp --add-port=3003/udp;
success

# This command reloads the firewall configuration, applying any recent changes made to the firewall rules. The new rule added in the previous step will take effect after the reload.
$ sudo firewall-cmd --reload
success

$ firewall-cmd --zone=public --list-all
public
  target: default
  icmp-block-inversion: no
  interfaces: 
  sources: 
  services: dhcpv6-client ssh
  ports: 3002/tcp 3003/udp
  protocols: 
  masquerade: no
  forward-ports: 
  source-ports: 
  icmp-blocks: 
  rich rules: 
```

- To list the services that are currently allowed or open in the "public" zone of your firewall configuration

```bash
# Allowing the ssh service means that your system can accept incoming SSH connections, allowing users to connect remotely and securely access the system's command-line interface.
$ firewall-cmd --zone=public --list-services
ssh
```

- `rule family="ipv4" destination address="10.0.0.24/32" accept:` This rule states that for traffic in the IPv4 family, if the destination address matches "10.0.0.24" (you'd replace this with an actual IP), the firewall should accept the traffic. The "/32" means it's a single IP address you're specifying (in CIDR notation, /32 represents a single IPv4 address).

```bash
$ firewall-cmd --zone=public --list-all
public
  target: default
  icmp-block-inversion: no
  interfaces: 
  sources: 
  services: dhcpv6-client ssh
  ports: 
  protocols: 
  masquerade: no
  forward-ports: 
  source-ports: 
  icmp-blocks: 
  rich rules:

$ firewall-cmd --permanent --zone=public --add-rich-rule='
   rule family="ipv4"
   destination address="10.0.0.24/32"
   accept'
$ firewall-cmd --reload
success
success

$ firewall-cmd --zone=public --list-all
public
  target: default
  icmp-block-inversion: no
  interfaces: 
  sources: 
  services: dhcpv6-client ssh
  ports: 
  protocols: 
  masquerade: no
  forward-ports: 
  source-ports: 
  icmp-blocks: 
  rich rules: 
        rule family="ipv4" destination address="10.0.0.24/32" accept
```

- To remove the above rule (`rule family="ipv4" destination address="x.x.x.x/32" accept:`) from the firewall configuration, use the following commands:
  - `--add-rich-rule`: This option allows you to add a rich rule, which is a rule that allows you more granular control over firewall decisions.

```bash
$ firewall-cmd --permanent --zone=public --remove-rich-rule='
   rule family="ipv4"
   destination address="x.x.x.x./32"
   accept'
$ firewall-cmd --reload
```

- `rule family="ipv4" source address="10.0.0.24/18" accept`: This is the rich rule you're adding. This rule states that for IPv4 traffic, if the source address falls within the "10.0.0.24/18" IP range, the firewall should accept the traffic. In CIDR notation, /18 represents a subnet mask of 255.255.192.0 and allows for 16,382 potential IP addresses.
  - `--add-rich-rule`: This option allows you to add a rich rule, which is a rule that allows you more granular control over firewall decisions.

```bash
$ firewall-cmd --zone=public --list-all
public
  target: default
  icmp-block-inversion: no
  interfaces: 
  sources: 
  services: dhcpv6-client ssh
  ports: 
  protocols: 
  masquerade: no
  forward-ports: 
  source-ports: 
  icmp-blocks: 
  rich rules: 
$ firewall-cmd --permanent --zone=public --add-rich-rule='
   rule family="ipv4"
   source address="10.0.0.24/18"
   accept'
$ firewall-cmd --reload
$ firewall-cmd --zone=public --list-all
public
  target: default
  icmp-block-inversion: no
  interfaces: 
  sources: 
  services: dhcpv6-client ssh
  ports: 
  protocols: 
  masquerade: no
  forward-ports: 
  source-ports: 
  icmp-blocks: 
  rich rules: 
        rule family="ipv4" source address="10.0.0.24/18" accept
```
