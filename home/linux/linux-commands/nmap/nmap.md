## nmap

### NAME

nmap - Network exploration tool and security / port scanner

### SYNOPSIS

> nmap [Scan Type...] [Options] {target specification}

### DESCRIPTION

Nmap ("Network Mapper") is an open source tool for network exploration and security auditing. It was designed to rapidly scan large networks, although it works fine against single hosts. 

Nmap uses raw IP packets in novel ways to determine 

- what hosts are available on the network, what services (application name and version) those hosts are offering, 
- what operating systems (and OS versions) they are running, 
- what type of packet filters/firewalls are in use, and 
- dozens of other characteristics. 

While Nmap is commonly used for security audits, many systems and network administrators find it useful for routine tasks such as network inventory, managing service upgrade schedules, and monitoring host or service uptime.

The output from Nmap is a list of scanned targets, with supplemental information on each depending on the options used. 

Key among that information is the "interesting ports table".  That table lists the port number and protocol, service name, and state. The state is either open, filtered, closed, or unfiltered.  

- Open means that an application on the target machine is listening for connections/packets on that port.  
- Filtered means that a firewall, filter, or other network obstacle is blocking the port so that Nmap cannot tell whether it is open or closed.  
- Closed ports have no application listening on them, though they could open up at any time. 
- Ports are classified as unfiltered when they are responsive to Nmap's probes, but Nmap cannot determine whether they are open or closed. 
- Nmap reports the state combinations open|filtered and closed|filtered when it cannot determine which of the two states describe a port. 

The port table may also include software version details when version detection has been requested. When an IP protocol scan is requested (-sO), Nmap provides information on supported IP protocols rather than listening ports.

Nmap can provide further information on targets, including reverse DNS names, operating system guesses, device types, and MAC addresses.

### OPTIONS

* -sU (UDP scans)
  * While most popular services on the Internet run over the TCP protocol, UDP[6] services are widely deployed. DNS, SNMP, and DHCP (registered ports 53, 161/162, and 67/68) are three of the most common. Because UDP scanning is generally slower and more difficult than TCP, some security auditors ignore these ports. This is a mistake, as exploitable UDP services are quite common and attackers certainly don't ignore the whole protocol. Fortunately, Nmap can help inventory UDP ports.
  * UDP scan is activated with the -sU option. It can be combined with a TCP scan type such as SYN scan (-sS) to check both protocols during the same run.
  * UDP scan works by sending a UDP packet to every targeted port. For some common ports such as 53 and 161, a protocol-specific payload is sent to increase response rate, but for most ports the packet is empty unless the --data, --data-string, or --data-length options are specified. If an ICMP port unreachable error (type 3, code 3) is returned, the port is closed. Other ICMP unreachable errors (type 3, codes 0, 1, 2, 9, 10, or 13) mark the port as filtered. Occasionally, a service will respond with a UDP packet, proving that it is open. If no response is received after retransmissions, the port is classified as open|filtered. This means that the port could be open, or perhaps packet filters are blocking the communication. Version detection (-sV) can be used to help differentiate the truly open ports from the filtered ones.

* -O (Enable OS detection)
  * Enables OS detection, as discussed above. Alternatively, you can use -A to enable OS detection along with other things.
* -sT (TCP connect scan)
  * TCP connect scan is the default TCP scan type when SYN scan is not an option. This is the case when a user does not have raw packet privileges. Instead of writing raw packets as most other scan types do, Nmap asks the underlying operating system to establish a connection with the target machine and port by issuing the connect system call. This is the same high-level system call that web browsers, P2P clients, and most other network-enabled applications use to establish a connection. It is part of a programming interface known as the Berkeley Sockets API. Rather than read raw packet responses off the wire, Nmap uses this API to obtain status information on each connection attempt.
  * When SYN scan is available, it is usually a better choice. Nmap has less control over the high level connect call than with raw packets, making it less efficient. The system call completes connections to open target ports rather than performing the half-open reset that SYN scan does. Not only does this take longer and require more packets to obtain the same information, but target machines are more likely to log the connection. A decent IDS will catch either, but most machines have no such alarm system. Many services on your average Unix system will add a note to syslog, and sometimes a cryptic error message, when Nmap connects and then closes the connection without sending data. Truly pathetic services crash when this happens, though that is uncommon. An administrator who sees a bunch of connection attempts in her logs from a single system should know that she has been connect scanned.
  

### EXAMPLES

The syntax is 

```bash
sudo nmap -sT -O localhost
```

list open UDP ports


```bash
sudo nmap -sU -O 192.168.2.13
```

list open TCP ports

```bash
sudo nmap -sT -O 192.168.2.13
```
