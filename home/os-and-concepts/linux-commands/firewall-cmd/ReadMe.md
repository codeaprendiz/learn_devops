# firewall-cmd

- [firewall-cmd](https://firewalld.org/documentation/man-pages/firewall-cmd.html)

firewall-cmd is the command line client of the firewalld daemon. It provides an interface to manage the runtime and permanent configurations.

## Examples

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

- To add a permanent firewall rule to the "public" zone, allowing incoming connections on port 3001 TCP. The --permanent option ensures that the rule persists across firewall reloads or system reboots.

```bash
$ firewall-cmd --zone=public --permanent --add-port=3001/tcp; 
success

# This command reloads the firewall configuration, applying any recent changes made to the firewall rules. The new rule added in the previous step will take effect after the reload.
$ sudo firewall-cmd --reload
success

# To add a permanent firewall rule to the "public" zone, allowing incoming UDP (User Datagram Protocol) connections on port 7846. The --permanent option ensures that the rule persists across firewall reloads or system reboots.
$ firewall-cmd --zone=public --permanent --add-port=7846/udp; sudo firewall-cmd --reload;
success
success
```

- To list the services that are currently allowed or open in the "public" zone of your firewall configuration

```bash
# Allowing the ssh service means that your system can accept incoming SSH connections, allowing users to connect remotely and securely access the system's command-line interface.
$ firewall-cmd --zone=public --list-services
ssh
```
