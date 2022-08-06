## traceroute


### NAME

traceroute -- print the route packets take to network host

SYNOPSIS

> traceroute [-adeFISdNnrvx] [-A as_server] [-f first_ttl] [-g gateway] [-i iface] [-M first_ttl] [-m max_ttl] [-P proto] [-p port] [-q nqueries] [-s src_addr] [-t tos][-w waittime] [-z pausemsecs] host [packetsize]

### DESCRIPTION

The Internet is a large and complex aggregation of network hardware, connected together by gateways.  Tracking the route one's packets follow (or finding the miscreant gateway that's discarding your packets) can be difficult.  traceroute utilizes the IP protocol `time to live' field and attempts to elicit an ICMP TIME_EXCEEDED response from each gateway along the path to some host.

The only mandatory parameter is the destination host name or IP number.  The default probe datagram length is 40 bytes, but this may be increased by specifying a packet size (in bytes) after the destination host name.

Traceroute transmits packets with small TTL (Time To Live) values. The TTL is an IP header field that is used to prevent packets from running into endless loops. When a router that handles the packet subtracts one from the packet's TTL. The packet expires and it's discarded when the TTL reaches zero.

Traceroute sends ICMP Time Exceeded messages, (RFC 792), back to the sender when this occurs. By using small TTL values, the packets will quickly expire, so traceroute causes all routers along a packet's path to generate the ICMP messages that identify the router.

For example, TTL = 1 should produce the message from the first router, TTL = 2 generates a message from the second router in the path, and so on…

The Internet is a large and complex aggregation of network hardware, connected together by gateways.  Tracking the route one's packets follow (or finding the miscreant gateway that's discarding your packets) can be difficult.  traceroute utilizes the IP protocol `time to live' field and attempts to elicit an ICMP TIME_EXCEEDED response from each gateway along the path to some host.

```bash
$ traceroute google.com
```
