## ping

### NAME

ping -- send ICMP ECHO_REQUEST packets to network hosts

### SYNOPSIS

> ping [-AaCDdfnoQqRrv] [-b boundif] [-c count] [-G sweepmaxsize] [-g sweepminsize] [-h sweepincrsize] [-i wait] [-k trafficclass] [-K netservicetype] [-l preload] [-M mask | time] [-m ttl] [-P policy] [-p pattern] [-S src_addr][-s packetsize] [-t timeout] [-W waittime] [-z tos] [--apple-connect] [--apple-print] host

> ping [-AaDdfLnoQqRrv] [-b boundif] [-c count] [-I iface] [-i wait] [-k trafficclass] [-K netservicetype] [-l preload] [-M mask | time] [-m ttl] [-P policy] [-p pattern] [-S src_addr] [-s packetsize] [-T ttl] [-t timeout] [-W waittime] [-z tos] [--apple-connect] [--apple-print] mcast-group

### DESCRIPTION

The ping utility uses the ICMP protocol's mandatory ECHO_REQUEST datagram to elicit an ICMP ECHO_RESPONSE from a host or gateway.  ECHO_REQUEST datagrams (``pings'') have an IP and ICMP header, followed by a ``struct timeval'' and then an arbitrary number of ``pad'' bytes used to fill out the packet.

**Alternative Definitions**

ping is a computer network administration software utility used to test the reachability of a host on an Internet Protocol (IP) network. It measures the round-trip time for messages sent from the originating host to a destination computer that are echoed back to the source.

Ping stands for "Packet INternet Groper." An Internet utility used to determine whether a particular IP address is reachable online by sending out a packet and waiting for a response. Ping is used to test and debug a network as well as see if a user or server is online.

Ping sends ICMP ECHO_REQUEST packets to any network addressable host (i.e. a server, a gateway router, etc.). The piece of equipment must be IP (Internet Protocol) addressable in order for ping to work

### OPTIONS

* -q 
  * Quiet output.  Nothing is displayed except the summary lines at startup time and when finished.
* -c count
  * Stop after sending (and receiving) count ECHO_RESPONSE packets.  If this option is not specified, ping will operate until interrupted.  If this option is specified in conjunction with ping sweeps, each sweep will consist of count packets.
  
```bash
ping google.com
```

Resolving Problems

If you can ping an IP host on a different network, it suggests that both hosts have TCP/IP correctly initialized and configured, and that routing between the networks is also configured correctly.

In cases where you cannot ping a remote host, don't jump to the conclusion that the remote host is unavailable or misconfigured, though it might be, the problem may also be a configuration issue with the source host, or potentially some routing-related (or physical connectivity) issue between the two. As a general rule, use the following steps to determine the source of connectivity issues between your PC and a remote system:

Assuming that your IP address, subnet mask, and default gateway are correct, attempt to ping a host on a different subnet. If this fails, one possibility is that routing is not configured correctly.

If pinging a remote host fails, attempt to ping your default gateway. If this fails, it may indicate that TCP/IP is not configured correctly on your local router interface, on your host PC, or that the router interface has not been enabled with the no shutdown command.

If pinging your default gateway fails, try pinging your host's configured IP address. If this fails, it can may mean that you have configured your host PC's IP address incorrectly, or that TCP/IP is not properly installed or initialized on the host system.

If pinging the host's IP address fails, try pinging the loopback address 127.0.0.1. If this fails, it generally indicates that TCP/IP is not properly installed or initialized on your host system.__